#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "arguments": [
        {
            "valueFrom": "    java -Xmx4000m -jar /usr/gitc/picard.jar \\    SortSam \\    INPUT=$(inputs.input_bam.path) \\    OUTPUT=/dev/stdout \\    SORT_ORDER=\"coordinate\" \\    CREATE_INDEX=false \\    CREATE_MD5_FILE=false | \\    java -Xmx500m -jar /usr/gitc/picard.jar \\    SetNmAndUqTags \\    INPUT=/dev/stdin \\    OUTPUT=$(inputs.output_bam_basename).bam \\    CREATE_INDEX=true \\    CREATE_MD5_FILE=true \\    REFERENCE_SEQUENCE=$(inputs.ref_fasta.path)  ",
            "shellQuote": false
        }
    ],
    "baseCommand": [],
    "id": "SortAndFixTags",
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
            "ramMin": "5000 MB",
            "class": "ResourceRequirement"
        }
    ],
    "inputs": [
        {
            "id": "input_bam",
            "type": "File"
        },
        {
            "id": "output_bam_basename",
            "type": "string"
        },
        {
            "id": "ref_dict",
            "type": "File"
        },
        {
            "id": "ref_fasta",
            "type": "File"
        },
        {
            "id": "ref_fasta_index",
            "type": "File"
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