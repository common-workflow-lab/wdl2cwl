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
            "id": "clusterSize",
            "type": "int?",
            "doc": "The number of SNPs which make up a cluster"
        },
        {
            "id": "clusterWindowSize",
            "type": "int?",
            "doc": "The window size (in bases) in which to evaluate clustered SNPs"
        },
        {
            "id": "filterExpression",
            "type": "string[]?",
            "doc": "One or more expression used with INFO fields to filter"
        },
        {
            "id": "filterName",
            "type": "string[]?",
            "doc": "Names to use for the list of filters"
        },
        {
            "id": "filterNotInMask",
            "type": "boolean?",
            "doc": "Filter records NOT in given input mask."
        },
        {
            "id": "genotypeFilterExpression",
            "type": "string[]?",
            "doc": "One or more expression used with FORMAT (sample/genotype-level) fields to filter (see documentation guide for more info)"
        },
        {
            "id": "genotypeFilterName",
            "type": "string[]?",
            "doc": "Names to use for the list of sample/genotype filters (must be a 1-to-1 mapping); this name is put in the FILTER field for variants that get filtered"
        },
        {
            "id": "invalidatePreviousFilters",
            "type": "boolean?",
            "doc": "Remove previous filters applied to the VCF"
        },
        {
            "id": "invertFilterExpression",
            "type": "boolean?",
            "doc": "Invert the selection criteria for --filterExpression"
        },
        {
            "id": "invertGenotypeFilterExpression",
            "type": "boolean?",
            "doc": "Invert the selection criteria for --genotypeFilterExpression"
        },
        {
            "id": "mask",
            "type": "string?",
            "doc": "Input ROD mask"
        },
        {
            "id": "maskExtension",
            "type": "int?",
            "doc": "How many bases beyond records from a provided 'mask' rod should variants be filtered"
        },
        {
            "id": "maskName",
            "type": "string?",
            "doc": "The text to put in the FILTER field if a 'mask' rod is provided and overlaps with a variant call"
        },
        {
            "id": "missingValuesInExpressionsShouldEvaluateAsFailing",
            "type": "boolean?",
            "doc": "When evaluating the JEXL expressions, missing values should be considered failing the expression"
        },
        {
            "id": "out",
            "type": "string?",
            "doc": "File to which variants should be written"
        },
        {
            "id": "setFilteredGtToNocall",
            "type": "boolean?",
            "doc": "Set filtered genotypes to no-call"
        },
        {
            "id": "variant",
            "type": "string",
            "doc": "Input VCF file"
        }
    ],
    "id": "VariantFiltration",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T VariantFiltration \\\t\t\t-R $(inputs.ref.path) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t-cluster $(inputs.clusterSize) \\\t\t\t-window $(inputs.clusterWindowSize) \\\t\t\t-filter $(inputs.filterExpression) \\\t\t\t-filterName $(inputs.filterName) \\\t\t\t-filterNotInMask $(inputs.filterNotInMask) \\\t\t\t-G_filter $(inputs.genotypeFilterExpression) \\\t\t\t-G_filterName $(inputs.genotypeFilterName) \\\t\t\tinvalidatePreviousFilters $(inputs.invalidatePreviousFilters) \\\t\t\t-invfilter $(inputs.invertFilterExpression) \\\t\t\t-invG_filter $(inputs.invertGenotypeFilterExpression) \\\t\t\t$(\"-mask \" + inputs.mask) \\\t\t\t-maskExtend $(inputs.maskExtension) \\\t\t\t-maskName $(inputs.maskName) \\\t\t\tmissingValuesInExpressionsShouldEvaluateAsFailing $(inputs.missingValuesInExpressionsShouldEvaluateAsFailing) \\\t\t\t-o $(inputs.out) \\\t\t\tsetFilteredGtToNocall $(inputs.setFilteredGtToNocall) \\\t\t\t-V $(inputs.variant) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}