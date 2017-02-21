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
            "id": "DeNovoPrior",
            "type": "float?",
            "doc": "Prior for de novo mutations. Default: 1e-8"
        },
        {
            "id": "FatherAlleleFirst",
            "type": "boolean?",
            "doc": "Ouputs the father allele as the first allele in phased child genotype. i.e. father|mother rather than mother|father."
        },
        {
            "id": "MendelianViolationsFile",
            "type": "string?",
            "doc": "File to output the mendelian violation details."
        },
        {
            "id": "out",
            "type": "string?",
            "doc": "An output file created by the walker.  Will overwrite contents if file exists"
        },
        {
            "id": "variant",
            "type": "string",
            "doc": "Input VCF file"
        }
    ],
    "id": "PhaseByTransmission",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T PhaseByTransmission \\\t\t\t-R $(inputs.ref.path) \\\t\t\t--input_file $(inputs.input_file) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t-prior $(inputs.DeNovoPrior) \\\t\t\t-fatherAlleleFirst $(inputs.FatherAlleleFirst) \\\t\t\t$(\"-mvf \" + inputs.MendelianViolationsFile) \\\t\t\t-o $(inputs.out) \\\t\t\t-V $(inputs.variant) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}