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
            "id": "assumeIdenticalSamples",
            "type": "boolean?",
            "doc": "Assume input VCFs have identical sample sets and disjoint calls"
        },
        {
            "id": "excludeNonVariants",
            "type": "boolean?",
            "doc": "Exclude sites where no variation is present after merging"
        },
        {
            "id": "filteredAreUncalled",
            "type": "boolean?",
            "doc": "Treat filtered variants as uncalled"
        },
        {
            "id": "filteredrecordsmergetype",
            "type": "string?",
            "doc": "Determines how we should handle records seen at the same site in the VCF, but with different FILTER fields"
        },
        {
            "id": "genotypemergeoption",
            "type": "string?",
            "doc": "Determines how we should merge genotype records for samples shared across the ROD files"
        },
        {
            "id": "mergeInfoWithMaxAC",
            "type": "boolean?",
            "doc": "Use the INFO content of the record with the highest AC"
        },
        {
            "id": "minimalVCF",
            "type": "boolean?",
            "doc": "Emit a sites-only file"
        },
        {
            "id": "minimumN",
            "type": "int?",
            "doc": "Minimum number of input files the site must be observed in to be included"
        },
        {
            "id": "out",
            "type": "string?",
            "doc": "File to which variants should be written"
        },
        {
            "id": "printComplexMerges",
            "type": "boolean?",
            "doc": "Emit interesting sites requiring complex compatibility merging to file"
        },
        {
            "id": "rod_priority_list",
            "type": "string?",
            "doc": "Ordered list specifying priority for merging"
        },
        {
            "id": "setKey",
            "type": "string?",
            "doc": "Key name for the set attribute"
        },
        {
            "id": "suppressCommandLineHeader",
            "type": "boolean?",
            "doc": "Do not output the command line to the header"
        },
        {
            "id": "variant",
            "type": "string[]",
            "doc": "VCF files to merge together"
        }
    ],
    "id": "CombineVariants",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T CombineVariants \\\t\t\t-R $(inputs.ref.path) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t$(\"-nt\" + inputs.ntVal) \\\t\t\t-assumeIdenticalSamples $(inputs.assumeIdenticalSamples) \\\t\t\t-env $(inputs.excludeNonVariants) \\\t\t\t-filteredAreUncalled $(inputs.filteredAreUncalled) \\\t\t\t-filteredRecordsMergeType $(inputs.filteredrecordsmergetype) \\\t\t\t$(\"-genotypeMergeOptions \" + inputs.genotypemergeoption) \\\t\t\t-mergeInfoWithMaxAC $(inputs.mergeInfoWithMaxAC) \\\t\t\t-minimalVCF $(inputs.minimalVCF) \\\t\t\t-minN $(inputs.minimumN) \\\t\t\t-o $(inputs.out) \\\t\t\t-printComplexMerges $(inputs.printComplexMerges) \\\t\t\t$(\"-priority \" + inputs.rod_priority_list) \\\t\t\t-setKey $(inputs.setKey) \\\t\t\t-suppressCommandLineHeader $(inputs.suppressCommandLineHeader) \\\t\t\t-V $(inputs.variant) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}