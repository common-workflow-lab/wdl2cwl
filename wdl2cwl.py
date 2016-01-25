import wdl.parser
import json
import sys
import cwltool.factory
import logging

handlers = {}

typemap = {"Int": "int",
           "File": "File",
           "String": "string"}

def ihandle(i, *k, **kw):
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
                kw.get("depends_on").append(i)
                return "inputs." + i.source_string
            else:
                return i.source_string
        else:
            raise Exception("Unknown terminal '%s'" % i.str )
    else:
        return handlers[i.name](i, *k, **kw)

def handleDocument(item):
    defs = []
    for i in item.attr("imports"):
        ihandle(i)
    for i in item.attr("definitions"):
        defs.append(ihandle(i))
    return defs

def handleImport(item):
    print("import")

def handleTask(item):
    tool = {"id": ihandle(item.attr("name")),
            "class": "CommandLineTool",
            "baseCommand": [],
            "requirements": [
                {"class": "ShellCommandRequirement"},
             ]}
    tool["inputs"] = []
    tool["outputs"] = []
    for i in item.attr("declarations"):
        tool["inputs"].append(ihandle(i))
    for i in item.attr("sections"):
        ihandle(i, context=tool)

    return tool

def handleWorkflow(item, **kwargs):
    wf = {"id": ihandle(item.attr("name")),
          "class": "Workflow",
          "inputs": [],
          "outputs": [],
          "steps": []}
    assignments = {}
    for i in item.attr("body"):
        if i.name == "Call":
            wf["steps"].append(ihandle(i, assignments=assignments, **kwargs))
        if i.name == "Declaration":
            wf["inputs"].append(ihandle(i, wf, assignments))
        if i.name == "WorkflowOutput":
            wf["outputs"].append(ihandle(i))
    return wf

def handleDeclaration(item, context, assignments):
    assignments[ihandle(item.attr("name"))] = "#%s/%s" % (context["id"], ihandle(item.attr("name")))
    return {"id": ihandle(item.attr("name")),
            "type": ihandle(item.attr("type"))}

def handleRawCommand(item, context):
    s = ""
    for p in item.attr("parts"):
        s += ihandle(p, context)
    context["arguments"] = [{"valueFrom": s}]

def handleOutputs(item, context):
    for a in item.attr("attributes"):
        out = {"id": ihandle(a.attr("var")),
               "type": ihandle(a.attr("type")),
               "outputBinding": {}}
        e = ihandle(a.attr("expression"),
                    is_expression=True,
                    depends_on=[],
                    outputs=out,
                    tool=context)
        if e != "self":
            out["outputBinding"]["outputEval"] = "$(" + e + ")"
        context["outputs"].append(out)

def handleFunctionCall(item, **kwargs):
    if ihandle(item.attr("name")) == "stdout":
        kwargs["tool"]["stdout"] = "__stdout"
        kwargs["outputs"]["outputBinding"]["glob"] = "__stdout"
        return "self"
    if ihandle(item.attr("name")) == "read_int":
        kwargs["outputs"]["outputBinding"]["loadContents"] = True
        return "parseInt(" + ihandle(item.attr("params")[0], **kwargs) + ".contents)"
    if ihandle(item.attr("name")) == "read_string":
        kwargs["outputs"]["outputBinding"]["loadContents"] = True
        return ihandle(item.attr("params")[0], **kwargs) + ".contents"
    else:
        raise Exception("Unknown function '%s'" % ihandle(item.attr("name")))
    pass

def handleCommandParameter(item, context):
    return "$(" + ihandle(item.attr("expr"), in_expression=True, depends_on=[]) + ")"

def handleCall(item, **kwargs):
    if item.attr("alias") is not None:
        stepid = ihandle(item.attr("alias"))
    else:
        stepid = ihandle(item.attr("task"))[1:]

    step = {"id": stepid,
            "inputs": [],
            "outputs": [],
            "run": ihandle(item.attr("task"))}

    for out in kwargs["tasks"][ihandle(item.attr("task"))[1:]]["outputs"]:
        step["outputs"].append({"id": out["id"]})

    b = item.attr("body")
    if b is not None:
        ihandle(b, step, kwargs["assignments"])

    return step

def handleCallBody(item, context, assignments):
    for i in item.attr("io"):
        ihandle(i, context, assignments)

def handleWorkflowOutputs(item):
    pass

def handleInputs(item, context, assignments):
    for m in item.attr("map"):
        ihandle(m, context, assignments)

def handleMultiply(ex, **kwargs):
    return ihandle(ex.attr("lhs"), **kwargs) + " * " + ihandle(ex.attr("rhs"), **kwargs)

def handleAdd(ex, **kwargs):
    return ihandle(ex.attr("lhs"), **kwargs) + " + " + ihandle(ex.attr("rhs"), **kwargs)

def handleMemberAccess(item):
    return ihandle(item.attr("value").attr("lhs")) + "." + ihandle(item.attr("value").attr("rhs"))

def handleIOMapping(item, context, assignments):
    mp = {"id": ihandle(item.attr("key"))}
    if (item.attr("value").name in ("MemberAccess") and
        item.attr("value").attr("lhs").str == "identifier" and
        item.attr("value").attr("rhs").str == "identifier"):
        mp["source"] = "#%s/%s" % (ihandle(item.attr("value").attr("lhs")),
                                  ihandle(item.attr("value").attr("rhs")))
    else:
        depends_on = []
        mp["valueFrom"] = "$(" + ihandle(item.attr("value"),
                                         in_expression=True, depends_on=depends_on) + ")"
        for d in depends_on:
            context["inputs"].append({"id": ihandle(d), "source": "%s" % assignments[ihandle(d)]})

    context["inputs"].append(mp)

m = sys.modules[__name__]
for k,v in m.__dict__.items():
    if k.startswith("handle"):
        handlers[k[6:]] = v

wdl_code = """
task my_task {
  File file
  command {
    ./my_binary --input=${file} > results
  }
  output {
    File results = "results"
  }
}

workflow my_wf {
  call my_task
}
"""

wdl_code2 = """
task my_task {
  command {
    true
  }
}
workflow test {
  Int a = (1 + 2) * 3
  call my_task {
    input: var=a*2, var2="file"+".txt"
  }
}
"""

wdl_code3 = """
task ps {
  command {
    ps
  }
  output {
    File procs = stdout()
  }
}

task cgrep {
  String pattern
  File in_file
  command {
    grep '${pattern}' ${in_file} | wc -l
  }
  output {
    Int count = read_int(stdout())
  }
}

task wc {
  File in_file
  command {
    cat ${in_file} | wc -l
  }
  output {
    Int count = read_int(stdout())
  }
}

workflow three_step {
  call ps
  call cgrep {
    input: in_file=ps.procs
  }
  call wc {
    input: in_file=ps.procs
  }
}
"""

factory = cwltool.factory.Factory()

def printstuff(wdl_code):
    # Parse source code into abstract syntax tree
    ast = wdl.parser.parse(wdl_code).ast()

    # Print out abstract syntax tree
    print(ast.dumps(indent=2))

    cwl = []
    tasks = {}

    # Find all 'Task' ASTs
    task_asts = wdl.find_asts(ast, 'Task')
    for task_ast in task_asts:
        a = ihandle(task_ast)
        cwl.append(a)
        tasks[ihandle(task_ast.attr("name"))] = a

    # Find all 'Workflow' ASTs
    workflow_asts = wdl.find_asts(ast, 'Workflow')
    lastwf = None
    for workflow_ast in workflow_asts:
        cwl.append(ihandle(workflow_ast, tasks=tasks))
        lastwf = workflow_ast.attr("name").source_string

    cwl = {"$graph": cwl, "id": "", "$base": "http://wdl"}

    print(json.dumps(cwl, indent=4))

    logging.getLogger("cwltool").setLevel(logging.DEBUG)

    f = factory.make(cwl, frag="http://wdl#" + lastwf, debug=True)
    print f()


#printstuff(wdl_code)
printstuff(wdl_code2)
printstuff(wdl_code3)
