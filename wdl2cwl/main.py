from __future__ import print_function

import argparse
import json
import os
import re
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
                # kw.get("depends_on").add(i)
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
            "requirements": [{"class": "ShellCommandRequirement"},
                             {"class": "InlineJavascriptRequirement"}],
            "inputs": [],
            "outputs": []}

    filevars = kwargs.get("filevars", set())
    for i in item.attr("declarations"):
        # NO! declarations can be expressions of other inputs and thus must not be treated as file inputs
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
            # NO! declarations can be expressions of other inputs and thus must not be treated as inputs
            inp = ihandle(i, context=wf, assignments=assignments,
                          filevars=filevars, **kwargs)
            if inp:
                wf["inputs"].append(inp)
        elif i.name == "WorkflowOutputs":
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
            # TODO: mention different measure units in the docs: megabytes (wdl) vs. mebibytes (cwl)
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
    expression = item.attr("expression")
    kwargs['context'] = context
    if expression is None:
        # assignments[param_id] = "#%s/%s" % (context["id"], param_id)
        if param_type == "File":
            filevars.add(param_id)
        return {"id": param_id,
                "type": param_type}
    else:
        kwargs['outputName'] = param_id
        result = ihandle(expression, **kwargs)


def handleRawCommand(item, context=None, **kwargs):
    s = body = ''
    symbols = []
    for p in item.attr("parts"):
        kwargs['command'] = s
        part = ihandle(p, **kwargs)
        if type(part) is list:
            body += part[0]
            s += part[1]
            symbols.append(part[1])
        else:
            s += part
    if body:
        symbols.append('\$\(.*?\)')
        l = re.split('(' + '|'.join(symbols) + ')', s)
        res = []
        for k in l:
            if k in set(symbols[:-1]):
                res.append(k)
            elif '$' in k:
                res.append(re.sub('[$()]', '', k))
            else:
                res.append("\"" + k + "\"")
        s = ' + '.join(res)
        result = '${' + body + 'return ' + s + '}'
    else:
        result = s
    result = result.replace('\n', '')
    context["arguments"] = [{"valueFrom": result, "shellQuote": False}]


def handleCommandParameter(item, context=None, **kwargs):
    attributes = item.attr('attributes')
    for option in attributes:
        key = ihandle(option.attr('key'))

        if key == 'sep':
            parameter = item.attr('expr').source_string
            string = parameter + '_separated'
            preprocessing = """
            var {2} = '';
            for (var i=0; i<inputs.{0}.length; i++){{
                {2} = {2} + inputs.{0}[i].path + '{1}';
            }}
            {2} = {2}.replace(/{1}$/, '');
            """.format(parameter,
                       ihandle(option.attr('value')).replace('\"', ""),
                       string)

            return [preprocessing, string]

    return "$(" + ihandle(item.attr("expr"), in_expression=True, depends_on=set(), **kwargs) + ")"


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
        e = e.replace('{', '(').replace('}', ')').replace("\"", '')
        if not str(re.search('\((.+?)\)', e)).startswith('inputs'):
            index = e.index('(')
            e = e[:index+1] + 'inputs.' + e[index+1:]
        if e != "self":
            out["outputBinding"]["glob"] = e
        context["outputs"].append(out)


def handleFunctionCall(item, **kwargs):
    global expression_tools

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
        params = [ihandle(param) for param in item.attr('params')]
        tool_name = step_name = 'read_tsv'
        tool_file = tool_name + '.cwl'
        # handle duplicate names
        read_tsv_steps = [step['id'] for step in kwargs['context']['steps'] if step['id'].startswith(step_name)]
        if not read_tsv_steps:
            step_name += '_1'
        else:
            step_name += str(int(read_tsv_steps[-1][-1]) + 1)  # if there are step_1, step_2 - create step_3
        output_name = kwargs['outputName']
        read_tsv_step = {'id': step_name,
                         'run': tool_file,
                         'in': {
                             'infile': params[0]},
                         'out': [output_name]
                         }
        kwargs['context']['steps'].insert(0, read_tsv_step)
        SUBSTITUTIONS = {'outputs': ('outputArray', output_name),
                         'expression': ('outputArray', output_name)}

        expression_tools.append((tool_file, SUBSTITUTIONS))

    # TODO: a lot of other function calls:

    else:
        raise NotImplementedError("Unknown function '%s'" % ihandle(item.attr("name")))
    pass


def handleCall(item, context=None, assignments=None, **kwargs):
    if item.attr("alias") is not None:
        stepid = ihandle(item.attr("alias"))
    else:
        stepid = ihandle(item.attr("task")).strip('#')

    step = {"id": stepid,
            "in": [],
            "out": [],
            "run": ihandle(item.attr("task")).strip('#') + '.cwl'}

    for out in kwargs["tasks"][ihandle(item.attr("task")).strip('#')]["outputs"]:
        step["out"].append({"id": out["id"]})
        mem = "%s.%s" % (stepid, out["id"])
        assignments[mem] = "#%s/%s/%s" % (context["id"], stepid, out["id"])
        if out["type"] == "File":
            kwargs["filevars"].add(mem)

    b = item.attr("body")
    if b is not None:
        ihandle(b, context=step, assignments=assignments, **kwargs)

    for taskinp in kwargs["tasks"][ihandle(item.attr("task")).strip('#')]["inputs"]:
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
    kwargs['context']['requirements'].extend([{'class': 'ScatterFeatureRequirement'},
                                              {'class': 'StepInputExpressionRequirement'}])
    # TODO: smart scattering (over subworkflows rather than individual steps)
    steps = []

    for task in item.attr('body'):
        tool_name = ihandle(task.attr("task")).strip('#')
        alias = task.attr("alias")
        if alias is not None:
            stepid = ihandle(alias)
        else:
            stepid = tool_name
        step = {"id": stepid,
                "in": [],
                "out": [],
                "run": tool_name + '.cwl'}
        scatter_vars = [ihandle(item.attr('item')), ihandle(item.attr('collection'))]

        # TODO: handle declarations inside steps (?)
        # Explanation: in WDL - scatter (scatter_vars[0] in scatter_vars[1])
        kwargs['scatter_vars'] = scatter_vars
        kwargs['scatter_inputs'] = []
        kwargs['step'] = step
        for out in kwargs["tasks"][tool_name]["outputs"]:
            step["out"].append({"id": out["id"]})

        b = task.attr("body")
        if b is not None:
            ihandle(b, **kwargs)
        scatter_inputs = kwargs['scatter_inputs']
        if type(scatter_inputs) is list and len(scatter_inputs) > 1:
            step['scatterMethod'] = 'dotproduct'
        step.update({"scatter": kwargs['scatter_inputs']})
        steps.append(step)
    return steps


def handleIOMapping(item, context=None, assignments=None, filevars=None, **kwargs):
    mp = {"id": ihandle(item.attr("key"))}

    scatter_vars = kwargs.get('scatter_vars', '')

    value = ihandle(item.attr("value"))
    if value.endswith(']'):
        wdl_var = value[:-3]
    else:
        wdl_var = value
    if scatter_vars:
        if (wdl_var == scatter_vars[0]):
            kwargs['scatter_inputs'].append(mp['id'])
            source = 'inputs'
            for step in context['steps']:
                if scatter_vars[1] in step['out']:
                    source = step['id']
            mp["source"] = "#{0}/{1}".format(source, scatter_vars[1])
            if scatter_vars[1] in mp.get("source", ""):
                mp["valueFrom"] = "$(" + ihandle(item.attr("value"),
                                                 in_expression=False,
                                                 filevars=filevars).replace(wdl_var, "self") + ")"
        else:
            mp['source'] = value
    else:
        if hasattr(item.attr("value"), 'str') and item.attr('value').str == 'string':
            mp['valueFrom'] = '$({0})'.format(value)
        else:
            mp['source'] = value
    # depends_on = set()
    # mp["valueFrom"] = "$(" + ihandle(item.attr("value"),
    #                                  in_expression=True,
    #                                  depends_on=depends_on,
    #                                  filevars=filevars) + ")"

    # context["in"].append(mp)
    # for d in depends_on:
    #     context["in"].append({"id": ihandle(d), "source": "%s" % assignments[ihandle(d)]})
    # kwargs['scatter_inputs'].append(d)
    if scatter_vars:
        kwargs['step']["in"].append(mp)
    else:
        context['in'].append(mp)


def handleWorkflowOutputs(item, **kwargs):
    # TODO: if output section not present, output all results of all tasks
    outputs = []
    for output in item.attr('outputs'):
        cwl_output = {}
        for key, value in output.attributes.items():
            if value:
                res = ihandle(value)
                res = res.split('.')
                if len(res) > 1:
                    cwl_output['id'] = res[1]
                    cwl_output['outputSource'] = res[0] + '/' + res[1]
                outputs.append(cwl_output)
    return outputs


def handleInputs(item, **kwargs):
    for m in item.attr("map"):
        ihandle(m, **kwargs)


def handleMultiply(ex, **kwargs):
    return ihandle(ex.attr("lhs"), **kwargs) + " * " + ihandle(ex.attr("rhs"), **kwargs)


def handleAdd(ex, **kwargs):
    return ihandle(ex.attr("lhs"), **kwargs) + " + " + ihandle(ex.attr("rhs"), **kwargs)


def handleArrayOrMapLookup(ex, **kwargs):
    return ihandle(ex.attr("lhs"), **kwargs) + "[" + ihandle(ex.attr("rhs"), **kwargs) + ']'


def handleMemberAccess(item, **kwargs):
    mem = ihandle(item.attr("lhs"), **kwargs) + "/" + ihandle(item.attr("rhs"), **kwargs)
    # kwargs["depends_on"].add(mem)
    # if mem in kwargs["filevars"]:
    #     mem = mem + ".path"
    return mem


m = sys.modules[__name__]
for k, v in m.__dict__.copy().items():
    if k.startswith("handle"):
        handlers[k[6:]] = v

env = Environment(
    loader=FileSystemLoader(os.path.abspath(os.path.join(os.path.dirname(__file__), 'templates'))),
    trim_blocks=True,
    lstrip_blocks=True)
main_template = env.get_template('cwltool.j2')
expression_tools = []  # [(file, SUBSTITUTIONS)] // SUBSTITUTIONS = {'path/to/substitute', (term, sub)}


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
        tool = ihandle(task_ast)
        # cwl.append(a)
        export_tool(tool, directory)
        tasks[ihandle(task_ast.attr("name"))] = tool

    # Find all 'Workflow' ASTs
    workflow_asts = wdl.find_asts(ast, 'Workflow')
    # lastwf = None
    for workflow_ast in workflow_asts:
        wf = ihandle(workflow_ast, tasks=tasks)
        export_tool(wf, directory)
        # lastwf = workflow_ast.attr("name").source_string

    for expression_tool in expression_tools:
        export_expression_tool(expression_tool[0], expression_tool[1], directory)

    main_template.render()


def export_tool(tool, directory):
    print(json.dumps(tool, indent=4))
    data = main_template.render(version=__version__,
                                code=json.dumps(tool, indent=4))
    filename = '{0}.cwl'.format(tool['id'])
    filename = os.path.join(directory, filename)
    with open(filename, 'w') as f:
        f.write(data)


def export_expression_tool(tool, substitutions, directory):
    replacements = dict([sub for sub in substitutions.values()])
    pattern = re.compile('|'.join(replacements.keys()))
    with open(os.path.join(os.path.dirname(os.path.abspath(__file__)),
                           'expression-tools', tool)) as source:
        with open(os.path.join(directory, tool), 'w') as target:
            for line in source:
                target.write(pattern.sub(lambda x: replacements[x.group()], line))

                # shutil.copy(os.path.join(os.path.dirname(os.path.abspath(__file__)),
                #                          'expression-tools',
                #                          '{0}'.format(tool)),
                #             directory)


def process_file(file, args):
    with open(file) as f:
        k = f.read()
    k.replace('\n', '')
    cwl_directory = os.path.basename(os.path.abspath(file)).replace('.wdl', '')
    if args.directory:
        os.chdir(args.directory)
    os.mkdir(cwl_directory)
    printstuff(k, cwl_directory)


def main():
    parser = argparse.ArgumentParser(description='Convert a WDL workflow to CWL')
    parser.add_argument('workflow', help='a WDL workflow')
    parser.add_argument('-d', '--directory', help='a WDL workflow')
    # TODO: other options
    args = parser.parse_args()
    process_file(args.workflow, args)


if __name__ == '__main__':
    main()
