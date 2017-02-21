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
            "id": "allowMissingData",
            "type": "boolean?",
            "doc": "If provided, we will not require every record to contain every field"
        },
        {
            "id": "fields",
            "type": "string[]?",
            "doc": "The name of each field to capture for output in the table"
        },
        {
            "id": "genotypeFields",
            "type": "string[]?",
            "doc": "The name of each genotype field to capture for output in the table"
        },
        {
            "id": "maxRecords",
            "type": "int?",
            "doc": "If provided, we will emit at most maxRecord records to the table"
        },
        {
            "id": "moltenize",
            "type": "boolean?",
            "doc": "If provided, we will produce molten output"
        },
        {
            "id": "out",
            "type": "string?",
            "doc": "File to which results should be written"
        },
        {
            "id": "showFiltered",
            "type": "boolean?",
            "doc": "If provided, field values from filtered records will be included in the output"
        },
        {
            "id": "splitMultiAllelic",
            "type": "boolean?",
            "doc": "If provided, we will split multi-allelic records into multiple lines of output"
        },
        {
            "id": "variant",
            "type": "string[]",
            "doc": "Input VCF file"
        }
    ],
    "id": "VariantsToTable",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T VariantsToTable \\\t\t\t-R $(inputs.ref.path) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t-AMD $(inputs.allowMissingData) \\\t\t\t-F $(inputs.fields) \\\t\t\t-GF $(inputs.genotypeFields) \\\t\t\t-M $(inputs.maxRecords) \\\t\t\t-moltenize $(inputs.moltenize) \\\t\t\t-o $(inputs.out) \\\t\t\t-raw $(inputs.showFiltered) \\\t\t\t-SMA $(inputs.splitMultiAllelic) \\\t\t\t-V $(inputs.variant) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}