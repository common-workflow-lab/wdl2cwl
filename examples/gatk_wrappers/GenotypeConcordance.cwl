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
            "id": "comp",
            "type": "string",
            "doc": "The variants and genotypes to compare against"
        },
        {
            "id": "eval",
            "type": "string",
            "doc": "The variants and genotypes to evaluate"
        },
        {
            "id": "genotypeFilterExpressionComp",
            "type": "string[]?",
            "doc": "One or more criteria to use to set COMP genotypes to no-call. These genotype-level filters are only applied to the COMP rod."
        },
        {
            "id": "genotypeFilterExpressionEval",
            "type": "string[]?",
            "doc": "One or more criteria to use to set EVAL genotypes to no-call. These genotype-level filters are only applied to the EVAL rod."
        },
        {
            "id": "ignoreFilters",
            "type": "boolean?",
            "doc": "Filters will be ignored"
        },
        {
            "id": "moltenize",
            "type": "boolean?",
            "doc": "Molten rather than tabular output"
        },
        {
            "id": "out",
            "type": "string?",
            "doc": "An output file created by the walker.  Will overwrite contents if file exists"
        },
        {
            "id": "printInterestingSites",
            "type": "string?",
            "doc": "File to output the discordant sites and genotypes."
        }
    ],
    "id": "GenotypeConcordance",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T GenotypeConcordance \\\t\t\t-R $(inputs.ref.path) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t-comp $(inputs.comp) \\\t\t\t-eval $(inputs.eval) \\\t\t\t-gfc $(inputs.genotypeFilterExpressionComp) \\\t\t\t-gfe $(inputs.genotypeFilterExpressionEval) \\\t\t\tignoreFilters $(inputs.ignoreFilters) \\\t\t\t-moltenize $(inputs.moltenize) \\\t\t\t-o $(inputs.out) \\\t\t\t$(\"-sites \" + inputs.printInterestingSites) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}