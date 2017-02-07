cwlVersion: v1.0
class: CommandLineTool
arguments: 
- shellQuote: false
  valueFrom: "cat $(inputs.file1.path) | wc -w" 
requirements: 
- class: ShellCommandRequirement
- class: InlineJavascriptRequirement

baseCommand: []
stdout: "count"

inputs:
  file1:
    type: File

outputs:
    count:
        type: int
        outputBinding:
            glob: "count"
            loadContents: true
            outputEval: "$(parseInt(self[0].contents))"