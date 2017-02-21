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
            "id": "BQSR",
            "type": "File?",
            "doc": "Input covariates table file for on-the-fly base quality score recalibration"
        },
        {
            "id": "nctVal",
            "type": "int?"
        },
        {
            "id": "ntVal",
            "type": "int?"
        },
        {
            "id": "alleles",
            "type": "string?",
            "doc": "The set of alleles at which to genotype when --genotyping_mode is GENOTYPE_GIVEN_ALLELES"
        },
        {
            "id": "allSitePLs",
            "type": "boolean?",
            "doc": "Annotate all sites with PLs"
        },
        {
            "id": "annotateNDA",
            "type": "boolean?",
            "doc": "If provided, we will annotate records with the number of alternate alleles that were discovered (but not necessarily genotyped) at a given site"
        },
        {
            "id": "annotation",
            "type": "string[]?",
            "doc": "One or more specific annotations to apply to variant calls"
        },
        {
            "id": "comp",
            "type": "string[]?",
            "doc": "Comparison VCF file"
        },
        {
            "id": "computeSLOD",
            "type": "boolean?",
            "doc": "If provided, we will calculate the SLOD (SB annotation)"
        },
        {
            "id": "contamination_fraction_per_sample_file",
            "type": "File?",
            "doc": "Tab-separated File containing fraction of contamination in sequencing data (per sample) to aggressively remove. Format should be <SampleID><TAB><Contamination> (Contamination is double) per line; No header."
        },
        {
            "id": "contamination_fraction_to_filter",
            "type": "float?",
            "doc": "Fraction of contamination in sequencing data (for all samples) to aggressively remove"
        },
        {
            "id": "dbsnp",
            "type": "string?",
            "doc": "dbSNP file"
        },
        {
            "id": "excludeAnnotation",
            "type": "string[]?",
            "doc": "One or more specific annotations to exclude"
        },
        {
            "id": "genotype_likelihoods_model",
            "type": "string?",
            "doc": "Genotype likelihoods calculation model to employ -- SNP is the default option, while INDEL is also available for calling indels and BOTH is available for calling both together"
        },
        {
            "id": "genotyping_mode",
            "type": "string?",
            "doc": "Specifies how to determine the alternate alleles to use for genotyping"
        },
        {
            "id": "group",
            "type": "string?",
            "doc": "One or more classes/groups of annotations to apply to variant calls.  The single value 'none' removes the default group"
        },
        {
            "id": "heterozygosity",
            "type": "float?",
            "doc": "Heterozygosity value used to compute prior likelihoods for any locus"
        },
        {
            "id": "indel_heterozygosity",
            "type": "float?",
            "doc": "Heterozygosity for indel calling"
        },
        {
            "id": "indelGapContinuationPenalty",
            "type": "string?",
            "doc": "Indel gap continuation penalty, as Phred-scaled probability.  I.e., 30 => 10^-30/10"
        },
        {
            "id": "indelGapOpenPenalty",
            "type": "string?",
            "doc": "Indel gap open penalty, as Phred-scaled probability.  I.e., 30 => 10^-30/10"
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
            "id": "max_deletion_fraction",
            "type": "float?",
            "doc": "Maximum fraction of reads with deletions spanning this locus for it to be callable"
        },
        {
            "id": "max_num_PL_values",
            "type": "int?",
            "doc": "Maximum number of PL values to output"
        },
        {
            "id": "min_base_quality_score",
            "type": "int?",
            "doc": "Minimum base quality required to consider a base for calling"
        },
        {
            "id": "min_indel_count_for_genotyping",
            "type": "int?",
            "doc": "Minimum number of consensus indels required to trigger genotyping run"
        },
        {
            "id": "min_indel_fraction_per_sample",
            "type": "float?",
            "doc": "Minimum fraction of all reads at a locus that must contain an indel (of any allele) for that sample to contribute to the indel count for alleles"
        },
        {
            "id": "onlyEmitSamples",
            "type": "string?",
            "doc": "If provided, only these samples will be emitted into the VCF, regardless of which samples are present in the BAM file"
        },
        {
            "id": "out",
            "type": "string?",
            "doc": "File to which variants should be written"
        },
        {
            "id": "output_mode",
            "type": "string?",
            "doc": "Specifies which type of calls we should output"
        },
        {
            "id": "pair_hmm_implementation",
            "type": "string?",
            "doc": "The PairHMM implementation to use for -glm INDEL genotype likelihood calculations"
        },
        {
            "id": "pcr_error_rate",
            "type": "float?",
            "doc": "The PCR error rate to be used for computing fragment-based likelihoods"
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
        }
    ],
    "id": "UnifiedGenotyper",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T UnifiedGenotyper \\\t\t\t-R $(inputs.ref.path) \\\t\t\t--input_file $(inputs.input_file) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t$(\"--BQSR \" + inputs.BQSR) \\\t\t\t$(\"-nct\" + inputs.nctVal) \\\t\t\t$(\"-nt\" + inputs.ntVal) \\\t\t\t$(\"-alleles \" + inputs.alleles) \\\t\t\t-allSitePLs $(inputs.allSitePLs) \\\t\t\t-nda $(inputs.annotateNDA) \\\t\t\t-A $(inputs.annotation) \\\t\t\t-comp $(inputs.comp) \\\t\t\t-slod $(inputs.computeSLOD) \\\t\t\t$(\"-contaminationFile \" + inputs.contamination_fraction_per_sample_file) \\\t\t\t-contamination $(inputs.contamination_fraction_to_filter) \\\t\t\t$(\"-D \" + inputs.dbsnp) \\\t\t\t-XA $(inputs.excludeAnnotation) \\\t\t\t-glm $(inputs.genotype_likelihoods_model) \\\t\t\t-gt_mode $(inputs.genotyping_mode) \\\t\t\t-G $(inputs.group) \\\t\t\t-hets $(inputs.heterozygosity) \\\t\t\t-indelHeterozygosity $(inputs.indel_heterozygosity) \\\t\t\t-indelGCP $(inputs.indelGapContinuationPenalty) \\\t\t\t-indelGOP $(inputs.indelGapOpenPenalty) \\\t\t\t-inputPrior $(inputs.input_prior) \\\t\t\t-maxAltAlleles $(inputs.max_alternate_alleles) \\\t\t\t-deletions $(inputs.max_deletion_fraction) \\\t\t\t-maxNumPLValues $(inputs.max_num_PL_values) \\\t\t\t-mbq $(inputs.min_base_quality_score) \\\t\t\t-minIndelCnt $(inputs.min_indel_count_for_genotyping) \\\t\t\t-minIndelFrac $(inputs.min_indel_fraction_per_sample) \\\t\t\t-onlyEmitSamples $(inputs.onlyEmitSamples) \\\t\t\t-o $(inputs.out) \\\t\t\t-out_mode $(inputs.output_mode) \\\t\t\t-pairHMM $(inputs.pair_hmm_implementation) \\\t\t\t-pcr_error $(inputs.pcr_error_rate) \\\t\t\t-ploidy $(inputs.sample_ploidy) \\\t\t\t-stand_call_conf $(inputs.standard_min_confidence_threshold_for_calling) \\\t\t\t-stand_emit_conf $(inputs.standard_min_confidence_threshold_for_emitting) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}