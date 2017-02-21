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
            "id": "binary_tag_name",
            "type": "string?",
            "doc": "the binary tag covariate name if using it"
        },
        {
            "id": "bqsrBAQGapOpenPenalty",
            "type": "float?",
            "doc": "BQSR BAQ gap open penalty (Phred Scaled).  Default value is 40.  30 is perhaps better for whole genome call sets"
        },
        {
            "id": "covariate",
            "type": "string?",
            "doc": "One or more covariates to be used in the recalibration. Can be specified multiple times"
        },
        {
            "id": "deletions_default_quality",
            "type": "string?",
            "doc": "default quality for the base deletions covariate"
        },
        {
            "id": "indels_context_size",
            "type": "int?",
            "doc": "Size of the k-mer context to be used for base insertions and deletions"
        },
        {
            "id": "insertions_default_quality",
            "type": "string?",
            "doc": "default quality for the base insertions covariate"
        },
        {
            "id": "knownSites",
            "type": "string[]?",
            "doc": "A database of known polymorphic sites"
        },
        {
            "id": "list",
            "type": "boolean?",
            "doc": "List the available covariates and exit"
        },
        {
            "id": "low_quality_tail",
            "type": "string?",
            "doc": "minimum quality for the bases in the tail of the reads to be considered"
        },
        {
            "id": "lowMemoryMode",
            "type": "boolean?",
            "doc": "Reduce memory usage in multi-threaded code at the expense of threading efficiency"
        },
        {
            "id": "maximum_cycle_value",
            "type": "int?",
            "doc": "The maximum cycle value permitted for the Cycle covariate"
        },
        {
            "id": "mismatches_context_size",
            "type": "int?",
            "doc": "Size of the k-mer context to be used for base mismatches"
        },
        {
            "id": "mismatches_default_quality",
            "type": "string?",
            "doc": "default quality for the base mismatches covariate"
        },
        {
            "id": "no_standard_covs",
            "type": "boolean?",
            "doc": "Do not use the standard set of covariates, but rather just the ones listed using the -cov argument"
        },
        {
            "id": "out",
            "type": "File",
            "doc": "The output recalibration table file to create"
        },
        {
            "id": "quantizing_levels",
            "type": "int?",
            "doc": "number of distinct quality scores in the quantized output"
        },
        {
            "id": "run_without_dbsnp_potentially_ruining_quality",
            "type": "boolean?",
            "doc": "If specified, allows the recalibrator to be used without a dbsnp rod. Very unsafe and for expert users only."
        },
        {
            "id": "solid_nocall_strategy",
            "type": "string?",
            "doc": "Defines the behavior of the recalibrator when it encounters no calls in the color space. Options = THROW_EXCEPTION, LEAVE_READ_UNRECALIBRATED, or PURGE_READ"
        },
        {
            "id": "solid_recal_mode",
            "type": "string?",
            "doc": "How should we recalibrate solid bases in which the reference was inserted? Options = DO_NOTHING, SET_Q_ZERO, SET_Q_ZERO_BASE_N, or REMOVE_REF_BIAS"
        },
        {
            "id": "sort_by_all_columns",
            "type": "boolean?",
            "doc": "Sort the rows in the tables of reports"
        }
    ],
    "id": "BaseRecalibrator",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T BaseRecalibrator \\\t\t\t-R $(inputs.ref.path) \\\t\t\t--input_file $(inputs.input_file) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t$(\"--BQSR \" + inputs.BQSR) \\\t\t\t$(\"-nct\" + inputs.nctVal) \\\t\t\t$(\"-bintag \" + inputs.binary_tag_name) \\\t\t\t-bqsrBAQGOP $(inputs.bqsrBAQGapOpenPenalty) \\\t\t\t$(\"-cov \" + inputs.covariate) \\\t\t\t-ddq $(inputs.deletions_default_quality) \\\t\t\t-ics $(inputs.indels_context_size) \\\t\t\t-idq $(inputs.insertions_default_quality) \\\t\t\t-knownSites $(inputs.knownSites) \\\t\t\t-ls $(inputs.list) \\\t\t\t-lqt $(inputs.low_quality_tail) \\\t\t\t-lowMemoryMode $(inputs.lowMemoryMode) \\\t\t\t-maxCycle $(inputs.maximum_cycle_value) \\\t\t\t-mcs $(inputs.mismatches_context_size) \\\t\t\t-mdq $(inputs.mismatches_default_quality) \\\t\t\t-noStandard $(inputs.no_standard_covs) \\\t\t\t-o $(inputs.out.path) \\\t\t\t-ql $(inputs.quantizing_levels) \\\t\t\t-run_without_dbsnp_potentially_ruining_quality $(inputs.run_without_dbsnp_potentially_ruining_quality) \\\t\t\t-solid_nocall_strategy $(inputs.solid_nocall_strategy) \\\t\t\t-sMode $(inputs.solid_recal_mode) \\\t\t\t-sortAllCols $(inputs.sort_by_all_columns) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}