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
            "id": "format",
            "type": "string?",
            "doc": "Output format"
        },
        {
            "id": "maxDepth",
            "type": "int?",
            "doc": "Maximum read depth before a locus is considered poorly mapped"
        },
        {
            "id": "maxFractionOfReadsWithLowMAPQ",
            "type": "float?",
            "doc": "If the fraction of reads at a base with low mapping quality exceeds this value, the site may be poorly mapped"
        },
        {
            "id": "maxLowMAPQ",
            "type": "string?",
            "doc": "Maximum value for MAPQ to be considered a problematic mapped read."
        },
        {
            "id": "minBaseQuality",
            "type": "string?",
            "doc": "Minimum quality of bases to count towards depth."
        },
        {
            "id": "minDepth",
            "type": "int?",
            "doc": "Minimum QC+ read depth before a locus is considered callable"
        },
        {
            "id": "minDepthForLowMAPQ",
            "type": "int?",
            "doc": "Minimum read depth before a locus is considered a potential candidate for poorly mapped"
        },
        {
            "id": "minMappingQuality",
            "type": "string?",
            "doc": "Minimum mapping quality of reads to count towards depth."
        },
        {
            "id": "out",
            "type": "string?",
            "doc": "An output file created by the walker.  Will overwrite contents if file exists"
        },
        {
            "id": "summary",
            "type": "File",
            "doc": "Name of file for output summary"
        }
    ],
    "id": "CallableLoci",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T CallableLoci \\\t\t\t-R $(inputs.ref.path) \\\t\t\t--input_file $(inputs.input_file) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t-format $(inputs.format) \\\t\t\t-maxDepth $(inputs.maxDepth) \\\t\t\t-frlmq $(inputs.maxFractionOfReadsWithLowMAPQ) \\\t\t\t-mlmq $(inputs.maxLowMAPQ) \\\t\t\t-mbq $(inputs.minBaseQuality) \\\t\t\t-minDepth $(inputs.minDepth) \\\t\t\t-mdflmq $(inputs.minDepthForLowMAPQ) \\\t\t\t-mmq $(inputs.minMappingQuality) \\\t\t\t-o $(inputs.out) \\\t\t\t-summary $(inputs.summary.path) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}