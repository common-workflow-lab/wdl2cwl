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
            "id": "errorRate",
            "type": "int?",
            "doc": "Base error rate (Phred-scaled)"
        },
        {
            "id": "out",
            "type": "string",
            "doc": "Reads corresponding to variants"
        },
        {
            "id": "readDepth",
            "type": "int?",
            "doc": "Read depth to generate"
        },
        {
            "id": "readLength",
            "type": "int?",
            "doc": "Read lengths (bp)"
        },
        {
            "id": "readSamplingMode",
            "type": "string?",
            "doc": "Sampling mode"
        },
        {
            "id": "rgPlatform",
            "type": "string?",
            "doc": "Sequencing platform"
        },
        {
            "id": "variant",
            "type": "string",
            "doc": "Input VCF file"
        }
    ],
    "id": "SimulateReadsForVariants",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T SimulateReadsForVariants \\\t\t\t-R $(inputs.ref.path) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t-ER $(inputs.errorRate) \\\t\t\t-o $(inputs.out) \\\t\t\t-DP $(inputs.readDepth) \\\t\t\t-RL $(inputs.readLength) \\\t\t\t-RSM $(inputs.readSamplingMode) \\\t\t\t-RGPL $(inputs.rgPlatform) \\\t\t\t-V $(inputs.variant) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}