#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "arguments": [
        {
            "valueFrom": "${            var known_indels_sites_VCFs_separated = '';            for (var i=0; i<inputs.known_indels_sites_VCFs.length; i++){                known_indels_sites_VCFs_separated = known_indels_sites_VCFs_separated + inputs.known_indels_sites_VCFs[i].path + ' -knownSites ';            }            known_indels_sites_VCFs_separated = known_indels_sites_VCFs_separated.replace(/ -knownSites $/, '');                        var sequence_group_interval_separated = '';            for (var i=0; i<inputs.sequence_group_interval.length; i++){                sequence_group_interval_separated = sequence_group_interval_separated + inputs.sequence_group_interval[i].path + ' -L ';            }            sequence_group_interval_separated = sequence_group_interval_separated.replace(/ -L $/, '');            return \"    java -XX:GCTimeLimit=50 -XX:GCHeapFreeLimit=10 -XX:+PrintFlagsFinal \\      -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -XX:+PrintGCDetails \\      -Xloggc:gc_log.log -Dsamjdk.use_async_io=false -Xmx4000m \\      -jar /usr/gitc/GATK4.jar \\      BaseRecalibrator \\      -R \" + inputs.ref_fasta.path + \" \\      -I \" + inputs.input_bam.path + \" \\      --useOriginalQualities \\      -O \" + inputs.recalibration_report_filename + \" \\      -knownSites \" + inputs.dbSNP_vcf.path + \" \\      -knownSites \" + known_indels_sites_VCFs_separated + \" \\      -L \" + sequence_group_interval_separated + \"  \"}",
            "shellQuote": false
        }
    ],
    "baseCommand": [],
    "id": "BaseRecalibrator",
    "outputs": [
        {
            "outputBinding": {
                "glob": "$(inputs.recalibration_report_filename)"
            },
            "id": "recalibration_report",
            "type": "File"
        }
    ],
    "requirements": [
        {
            "class": "ShellCommandRequirement"
        },
        {
            "class": "InlineJavascriptRequirement"
        },
        {
            "dockerPull": "broadinstitute/genomes-in-the-cloud:2.2.4-1469632282",
            "class": "DockerRequirement"
        },
        {
            "ramMin": "6 GB",
            "class": "ResourceRequirement"
        }
    ],
    "inputs": [
        {
            "id": "input_bam",
            "type": "File"
        },
        {
            "id": "input_bam_index",
            "type": "File"
        },
        {
            "id": "recalibration_report_filename",
            "type": "string"
        },
        {
            "id": "sequence_group_interval",
            "type": "string[]"
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
            "id": "ref_dict",
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
            "id": "disk_size",
            "type": "int"
        },
        {
            "id": "preemptible_tries",
            "type": "int"
        }
    ],
    "class": "CommandLineTool",
    "cwlVersion": "v1.0"
}