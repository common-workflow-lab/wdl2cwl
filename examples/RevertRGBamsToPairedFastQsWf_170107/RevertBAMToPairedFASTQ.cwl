#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "inputs": [
        {
            "id": "bam_file",
            "type": "File"
        },
        {
            "id": "output_basename",
            "type": "string"
        },
        {
            "id": "disk_size",
            "type": "int"
        },
        {
            "id": "mem_size",
            "type": "string"
        }
    ],
    "baseCommand": [],
    "requirements": [
        {
            "class": "ShellCommandRequirement"
        },
        {
            "class": "InlineJavascriptRequirement"
        },
        {
            "dockerPull": "broadinstitute/genomes-in-the-cloud:2.2.3-1469027018",
            "class": "DockerRequirement"
        },
        {
            "ramMin": "mem_size",
            "class": "ResourceRequirement"
        }
    ],
    "id": "RevertBAMToPairedFASTQ",
    "arguments": [
        {
            "valueFrom": "    java -Xmx3000m -jar /usr/gitc/picard.jar \\      SamToFastq \\      I=$(inputs.bam_file.path) \\      FASTQ=$(inputs.output_basename)_1.fastq \\      SECOND_END_FASTQ=$(inputs.output_basename)_2.fastq \\      UNPAIRED_FASTQ=$(inputs.output_basename)_unp.fastq \\      INCLUDE_NON_PRIMARY_ALIGNMENTS=true \\      INCLUDE_NON_PF_READS=true   ",
            "shellQuote": false
        }
    ],
    "class": "CommandLineTool",
    "outputs": [
        {
            "id": "output_fastqs",
            "outputBinding": {
                "glob": [
                    "*.fastq"
                ]
            },
            "type": "File[]"
        }
    ],
    "cwlVersion": "v1.0"
}