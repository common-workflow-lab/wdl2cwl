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
            "id": "doPairwise",
            "type": "boolean?",
            "doc": "If provided, we will compute the minimum pairwise differences to summary, which can be extremely expensive"
        },
        {
            "id": "iterations",
            "type": "int?",
            "doc": "Number of iterations to perform, should be 1 unless you are doing memory testing"
        },
        {
            "id": "master",
            "type": "File",
            "doc": "Master file: expected results"
        },
        {
            "id": "maxCount1Diffs",
            "type": "int?",
            "doc": "Max. number of diffs occuring exactly once in the file to process"
        },
        {
            "id": "maxDiffs",
            "type": "int?",
            "doc": "Max. number of diffs to process"
        },
        {
            "id": "maxObjectsToRead",
            "type": "int?",
            "doc": "Max. number of objects to read from the files.  -1 [default] means unlimited"
        },
        {
            "id": "maxRawDiffsToSummarize",
            "type": "int?",
            "doc": "Max. number of differences to include in the summary.  -1 [default] means unlimited"
        },
        {
            "id": "minCountForDiff",
            "type": "int?",
            "doc": "Min number of observations for a records to display"
        },
        {
            "id": "out",
            "type": "string?",
            "doc": "File to which results should be written"
        },
        {
            "id": "showItemizedDifferences",
            "type": "boolean?",
            "doc": "Should we enumerate all differences between the files?"
        },
        {
            "id": "test",
            "type": "File",
            "doc": "Test file: new results to compare to the master file"
        }
    ],
    "id": "DiffObjects",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T DiffObjects \\\t\t\t-R $(inputs.ref.path) \\\t\t\t-doPairwise $(inputs.doPairwise) \\\t\t\titerations $(inputs.iterations) \\\t\t\t-m $(inputs.master.path) \\\t\t\t-M1 $(inputs.maxCount1Diffs) \\\t\t\t-M $(inputs.maxDiffs) \\\t\t\t-motr $(inputs.maxObjectsToRead) \\\t\t\t-maxRawDiffsToSummarize $(inputs.maxRawDiffsToSummarize) \\\t\t\t-MCFD $(inputs.minCountForDiff) \\\t\t\t-o $(inputs.out) \\\t\t\t-SID $(inputs.showItemizedDifferences) \\\t\t\t-t $(inputs.test.path) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}