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
            "id": "bad_mate_status_threshold",
            "type": "float?",
            "doc": "The proportion of the loci needed for calling BAD_MATE"
        },
        {
            "id": "coverage_status_threshold",
            "type": "float?",
            "doc": "The proportion of the loci needed for calling LOW_COVERAGE and COVERAGE_GAPS"
        },
        {
            "id": "excessive_coverage_status_threshold",
            "type": "float?",
            "doc": "The proportion of the loci needed for calling EXCESSIVE_COVERAGE"
        },
        {
            "id": "maximum_coverage",
            "type": "int?",
            "doc": "The maximum allowable coverage, used for calling EXCESSIVE_COVERAGE"
        },
        {
            "id": "maximum_insert_size",
            "type": "int?",
            "doc": "The maximum allowed distance between a read and its mate"
        },
        {
            "id": "minimum_base_quality",
            "type": "int?",
            "doc": "The minimum Base Quality that is considered for calls"
        },
        {
            "id": "minimum_coverage",
            "type": "int?",
            "doc": "The minimum allowable coverage, used for calling LOW_COVERAGE"
        },
        {
            "id": "minimum_mapping_quality",
            "type": "int?",
            "doc": "The minimum read mapping quality considered for calls"
        },
        {
            "id": "missing_intervals",
            "type": "string?",
            "doc": "Produces a file with the intervals that don't pass filters"
        },
        {
            "id": "out",
            "type": "string?",
            "doc": "File to which interval statistics should be written"
        },
        {
            "id": "quality_status_threshold",
            "type": "float?",
            "doc": "The proportion of the loci needed for calling POOR_QUALITY"
        },
        {
            "id": "voting_status_threshold",
            "type": "float?",
            "doc": "The needed proportion of samples containing a call for the interval to adopt the call "
        }
    ],
    "id": "DiagnoseTargets",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T DiagnoseTargets \\\t\t\t-R $(inputs.ref.path) \\\t\t\t--input_file $(inputs.input_file) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t-stBM $(inputs.bad_mate_status_threshold) \\\t\t\t-stC $(inputs.coverage_status_threshold) \\\t\t\t-stXC $(inputs.excessive_coverage_status_threshold) \\\t\t\t-max $(inputs.maximum_coverage) \\\t\t\t-ins $(inputs.maximum_insert_size) \\\t\t\t-BQ $(inputs.minimum_base_quality) \\\t\t\t-min $(inputs.minimum_coverage) \\\t\t\t-MQ $(inputs.minimum_mapping_quality) \\\t\t\t$(\"-missing \" + inputs.missing_intervals) \\\t\t\t-o $(inputs.out) \\\t\t\t-stQ $(inputs.quality_status_threshold) \\\t\t\t-stV $(inputs.voting_status_threshold) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}