#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "arguments": [
        {
            "valueFrom": "      samtools view -C -T $(inputs.ref_fasta.path) $(inputs.input_bam.path) | \\      tee $(inputs.output_basename).cram | \\      md5sum > $(inputs.output_basename).cram.md5      # Create REF_CACHE. Used when indexing a CRAM      seq_cache_populate.pl -root ./ref/cache $(inputs.ref_fasta.path)      export REF_PATH=:      export REF_CACHE=./ref/cache/%2s/%2s/%s      samtools index $(inputs.output_basename).cram      mv $(inputs.output_basename).cram.crai $(inputs.output_basename).crai  ",
            "shellQuote": false
        }
    ],
    "baseCommand": [],
    "id": "ConvertToCram",
    "outputs": [
        {
            "outputBinding": {
                "glob": "$(inputs.output_basename).cram"
            },
            "id": "output_cram",
            "type": "File"
        },
        {
            "outputBinding": {
                "glob": "$(inputs.output_basename).crai"
            },
            "id": "output_cram_index",
            "type": "File"
        },
        {
            "outputBinding": {
                "glob": "$(inputs.output_basename).cram.md5"
            },
            "id": "output_cram_md5",
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
            "ramMin": "3 GB",
            "class": "ResourceRequirement"
        }
    ],
    "inputs": [
        {
            "id": "input_bam",
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
            "id": "output_basename",
            "type": "string"
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