#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "arguments": [
        {
            "valueFrom": "    python <<CODE    with open(\"$(inputs.ref_dict.path)\", \"r\") as ref_dict_file:        sequence_tuple_list = []        longest_sequence = 0        for line in ref_dict_file:            if line.startswith(\"@SQ\"):                line_split = line.split(\"\\t\")                # (Sequence_Name, Sequence_Length)                sequence_tuple_list.append((line_split[1].split(\"SN:\")[1], int(line_split[2].split(\"LN:\")[1])))        longest_sequence = sorted(sequence_tuple_list, key=lambda x: x[1], reverse=True)[0][1]    # We are adding this to the intervals because hg38 has contigs named with embedded colons and a bug in GATK strips off    # the last element after a :, so we add this as a sacrificial element.    hg38_protection_tag = \":1+\"    # initialize the tsv string with the first sequence    tsv_string = sequence_tuple_list[0][0] + hg38_protection_tag    temp_size = sequence_tuple_list[0][1]    for sequence_tuple in sequence_tuple_list[1:]:        if temp_size + sequence_tuple[1] <= longest_sequence:            temp_size += sequence_tuple[1]            tsv_string += \"\\t\" + sequence_tuple[0] + hg38_protection_tag        else:            tsv_string += \"\\n\" + sequence_tuple[0] + hg38_protection_tag            temp_size = sequence_tuple[1]    print tsv_string    CODE  ",
            "shellQuote": false
        }
    ],
    "baseCommand": [],
    "id": "CreateSequenceGroupingTSV",
    "outputs": [
        {
            "outputBinding": {
                "glob": "$(inputs.preemtible_tries).bam"
            },
            "id": "sequence_grouping",
            "type": {
                "type": "array",
                "items": {
                    "type": "array",
                    "items": "string"
                }
            }
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
            "dockerPull": "python:2.7",
            "class": "DockerRequirement"
        },
        {
            "ramMin": "2 GB",
            "class": "ResourceRequirement"
        }
    ],
    "inputs": [
        {
            "id": "ref_dict",
            "type": "File"
        },
        {
            "id": "preemptible_tries",
            "type": "int"
        }
    ],
    "class": "CommandLineTool",
    "cwlVersion": "v1.0"
}