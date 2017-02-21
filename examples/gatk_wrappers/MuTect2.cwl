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
            "id": "input_filetumor",
            "type": "boolean",
            "doc": "Output version information"
        },
        {
            "id": "input_filenormal",
            "type": "boolean?",
            "doc": "Output version information"
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
            "id": "alleles",
            "type": "string?",
            "doc": "The set of alleles at which to genotype when --genotyping_mode is GENOTYPE_GIVEN_ALLELES"
        },
        {
            "id": "allowNonUniqueKmersInRef",
            "type": "boolean?",
            "doc": "Allow graphs that have non-unique kmers in the reference"
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
            "id": "artifact_detection_mode",
            "type": "boolean?",
            "doc": "Enable artifact detection for creating panels of normals"
        },
        {
            "id": "bamOutput",
            "type": "string?",
            "doc": "File to which assembled haplotypes should be written"
        },
        {
            "id": "bamWriterType",
            "type": "string?",
            "doc": "Which haplotypes should be written to the BAM"
        },
        {
            "id": "bandPassSigma",
            "type": "float?",
            "doc": "The sigma of the band pass filter Gaussian kernel; if not provided defaults to Walker annotated default"
        },
        {
            "id": "comp",
            "type": "string[]?",
            "doc": "comparison VCF file"
        },
        {
            "id": "consensus",
            "type": "boolean?",
            "doc": "1000G consensus mode"
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
            "id": "cosmic",
            "type": "string[]?",
            "doc": "VCF file of COSMIC sites"
        },
        {
            "id": "dbsnp",
            "type": "string?",
            "doc": "dbSNP file"
        },
        {
            "id": "dbsnp_normal_lod",
            "type": "float?",
            "doc": "LOD threshold for calling normal non-variant at dbsnp sites"
        },
        {
            "id": "debug",
            "type": "boolean?",
            "doc": "Print out very verbose debug information about each triggering active region"
        },
        {
            "id": "debug_read_name",
            "type": "string?",
            "doc": "trace this read name through the calling process"
        },
        {
            "id": "disableOptimizations",
            "type": "boolean?",
            "doc": "Don't skip calculations in ActiveRegions with no variants"
        },
        {
            "id": "doNotRunPhysicalPhasing",
            "type": "boolean?",
            "doc": "Disable physical phasing"
        },
        {
            "id": "dontIncreaseKmerSizesForCycles",
            "type": "boolean?",
            "doc": "Disable iterating over kmer sizes when graph cycles are detected"
        },
        {
            "id": "dontTrimActiveRegions",
            "type": "boolean?",
            "doc": "If specified, we will not trim down the active region from the full region (active + extension) to just the active interval for genotyping"
        },
        {
            "id": "dontUseSoftClippedBases",
            "type": "boolean?",
            "doc": "If specified, we will not analyze soft clipped bases in the reads"
        },
        {
            "id": "emitDroppedReads",
            "type": "boolean?",
            "doc": "Emit reads that are dropped for filtering, trimming, realignment failure"
        },
        {
            "id": "emitRefConfidence",
            "type": "string?",
            "doc": "Mode for emitting reference confidence scores"
        },
        {
            "id": "excludeAnnotation",
            "type": "string[]?",
            "doc": "One or more specific annotations to exclude"
        },
        {
            "id": "forceActive",
            "type": "boolean?",
            "doc": "If provided, all bases will be tagged as active"
        },
        {
            "id": "gcpHMM",
            "type": "int?",
            "doc": "Flat gap continuation penalty for use in the Pair HMM"
        },
        {
            "id": "genotyping_mode",
            "type": "string?",
            "doc": "Specifies how to determine the alternate alleles to use for genotyping"
        },
        {
            "id": "graphOutput",
            "type": "string?",
            "doc": "Write debug assembly graph information to this file"
        },
        {
            "id": "group",
            "type": "string?",
            "doc": "One or more classes/groups of annotations to apply to variant calls"
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
            "id": "initial_normal_lod",
            "type": "float?",
            "doc": "Initial LOD threshold for calling normal variant"
        },
        {
            "id": "initial_tumor_lod",
            "type": "float?",
            "doc": "Initial LOD threshold for calling tumor variant"
        },
        {
            "id": "input_prior",
            "type": "float[]?",
            "doc": "Input prior for calls"
        },
        {
            "id": "kmerSize",
            "type": "int[]?",
            "doc": "Kmer size to use in the read threading assembler"
        },
        {
            "id": "m2debug",
            "type": "boolean?",
            "doc": "Print out very verbose M2 debug information"
        },
        {
            "id": "max_alt_allele_in_normal_fraction",
            "type": "float?",
            "doc": "Threshold for maximum alternate allele fraction in normal"
        },
        {
            "id": "max_alt_alleles_in_normal_count",
            "type": "int?",
            "doc": "Threshold for maximum alternate allele counts in normal"
        },
        {
            "id": "max_alt_alleles_in_normal_qscore_sum",
            "type": "int?",
            "doc": "Threshold for maximum alternate allele quality score sum in normal"
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
            "id": "maxNumHaplotypesInPopulation",
            "type": "int?",
            "doc": "Maximum number of haplotypes to consider for your population"
        },
        {
            "id": "min_base_quality_score",
            "type": "string?",
            "doc": "Minimum base quality required to consider a base for calling"
        },
        {
            "id": "minDanglingBranchLength",
            "type": "int?",
            "doc": "Minimum length of a dangling branch to attempt recovery"
        },
        {
            "id": "minPruning",
            "type": "int?",
            "doc": "Minimum support to not prune paths in the graph"
        },
        {
            "id": "normal_lod",
            "type": "float?",
            "doc": "LOD threshold for calling normal non-germline"
        },
        {
            "id": "normal_panel",
            "type": "string[]?",
            "doc": "VCF file of sites observed in normal"
        },
        {
            "id": "numPruningSamples",
            "type": "int?",
            "doc": "Number of samples that must pass the minPruning threshold"
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
            "id": "phredScaledGlobalReadMismappingRate",
            "type": "int?",
            "doc": "The global assumed mismapping rate for reads"
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
            "id": "tumor_lod",
            "type": "float?",
            "doc": "LOD threshold for calling tumor variant"
        },
        {
            "id": "useFilteredReadsForAnnotations",
            "type": "boolean?",
            "doc": "Use the contamination-filtered read maps for the purposes of annotating variants"
        }
    ],
    "id": "MuTect2",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T MuTect2 \\\t\t\t-R $(inputs.ref.path) \\\t\t\t--input_file:tumor $(inputs.input_filetumor) \\\t\t\t$(\"--input_file:normal \" + inputs.input_filenormal) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t$(\"--BQSR \" + inputs.BQSR) \\\t\t\t$(\"-nct\" + inputs.nctVal) \\\t\t\t-ActProbThresh $(inputs.activeProbabilityThreshold) \\\t\t\t$(\"-activeRegionExtension \" + inputs.activeRegionExtension) \\\t\t\t$(\"-AR \" + inputs.activeRegionIn) \\\t\t\t$(\"-activeRegionMaxSize \" + inputs.activeRegionMaxSize) \\\t\t\t$(\"-ARO \" + inputs.activeRegionOut) \\\t\t\t$(\"-APO \" + inputs.activityProfileOut) \\\t\t\t$(\"-alleles \" + inputs.alleles) \\\t\t\t-allowNonUniqueKmersInRef $(inputs.allowNonUniqueKmersInRef) \\\t\t\t-allSitePLs $(inputs.allSitePLs) \\\t\t\t-nda $(inputs.annotateNDA) \\\t\t\t-A $(inputs.annotation) \\\t\t\tartifact_detection_mode $(inputs.artifact_detection_mode) \\\t\t\t$(\"-bamout \" + inputs.bamOutput) \\\t\t\t-bamWriterType $(inputs.bamWriterType) \\\t\t\t$(\"-bandPassSigma \" + inputs.bandPassSigma) \\\t\t\t-comp $(inputs.comp) \\\t\t\t-consensus $(inputs.consensus) \\\t\t\t$(\"-contaminationFile \" + inputs.contamination_fraction_per_sample_file) \\\t\t\t-contamination $(inputs.contamination_fraction_to_filter) \\\t\t\t-cosmic $(inputs.cosmic) \\\t\t\t$(\"-D \" + inputs.dbsnp) \\\t\t\tdbsnp_normal_lod $(inputs.dbsnp_normal_lod) \\\t\t\t-debug $(inputs.debug) \\\t\t\t$(\"debug_read_name \" + inputs.debug_read_name) \\\t\t\t-disableOptimizations $(inputs.disableOptimizations) \\\t\t\t-doNotRunPhysicalPhasing $(inputs.doNotRunPhysicalPhasing) \\\t\t\t-dontIncreaseKmerSizesForCycles $(inputs.dontIncreaseKmerSizesForCycles) \\\t\t\t-dontTrimActiveRegions $(inputs.dontTrimActiveRegions) \\\t\t\t-dontUseSoftClippedBases $(inputs.dontUseSoftClippedBases) \\\t\t\t-edr $(inputs.emitDroppedReads) \\\t\t\t-ERC $(inputs.emitRefConfidence) \\\t\t\t-XA $(inputs.excludeAnnotation) \\\t\t\t-forceActive $(inputs.forceActive) \\\t\t\t-gcpHMM $(inputs.gcpHMM) \\\t\t\t-gt_mode $(inputs.genotyping_mode) \\\t\t\t$(\"-graph \" + inputs.graphOutput) \\\t\t\t-G $(inputs.group) \\\t\t\t-hets $(inputs.heterozygosity) \\\t\t\t-indelHeterozygosity $(inputs.indel_heterozygosity) \\\t\t\tinitial_normal_lod $(inputs.initial_normal_lod) \\\t\t\tinitial_tumor_lod $(inputs.initial_tumor_lod) \\\t\t\t-inputPrior $(inputs.input_prior) \\\t\t\t-kmerSize $(inputs.kmerSize) \\\t\t\t-m2debug $(inputs.m2debug) \\\t\t\tmax_alt_allele_in_normal_fraction $(inputs.max_alt_allele_in_normal_fraction) \\\t\t\tmax_alt_alleles_in_normal_count $(inputs.max_alt_alleles_in_normal_count) \\\t\t\tmax_alt_alleles_in_normal_qscore_sum $(inputs.max_alt_alleles_in_normal_qscore_sum) \\\t\t\t-maxAltAlleles $(inputs.max_alternate_alleles) \\\t\t\t-maxNumPLValues $(inputs.max_num_PL_values) \\\t\t\t-maxNumHaplotypesInPopulation $(inputs.maxNumHaplotypesInPopulation) \\\t\t\t-mbq $(inputs.min_base_quality_score) \\\t\t\t-minDanglingBranchLength $(inputs.minDanglingBranchLength) \\\t\t\t-minPruning $(inputs.minPruning) \\\t\t\tnormal_lod $(inputs.normal_lod) \\\t\t\t-PON $(inputs.normal_panel) \\\t\t\t-numPruningSamples $(inputs.numPruningSamples) \\\t\t\t-o $(inputs.out) \\\t\t\t-out_mode $(inputs.output_mode) \\\t\t\t-globalMAPQ $(inputs.phredScaledGlobalReadMismappingRate) \\\t\t\t-ploidy $(inputs.sample_ploidy) \\\t\t\t-stand_call_conf $(inputs.standard_min_confidence_threshold_for_calling) \\\t\t\t-stand_emit_conf $(inputs.standard_min_confidence_threshold_for_emitting) \\\t\t\ttumor_lod $(inputs.tumor_lod) \\\t\t\t-useFilteredReadsForAnnotations $(inputs.useFilteredReadsForAnnotations) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}