#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "inputs": [
        {
            "type": "File",
            "id": "bam_file"
        },
        {
            "type": "string",
            "id": "output_basename"
        },
        {
            "type": "string",
            "id": "validation_mode"
        },
        {
            "type": "int",
            "id": "disk_size"
        },
        {
            "type": "string",
            "id": "mem_size"
        },
        {
            "type": "string",
            "id": "output_name",
            "default": "$(\"${output_basename}_${validation_mode}.txt\")"
        }
    ],
    "cwlVersion": "v1.0",
    "outputs": [
        {
            "outputBinding": {
                "glob": "$(inputs.output_name)"
            },
            "type": "File",
            "id": "validation_report"
        }
    ],
    "arguments": [
        {
            "shellQuote": false,
            "valueFrom": "    java -Xmx3000m -jar /usr/gitc/picard.jar \\      ValidateSamFile \\      I=$(inputs.bam_file.path) \\      OUTPUT=$(inputs.output_name) \\      MODE=$(inputs.validation_mode)  "
        }
    ],
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
            "class": "DockerRequirement",
            "dockerPull": "broadinstitute/genomes-in-the-cloud:2.2.3-1469027018"
        },
        {
            "class": "ResourceRequirement",
            "ramMin": "mem_size"
        }
    ],
    "id": "ValidateBAM"
}