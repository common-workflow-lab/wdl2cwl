#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "requirements": [
        {
            "class": "InlineJavascriptRequirement"
        }
    ],
    "inputs": [
        {
            "type": "File",
            "id": "input_bam"
        },
        {
            "type": "File",
            "id": "ref_fasta"
        },
        {
            "type": "File",
            "id": "ref_fasta_index"
        },
        {
            "type": "string",
            "id": "output_dir"
        },
        {
            "type": "float?",
            "id": "RevertBamToUnmappedRGBams_max_discard_pct"
        },
        {
            "type": "int",
            "id": "RevertBamToUnmappedRGBams_disk_size"
        },
        {
            "type": "string",
            "id": "RevertBamToUnmappedRGBams_mem_size"
        }
    ],
    "id": "RevertBamToUnmappedRGBamsWf",
    "steps": [
        {
            "run": "RevertBamToUnmappedRGBams.cwl",
            "in": [
                {
                    "source": "input_bam",
                    "id": "input_bam"
                },
                {
                    "source": "output_dir",
                    "id": "output_dir"
                },
                {
                    "source": "RevertBamToUnmappedRGBams_max_discard_pct",
                    "id": "max_discard_pct"
                },
                {
                    "source": "RevertBamToUnmappedRGBams_disk_size",
                    "id": "disk_size"
                },
                {
                    "source": "RevertBamToUnmappedRGBams_mem_size",
                    "id": "mem_size"
                }
            ],
            "id": "RevertBamToUnmappedRGBams",
            "out": [
                {
                    "id": "unmapped_bams"
                }
            ]
        }
    ],
    "cwlVersion": "v1.0",
    "class": "Workflow",
    "outputs": [
        {
            "type": {
                "type": "array",
                "items": "File"
            },
            "outputSource": "RevertBamToUnmappedRGBams/unmapped_bams",
            "id": "unmapped_bams_output"
        }
    ]
}