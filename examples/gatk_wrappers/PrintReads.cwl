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
            "id": "input_file",
            "type": "string[]",
            "doc": "Input file containing sequence data (BAM or CRAM)"
        },
        {
            "id": "intervals",
            "type": "string[]?",
            "doc": "One or more genomic intervals over which to operate"
        },
        {
            "id": "BQSR",
            "type": "File?",
            "doc": "Input covariates table file for on-the-fly base quality score recalibration"
        },
        {
            "id": "nctVal",
            "type": "int?"
        },
        {
            "id": "number",
            "type": "int?",
            "doc": "Print the first n reads from the file, discarding the rest"
        },
        {
            "id": "out",
            "type": "string?",
            "doc": "Write output to this BAM filename instead of STDOUT"
        },
        {
            "id": "platform",
            "type": "string?",
            "doc": "Exclude all reads with this platform from the output"
        },
        {
            "id": "readGroup",
            "type": "string?",
            "doc": "Exclude all reads with this read group from the output"
        },
        {
            "id": "sample_file",
            "type": "string?",
            "doc": "File containing a list of samples (one per line). Can be specified multiple times"
        },
        {
            "id": "sample_name",
            "type": "string?",
            "doc": "Sample name to be included in the analysis. Can be specified multiple times."
        },
        {
            "id": "simplify",
            "type": "boolean?",
            "doc": "Simplify all reads"
        }
    ],
    "id": "PrintReads",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T PrintReads \\\t\t\t-R $(inputs.ref.path) \\\t\t\t--input_file $(inputs.input_file) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t$(\"--BQSR \" + inputs.BQSR) \\\t\t\t$(\"-nct\" + inputs.nctVal) \\\t\t\t-n $(inputs.number) \\\t\t\t-o $(inputs.out) \\\t\t\t$(\"-platform \" + inputs.platform) \\\t\t\t$(\"-readGroup \" + inputs.readGroup) \\\t\t\t-sf $(inputs.sample_file) \\\t\t\t-sn $(inputs.sample_name) \\\t\t\t-s $(inputs.simplify) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}