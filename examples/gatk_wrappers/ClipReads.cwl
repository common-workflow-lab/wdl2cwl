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
            "id": "clipRepresentation",
            "type": "string?",
            "doc": "How should we actually clip the bases?"
        },
        {
            "id": "clipSequence",
            "type": "string?",
            "doc": "Remove sequences within reads matching this sequence"
        },
        {
            "id": "clipSequencesFile",
            "type": "string?",
            "doc": "Remove sequences within reads matching the sequences in this FASTA file"
        },
        {
            "id": "cyclesToTrim",
            "type": "string?",
            "doc": "String indicating machine cycles to clip from the reads"
        },
        {
            "id": "out",
            "type": "string?",
            "doc": "Write BAM output here"
        },
        {
            "id": "outputStatistics",
            "type": "string?",
            "doc": "File to output statistics"
        },
        {
            "id": "qTrimmingThreshold",
            "type": "int?",
            "doc": "If provided, the Q-score clipper will be applied"
        }
    ],
    "id": "ClipReads",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T ClipReads \\\t\t\t-R $(inputs.ref.path) \\\t\t\t--input_file $(inputs.input_file) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t-CR $(inputs.clipRepresentation) \\\t\t\t$(\"-X \" + inputs.clipSequence) \\\t\t\t$(\"-XF \" + inputs.clipSequencesFile) \\\t\t\t$(\"-CT \" + inputs.cyclesToTrim) \\\t\t\t-o $(inputs.out) \\\t\t\t$(\"-os \" + inputs.outputStatistics) \\\t\t\t-QT $(inputs.qTrimmingThreshold) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}