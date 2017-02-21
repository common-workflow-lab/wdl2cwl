#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "arguments": [
        {
            "valueFrom": "    # set the bash variable needed for the command-line    bash_ref_fasta=$(inputs.ref_fasta.path)    java -Xmx3000m -jar /usr/gitc/picard.jar \\      MergeBamAlignment \\      VALIDATION_STRINGENCY=SILENT \\      EXPECTED_ORIENTATIONS=FR \\      ATTRIBUTES_TO_RETAIN=X0 \\      ALIGNED_BAM=$(inputs.aligned_bam.path) \\      UNMAPPED_BAM=$(inputs.unmapped_bam.path) \\      OUTPUT=$(inputs.output_bam_basename).bam \\      REFERENCE_SEQUENCE=$(inputs.ref_fasta.path) \\      PAIRED_RUN=true \\      SORT_ORDER=\"unsorted\" \\      IS_BISULFITE_SEQUENCE=false \\      ALIGNED_READS_ONLY=false \\      CLIP_ADAPTERS=false \\      MAX_RECORDS_IN_RAM=2000000 \\      ADD_MATE_CIGAR=true \\      MAX_INSERTIONS_OR_DELETIONS=-1 \\      PRIMARY_ALIGNMENT_STRATEGY=MostDistant \\      PROGRAM_RECORD_ID=\"bwamem\" \\      PROGRAM_GROUP_VERSION=\"$(inputs.bwa_version)\" \\      PROGRAM_GROUP_COMMAND_LINE=\"$(inputs.bwa_commandline)\" \\      PROGRAM_GROUP_NAME=\"bwamem\" \\      UNMAP_CONTAMINANT_READS=true  ",
            "shellQuote": false
        }
    ],
    "baseCommand": [],
    "id": "MergeBamAlignment",
    "outputs": [
        {
            "outputBinding": {
                "glob": "$(inputs.output_bam_basename).bam"
            },
            "id": "output_bam",
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
            "id": "unmapped_bam",
            "type": "File"
        },
        {
            "id": "bwa_commandline",
            "type": "string"
        },
        {
            "id": "bwa_version",
            "type": "string"
        },
        {
            "id": "aligned_bam",
            "type": "File"
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