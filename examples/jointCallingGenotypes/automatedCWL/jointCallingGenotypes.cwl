#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "cwlVersion": "v1.0",
    "steps": [
        {
            "out": [
                "inputSamples"
            ],
            "id": "read_tsv_1",
            "in": {
                "infile": "inputSamplesFile"
            },
            "run": "read_tsv.cwl"
        },
        {
            "scatterMethod": "dotproduct",
            "in": [
                {
                    "valueFrom": "$(self[1])",
                    "id": "bamFile",
                    "source": "#read_tsv_1/inputSamples"
                },
                {
                    "valueFrom": "$(self[2])",
                    "id": "bamIndex",
                    "source": "#read_tsv_1/inputSamples"
                },
                {
                    "valueFrom": "$(self[0])",
                    "id": "sampleName",
                    "source": "#read_tsv_1/inputSamples"
                },
                {
                    "id": "RefFasta",
                    "source": "refFasta"
                },
                {
                    "id": "GATK",
                    "source": "gatk"
                },
                {
                    "id": "RefIndex",
                    "source": "refIndex"
                },
                {
                    "id": "RefDict",
                    "source": "refDict"
                }
            ],
            "run": "HaplotypeCallerERC.cwl",
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
            "id": "HaplotypeCallerERC"
        },
        {
            "out": [
                {
                    "id": "rawVCF"
                }
            ],
            "id": "GenotypeGVCFs",
            "in": [
                {
                    "id": "GVCFs",
                    "source": "HaplotypeCallerERC/GVCF"
                },
                {
                    "valueFrom": "$(\"CEUtrio\")",
                    "id": "sampleName"
                },
                {
                    "id": "RefFasta",
                    "source": "refFasta"
                },
                {
                    "id": "GATK",
                    "source": "gatk"
                },
                {
                    "id": "RefIndex",
                    "source": "refIndex"
                },
                {
                    "id": "RefDict",
                    "source": "refDict"
                }
            ],
            "run": "GenotypeGVCFs.cwl"
        }
    ],
    "inputs": [
        {
            "id": "inputSamplesFile",
            "type": "File"
        },
        {
            "id": "gatk",
            "type": "File"
        },
        {
            "id": "refFasta",
            "type": "File"
        },
        {
            "id": "refIndex",
            "type": "File"
        },
        {
            "id": "refDict",
            "type": "File"
        }
    ],
    "outputs": [],
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
    "id": "jointCallingGenotypes",
    "class": "Workflow"
}