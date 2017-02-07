#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "arguments": [
        {
            "valueFrom": "    java -jar $(inputs.GATK.path) \\        -T HaplotypeCaller \\        -ERC GVCF \\        -R $(inputs.RefFasta.path) \\        -I $(inputs.bamFile.path) \\        -o $(inputs.sampleName)_rawLikelihoods.g.vcf   ",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0",
    "baseCommand": [],
    "inputs": [
        {
            "id": "GATK",
            "type": "File"
        },
        {
            "id": "RefFasta",
            "type": "File",
                      "secondaryFiles": [
            "^.dict",
            ".fai"]
        },
        {
            "id": "RefIndex",
            "type": "File"
        },
        {
            "id": "RefDict",
            "type": "File"
        },
        {
            "id": "sampleName",
            "type": "string"
        },
        {
            "id": "bamFile",
            "type": "File"
        },
        {
            "id": "bamIndex",
            "type": "File"
        }
    ],
    "outputs": [
        {
            "outputBinding": {
                "glob": "$(inputs.sampleName)_rawLikelihoods.g.vcf"
            },
            "id": "GVCF",
            "type": "File"
        }
    ],
    "requirements": [
        {
            "class": "ShellCommandRequirement"
        },
        {
            "class": "InlineJavascriptRequirement"
        }
    ],
    "id": "HaplotypeCallerERC",
    "class": "CommandLineTool"
}