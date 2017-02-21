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
            "id": "ntVal",
            "type": "int?"
        },
        {
            "id": "known",
            "type": "string[]?",
            "doc": "Input VCF file with known indels"
        },
        {
            "id": "maxIntervalSize",
            "type": "int?",
            "doc": "maximum interval size; any intervals larger than this value will be dropped"
        },
        {
            "id": "minReadsAtLocus",
            "type": "int?",
            "doc": "minimum reads at a locus to enable using the entropy calculation"
        },
        {
            "id": "mismatchFraction",
            "type": "float?",
            "doc": "fraction of base qualities needing to mismatch for a position to have high entropy"
        },
        {
            "id": "out",
            "type": "File?",
            "doc": "An output file created by the walker.  Will overwrite contents if file exists"
        },
        {
            "id": "windowSize",
            "type": "int?",
            "doc": "window size for calculating entropy or SNP clusters"
        }
    ],
    "id": "RealignerTargetCreator",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T RealignerTargetCreator \\\t\t\t-R $(inputs.ref.path) \\\t\t\t--input_file $(inputs.input_file) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t$(\"-nt\" + inputs.ntVal) \\\t\t\t-known $(inputs.known) \\\t\t\t-maxInterval $(inputs.maxIntervalSize) \\\t\t\t-minReads $(inputs.minReadsAtLocus) \\\t\t\t-mismatch $(inputs.mismatchFraction) \\\t\t\t$(\"-o \" + inputs.out) \\\t\t\t-window $(inputs.windowSize) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}