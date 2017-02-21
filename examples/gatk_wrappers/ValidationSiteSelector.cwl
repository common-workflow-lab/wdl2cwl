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
            "id": "frequencySelectionMode",
            "type": "string?",
            "doc": "Allele Frequency selection mode"
        },
        {
            "id": "ignoreGenotypes",
            "type": "boolean?",
            "doc": "If true, will ignore genotypes in VCF, will take AC,AF from annotations and will make no sample selection"
        },
        {
            "id": "ignorePolymorphicStatus",
            "type": "boolean?",
            "doc": "If true, will ignore polymorphic status in VCF, and will take VCF record directly without pre-selection"
        },
        {
            "id": "includeFilteredSites",
            "type": "boolean?",
            "doc": "If true, will include filtered sites in set to choose variants from"
        },
        {
            "id": "numValidationSites",
            "type": "int",
            "doc": "Number of output validation sites"
        },
        {
            "id": "out",
            "type": "string?",
            "doc": "File to which variants should be written"
        },
        {
            "id": "sample_expressions",
            "type": "string?",
            "doc": "Regular expression to select many samples from the ROD tracks provided. Can be specified multiple times"
        },
        {
            "id": "sample_file",
            "type": "string?",
            "doc": "File containing a list of samples (one per line) to include. Can be specified multiple times"
        },
        {
            "id": "sample_name",
            "type": "string?",
            "doc": "Include genotypes from this sample. Can be specified multiple times"
        },
        {
            "id": "sampleMode",
            "type": "string?",
            "doc": "Sample selection mode"
        },
        {
            "id": "samplePNonref",
            "type": "float?",
            "doc": "GL-based selection mode only: the probability that a site is non-reference in the samples for which to include the site"
        },
        {
            "id": "selectTypeToInclude",
            "type": "string[]?",
            "doc": "Select only a certain type of variants from the input file. Valid types are INDEL, SNP, MIXED, MNP, SYMBOLIC, NO_VARIATION. Can be specified multiple times"
        },
        {
            "id": "variant",
            "type": "string[]",
            "doc": "Input VCF file, can be specified multiple times"
        }
    ],
    "id": "ValidationSiteSelector",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T ValidationSiteSelector \\\t\t\t-R $(inputs.ref.path) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t-freqMode $(inputs.frequencySelectionMode) \\\t\t\t-ignoreGenotypes $(inputs.ignoreGenotypes) \\\t\t\t-ignorePolymorphicStatus $(inputs.ignorePolymorphicStatus) \\\t\t\t-ifs $(inputs.includeFilteredSites) \\\t\t\t-numSites $(inputs.numValidationSites) \\\t\t\t-o $(inputs.out) \\\t\t\t$(\"-se \" + inputs.sample_expressions) \\\t\t\t$(\"-sf \" + inputs.sample_file) \\\t\t\t-sn $(inputs.sample_name) \\\t\t\t-sampleMode $(inputs.sampleMode) \\\t\t\t-samplePNonref $(inputs.samplePNonref) \\\t\t\t-selectType $(inputs.selectTypeToInclude) \\\t\t\t-V $(inputs.variant) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}