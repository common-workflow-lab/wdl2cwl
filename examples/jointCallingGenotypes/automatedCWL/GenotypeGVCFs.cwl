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
            "type": "File[]",
            "id": "GVCFs"
        }
    ],
    "outputs": [
        {
            "outputBinding": {
                "glob": "$(inputs.sampleName)_rawVariants.vcf"
            },
            "type": "File",
            "id": "rawVCF"
        }
    ],
    "id": "GenotypeGVCFs",
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
            "valueFrom": "${            var GVCFs_separated = '';            for (var i=0; i<inputs.GVCFs.length; i++){                GVCFs_separated = GVCFs_separated + inputs.GVCFs[i].path + ' -V ';            }            GVCFs_separated = GVCFs_separated.replace(/ -V $/, '');            return \"    java -jar \" + inputs.GATK.path + \" \\        -T GenotypeGVCFs \\        -R \" + inputs.RefFasta.path + \" \\        -V \" + GVCFs_separated + \" \\        -o \" + inputs.sampleName + \"_rawVariants.vcf  \"}"
        }
    ],
    "baseCommand": [],
    "class": "CommandLineTool"
}