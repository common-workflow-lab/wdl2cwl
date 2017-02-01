from __future__ import print_function

import argparse
import json
import os
import sys

import wdl.parser
from jinja2 import Environment, FileSystemLoader

from wdl2cwl import __version__

handlers = {}

typemap = {"Int": "int",
           "File": "File",
           "String": "string",
           "Array": "array"}


def ihandle(i, **kw):
    if isinstance(i, wdl.parser.Terminal):
        if i.str == "string":
            return '"%s"' % i.source_string
        elif i.str == "integer":
            return i.source_string
        elif i.str == "cmd_part":
            return i.source_string
        elif i.str == "type":
            return typemap[i.source_string]
        elif i.str == "fqn":
            return "#" + i.source_string
        elif i.str in "identifier":
            if kw.get("in_expression"):
                kw.get("depends_on").add(i)
                if i.source_string in kw["filevars"]:
                    return "inputs.%s.path" % i.source_string
                else:
                    return "inputs." + i.source_string
            else:
                return i.source_string
        else:
            raise NotImplementedError("Unknown terminal '%s'" % i.str)
    else:
        return handlers[i.name](i, **kw)


def handleDocument(item, **kwargs):
    defs = []
    for i in item.attr("imports"):
        ihandle(i, **kwargs)
    for i in item.attr("definitions"):
        defs.append(ihandle(i, **kwargs))
    return defs


def handleImport(item, **kwargs):
    raise NotImplementedError('Import not implemented')


def handleTask(item, **kwargs):
    tool = {"id": ihandle(item.attr("name"), **kwargs),
            "class": "CommandLineTool",
            "cwlVersion": "v1.0",
            "baseCommand": [],
            "requirements": [{"class": "ShellCommandRequirement"}],
            "inputs": [],
            "outputs": []}

    filevars = kwargs.get("filevars", set())
    for i in item.attr("declarations"):
        tool["inputs"].append(ihandle(i, context=tool,
                                      assignments=kwargs.get("assignments", {}),
                                      filevars=filevars,
                                      **kwargs))
    for i in item.attr("sections"):
        ihandle(i, context=tool, assignments=kwargs.get("assignments", {}),
                filevars=filevars, **kwargs)

    return tool


def handleWorkflow(item, **kwargs):
    wf = {"id": ihandle(item.attr("name")),
          "class": "Workflow",
          "cwlVersion": "v1.0",
          "inputs": [],
          "outputs": [],
          "requirements": [
              {"class": "InlineJavascriptRequirement"}
          ],
          "steps": []}
    assignments = {}
    filevars = set()
    for i in item.attr("body"):
        if i.name == "Call":
            wf["steps"].append(ihandle(i, context=wf, assignments=assignments,
                                       filevars=filevars, **kwargs))
        elif i.name == "Declaration":
            wf["inputs"].append(ihandle(i, context=wf, assignments=assignments,
                                        filevars=filevars, **kwargs))
        elif i.name == "WorkflowOutput":
            wf["outputs"].append(ihandle(i, **kwargs))
        elif i.name == "Scatter":
            wf["steps"].extend(ihandle(i, context=wf, assignments=assignments,
                                       filevars=filevars, **kwargs))
        else:
            raise NotImplementedError
    return wf


def handleRuntime(item, **kwargs):
    for runtimeRequirement in item.attr('map'):
        key = ihandle(runtimeRequirement.attr('key'))
        if key == 'docker':
            value = ihandle(runtimeRequirement.attr('value'))
            if type(value) is list:
                value = value[0]  # if there are several Docker images, pick the first one (due to CWL restrictions)
            kwargs['context']['requirements'].append({
                'class': 'DockerRequirement',
                'dockerPull': strip_special_ch(value)
            })
        elif key == 'memory':
            # TODO: discuss, different measure units: megabytes (wdl) vs. mebibytes (cwl)
            kwargs['context']['requirements'].append({
                'class': 'ResourceRequirement',
                'ramMin': strip_special_ch(ihandle(runtimeRequirement.attr('value')))
            })


def handleType(item, **kwargs):
    param_type = ihandle(item.attr('name'))
    subtype = ihandle(item.attr('subtype')[0])
    return {'type': param_type,
            'items': subtype}


def strip_special_ch(string):
    return string.strip('"\'')


def handleDeclaration(item, context=None, assignments=None, filevars=None, **kwargs):
    param_id = ihandle(item.attr("name"))
    param_type = ihandle(item.attr("type"))
    assignments[param_id] = "#%s/%s" % (context["id"], param_id)
    if param_type == "File":
        filevars.add(param_id, **kwargs)
    return {"id": param_id,
            "type": param_type}


def handleRawCommand(item, context=None, **kwargs):
    s = ""
    for p in item.attr("parts"):
        s += ihandle(p, **kwargs)
    context["arguments"] = [{"valueFrom": s, "shellQuote": False}]


def handleOutputs(item, context=None, **kwargs):
    for a in item.attr("attributes"):
        out = {"id": ihandle(a.attr("name")),
               "type": ihandle(a.attr("type")),
               "outputBinding": {}}
        e = ihandle(a.attr("expression"),
                    is_expression=True,
                    depends_on=set(),
                    outputs=out,
                    tool=context,
                    **kwargs)
        if e != "self":
            out["outputBinding"]["outputEval"] = "$(" + e + ")"
        context["outputs"].append(out)


def handleFunctionCall(item, **kwargs):
    if ihandle(item.attr("name")) == "stdout":
        kwargs["tool"]["stdout"] = "__stdout"
        kwargs["outputs"]["outputBinding"]["glob"] = "__stdout"
        return "self[0]"
    elif ihandle(item.attr("name")) == "read_int":
        kwargs["outputs"]["outputBinding"]["loadContents"] = True
        return "parseInt(" + ihandle(item.attr("params")[0], **kwargs) + ".contents)"
    elif ihandle(item.attr("name")) == "read_string":
        kwargs["outputs"]["outputBinding"]["loadContents"] = True
        return ihandle(item.attr("params")[0], **kwargs) + ".contents"
    elif ihandle(item.attr("name")) == "read_tsv":
        raise NotImplementedError
    # TODO: a lot of other function calls:
    else:
        raise NotImplementedError("Unknown function '%s'" % ihandle(item.attr("name")))
    pass


def handleCommandParameter(item, context=None, **kwargs):
    return "$(" + ihandle(item.attr("expr"), in_expression=True, depends_on=set(), **kwargs) + ")"


def handleCall(item, context=None, assignments=None, **kwargs):
    if item.attr("alias") is not None:
        stepid = ihandle(item.attr("alias"))
    else:
        stepid = ihandle(item.attr("task"))[1:]

    step = {"id": stepid,
            "in": [],
            "out": [],
            "run": ihandle(item.attr("task")).strip('#') + '.cwl'}

    for out in kwargs["tasks"][ihandle(item.attr("task"))[1:]]["outputs"]:
        step["out"].append({"id": out["id"]})
        mem = "%s.%s" % (stepid, out["id"])
        assignments[mem] = "#%s/%s/%s" % (context["id"], stepid, out["id"])
        if out["type"] == "File":
            kwargs["filevars"].add(mem)

    b = item.attr("body")
    if b is not None:
        ihandle(b, context=step, assignments=assignments, **kwargs)

    for taskinp in kwargs["tasks"][ihandle(item.attr("task"))[1:]]["inputs"]:
        f = [stepinp for stepinp in step["in"] if stepinp["id"] == taskinp["id"]]
        if not f and taskinp.get("default") is None:
            newinp = "%s_%s" % (stepid, taskinp["id"])
            context["inputs"].append({
                "id": newinp,
                "type": taskinp["type"]
            })
            step["in"].append({
                "id": taskinp["id"],
                "source": "%s" % (newinp)
            })

    return step


def handleCallBody(item, **kwargs):
    for i in item.attr("io"):
        ihandle(i, **kwargs)


def handleScatter(item, **kwargs):
    kwargs['context']['requirements'].append({'class': 'ScatterFeatureRequirement'})
    # TODO: smart scattering (over subworkflows rather than individual steps)
    steps = []

    for task in item.attr('body'):
        tool_name = ihandle(task.attr("task")).strip('#')
        alias = task.attr("alias")
        if alias is not None:
            stepid = ihandle(alias)
        else:
            stepid = tool_name
        # TODO: handle declarations inside steps (?)
        step = {"id": stepid,
                "in": [],
                "out": [],
                "run": tool_name + '.cwl'}
        scatter_var = ihandle(task.attr('body').attr('io')[0].attr('map')[0].attr('key'))
        step.update({"scatter": scatter_var})
        for out in kwargs["tasks"][tool_name]["outputs"]:
            step["out"].append({"id": out["id"]})
        """
        inputs
        outputs
        expression tools

        b = task.attr("body")
        if b is not None:
            ihandle(b, context=step, assignments=assignments, **kwargs)
    
        for taskinp in kwargs["tasks"][ihandle(task.attr("task"))[1:]]["inputs"]:
            f = [stepinp for stepinp in step["in"] if stepinp["id"] == taskinp["id"]]
            if not f and taskinp.get("default") is None:
                newinp = "%s_%s" % (stepid, taskinp["id"])
                context["inputs"].append({
                    "id": newinp,
                    "type": taskinp["type"]
                })
                step["in"].append({
                    "id": taskinp["id"],
                    "source": "%s" % (newinp)
                })
        """
        steps.append(step)
    return steps


def handleWorkflowOutputs(item, **kwargs):
    raise NotImplementedError


def handleInputs(item, **kwargs):
    for m in item.attr("map"):
        ihandle(m, **kwargs)


def handleMultiply(ex, **kwargs):
    return ihandle(ex.attr("lhs"), **kwargs) + " * " + ihandle(ex.attr("rhs"), **kwargs)


def handleAdd(ex, **kwargs):
    return ihandle(ex.attr("lhs"), **kwargs) + " + " + ihandle(ex.attr("rhs"), **kwargs)


def handleMemberAccess(item, **kwargs):
    mem = ihandle(item.attr("value").attr("lhs"), **kwargs) + "." + ihandle(item.attr("value").attr("rhs"), **kwargs)
    kwargs["depends_on"].add(mem)
    if mem in kwargs["filevars"]:
        mem = mem + ".path"
    return mem


def handleIOMapping(item, context=None, assignments=None, filevars=None, **kwargs):
    mp = {"id": ihandle(item.attr("key"))}
    if (item.attr("value").name in ("MemberAccess") and
                item.attr("value").attr("lhs").str == "identifier" and
                item.attr("value").attr("rhs").str == "identifier"):
        mp["source"] = assignments["%s.%s" % (ihandle(item.attr("value").attr("lhs")),
                                              ihandle(item.attr("value").attr("rhs")))]
    else:
        depends_on = set()
        mp["valueFrom"] = "$(" + ihandle(item.attr("value"),
                                         in_expression=True,
                                         depends_on=depends_on,
                                         filevars=filevars) + ")"
        for d in depends_on:
            context["inputs"].append({"id": ihandle(d), "source": "%s" % assignments[ihandle(d)]})

    context["inputs"].append(mp)


m = sys.modules[__name__]
for k, v in m.__dict__.copy().items():
    if k.startswith("handle"):
        handlers[k[6:]] = v

# factory = cwltool.factory.Factory()

env = Environment(
    loader=FileSystemLoader(os.path.abspath(os.path.join(os.path.dirname(__file__), 'templates'))),
    trim_blocks=True,
    lstrip_blocks=True)
main_template = env.get_template('cwltool.j2')


def printstuff(wdl_code, directory=os.getcwd()):
    # Parse source code into abstract syntax tree
    ast = wdl.parser.parse(wdl_code).ast()
    # ast = AST()
    # Print out abstract syntax tree
    # print(ast.dumps(indent=2))

    cwl = []
    tasks = {}

    # Find all 'Task' ASTs
    task_asts = wdl.find_asts(ast, 'Task')
    for task_ast in task_asts:
        a = ihandle(task_ast)
        # cwl.append(a)
        export_tool(a, directory)
        tasks[ihandle(task_ast.attr("name"))] = a

    # Find all 'Workflow' ASTs
    workflow_asts = wdl.find_asts(ast, 'Workflow')
    # lastwf = None
    for workflow_ast in workflow_asts:
        wf = ihandle(workflow_ast, tasks=tasks)
        export_tool(wf, directory)
        # lastwf = workflow_ast.attr("name").source_string

    cwl = {"$graph": cwl, "id": "", "$base": "http://wdl"}

    print(json.dumps(cwl, indent=4))

    main_template.render()
    # f = factory.make(cwl)
    # print(f(cgrep_pattern="python"))


def export_tool(tool, directory):
    print(json.dumps(tool, indent=4))
    data = main_template.render(version=__version__,
                                code=json.dumps(tool, indent=4))
    filename = '{0}.cwl'.format(tool['id'])
    filename = os.path.join(directory, filename)
    with open(filename, 'w') as f:
        f.write(data)


def process_file(file):
    with open(file) as f:
        k = f.read()
    k.replace('\n', '')
    directory = os.path.basename(os.path.abspath(file)).replace('.wdl', '')
    os.mkdir(directory)
    printstuff(k, directory)


def main():
    parser = argparse.ArgumentParser(description='Convert a WDL workflow to CWL')
    parser.add_argument('workflow', help='a WDL workflow')
    # TODO: directory to store CWL files
    # TODO:
    args = parser.parse_args()
    process_file(args.workflow)


if __name__ == '__main__':
    main()
