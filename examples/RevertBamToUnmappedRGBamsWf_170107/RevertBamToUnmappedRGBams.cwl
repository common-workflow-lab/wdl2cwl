#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "requirements": [
        {
            "class": "ShellCommandRequirement"
        },
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
            "type": "string",
            "id": "output_dir"
        },
        {
            "type": "float?",
            "id": "max_discard_pct"
        },
        {
            "type": "int",
            "id": "disk_size"
        },
        {
            "type": "string",
            "id": "mem_size"
        }
    ],
    "id": "RevertBamToUnmappedRGBams",
    "baseCommand": [],
    "arguments": [
        {
            "valueFrom": "    java -Xmx1000m -jar /usr/gitc/picard.jar \\    RevertSam \\    INPUT=$(inputs.input_bam.path) \\    O=$(inputs.output_dir) \\    OUTPUT_BY_READGROUP=true \\    VALIDATION_STRINGENCY=LENIENT \\    SANITIZE=TRUE \\    MAX_DISCARD_FRACTION=$(inputs.max_discard_pct) \\    ATTRIBUTE_TO_CLEAR=FT \\    SORT_ORDER=queryname   ",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0",
    "class": "CommandLineTool",
    "outputs": [
        {
            "type": {
                "type": "array",
                "items": "File"
            },
            "id": "unmapped_bams",
            "outputBinding": {
                "glob": [
                    "*.bam"
                ]
            }
        }
    ]
}