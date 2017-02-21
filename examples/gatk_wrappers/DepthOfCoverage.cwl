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
            "id": "ntVal",
            "type": "int?"
        },
        {
            "id": "calculateCoverageOverGenes",
            "type": "File?",
            "doc": "Calculate coverage statistics over this list of genes"
        },
        {
            "id": "countType",
            "type": "string?",
            "doc": "How should overlapping reads from the same fragment be handled?"
        },
        {
            "id": "ignoreDeletionSites",
            "type": "boolean?",
            "doc": "Ignore sites consisting only of deletions"
        },
        {
            "id": "includeDeletions",
            "type": "boolean?",
            "doc": "Include information on deletions"
        },
        {
            "id": "includeRefNSites",
            "type": "boolean?",
            "doc": "Include sites where the reference is N"
        },
        {
            "id": "maxBaseQuality",
            "type": "string?",
            "doc": "Maximum quality of bases to count towards depth"
        },
        {
            "id": "maxMappingQuality",
            "type": "int?",
            "doc": "Maximum mapping quality of reads to count towards depth"
        },
        {
            "id": "minBaseQuality",
            "type": "string?",
            "doc": "Minimum quality of bases to count towards depth"
        },
        {
            "id": "minMappingQuality",
            "type": "int?",
            "doc": "Minimum mapping quality of reads to count towards depth"
        },
        {
            "id": "nBins",
            "type": "int?",
            "doc": "Number of bins to use for granular binning"
        },
        {
            "id": "omitDepthOutputAtEachBase",
            "type": "boolean?",
            "doc": "Do not output depth of coverage at each base"
        },
        {
            "id": "omitIntervalStatistics",
            "type": "boolean?",
            "doc": "Do not calculate per-interval statistics"
        },
        {
            "id": "omitLocusTable",
            "type": "boolean?",
            "doc": "Do not calculate per-sample per-depth counts of loci"
        },
        {
            "id": "omitPerSampleStats",
            "type": "boolean?",
            "doc": "Do not output the summary files per-sample"
        },
        {
            "id": "out",
            "type": "string?",
            "doc": "An output file created by the walker.  Will overwrite contents if file exists"
        },
        {
            "id": "outputFormat",
            "type": "string?",
            "doc": "The format of the output file"
        },
        {
            "id": "partitionType",
            "type": "string?",
            "doc": "Partition type for depth of coverage"
        },
        {
            "id": "printBaseCounts",
            "type": "boolean?",
            "doc": "Add base counts to per-locus output"
        },
        {
            "id": "printBinEndpointsAndExit",
            "type": "boolean?",
            "doc": "Print the bin values and exit immediately"
        },
        {
            "id": "start",
            "type": "int?",
            "doc": "Starting (left endpoint) for granular binning"
        },
        {
            "id": "stop",
            "type": "int?",
            "doc": "Ending (right endpoint) for granular binning"
        },
        {
            "id": "summaryCoverageThreshold",
            "type": "string?",
            "doc": "Coverage threshold (in percent) for summarizing statistics"
        }
    ],
    "id": "DepthOfCoverage",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T DepthOfCoverage \\\t\t\t-R $(inputs.ref.path) \\\t\t\t--input_file $(inputs.input_file) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t$(\"-nt\" + inputs.ntVal) \\\t\t\t$(\"-geneList \" + inputs.calculateCoverageOverGenes) \\\t\t\tcountType $(inputs.countType) \\\t\t\tignoreDeletionSites $(inputs.ignoreDeletionSites) \\\t\t\t-dels $(inputs.includeDeletions) \\\t\t\tincludeRefNSites $(inputs.includeRefNSites) \\\t\t\tmaxBaseQuality $(inputs.maxBaseQuality) \\\t\t\tmaxMappingQuality $(inputs.maxMappingQuality) \\\t\t\t-mbq $(inputs.minBaseQuality) \\\t\t\t-mmq $(inputs.minMappingQuality) \\\t\t\tnBins $(inputs.nBins) \\\t\t\t-omitBaseOutput $(inputs.omitDepthOutputAtEachBase) \\\t\t\t-omitIntervals $(inputs.omitIntervalStatistics) \\\t\t\t-omitLocusTable $(inputs.omitLocusTable) \\\t\t\t-omitSampleSummary $(inputs.omitPerSampleStats) \\\t\t\t-o $(inputs.out) \\\t\t\toutputFormat $(inputs.outputFormat) \\\t\t\t-pt $(inputs.partitionType) \\\t\t\t-baseCounts $(inputs.printBaseCounts) \\\t\t\tprintBinEndpointsAndExit $(inputs.printBinEndpointsAndExit) \\\t\t\tstart $(inputs.start) \\\t\t\tstop $(inputs.stop) \\\t\t\t-ct $(inputs.summaryCoverageThreshold) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}