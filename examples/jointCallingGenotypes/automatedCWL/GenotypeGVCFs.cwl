#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "arguments": [
        {
            "valueFrom": "${            var GVCFs_separated = '';            for (var i=0; i<inputs.GVCFs.length; i++){                GVCFs_separated = GVCFs_separated + inputs.GVCFs[i].path + ' -V ';            }            GVCFs_separated = GVCFs_separated.replace(/ -V $/, '');            return \"    java -jar \" + inputs.GATK.path + \" \\        -T GenotypeGVCFs \\        -R \" + inputs.RefFasta.path + \" \\        -V \" + GVCFs_separated + \" \\        -o \" + inputs.sampleName + \"_rawVariants.vcf  \"}",
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
            "id": "GVCFs",
            "type": {
                "items": "File",
                "type": "array"
            }
        }
    ],
    "outputs": [
        {
            "outputBinding": {
                "glob": "$(inputs.sampleName)_rawVariants.vcf"
            },
            "id": "rawVCF",
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
    "id": "GenotypeGVCFs",
    "class": "CommandLineTool"
}