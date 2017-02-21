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
            "id": "input_fileeval",
            "type": "boolean",
            "doc": "Output version information"
        },
        {
            "id": "input_filegenotype",
            "type": "boolean?",
            "doc": "Output version information"
        },
        {
            "id": "intervals",
            "type": "string[]?",
            "doc": "One or more genomic intervals over which to operate"
        },
        {
            "id": "base_report",
            "type": "string?",
            "doc": "Where to write a full report about the loci we processed"
        },
        {
            "id": "beta_threshold",
            "type": "float?",
            "doc": "threshold for p(f>=0.5) to trim"
        },
        {
            "id": "genotype_mode",
            "type": "string?",
            "doc": "which approach should we take to getting the genotypes (only in array-free mode)"
        },
        {
            "id": "genotypes",
            "type": "string?",
            "doc": "the genotype information for our sample"
        },
        {
            "id": "lane_level_contamination",
            "type": "string?",
            "doc": "set to META (default), SAMPLE or READGROUP to produce per-bam, per-sample or per-lane estimates"
        },
        {
            "id": "likelihood_file",
            "type": "string?",
            "doc": "write the likelihood values to the specified location"
        },
        {
            "id": "min_mapq",
            "type": "int?",
            "doc": "threshold for minimum mapping quality score"
        },
        {
            "id": "min_qscore",
            "type": "int?",
            "doc": "threshold for minimum base quality score"
        },
        {
            "id": "minimum_base_count",
            "type": "int?",
            "doc": "what minimum number of bases do we need to see to call contamination in a lane / sample?"
        },
        {
            "id": "out",
            "type": "string?",
            "doc": "An output file created by the walker.  Will overwrite contents if file exists"
        },
        {
            "id": "popfile",
            "type": "string",
            "doc": "the variant file containing information about the population allele frequencies"
        },
        {
            "id": "population",
            "type": "string?",
            "doc": "evaluate contamination for just a single contamination population"
        },
        {
            "id": "precision",
            "type": "float?",
            "doc": "the degree of precision to which the contamination tool should estimate (e.g. the bin size)"
        },
        {
            "id": "sample_name",
            "type": "string?",
            "doc": "The sample name; used to extract the correct genotypes from mutli-sample truth vcfs"
        },
        {
            "id": "trim_fraction",
            "type": "float?",
            "doc": "at most, what fraction of sites should be trimmed based on BETA_THRESHOLD"
        },
        {
            "id": "verify_sample",
            "type": "boolean?",
            "doc": "should we verify that the sample name is in the genotypes file?"
        }
    ],
    "id": "ContEst",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T ContEst \\\t\t\t-R $(inputs.ref.path) \\\t\t\t--input_file:eval $(inputs.input_fileeval) \\\t\t\t$(\"--input_file:genotype \" + inputs.input_filegenotype) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t$(\"-br \" + inputs.base_report) \\\t\t\tbeta_threshold $(inputs.beta_threshold) \\\t\t\t-gm $(inputs.genotype_mode) \\\t\t\t$(\"-genotypes \" + inputs.genotypes) \\\t\t\t$(\"-llc \" + inputs.lane_level_contamination) \\\t\t\t$(\"-lf \" + inputs.likelihood_file) \\\t\t\tmin_mapq $(inputs.min_mapq) \\\t\t\tmin_qscore $(inputs.min_qscore) \\\t\t\t-mbc $(inputs.minimum_base_count) \\\t\t\t-o $(inputs.out) \\\t\t\t-pf $(inputs.popfile) \\\t\t\t-population $(inputs.population) \\\t\t\t-pc $(inputs.precision) \\\t\t\t-sn $(inputs.sample_name) \\\t\t\ttrim_fraction $(inputs.trim_fraction) \\\t\t\t-vs $(inputs.verify_sample) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}