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
            "id": "assumeSorted",
            "type": "boolean?",
            "doc": "assumeSorted should be true if the input files are already sorted (based on the position of the variants)"
        },
        {
            "id": "help",
            "type": "boolean?",
            "doc": "Generate the help message"
        },
        {
            "id": "log_to_file",
            "type": "string?",
            "doc": "Set the logging location"
        },
        {
            "id": "logging_level",
            "type": "string?",
            "doc": "Set the minimum level of logging"
        },
        {
            "id": "outputFile",
            "type": "File",
            "doc": "output file"
        },
        {
            "id": "reference",
            "type": "File",
            "doc": "genome reference file <name>.fasta"
        },
        {
            "id": "variant",
            "type": "File[]",
            "doc": "Input VCF file/s"
        },
        {
            "id": "variant_index_parameter",
            "type": "int?",
            "doc": "the parameter (bin width or features per bin) to pass to the VCF/BCF IndexCreator"
        },
        {
            "id": "variant_index_type",
            "type": "string?",
            "doc": "which type of IndexCreator to use for VCF/BCF indices"
        },
        {
            "id": "version",
            "type": "boolean?",
            "doc": "Output version information"
        }
    ],
    "id": "CatVariants",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T CatVariants \\\t\t\t-R $(inputs.ref.path) \\\t\t\t-assumeSorted $(inputs.assumeSorted) \\\t\t\t-h $(inputs.help) \\\t\t\t$(\"-log \" + inputs.log_to_file) \\\t\t\t-l $(inputs.logging_level) \\\t\t\t-out $(inputs.outputFile.path) \\\t\t\t-R $(inputs.reference.path) \\\t\t\t-V $(inputs.variant) \\\t\t\tvariant_index_parameter $(inputs.variant_index_parameter) \\\t\t\tvariant_index_type $(inputs.variant_index_type) \\\t\t\t-version $(inputs.version) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}