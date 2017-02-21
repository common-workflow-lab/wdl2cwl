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
            "id": "activeProbabilityThreshold",
            "type": "float?",
            "doc": "Threshold for the probability of a profile state being active."
        },
        {
            "id": "activeRegionExtension",
            "type": "int?",
            "doc": "The active region extension; if not provided defaults to Walker annotated default"
        },
        {
            "id": "activeRegionIn",
            "type": "string[]?",
            "doc": "Use this interval list file as the active regions to process"
        },
        {
            "id": "activeRegionMaxSize",
            "type": "int?",
            "doc": "The active region maximum size; if not provided defaults to Walker annotated default"
        },
        {
            "id": "activeRegionOut",
            "type": "string?",
            "doc": "Output the active region to this IGV formatted file"
        },
        {
            "id": "activityProfileOut",
            "type": "string?",
            "doc": "Output the raw activity profile results in IGV format"
        },
        {
            "id": "bandPassSigma",
            "type": "float?",
            "doc": "The sigma of the band pass filter Gaussian kernel; if not provided defaults to Walker annotated default"
        },
        {
            "id": "coverage_threshold",
            "type": "int?",
            "doc": "The minimum allowable coverage to be considered covered"
        },
        {
            "id": "forceActive",
            "type": "boolean?",
            "doc": "If provided, all bases will be tagged as active"
        },
        {
            "id": "minBaseQuality",
            "type": "int?",
            "doc": "The minimum allowable base quality score to be counted for coverage"
        },
        {
            "id": "minMappingQuality",
            "type": "int?",
            "doc": "The minimum allowable mapping quality score to be counted for coverage"
        },
        {
            "id": "out",
            "type": "string?",
            "doc": "An output file created by the walker.  Will overwrite contents if file exists"
        },
        {
            "id": "uncovered",
            "type": "boolean?",
            "doc": "output intervals that fail the coverage threshold instead"
        }
    ],
    "id": "FindCoveredIntervals",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T FindCoveredIntervals \\\t\t\t-R $(inputs.ref.path) \\\t\t\t--input_file $(inputs.input_file) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t-ActProbThresh $(inputs.activeProbabilityThreshold) \\\t\t\t$(\"-activeRegionExtension \" + inputs.activeRegionExtension) \\\t\t\t$(\"-AR \" + inputs.activeRegionIn) \\\t\t\t$(\"-activeRegionMaxSize \" + inputs.activeRegionMaxSize) \\\t\t\t$(\"-ARO \" + inputs.activeRegionOut) \\\t\t\t$(\"-APO \" + inputs.activityProfileOut) \\\t\t\t$(\"-bandPassSigma \" + inputs.bandPassSigma) \\\t\t\t-cov $(inputs.coverage_threshold) \\\t\t\t-forceActive $(inputs.forceActive) \\\t\t\t-minBQ $(inputs.minBaseQuality) \\\t\t\t-minMQ $(inputs.minMappingQuality) \\\t\t\t-o $(inputs.out) \\\t\t\t-u $(inputs.uncovered) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}