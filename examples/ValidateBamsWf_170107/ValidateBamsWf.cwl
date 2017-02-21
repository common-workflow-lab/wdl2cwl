#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "inputs": [
        {
            "type": "File[]",
            "id": "bam_list"
        },
        {
            "type": "string",
            "id": "sub_strip_path",
            "default": "$(\"gs://.*/\")"
        },
        {
            "type": "string",
            "id": "sub_strip_suffix",
            "default": "$(\".bam$\")"
        }
    ],
    "cwlVersion": "v1.0",
    "outputs": [
        {
            "outputSource": "ValidateBAM/validation_report",
            "id": "validation_reports",
            "type": "File[]"
        }
    ],
    "steps": [
        {
            "in": [
                {
                    "source": "bam_list",
                    "id": "bam_file",
                    "valueFrom": "$(self)"
                },
                {
                    "source": "bam_list",
                    "id": "output_basename",
                    "valueFrom": "$(inputs.self.replace(sub_strip_path, \"\").replace(sub_strip_suffix, \"\") + \".validation\")"
                }
            ],
            "run": "ValidateBAM.cwl",
            "scatter": [
                "bam_file",
                "output_basename"
            ],
            "id": "ValidateBAM",
            "scatterMethod": "dotproduct",
            "out": [
                {
                    "id": "validation_report"
                }
            ]
        }
    ],
    "class": "Workflow",
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
    "id": "ValidateBamsWf"
}