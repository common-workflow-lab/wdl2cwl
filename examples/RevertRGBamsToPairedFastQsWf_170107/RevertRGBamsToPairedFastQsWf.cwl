#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "inputs": [
        {
            "id": "bam_list",
            "type": "File[]"
        },
        {
            "id": "sub_strip_path",
            "default": "$(\"gs://.*/\")",
            "type": "string"
        },
        {
            "id": "sub_strip_suffix",
            "default": "$(\".bam$\")",
            "type": "string"
        }
    ],
    "steps": [
        {
            "scatterMethod": "dotproduct",
            "id": "RevertBAMToPairedFASTQ",
            "in": [
                {
                    "id": "bam_file",
                    "valueFrom": "$(self)",
                    "source": "bam_list"
                },
                {
                    "id": "output_basename",
                    "valueFrom": "$(inputs.self.replace(sub_strip_path, \"\").replace(sub_strip_suffix, \"\"))",
                    "source": "bam_list"
                }
            ],
            "out": [
                {
                    "id": "output_fastqs"
                }
            ],
            "run": "RevertBAMToPairedFASTQ.cwl",
            "scatter": [
                "bam_file",
                "output_basename"
            ]
        }
    ],
    "requirements": [
        {
            "class": "InlineJavascriptRequirement"
        },
        {
            "class": "ScatterFeatureRequirement"
        },
        {
            "class": "StepInputExpressionRequirement"
        }
    ],
    "id": "RevertRGBamsToPairedFastQsWf",
    "class": "Workflow",
    "outputs": [
        {
            "id": "output_fastqs_globs",
            "outputSource": "RevertBAMToPairedFASTQ/output_fastqs",
            "type": {
                "type": "array",
                "items": {
                    "type": "array",
                    "items": "File"
                }
            }
        }
    ],
    "cwlVersion": "v1.0"
}