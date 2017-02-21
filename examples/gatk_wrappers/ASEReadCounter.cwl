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
            "id": "unsafe",
            "type": "string",
            "doc": "Enable unsafe operations: nothing will be checked at runtime"
        },
        {
            "id": "countOverlapReadsType",
            "type": "string?",
            "doc": "Handling of overlapping reads from the same fragment"
        },
        {
            "id": "minBaseQuality",
            "type": "string?",
            "doc": "Minimum base quality"
        },
        {
            "id": "minDepthOfNonFilteredBase",
            "type": "int?",
            "doc": "Minimum number of bases that pass filters"
        },
        {
            "id": "minMappingQuality",
            "type": "int?",
            "doc": "Minimum read mapping quality"
        },
        {
            "id": "out",
            "type": "string?",
            "doc": "An output file created by the walker.  Will overwrite contents if file exists"
        },
        {
            "id": "outputFormat",
            "type": "string?",
            "doc": "Format of the output file, can be CSV, TABLE, RTABLE"
        },
        {
            "id": "sitesVCFFile",
            "type": "string",
            "doc": "Undocumented option"
        }
    ],
    "id": "ASEReadCounter",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T ASEReadCounter \\\t\t\t-R $(inputs.ref.path) \\\t\t\t--input_file $(inputs.input_file) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t--unsafe $(inputs.unsafe) \\\t\t\t-overlap $(inputs.countOverlapReadsType) \\\t\t\t-mbq $(inputs.minBaseQuality) \\\t\t\t-minDepth $(inputs.minDepthOfNonFilteredBase) \\\t\t\t-mmq $(inputs.minMappingQuality) \\\t\t\t-o $(inputs.out) \\\t\t\toutputFormat $(inputs.outputFormat) \\\t\t\t-sites $(inputs.sitesVCFFile) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}