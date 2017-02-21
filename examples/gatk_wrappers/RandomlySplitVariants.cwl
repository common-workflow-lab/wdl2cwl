#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "inputs": [
        {
            "id": "gatk",
            "type": "File",
            "doc": "Executable jar for the GenomeAnalysisTK"
        },
        {
            "id": "ref",
            "type": "File",
            "doc": "fasta file of reference genome"
        },
        {
            "id": "refIndex",
            "type": "File",
            "doc": "Index file of reference genome"
        },
        {
            "id": "refDict",
            "type": "File",
            "doc": "dict file of reference genome"
        },
        {
            "id": "userString",
            "type": "string?",
            "doc": "An optional parameter which allows the user to specify additions to the command line at run time"
        },
        {
            "id": "intervals",
            "type": "string[]?",
            "doc": "One or more genomic intervals over which to operate"
        },
        {
            "id": "fractionToOut1",
            "type": "float?",
            "doc": "Fraction of records to be placed in out1 (must be 0 >= fraction <= 1); all other records are placed in out2"
        },
        {
            "id": "numOfOutputVCFFiles",
            "type": "int?",
            "doc": "number of output VCF files. Only works with SplitToMany = true"
        },
        {
            "id": "out1",
            "type": "string?",
            "doc": "File #1 to which variants should be written"
        },
        {
            "id": "out2",
            "type": "File?",
            "doc": "File #2 to which variants should be written"
        },
        {
            "id": "prefixForAllOutputFileNames",
            "type": "string?",
            "doc": "the name of the output VCF file will be: <baseOutputName>.split.<number>.vcf. Required with SplitToMany option"
        },
        {
            "id": "splitToManyFiles",
            "type": "boolean?",
            "doc": "split (with uniform distribution) to more than 2 files. numOfFiles and baseOutputName parameters are required"
        },
        {
            "id": "variant",
            "type": "string",
            "doc": "Input VCF file"
        }
    ],
    "id": "RandomlySplitVariants",
    "baseCommand": [],
    "class": "CommandLineTool",
    "requirements": [
        {
            "class": "ShellCommandRequirement"
        },
        {
            "class": "InlineJavascriptRequirement"
        },
        {
            "dockerPull": "broadinstitute/genomes-in-the-cloud:2.2.2-1466113830",
            "class": "DockerRequirement"
        }
    ],
    "outputs": [
        {
            "id": "taskOut",
            "outputBinding": {
                "glob": "$(inputs.out)"
            },
            "type": "string"
        }
    ],
    "arguments": [
        {
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T RandomlySplitVariants \\\t\t\t-R $(inputs.ref.path) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t-fraction $(inputs.fractionToOut1) \\\t\t\t-N $(inputs.numOfOutputVCFFiles) \\\t\t\t-o1 $(inputs.out1) \\\t\t\t$(\"-o2 \" + inputs.out2) \\\t\t\t$(\"-baseOutputName \" + inputs.prefixForAllOutputFileNames) \\\t\t\t-splitToMany $(inputs.splitToManyFiles) \\\t\t\t-V $(inputs.variant) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}