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
            "id": "annotation",
            "type": "string[]?",
            "doc": "One or more specific annotations to recompute.  The single value 'none' removes the default annotations"
        },
        {
            "id": "breakBandsAtMultiplesOf",
            "type": "int?",
            "doc": "If > 0, reference bands will be broken up at genomic positions that are multiples of this number"
        },
        {
            "id": "convertToBasePairResolution",
            "type": "boolean?",
            "doc": "If specified, convert banded gVCFs to all-sites gVCFs"
        },
        {
            "id": "dbsnp",
            "type": "string?",
            "doc": "dbSNP file"
        },
        {
            "id": "group",
            "type": "string?",
            "doc": "One or more classes/groups of annotations to apply to variant calls"
        },
        {
            "id": "out",
            "type": "string?",
            "doc": "File to which the combined gVCF should be written"
        },
        {
            "id": "variant",
            "type": "string[]",
            "doc": "One or more input gVCF files"
        }
    ],
    "id": "CombineGVCFs",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T CombineGVCFs \\\t\t\t-R $(inputs.ref.path) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t-A $(inputs.annotation) \\\t\t\t-breakBandsAtMultiplesOf $(inputs.breakBandsAtMultiplesOf) \\\t\t\t-bpResolution $(inputs.convertToBasePairResolution) \\\t\t\t$(\"-D \" + inputs.dbsnp) \\\t\t\t-G $(inputs.group) \\\t\t\t-o $(inputs.out) \\\t\t\t-V $(inputs.variant) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}