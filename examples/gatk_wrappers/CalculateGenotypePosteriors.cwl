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
            "id": "defaultToAC",
            "type": "boolean?",
            "doc": "Use the AC field as opposed to MLEAC. Does nothing if VCF lacks MLEAC field"
        },
        {
            "id": "deNovoPrior",
            "type": "float?",
            "doc": "The de novo mutation prior"
        },
        {
            "id": "discoveredACpriorsOff",
            "type": "boolean?",
            "doc": "Do not use discovered allele count in the input callset for variants that do not appear in the external callset. "
        },
        {
            "id": "globalPrior",
            "type": "float?",
            "doc": "The global Dirichlet prior parameters for the allele frequency"
        },
        {
            "id": "ignoreInputSamples",
            "type": "boolean?",
            "doc": "Use external information only; do not inform genotype priors by the discovered allele frequency in the callset whose posteriors are being calculated. Useful for callsets containing related individuals."
        },
        {
            "id": "numRefSamplesIfNoCall",
            "type": "int?",
            "doc": "The number of homozygous reference to infer were seen at a position where an other callset contains no site or genotype information"
        },
        {
            "id": "out",
            "type": "string?",
            "doc": "File to which variants should be written"
        },
        {
            "id": "skipFamilyPriors",
            "type": "boolean?",
            "doc": "Skip application of family-based priors"
        },
        {
            "id": "skipPopulationPriors",
            "type": "boolean?",
            "doc": "Skip application of population-based priors"
        },
        {
            "id": "supporting",
            "type": "string[]?",
            "doc": "Other callsets to use in generating genotype posteriors"
        },
        {
            "id": "variant",
            "type": "string",
            "doc": "Input VCF file"
        }
    ],
    "id": "CalculateGenotypePosteriors",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T CalculateGenotypePosteriors \\\t\t\t-R $(inputs.ref.path) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t-useAC $(inputs.defaultToAC) \\\t\t\t-DNP $(inputs.deNovoPrior) \\\t\t\t-useACoff $(inputs.discoveredACpriorsOff) \\\t\t\t-G $(inputs.globalPrior) \\\t\t\t-ext $(inputs.ignoreInputSamples) \\\t\t\t-nrs $(inputs.numRefSamplesIfNoCall) \\\t\t\t-o $(inputs.out) \\\t\t\t-skipFam $(inputs.skipFamilyPriors) \\\t\t\t-skipPop $(inputs.skipPopulationPriors) \\\t\t\t-supporting $(inputs.supporting) \\\t\t\t-V $(inputs.variant) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}