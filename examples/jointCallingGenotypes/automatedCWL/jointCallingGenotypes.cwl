#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "cwlVersion": "v1.0",
    "inputs": [
        {
            "type": "File",
            "id": "inputSamplesFile"
        },
        {
            "type": "File",
            "id": "gatk"
        },
        {
            "type": "File",
            "id": "refFasta"
        },
        {
            "type": "File",
            "id": "refIndex"
        },
        {
            "type": "File",
            "id": "refDict"
        }
    ],
    "outputs": [
        {
            "type": "Any",
            "id": "read_tsv_1_inputSamples",
            "outputSource": "#read_tsv_1/inputSamples"
        },
        {
            "type": {
                "items": "File",
                "type": "array"
            },
            "id": "HaplotypeCallerERC_GVCF",
            "outputSource": "#HaplotypeCallerERC/GVCF"
        },
        {
            "type": "File",
            "id": "GenotypeGVCFs_rawVCF",
            "outputSource": "#GenotypeGVCFs/rawVCF"
        }
    ],
    "id": "jointCallingGenotypes",
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
    "steps": [
        {
            "in": {
                "infile": "inputSamplesFile"
            },
            "run": "read_tsv.cwl",
            "id": "read_tsv_1",
            "out": [
                "inputSamples"
            ]
        },
        {
            "in": [
                {
                    "source": "#read_tsv_1/inputSamples",
                    "valueFrom": "$(self[1])",
                    "id": "bamFile"
                },
                {
                    "source": "#read_tsv_1/inputSamples",
                    "valueFrom": "$(self[2])",
                    "id": "bamIndex"
                },
                {
                    "source": "#read_tsv_1/inputSamples",
                    "valueFrom": "$(self[0])",
                    "id": "sampleName"
                },
                {
                    "source": "refFasta",
                    "id": "RefFasta"
                },
                {
                    "source": "gatk",
                    "id": "GATK"
                },
                {
                    "source": "refIndex",
                    "id": "RefIndex"
                },
                {
                    "source": "refDict",
                    "id": "RefDict"
                }
            ],
            "scatterMethod": "dotproduct",
            "id": "HaplotypeCallerERC",
            "out": [
                {
                    "id": "GVCF"
                }
            ],
            "scatter": [
                "bamFile",
                "bamIndex",
                "sampleName"
            ],
            "run": "HaplotypeCallerERC.cwl"
        },
        {
            "in": [
                {
                    "source": "HaplotypeCallerERC/GVCF",
                    "id": "GVCFs"
                },
                {
                    "valueFrom": "$(\"CEUtrio\")",
                    "id": "sampleName"
                },
                {
                    "source": "refFasta",
                    "id": "RefFasta"
                },
                {
                    "source": "gatk",
                    "id": "GATK"
                },
                {
                    "source": "refIndex",
                    "id": "RefIndex"
                },
                {
                    "source": "refDict",
                    "id": "RefDict"
                }
            ],
            "run": "GenotypeGVCFs.cwl",
            "id": "GenotypeGVCFs",
            "out": [
                {
                    "id": "rawVCF"
                }
            ]
        }
    ],
    "class": "Workflow"
}