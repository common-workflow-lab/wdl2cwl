#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "cwlVersion": "v1.0",
    "inputs": [
        {
            "type": "File",
            "id": "GATK"
        },
        {
            "type": "File",
            "id": "RefFasta"
        },
        {
            "type": "File",
            "id": "RefIndex"
        },
        {
            "type": "File",
            "id": "RefDict"
        },
        {
            "type": "string",
            "id": "sampleName"
        },
        {
            "type": "File",
            "id": "bamFile"
        },
        {
            "type": "File",
            "id": "bamIndex"
        }
    ],
    "outputs": [
        {
            "outputBinding": {
                "glob": "$(inputs.sampleName)_rawLikelihoods.g.vcf"
            },
            "type": "File",
            "id": "GVCF"
        }
    ],
    "id": "HaplotypeCallerERC",
    "requirements": [
        {
            "class": "ShellCommandRequirement"
        },
        {
            "class": "InlineJavascriptRequirement"
        }
    ],
    "arguments": [
        {
            "shellQuote": false,
            "valueFrom": "    java -jar $(inputs.GATK.path) \\        -T HaplotypeCaller \\        -ERC GVCF \\        -R $(inputs.RefFasta.path) \\        -I $(inputs.bamFile.path) \\        -o $(inputs.sampleName)_rawLikelihoods.g.vcf   "
        }
    ],
    "baseCommand": [],
    "class": "CommandLineTool"
}