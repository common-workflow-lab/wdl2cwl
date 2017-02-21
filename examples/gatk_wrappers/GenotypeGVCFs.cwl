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
            "id": "intervals",
            "type": "string[]?",
            "doc": "One or more genomic intervals over which to operate"
        },
        {
            "id": "ntVal",
            "type": "int?"
        },
        {
            "id": "annotateNDA",
            "type": "boolean?",
            "doc": "If provided, we will annotate records with the number of alternate alleles that were discovered (but not necessarily genotyped) at a given site"
        },
        {
            "id": "annotation",
            "type": "string[]?",
            "doc": "One or more specific annotations to recompute.  The single value 'none' removes the default annotations"
        },
        {
            "id": "dbsnp",
            "type": "string?",
            "doc": "dbSNP file"
        },
        {
            "id": "group",
            "type": "string[]?",
            "doc": "One or more classes/groups of annotations to apply to variant calls"
        },
        {
            "id": "heterozygosity",
            "type": "float?",
            "doc": "Heterozygosity value used to compute prior likelihoods for any locus"
        },
        {
            "id": "includeNonVariantSites",
            "type": "boolean?",
            "doc": "Include loci found to be non-variant after genotyping"
        },
        {
            "id": "indel_heterozygosity",
            "type": "float?",
            "doc": "Heterozygosity for indel calling"
        },
        {
            "id": "input_prior",
            "type": "float[]?",
            "doc": "Input prior for calls"
        },
        {
            "id": "max_alternate_alleles",
            "type": "int?",
            "doc": "Maximum number of alternate alleles to genotype"
        },
        {
            "id": "max_num_PL_values",
            "type": "int?",
            "doc": "Maximum number of PL values to output"
        },
        {
            "id": "out",
            "type": "string?",
            "doc": "File to which variants should be written"
        },
        {
            "id": "sample_ploidy",
            "type": "int?",
            "doc": "Ploidy (number of chromosomes) per sample. For pooled data, set to (Number of samples in each pool * Sample Ploidy)."
        },
        {
            "id": "standard_min_confidence_threshold_for_calling",
            "type": "float?",
            "doc": "The minimum phred-scaled confidence threshold at which variants should be called"
        },
        {
            "id": "standard_min_confidence_threshold_for_emitting",
            "type": "float?",
            "doc": "The minimum phred-scaled confidence threshold at which variants should be emitted (and filtered with LowQual if less than the calling threshold)"
        },
        {
            "id": "variant",
            "type": "string[]",
            "doc": "One or more input gVCF files"
        }
    ],
    "id": "GenotypeGVCFs",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T GenotypeGVCFs \\\t\t\t-R $(inputs.ref.path) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t$(\"-nt\" + inputs.ntVal) \\\t\t\t-nda $(inputs.annotateNDA) \\\t\t\t-A $(inputs.annotation) \\\t\t\t$(\"-D \" + inputs.dbsnp) \\\t\t\t-G $(inputs.group) \\\t\t\t-hets $(inputs.heterozygosity) \\\t\t\t-allSites $(inputs.includeNonVariantSites) \\\t\t\t-indelHeterozygosity $(inputs.indel_heterozygosity) \\\t\t\t-inputPrior $(inputs.input_prior) \\\t\t\t-maxAltAlleles $(inputs.max_alternate_alleles) \\\t\t\t-maxNumPLValues $(inputs.max_num_PL_values) \\\t\t\t-o $(inputs.out) \\\t\t\t-ploidy $(inputs.sample_ploidy) \\\t\t\t-stand_call_conf $(inputs.standard_min_confidence_threshold_for_calling) \\\t\t\t-stand_emit_conf $(inputs.standard_min_confidence_threshold_for_emitting) \\\t\t\t-V $(inputs.variant) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}