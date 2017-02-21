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
            "id": "BQSR",
            "type": "File?",
            "doc": "Input covariates table file for on-the-fly base quality score recalibration"
        },
        {
            "id": "afterReportFile",
            "type": "File?",
            "doc": "file containing the BQSR second-pass report file"
        },
        {
            "id": "beforeReportFile",
            "type": "File?",
            "doc": "file containing the BQSR first-pass report file"
        },
        {
            "id": "ignoreLastModificationTimes",
            "type": "boolean?",
            "doc": "do not emit warning messages related to suspicious last modification time order of inputs"
        },
        {
            "id": "intermediateCsvFile",
            "type": "File?",
            "doc": "location of the csv intermediate file"
        },
        {
            "id": "plotsReportFile",
            "type": "File?",
            "doc": "location of the output report"
        }
    ],
    "id": "AnalyzeCovariates",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T AnalyzeCovariates \\\t\t\t-R $(inputs.ref.path) \\\t\t\t$(\"--BQSR \" + inputs.BQSR) \\\t\t\t$(\"-after \" + inputs.afterReportFile) \\\t\t\t$(\"-before \" + inputs.beforeReportFile) \\\t\t\t-ignoreLMT $(inputs.ignoreLastModificationTimes) \\\t\t\t$(\"-csv \" + inputs.intermediateCsvFile) \\\t\t\t$(\"-plots \" + inputs.plotsReportFile) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}