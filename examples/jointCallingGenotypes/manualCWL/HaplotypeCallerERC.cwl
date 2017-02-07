cwlVersion: v1.0
class: CommandLineTool
requirements: 
- class: ShellCommandRequirement
- class: InlineJavascriptRequirement

arguments: 
- shellQuote: false
  valueFrom: "java -jar $(inputs.GATK.path) \
        -T HaplotypeCaller \
        -ERC GVCF \
        -R $(inputs.RefFasta.path) \
        -I $(inputs.bamFile.path) \
        -o $(inputs.sampleName)_rawLikelihoods.g.vcf" 

baseCommand: []

inputs:
  GATK:
    type: File
  RefIndex:
    type: File
  RefFasta: 
    type: File
    secondaryFiles:
    - ^.dict
    - .fai
,
                      "secondaryFiles": [
            "^.dict",
            ".fai"]
  sampleName:
    type: string
  bamFile:
    type: File
  bamIndex:
    type: File 

outputs:
    GVCF:
        type: File
        outputBinding:
            glob: "$(inputs.sampleName)_rawLikelihoods.g.vcf"