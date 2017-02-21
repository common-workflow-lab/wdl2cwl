cwlVersion: v1.0
class: Workflow
requirements: 
- class: ScatterFeatureRequirement
inputs:
  inputSamplesFiles: 
    type:
      type: array
      items: File

outputs:
  count:
    outputSource: wc/count
    type: 
      type: array
      items: int
    

steps:
  wc:
    run: wc.cwl
    scatter: file1
    in:
      file1: inputSamplesFiles
    out: [count]