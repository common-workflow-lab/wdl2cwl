class: Workflow

cwlVersion: v1.0

requirements: 
- class: ScatterFeatureRequirement
- class: InlineJavascriptRequirement
- class: StepInputExpressionRequirement


inputs:
  inputSamplesFile: 
    type: File
  gatk:
    type: File
  refIndex:
    type: File
  refFasta: 
    type: File
  refDict:
    type: File
    
steps:
  read_tsv:
    run: read_tsv.cwl
    in: 
      infile: inputSamplesFile
    out: [inputSamples]
  HaplotypeCallerERC:
    run: HaplotypeCallerERC.cwl
    scatter: [sampleName, bamFile, bamIndex]
    scatterMethod: dotproduct
    in:
      GATK:
        source: gatk
      RefFasta: refFasta
      RefIndex: refIndex
      sampleName:
        source: "#read_tsv/inputSamples"
        valueFrom:
          $(self[0])
      bamFile:
        source: "#read_tsv/inputSamples"
        valueFrom:
          $(self[1])
      bamIndex:
        source: "#read_tsv/inputSamples"
        valueFrom:
          $(self[2])   
    out: [GVCF]

  GenotypeGVCFs:
    run: GenotypeGVCFs.cwl
    in:
      GATK: gatk
      RefFasta: refFasta
      RefIndex: refIndex
      RefDict: refDict
      sampleName: 
        valueFrom:
          $("CEUtrio")
      GVCFs: HaplotypeCallerERC/GVCF
    out: [rawGVCF]  

outputs:
  rawGVCF:
    type: File
    outputSource: GenotypeGVCFs/rawGVCF
  