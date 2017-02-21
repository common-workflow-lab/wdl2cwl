#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "arguments": [
        {
            "valueFrom": "    java -XX:GCTimeLimit=50 -XX:GCHeapFreeLimit=10 -Xmx8000m \\      -jar /usr/gitc/GATK35.jar \\      -T HaplotypeCaller \\      -R $(inputs.ref_fasta.path) \\      -o $(inputs.gvcf_basename).vcf.gz \\      -I $(inputs.input_bam.path) \\      -L $(inputs.interval_list.path) \\      -ERC GVCF \\      --max_alternate_alleles 3 \\      -variant_index_parameter 128000 \\      -variant_index_type LINEAR \\      -contamination $(inputs.contamination) \\      --read_filter OverclippedRead   ",
            "shellQuote": false
        }
    ],
    "baseCommand": [],
    "id": "HaplotypeCaller",
    "outputs": [
        {
            "outputBinding": {
                "glob": "$(inputs.gvcf_basename).vcf.gz"
            },
            "id": "output_gvcf",
            "type": "File"
        },
        {
            "outputBinding": {
                "glob": "$(inputs.gvcf_basename).vcf.gz.tbi"
            },
            "id": "output_gvcf_index",
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
            "ramMin": "10 GB",
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
            "id": "interval_list",
            "type": "File"
        },
        {
            "id": "gvcf_basename",
            "type": "string"
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
            "id": "contamination",
            "type": "float?"
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