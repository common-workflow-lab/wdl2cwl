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
            "id": "dbsnp",
            "type": "string?",
            "doc": "dbSNP file"
        },
        {
            "id": "doNotValidateFilteredRecords",
            "type": "boolean?",
            "doc": "skip validation on filtered records"
        },
        {
            "id": "validateGVCF",
            "type": "boolean?",
            "doc": "Validate this file as a GVCF"
        },
        {
            "id": "validationTypeToExclude",
            "type": "string[]?",
            "doc": "which validation type to exclude from a full strict validation"
        },
        {
            "id": "variant",
            "type": "string",
            "doc": "Input VCF file"
        },
        {
            "id": "warnOnErrors",
            "type": "boolean?",
            "doc": "just emit warnings on errors instead of terminating the run at the first instance"
        }
    ],
    "id": "ValidateVariants",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T ValidateVariants \\\t\t\t-R $(inputs.ref.path) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t$(\"-D \" + inputs.dbsnp) \\\t\t\t-doNotValidateFilteredRecords $(inputs.doNotValidateFilteredRecords) \\\t\t\t-gvcf $(inputs.validateGVCF) \\\t\t\t-Xtype $(inputs.validationTypeToExclude) \\\t\t\t-V $(inputs.variant) \\\t\t\t-warnOnErrors $(inputs.warnOnErrors) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}