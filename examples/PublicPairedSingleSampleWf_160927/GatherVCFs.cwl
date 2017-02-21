#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "arguments": [
        {
            "valueFrom": "${            var input_vcfs_separated = '';            for (var i=0; i<inputs.input_vcfs.length; i++){                input_vcfs_separated = input_vcfs_separated + inputs.input_vcfs[i].path + ' INPUT=';            }            input_vcfs_separated = input_vcfs_separated.replace(/ INPUT=$/, '');            return \"    java -Xmx2g -jar /usr/gitc/picard.jar \\    MergeVcfs \\    INPUT=\" + input_vcfs_separated + \" \\    OUTPUT=\" + inputs.output_vcf_name + \"  \"}",
            "shellQuote": false
        }
    ],
    "baseCommand": [],
    "id": "GatherVCFs",
    "outputs": [
        {
            "outputBinding": {
                "glob": "$(inputs.output_vcf_name)"
            },
            "id": "output_vcf",
            "type": "File"
        },
        {
            "outputBinding": {
                "glob": "$(inputs.output_vcf_name).tbi"
            },
            "id": "output_vcf_index",
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
            "id": "input_vcfs",
            "type": "File[]"
        },
        {
            "id": "input_vcfs_indexes",
            "type": "File[]"
        },
        {
            "id": "output_vcf_name",
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