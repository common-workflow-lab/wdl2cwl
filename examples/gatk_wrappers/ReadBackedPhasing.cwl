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
            "id": "cacheWindowSize",
            "type": "int?",
            "doc": "The window size (in bases) to cache variant sites and their reads for the phasing procedure"
        },
        {
            "id": "debug",
            "type": "boolean?",
            "doc": "If specified, print out very verbose debug information (if -l DEBUG is also specified)"
        },
        {
            "id": "enableMergePhasedSegregatingPolymorphismsToMNP",
            "type": "boolean?",
            "doc": "Merge consecutive phased sites into MNP records"
        },
        {
            "id": "maxGenomicDistanceForMNP",
            "type": "int?",
            "doc": "The maximum reference-genome distance between consecutive heterozygous sites to permit merging phased VCF records into a MNP record"
        },
        {
            "id": "maxPhaseSites",
            "type": "int?",
            "doc": "The maximum number of successive heterozygous sites permitted to be used by the phasing algorithm"
        },
        {
            "id": "min_base_quality_score",
            "type": "int?",
            "doc": "Minimum base quality required to consider a base for phasing"
        },
        {
            "id": "min_mapping_quality_score",
            "type": "int?",
            "doc": "Minimum read mapping quality required to consider a read for phasing"
        },
        {
            "id": "out",
            "type": "string?",
            "doc": "File to which variants should be written"
        },
        {
            "id": "phaseQualityThresh",
            "type": "float?",
            "doc": "The minimum phasing quality score required to output phasing"
        },
        {
            "id": "sampleToPhase",
            "type": "string?",
            "doc": "Only include these samples when phasing"
        },
        {
            "id": "variant",
            "type": "string",
            "doc": "Input VCF file"
        }
    ],
    "id": "ReadBackedPhasing",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T ReadBackedPhasing \\\t\t\t-R $(inputs.ref.path) \\\t\t\t--input_file $(inputs.input_file) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t-cacheWindow $(inputs.cacheWindowSize) \\\t\t\t-debug $(inputs.debug) \\\t\t\t-enableMergeToMNP $(inputs.enableMergePhasedSegregatingPolymorphismsToMNP) \\\t\t\t-maxDistMNP $(inputs.maxGenomicDistanceForMNP) \\\t\t\t-maxSites $(inputs.maxPhaseSites) \\\t\t\t-mbq $(inputs.min_base_quality_score) \\\t\t\t-mmq $(inputs.min_mapping_quality_score) \\\t\t\t-o $(inputs.out) \\\t\t\t-phaseThresh $(inputs.phaseQualityThresh) \\\t\t\t$(\"-sampleToPhase \" + inputs.sampleToPhase) \\\t\t\t-V $(inputs.variant) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}