#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "inputs": [
        {
            "id": "gatk",
            "type": "File",
            "doc": "Executable jar for the GenomeAnalysisTK"
        },
        {
            "id": "ref",
            "type": "File",
            "doc": "fasta file of reference genome"
        },
        {
            "id": "refIndex",
            "type": "File",
            "doc": "Index file of reference genome"
        },
        {
            "id": "refDict",
            "type": "File",
            "doc": "dict file of reference genome"
        },
        {
            "id": "userString",
            "type": "string?",
            "doc": "An optional parameter which allows the user to specify additions to the command line at run time"
        },
        {
            "id": "input_file",
            "type": "string[]",
            "doc": "Input file containing sequence data (BAM or CRAM)"
        },
        {
            "id": "intervals",
            "type": "string[]?",
            "doc": "One or more genomic intervals over which to operate"
        },
        {
            "id": "consensusDeterminationModel",
            "type": "string?",
            "doc": "Determines how to compute the possible alternate consenses"
        },
        {
            "id": "entropyThreshold",
            "type": "float?",
            "doc": "Percentage of mismatches at a locus to be considered having high entropy (0.0 < entropy <= 1.0)"
        },
        {
            "id": "knownAlleles",
            "type": "string[]?",
            "doc": "Input VCF file(s) with known indels"
        },
        {
            "id": "LODThresholdForCleaning",
            "type": "float?",
            "doc": "LOD threshold above which the cleaner will clean"
        },
        {
            "id": "maxConsensuses",
            "type": "int?",
            "doc": "Max alternate consensuses to try (necessary to improve performance in deep coverage)"
        },
        {
            "id": "maxIsizeForMovement",
            "type": "int?",
            "doc": "maximum insert size of read pairs that we attempt to realign"
        },
        {
            "id": "maxPositionalMoveAllowed",
            "type": "int?",
            "doc": "Maximum positional move in basepairs that a read can be adjusted during realignment"
        },
        {
            "id": "maxReadsForConsensuses",
            "type": "int?",
            "doc": "Max reads used for finding the alternate consensuses (necessary to improve performance in deep coverage)"
        },
        {
            "id": "maxReadsForRealignment",
            "type": "int?",
            "doc": "Max reads allowed at an interval for realignment"
        },
        {
            "id": "maxReadsInMemory",
            "type": "int?",
            "doc": "max reads allowed to be kept in memory at a time by the SAMFileWriter"
        },
        {
            "id": "noOriginalAlignmentTags",
            "type": "boolean?",
            "doc": "Don't output the original cigar or alignment start tags for each realigned read in the output bam"
        },
        {
            "id": "nWayOut",
            "type": "string?",
            "doc": "Generate one output file for each input (-I) bam file (not compatible with -output)"
        },
        {
            "id": "out",
            "type": "string?",
            "doc": "Output bam"
        },
        {
            "id": "targetIntervals",
            "type": "string",
            "doc": "Intervals file output from RealignerTargetCreator"
        }
    ],
    "id": "IndelRealigner",
    "baseCommand": [],
    "class": "CommandLineTool",
    "requirements": [
        {
            "class": "ShellCommandRequirement"
        },
        {
            "class": "InlineJavascriptRequirement"
        },
        {
            "dockerPull": "broadinstitute/genomes-in-the-cloud:2.2.2-1466113830",
            "class": "DockerRequirement"
        }
    ],
    "outputs": [
        {
            "id": "taskOut",
            "outputBinding": {
                "glob": "$(inputs.out)"
            },
            "type": "string"
        }
    ],
    "arguments": [
        {
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T IndelRealigner \\\t\t\t-R $(inputs.ref.path) \\\t\t\t--input_file $(inputs.input_file) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t-model $(inputs.consensusDeterminationModel) \\\t\t\t-entropy $(inputs.entropyThreshold) \\\t\t\t-known $(inputs.knownAlleles) \\\t\t\t-LOD $(inputs.LODThresholdForCleaning) \\\t\t\t-maxConsensuses $(inputs.maxConsensuses) \\\t\t\t-maxIsize $(inputs.maxIsizeForMovement) \\\t\t\t-maxPosMove $(inputs.maxPositionalMoveAllowed) \\\t\t\t-greedy $(inputs.maxReadsForConsensuses) \\\t\t\t-maxReads $(inputs.maxReadsForRealignment) \\\t\t\t-maxInMemory $(inputs.maxReadsInMemory) \\\t\t\t-noTags $(inputs.noOriginalAlignmentTags) \\\t\t\t$(\"-nWayOut \" + inputs.nWayOut) \\\t\t\t$(\"-o \" + inputs.out) \\\t\t\t-targetIntervals $(inputs.targetIntervals) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}