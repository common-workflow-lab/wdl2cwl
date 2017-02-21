#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "arguments": [
        {
            "valueFrom": "${            var input_bqsr_reports_separated = '';            for (var i=0; i<inputs.input_bqsr_reports.length; i++){                input_bqsr_reports_separated = input_bqsr_reports_separated + inputs.input_bqsr_reports[i].path + ' -I ';            }            input_bqsr_reports_separated = input_bqsr_reports_separated.replace(/ -I $/, '');            return \"    java -Xmx3000m -jar /usr/gitc/GATK4.jar \\      GatherBQSRReports \\      -I \" + input_bqsr_reports_separated + \" \\      -O \" + inputs.output_report_filename + \"    \"}",
            "shellQuote": false
        }
    ],
    "baseCommand": [],
    "id": "GatherBqsrReports",
    "outputs": [
        {
            "outputBinding": {
                "glob": "$(inputs.output_report_filename)"
            },
            "id": "output_bqsr_report",
            "type": "File"
        }
    ],
    "requirements": [
        {
            "class": "ShellCommandRequirement"
        },
        {
            "class": "InlineJavascriptRequirement"
        },
        {
            "dockerPull": "broadinstitute/genomes-in-the-cloud:2.2.4-1469632282",
            "class": "DockerRequirement"
        },
        {
            "ramMin": "3500 MB",
            "class": "ResourceRequirement"
        }
    ],
    "inputs": [
        {
            "id": "input_bqsr_reports",
            "type": "File[]"
        },
        {
            "id": "output_report_filename",
            "type": "string"
        },
        {
            "id": "disk_size",
            "type": "int"
        },
        {
            "id": "preemptible_tries",
            "type": "int"
        }
    ],
    "class": "CommandLineTool",
    "cwlVersion": "v1.0"
}