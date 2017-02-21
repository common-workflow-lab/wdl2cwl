#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "arguments": [
        {
            "valueFrom": "${            var input_bams_separated = '';            for (var i=0; i<inputs.input_bams.length; i++){                input_bams_separated = input_bams_separated + inputs.input_bams[i].path + ' INPUT=';            }            input_bams_separated = input_bams_separated.replace(/ INPUT=$/, '');            return \"    java -Xmx4000m -jar /usr/gitc/picard.jar \\      MarkDuplicates \\      INPUT=\" + input_bams_separated + \" \\      OUTPUT=\" + inputs.output_bam_basename + \".bam \\      METRICS_FILE=\" + inputs.metrics_filename + \" \\      VALIDATION_STRINGENCY=SILENT \\      OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \\      ASSUME_SORT_ORDER=\"queryname\"      CREATE_MD5_FILE=true  \"}",
            "shellQuote": false
        }
    ],
    "baseCommand": [],
    "id": "MarkDuplicates",
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
                "glob": "$(inputs.metrics_filename)"
            },
            "id": "duplicate_metrics",
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
            "ramMin": "7 GB",
            "class": "ResourceRequirement"
        }
    ],
    "inputs": [
        {
            "id": "input_bams",
            "type": "File[]"
        },
        {
            "id": "output_bam_basename",
            "type": "string"
        },
        {
            "id": "metrics_filename",
            "type": "string"
        },
        {
            "id": "disk_size",
            "type": "int"
        }
    ],
    "class": "CommandLineTool",
    "cwlVersion": "v1.0"
}