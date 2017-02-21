#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "steps": [
        {
            "out": [
                {
                    "id": "version"
                }
            ],
            "in": [],
            "id": "GetBwaVersion",
            "run": "GetBwaVersion.cwl"
        },
        {
            "out": [
                {
                    "id": "output_bam"
                },
                {
                    "id": "bwa_stderr_log"
                }
            ],
            "id": "SamToFastqAndBwaMem",
            "run": "SamToFastqAndBwaMem.cwl",
            "in": [
                {
                    "source": "flowcell_unmapped_bams",
                    "id": "input_bam",
                    "valueFrom": "$(self)"
                },
                {
                    "source": "bwa_commandline",
                    "id": "bwa_commandline"
                },
                {
                    "source": "flowcell_unmapped_bams",
                    "id": "output_bam_basename",
                    "valueFrom": "$(inputs.self.replace(sub_strip_path, \"sdddd\").replace(sub_strip_unmapped, \"\") + \".unmerged\")"
                },
                {
                    "source": "ref_fasta",
                    "id": "ref_fasta"
                },
                {
                    "source": "ref_fasta_index",
                    "id": "ref_fasta_index"
                },
                {
                    "source": "ref_dict",
                    "id": "ref_dict"
                },
                {
                    "source": "ref_alt",
                    "id": "ref_alt"
                },
                {
                    "source": "ref_bwt",
                    "id": "ref_bwt"
                },
                {
                    "source": "ref_amb",
                    "id": "ref_amb"
                },
                {
                    "source": "ref_ann",
                    "id": "ref_ann"
                },
                {
                    "source": "ref_pac",
                    "id": "ref_pac"
                },
                {
                    "source": "ref_sa",
                    "id": "ref_sa"
                },
                {
                    "source": "flowcell_medium_disk",
                    "id": "disk_size"
                },
                {
                    "source": "preemptible_tries",
                    "id": "preemptible_tries"
                }
            ],
            "scatterMethod": "dotproduct",
            "scatter": [
                "input_bam",
                "output_bam_basename"
            ]
        },
        {
            "out": [
                {
                    "id": "output_bam"
                }
            ],
            "id": "MergeBamAlignment",
            "run": "MergeBamAlignment.cwl",
            "in": [
                {
                    "source": "flowcell_unmapped_bams",
                    "id": "unmapped_bam",
                    "valueFrom": "$(self)"
                },
                {
                    "source": "bwa_commandline",
                    "id": "bwa_commandline"
                },
                {
                    "source": "#GetBwaVersion/version",
                    "id": "bwa_version"
                },
                {
                    "source": "#SamToFastqAndBwaMem/output_bam",
                    "id": "aligned_bam"
                },
                {
                    "source": "flowcell_unmapped_bams",
                    "id": "output_bam_basename",
                    "valueFrom": "$(inputs.self.replace(sub_strip_path, \"\").replace(sub_strip_unmapped, \"\") + \".aligned.unsorted\")"
                },
                {
                    "source": "ref_fasta",
                    "id": "ref_fasta"
                },
                {
                    "source": "ref_fasta_index",
                    "id": "ref_fasta_index"
                },
                {
                    "source": "ref_dict",
                    "id": "ref_dict"
                },
                {
                    "source": "flowcell_medium_disk",
                    "id": "disk_size"
                },
                {
                    "source": "preemptible_tries",
                    "id": "preemptible_tries"
                }
            ],
            "scatterMethod": "dotproduct",
            "scatter": [
                "unmapped_bam",
                "output_bam_basename"
            ]
        },
        {
            "out": [
                {
                    "id": "output_bam"
                },
                {
                    "id": "output_bam_index"
                },
                {
                    "id": "output_bam_md5"
                }
            ],
            "in": [
                {
                    "source": "#MergeBamAlignment/output_bam",
                    "id": "input_bam"
                },
                {
                    "source": "flowcell_unmapped_bams",
                    "id": "output_bam_basename",
                    "valueFrom": "$(inputs.self.replace(sub_strip_path, \"\").replace(sub_strip_unmapped, \"\") + \".sorted\")"
                },
                {
                    "source": "ref_dict",
                    "id": "ref_dict"
                },
                {
                    "source": "ref_fasta",
                    "id": "ref_fasta"
                },
                {
                    "source": "ref_fasta_index",
                    "id": "ref_fasta_index"
                },
                {
                    "source": "flowcell_medium_disk",
                    "id": "disk_size"
                },
                {
                    "source": "preemptible_tries",
                    "id": "preemptible_tries"
                }
            ],
            "id": "SortAndFixReadGroupBam",
            "run": "SortAndFixTags.cwl",
            "scatter": [
                "output_bam_basename"
            ]
        },
        {
            "out": [
                {
                    "id": "output_bam"
                },
                {
                    "id": "duplicate_metrics"
                }
            ],
            "in": [
                {
                    "source": "#MergeBamAlignment/output_bam",
                    "id": "input_bams"
                },
                {
                    "valueFrom": "$(sample_name + \".aligned.unsorted.duplicates_marked\")",
                    "id": "output_bam_basename"
                },
                {
                    "valueFrom": "$(sample_name + \".duplicate_metrics\")",
                    "id": "metrics_filename"
                },
                {
                    "source": "agg_large_disk",
                    "id": "disk_size"
                }
            ],
            "id": "MarkDuplicates",
            "run": "MarkDuplicates.cwl"
        },
        {
            "out": [
                {
                    "id": "output_bam"
                },
                {
                    "id": "output_bam_index"
                },
                {
                    "id": "output_bam_md5"
                }
            ],
            "in": [
                {
                    "source": "#MarkDuplicates/output_bam",
                    "id": "input_bam"
                },
                {
                    "valueFrom": "$(sample_name + \".aligned.duplicate_marked.sorted\")",
                    "id": "output_bam_basename"
                },
                {
                    "source": "ref_dict",
                    "id": "ref_dict"
                },
                {
                    "source": "ref_fasta",
                    "id": "ref_fasta"
                },
                {
                    "source": "ref_fasta_index",
                    "id": "ref_fasta_index"
                },
                {
                    "source": "agg_large_disk",
                    "id": "disk_size"
                },
                {
                    "valueFrom": "$(0)",
                    "id": "preemptible_tries"
                }
            ],
            "id": "SortAndFixSampleBam",
            "run": "SortAndFixTags.cwl"
        },
        {
            "out": [
                {
                    "id": "sequence_grouping"
                }
            ],
            "in": [
                {
                    "source": "ref_dict",
                    "id": "ref_dict"
                },
                {
                    "source": "preemptible_tries",
                    "id": "preemptible_tries"
                }
            ],
            "id": "CreateSequenceGroupingTSV",
            "run": "CreateSequenceGroupingTSV.cwl"
        },
        {
            "out": [
                {
                    "id": "recalibration_report"
                }
            ],
            "in": [
                {
                    "source": "#SortAndFixSampleBam/output_bam",
                    "id": "input_bam"
                },
                {
                    "source": "#SortAndFixSampleBam/output_bam_index",
                    "id": "input_bam_index"
                },
                {
                    "valueFrom": "$(sample_name + \".recal_data.csv\")",
                    "id": "recalibration_report_filename"
                },
                {
                    "source": "CreateSequenceGroupingTSV/sequence_grouping",
                    "id": "sequence_group_interval",
                    "valueFrom": "$(self)"
                },
                {
                    "source": "dbSNP_vcf",
                    "id": "dbSNP_vcf"
                },
                {
                    "source": "dbSNP_vcf_index",
                    "id": "dbSNP_vcf_index"
                },
                {
                    "source": "known_indels_sites_VCFs",
                    "id": "known_indels_sites_VCFs"
                },
                {
                    "source": "known_indels_sites_indices",
                    "id": "known_indels_sites_indices"
                },
                {
                    "source": "ref_dict",
                    "id": "ref_dict"
                },
                {
                    "source": "ref_fasta",
                    "id": "ref_fasta"
                },
                {
                    "source": "ref_fasta_index",
                    "id": "ref_fasta_index"
                },
                {
                    "source": "agg_small_disk",
                    "id": "disk_size"
                },
                {
                    "source": "agg_preemptible_tries",
                    "id": "preemptible_tries"
                }
            ],
            "id": "BaseRecalibrator",
            "run": "BaseRecalibrator.cwl",
            "scatter": [
                "sequence_group_interval"
            ]
        },
        {
            "out": [
                {
                    "id": "recalibrated_bam"
                },
                {
                    "id": "recalibrated_bam_checksum"
                }
            ],
            "in": [
                {
                    "source": "#SortAndFixSampleBam/output_bam",
                    "id": "input_bam"
                },
                {
                    "source": "#SortAndFixSampleBam/output_bam_index",
                    "id": "input_bam_index"
                },
                {
                    "source": "recalibrated_bam_basename",
                    "id": "output_bam_basename"
                },
                {
                    "source": "#GatherBqsrReports/output_bqsr_report",
                    "id": "recalibration_report"
                },
                {
                    "source": "CreateSequenceGroupingTSV/sequence_grouping",
                    "id": "sequence_group_interval",
                    "valueFrom": "$(self)"
                },
                {
                    "source": "ref_dict",
                    "id": "ref_dict"
                },
                {
                    "source": "ref_fasta",
                    "id": "ref_fasta"
                },
                {
                    "source": "ref_fasta_index",
                    "id": "ref_fasta_index"
                },
                {
                    "source": "agg_small_disk",
                    "id": "disk_size"
                },
                {
                    "source": "agg_preemptible_tries",
                    "id": "preemptible_tries"
                }
            ],
            "id": "ApplyBQSR",
            "run": "ApplyBQSR.cwl",
            "scatter": [
                "sequence_group_interval"
            ]
        },
        {
            "out": [
                {
                    "id": "output_bqsr_report"
                }
            ],
            "in": [
                {
                    "source": "#BaseRecalibrator/recalibration_report",
                    "id": "input_bqsr_reports"
                },
                {
                    "valueFrom": "$(sample_name + \".recal_data.csv\")",
                    "id": "output_report_filename"
                },
                {
                    "source": "flowcell_small_disk",
                    "id": "disk_size"
                },
                {
                    "source": "preemptible_tries",
                    "id": "preemptible_tries"
                }
            ],
            "id": "GatherBqsrReports",
            "run": "GatherBqsrReports.cwl"
        },
        {
            "out": [
                {
                    "id": "recalibrated_bam"
                },
                {
                    "id": "recalibrated_bam_checksum"
                }
            ],
            "in": [
                {
                    "source": "#SortAndFixSampleBam/output_bam",
                    "id": "input_bam"
                },
                {
                    "source": "#SortAndFixSampleBam/output_bam_index",
                    "id": "input_bam_index"
                },
                {
                    "source": "recalibrated_bam_basename",
                    "id": "output_bam_basename"
                },
                {
                    "source": "#GatherBqsrReports/output_bqsr_report",
                    "id": "recalibration_report"
                },
                {
                    "source": "unmapped_group_interval",
                    "id": "sequence_group_interval"
                },
                {
                    "source": "ref_dict",
                    "id": "ref_dict"
                },
                {
                    "source": "ref_fasta",
                    "id": "ref_fasta"
                },
                {
                    "source": "ref_fasta_index",
                    "id": "ref_fasta_index"
                },
                {
                    "source": "agg_small_disk",
                    "id": "disk_size"
                },
                {
                    "source": "agg_preemptible_tries",
                    "id": "preemptible_tries"
                }
            ],
            "id": "ApplyBQSRToUnmappedReads",
            "run": "ApplyBQSR.cwl"
        },
        {
            "out": [
                {
                    "id": "output_bam"
                },
                {
                    "id": "output_bam_index"
                },
                {
                    "id": "output_bam_md5"
                }
            ],
            "in": [
                {
                    "source": "#ApplyBQSR/recalibrated_bam",
                    "id": "input_bams"
                },
                {
                    "source": "#ApplyBQSRToUnmappedReads/recalibrated_bam",
                    "id": "input_unmapped_reads_bam"
                },
                {
                    "source": "sample_name",
                    "id": "output_bam_basename"
                },
                {
                    "source": "agg_large_disk",
                    "id": "disk_size"
                },
                {
                    "source": "agg_preemptible_tries",
                    "id": "preemptible_tries"
                }
            ],
            "id": "GatherBamFiles",
            "run": "GatherBamFiles.cwl"
        },
        {
            "out": [
                {
                    "id": "output_cram"
                },
                {
                    "id": "output_cram_index"
                },
                {
                    "id": "output_cram_md5"
                }
            ],
            "in": [
                {
                    "source": "#GatherBamFiles/output_bam",
                    "id": "input_bam"
                },
                {
                    "source": "ref_fasta",
                    "id": "ref_fasta"
                },
                {
                    "source": "ref_fasta_index",
                    "id": "ref_fasta_index"
                },
                {
                    "source": "sample_name",
                    "id": "output_basename"
                },
                {
                    "source": "agg_medium_disk",
                    "id": "disk_size"
                },
                {
                    "source": "agg_preemptible_tries",
                    "id": "preemptible_tries"
                }
            ],
            "id": "ConvertToCram",
            "run": "ConvertToCram.cwl"
        },
        {
            "out": [
                {
                    "id": "output_gvcf"
                },
                {
                    "id": "output_gvcf_index"
                }
            ],
            "in": [
                {
                    "source": "#GatherBamFiles/output_bam",
                    "id": "input_bam"
                },
                {
                    "source": "#GatherBamFiles/output_bam_index",
                    "id": "input_bam_index"
                },
                {
                    "source": "scattered_calling_intervals",
                    "id": "interval_list",
                    "valueFrom": "$(self)"
                },
                {
                    "source": "sample_name",
                    "id": "gvcf_basename"
                },
                {
                    "source": "ref_dict",
                    "id": "ref_dict"
                },
                {
                    "source": "ref_fasta",
                    "id": "ref_fasta"
                },
                {
                    "source": "ref_fasta_index",
                    "id": "ref_fasta_index"
                },
                {
                    "source": "agg_small_disk",
                    "id": "disk_size"
                },
                {
                    "source": "agg_preemptible_tries",
                    "id": "preemptible_tries"
                }
            ],
            "id": "HaplotypeCaller",
            "run": "HaplotypeCaller.cwl",
            "scatter": [
                "interval_list"
            ]
        },
        {
            "out": [
                {
                    "id": "output_vcf"
                },
                {
                    "id": "output_vcf_index"
                }
            ],
            "in": [
                {
                    "source": "#HaplotypeCaller/output_gvcf",
                    "id": "input_vcfs"
                },
                {
                    "source": "#HaplotypeCaller/output_gvcf_index",
                    "id": "input_vcfs_indexes"
                },
                {
                    "source": "final_gvcf_name",
                    "id": "output_vcf_name"
                },
                {
                    "source": "agg_small_disk",
                    "id": "disk_size"
                },
                {
                    "source": "agg_preemptible_tries",
                    "id": "preemptible_tries"
                }
            ],
            "id": "GatherVCFs",
            "run": "GatherVCFs.cwl"
        }
    ],
    "id": "PairedEndSingleSampleWorkflow",
    "outputs": [
        {
            "outputSource": "#MarkDuplicates/duplicate_metrics",
            "id": "duplicate_metrics"
        },
        {
            "outputSource": "#GatherBqsrReports/output_bqsr_report",
            "id": "GatherBqsrReports_output_bqsr_report",
            "type": "File"
        },
        {
            "outputSource": "#ConvertToCram/output_cram",
            "id": "ConvertToCram_output_cram",
            "type": "File"
        },
        {
            "outputSource": "#ConvertToCram/output_cram_index",
            "id": "ConvertToCram_output_cram_index",
            "type": "File"
        },
        {
            "outputSource": "#ConvertToCram/output_cram_md5",
            "id": "ConvertToCram_output_cram_md5",
            "type": "File"
        },
        {
            "outputSource": "#GatherVCFs/output_vcf",
            "id": "GatherVCFs_output_vcf",
            "type": "File"
        },
        {
            "outputSource": "#GatherVCFs/output_vcf_index",
            "id": "GatherVCFs_output_vcf_index",
            "type": "File"
        }
    ],
    "inputs": [
        {
            "id": "sample_name",
            "type": "string"
        },
        {
            "id": "final_gvcf_name",
            "type": "string"
        },
        {
            "id": "flowcell_unmapped_bams",
            "type": "File[]"
        },
        {
            "id": "unmapped_bam_suffix",
            "type": "string"
        },
        {
            "id": "scattered_calling_intervals",
            "type": "File[]"
        },
        {
            "id": "wgs_calling_interval_list",
            "type": "File"
        },
        {
            "id": "ref_fasta",
            "type": "File"
        },
        {
            "id": "ref_fasta_index",
            "type": "File"
        },
        {
            "id": "ref_dict",
            "type": "File"
        },
        {
            "id": "ref_alt",
            "type": "File"
        },
        {
            "id": "ref_bwt",
            "type": "File"
        },
        {
            "id": "ref_sa",
            "type": "File"
        },
        {
            "id": "ref_amb",
            "type": "File"
        },
        {
            "id": "ref_ann",
            "type": "File"
        },
        {
            "id": "ref_pac",
            "type": "File"
        },
        {
            "id": "dbSNP_vcf",
            "type": "File"
        },
        {
            "id": "dbSNP_vcf_index",
            "type": "File"
        },
        {
            "id": "known_indels_sites_VCFs",
            "type": "File[]"
        },
        {
            "id": "known_indels_sites_indices",
            "type": "File[]"
        },
        {
            "id": "flowcell_small_disk",
            "type": "int"
        },
        {
            "id": "flowcell_medium_disk",
            "type": "int"
        },
        {
            "id": "agg_small_disk",
            "type": "int"
        },
        {
            "id": "agg_medium_disk",
            "type": "int"
        },
        {
            "id": "agg_large_disk",
            "type": "int"
        },
        {
            "id": "preemptible_tries",
            "type": "int"
        },
        {
            "id": "agg_preemptible_tries",
            "type": "int"
        },
        {
            "default": "$(\"bwa mem -K 100000000 -p -v 3 -t 16 $bash_ref_fasta\")",
            "id": "bwa_commandline",
            "type": "string"
        },
        {
            "default": "$(sample_name + \".aligned.duplicates_marked.recalibrated\")",
            "id": "recalibrated_bam_basename",
            "type": "string"
        },
        {
            "default": "$(\"gs://.*/\")",
            "id": "sub_strip_path",
            "type": "string"
        },
        {
            "default": "$(unmapped_bam_suffix + \"$\")",
            "id": "sub_strip_unmapped",
            "type": "string"
        },
        {
            "default": [
                "unmapped"
            ],
            "id": "unmapped_group_interval",
            "type": "string[]"
        }
    ],
    "requirements": [
        {
            "class": "InlineJavascriptRequirement"
        },
        {
            "class": "ScatterFeatureRequirement"
        },
        {
            "class": "StepInputExpressionRequirement"
        },
        {
            "class": "ScatterFeatureRequirement"
        },
        {
            "class": "StepInputExpressionRequirement"
        },
        {
            "class": "ScatterFeatureRequirement"
        },
        {
            "class": "StepInputExpressionRequirement"
        }
    ],
    "class": "Workflow",
    "cwlVersion": "v1.0"
}