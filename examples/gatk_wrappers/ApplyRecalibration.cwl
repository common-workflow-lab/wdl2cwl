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
            "id": "ntVal",
            "type": "int?"
        },
        {
            "id": "excludeFiltered",
            "type": "boolean?",
            "doc": "Don't output filtered loci after applying the recalibration"
        },
        {
            "id": "ignore_all_filters",
            "type": "boolean?",
            "doc": "If specified, the variant recalibrator will ignore all input filters. Useful to rerun the VQSR from a filtered output file."
        },
        {
            "id": "ignore_filter",
            "type": "string?",
            "doc": "If specified, the recalibration will be applied to variants marked as filtered by the specified filter name in the input VCF file"
        },
        {
            "id": "task_input",
            "type": "string[]",
            "doc": "The raw input variants to be recalibrated"
        },
        {
            "id": "lodCutoff",
            "type": "float?",
            "doc": "The VQSLOD score below which to start filtering"
        },
        {
            "id": "mode",
            "type": "string?",
            "doc": "Recalibration mode to employ: 1.) SNP for recalibrating only SNPs (emitting indels untouched in the output VCF); 2.) INDEL for indels; and 3.) BOTH for recalibrating both SNPs and indels simultaneously."
        },
        {
            "id": "out",
            "type": "string?",
            "doc": "The output filtered and recalibrated VCF file in which each variant is annotated with its VQSLOD value"
        },
        {
            "id": "recal_file",
            "type": "string",
            "doc": "The input recal file used by ApplyRecalibration"
        },
        {
            "id": "tranches_file",
            "type": "File?",
            "doc": "The input tranches file describing where to cut the data"
        },
        {
            "id": "ts_filter_level",
            "type": "float?",
            "doc": "The truth sensitivity level at which to start filtering"
        },
        {
            "id": "useAlleleSpecificAnnotations",
            "type": "boolean?",
            "doc": "If specified, the tool will attempt to apply a filter to each allele based on the input tranches and allele-specific .recal file."
        }
    ],
    "id": "ApplyRecalibration",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T ApplyRecalibration \\\t\t\t-R $(inputs.ref.path) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t$(\"-nt\" + inputs.ntVal) \\\t\t\t-ef $(inputs.excludeFiltered) \\\t\t\t-ignoreAllFilters $(inputs.ignore_all_filters) \\\t\t\t$(\"-ignoreFilter \" + inputs.ignore_filter) \\\t\t\t-input $(inputs.task_input) \\\t\t\t$(\"-lodCutoff \" + inputs.lodCutoff) \\\t\t\t-mode $(inputs.mode) \\\t\t\t-o $(inputs.out) \\\t\t\t-recalFile $(inputs.recal_file) \\\t\t\t$(\"-tranchesFile \" + inputs.tranches_file) \\\t\t\t$(\"-ts_filter_level \" + inputs.ts_filter_level) \\\t\t\t-AS $(inputs.useAlleleSpecificAnnotations) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}