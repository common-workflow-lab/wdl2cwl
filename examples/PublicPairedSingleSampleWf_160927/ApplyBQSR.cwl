#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "arguments": [
        {
            "valueFrom": "${            var sequence_group_interval_separated = '';            for (var i=0; i<inputs.sequence_group_interval.length; i++){                sequence_group_interval_separated = sequence_group_interval_separated + inputs.sequence_group_interval[i].path + ' -L ';            }            sequence_group_interval_separated = sequence_group_interval_separated.replace(/ -L $/, '');            return \"    java -XX:+PrintFlagsFinal -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps \\      -XX:+PrintGCDetails -Xloggc:gc_log.log -Dsamjdk.use_async_io=false \\      -XX:GCTimeLimit=50 -XX:GCHeapFreeLimit=10 -Xmx3000m \\      -jar /usr/gitc/GATK4.jar \\      ApplyBQSR \\      --createOutputBamMD5 \\      --addOutputSAMProgramRecord \\      -R \" + inputs.ref_fasta.path + \" \\      -I \" + inputs.input_bam.path + \" \\      --useOriginalQualities \\      -O \" + inputs.output_bam_basename + \".bam \\      -bqsr \" + inputs.recalibration_report.path + \" \\      -SQQ 10 -SQQ 20 -SQQ 30 -SQQ 40 \\      --emit_original_quals \\      -L \" + sequence_group_interval_separated + \"  \"}",
            "shellQuote": false
        }
    ],
    "baseCommand": [],
    "id": "ApplyBQSR",
    "outputs": [
        {
            "outputBinding": {
                "glob": "$(inputs.output_bam_basename).bam"
            },
            "id": "recalibrated_bam",
            "type": "File"
        },
        {
            "outputBinding": {
                "glob": "$(inputs.output_bam_basename).bam.md5"
            },
            "id": "recalibrated_bam_checksum",
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
            "ramMin": "3500 MB",
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
            "id": "output_bam_basename",
            "type": "string"
        },
        {
            "id": "recalibration_report",
            "type": "File"
        },
        {
            "id": "sequence_group_interval",
            "type": "string[]"
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