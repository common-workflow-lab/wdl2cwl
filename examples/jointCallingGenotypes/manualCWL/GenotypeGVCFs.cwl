cwlVersion: v1.0
class: CommandLineTool
requirements: 
- class: ShellCommandRequirement
- class: InlineJavascriptRequirement

arguments: 
- shellQuote: false
  valueFrom: ${var gvcf = '';
          for (var i=0; i<inputs.GVCFs.length; i++){
            gvcf = gvcf + inputs.GVCFs[i].path + " -V ";
          }
          gvcf = gvcf.replace(/ -V $/, "");
          return "java -jar "+ inputs.GATK.path +" \
                      -T GenotypeGVCFs \
                      -R " + inputs.RefFasta.path + " \
                      -V " + gvcf + " \
                      -o " + inputs.sampleName + "_rawVariants.vcf"
                      }
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
  sampleName:
    type: string
  GVCFs:
    type: File[]

outputs:
    rawGVCF:
        type: File
        outputBinding:
            glob: "$(inputs.sampleName)_rawVariants.vcf"