#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "arguments": [
        {
            "valueFrom": "    /usr/gitc/bwa 2>&1 | \\    grep -e '^Version' | \\    sed 's/Version: //'  ",
            "shellQuote": false
        }
    ],
    "baseCommand": [],
    "id": "GetBwaVersion",
    "outputs": [
        {
            "outputBinding": {
                "glob": "self[0].contents",
                "loadContents": true
            },
            "id": "version",
            "type": "string"
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
            "ramMin": "1 GB",
            "class": "ResourceRequirement"
        }
    ],
    "stdout": "__stdout",
    "inputs": [],
    "class": "CommandLineTool",
    "cwlVersion": "v1.0"
}