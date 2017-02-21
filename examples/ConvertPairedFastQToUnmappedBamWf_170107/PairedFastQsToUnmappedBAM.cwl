#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "baseCommand": [],
    "cwlVersion": "v1.0",
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
            "dockerPull": "broadinstitute/genomes-in-the-cloud:2.2.4-1469632282"
        },
        {
            "class": "ResourceRequirement",
            "ramMin": "mem_size"
        }
    ],
    "id": "PairedFastQsToUnmappedBAM",
    "arguments": [
        {
            "valueFrom": "    java -Xmx3000m -jar /usr/gitc/picard.jar \\      FastqToSam \\      FASTQ=$(inputs.fastq_1.path) \\      FASTQ2=$(inputs.fastq_2.path) \\      OUTPUT=$(inputs.readgroup_name).bam \\      READ_GROUP_NAME=$(inputs.readgroup_name) \\      SAMPLE_NAME=$(inputs.sample_name) \\      LIBRARY_NAME=$(inputs.library_name) \\      PLATFORM_UNIT=$(inputs.platform_unit) \\      RUN_DATE=$(inputs.run_date) \\      PLATFORM=$(inputs.platform_name) \\      SEQUENCING_CENTER=$(inputs.sequencing_center)   ",
            "shellQuote": false
        }
    ],
    "outputs": [
        {
            "type": "File",
            "id": "output_bam",
            "outputBinding": {
                "glob": "$(inputs.readgroup_name).bam"
            }
        }
    ],
    "inputs": [
        {
            "type": "File",
            "id": "fastq_1"
        },
        {
            "type": "File",
            "id": "fastq_2"
        },
        {
            "type": "string",
            "id": "readgroup_name"
        },
        {
            "type": "string",
            "id": "sample_name"
        },
        {
            "type": "string",
            "id": "library_name"
        },
        {
            "type": "string",
            "id": "platform_unit"
        },
        {
            "type": "string",
            "id": "run_date"
        },
        {
            "type": "string",
            "id": "platform_name"
        },
        {
            "type": "string",
            "id": "sequencing_center"
        },
        {
            "type": "int",
            "id": "disk_size"
        },
        {
            "type": "string",
            "id": "mem_size"
        }
    ]
}