#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "arguments": [
        {
            "valueFrom": "${            var input_bams_separated = '';            for (var i=0; i<inputs.input_bams.length; i++){                input_bams_separated = input_bams_separated + inputs.input_bams[i].path + ' INPUT=';            }            input_bams_separated = input_bams_separated.replace(/ INPUT=$/, '');            return \"    java -Xmx2000m -jar /usr/gitc/picard.jar \\      GatherBamFiles \\      INPUT=\" + input_bams_separated + \" \\      INPUT=\" + inputs.input_unmapped_reads_bam.path + \" \\      OUTPUT=\" + inputs.output_bam_basename + \".bam \\      CREATE_INDEX=true \\      CREATE_MD5_FILE=true    \"}",
            "shellQuote": false
        }
    ],
    "baseCommand": [],
    "id": "GatherBamFiles",
    "outputs": [
        {
            "outputBinding": {
                "glob": "$(inputs.output_bam_basename).bam"
            },
            "id": "output_bam",
            "type": "File"
        },
        {
            "outputBinding": {
                "glob": "$(inputs.output_bam_basename).bai"
            },
            "id": "output_bam_index",
            "type": "File"
        },
        {
            "outputBinding": {
                "glob": "$(inputs.output_bam_basename).bam.md5"
            },
            "id": "output_bam_md5",
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
            "ramMin": "3 GB",
            "class": "ResourceRequirement"
        }
    ],
    "inputs": [
        {
            "id": "input_bams",
            "type": "File[]"
        },
        {
            "id": "input_unmapped_reads_bam",
            "type": "File"
        },
        {
            "id": "output_bam_basename",
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