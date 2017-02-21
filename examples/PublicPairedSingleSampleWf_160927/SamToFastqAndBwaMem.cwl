#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "arguments": [
        {
            "valueFrom": "    set -o pipefail    # set the bash variable needed for the command-line    bash_ref_fasta=$(inputs.ref_fasta.path)    # if ref_alt has data in it,     if [ -s $(inputs.ref_alt.path) ]; then      java -Xmx3000m -jar /usr/gitc/picard.jar \\        SamToFastq \\        INPUT=$(inputs.input_bam.path) \\        FASTQ=/dev/stdout \\        INTERLEAVE=true \\        NON_PF=true | \\      /usr/gitc/$(inputs.bwa_commandline) /dev/stdin -  2> >(tee $(inputs.output_bam_basename).bwa.stderr.log >&2) | \\      samtools view -1 - > $(inputs.output_bam_basename).bam && \\      grep -m1 \"read .* ALT contigs\" $(inputs.output_bam_basename).bwa.stderr.log | \\      grep -v \"read 0 ALT contigs\"    # else ref_alt is empty or could not be found    else      exit 1;    fi  ",
            "shellQuote": false
        }
    ],
    "baseCommand": [],
    "id": "SamToFastqAndBwaMem",
    "outputs": [
        {
            "outputBinding": {
                "glob": "$(inputs.output_bam_basename).bam"
            },
            "id": "output_bam",
            "type": "File"
        },
        {
            "outputBinding": {
                "glob": "$(inputs.output_bam_basename).bwa.stderr.log"
            },
            "id": "bwa_stderr_log",
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
            "ramMin": "14 GB",
            "class": "ResourceRequirement"
        }
    ],
    "inputs": [
        {
            "id": "input_bam",
            "type": "File"
        },
        {
            "id": "bwa_commandline",
            "type": "string"
        },
        {
            "id": "output_bam_basename",
            "type": "string"
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
            "id": "ref_amb",
            "type": "File"
        },
        {
            "id": "ref_ann",
            "type": "File"
        },
        {
            "id": "ref_bwt",
            "type": "File"
        },
        {
            "id": "ref_pac",
            "type": "File"
        },
        {
            "id": "ref_sa",
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