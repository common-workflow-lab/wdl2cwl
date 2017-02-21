#!/usr/bin/env cwl-runner
# This tool description was generated automatically by wdl2cwl ver. 0.2

{
    "inputs": [
        {
            "id": "gatk",
            "type": "File",
            "doc": "Executable jar for the GenomeAnalysisTK"
        },
        {
            "id": "ref",
            "type": "File",
            "doc": "fasta file of reference genome"
        },
        {
            "id": "refIndex",
            "type": "File",
            "doc": "Index file of reference genome"
        },
        {
            "id": "refDict",
            "type": "File",
            "doc": "dict file of reference genome"
        },
        {
            "id": "userString",
            "type": "string?",
            "doc": "An optional parameter which allows the user to specify additions to the command line at run time"
        },
        {
            "id": "input_file",
            "type": "string[]?",
            "doc": "Input file containing sequence data (BAM or CRAM)"
        },
        {
            "id": "intervals",
            "type": "string[]?",
            "doc": "One or more genomic intervals over which to operate"
        },
        {
            "id": "ntVal",
            "type": "int?"
        },
        {
            "id": "alwaysAppendDbsnpId",
            "type": "boolean?",
            "doc": "Add dbSNP ID even if one is already present"
        },
        {
            "id": "annotation",
            "type": "string[]?",
            "doc": "One or more specific annotations to apply to variant calls"
        },
        {
            "id": "comp",
            "type": "string[]?",
            "doc": "Comparison VCF file"
        },
        {
            "id": "dbsnp",
            "type": "string?",
            "doc": "dbSNP file"
        },
        {
            "id": "excludeAnnotation",
            "type": "string[]?",
            "doc": "One or more specific annotations to exclude"
        },
        {
            "id": "expression",
            "type": "string?",
            "doc": "One or more specific expressions to apply to variant calls"
        },
        {
            "id": "group",
            "type": "string[]?",
            "doc": "One or more classes/groups of annotations to apply to variant calls"
        },
        {
            "id": "list",
            "type": "boolean?",
            "doc": "List the available annotations and exit"
        },
        {
            "id": "MendelViolationGenotypeQualityThreshold",
            "type": "float?",
            "doc": "GQ threshold for annotating MV ratio"
        },
        {
            "id": "out",
            "type": "string?",
            "doc": "File to which variants should be written"
        },
        {
            "id": "resource",
            "type": "string[]?",
            "doc": "External resource VCF file"
        },
        {
            "id": "resourceAlleleConcordance",
            "type": "boolean?",
            "doc": "Check for allele concordances when using an external resource VCF file"
        },
        {
            "id": "snpEffFile",
            "type": "string?",
            "doc": "SnpEff file from which to get annotations"
        },
        {
            "id": "useAllAnnotations",
            "type": "boolean?",
            "doc": "Use all possible annotations (not for the faint of heart)"
        },
        {
            "id": "variant",
            "type": "string",
            "doc": "Input VCF file"
        }
    ],
    "id": "VariantAnnotator",
    "baseCommand": [],
    "class": "CommandLineTool",
    "requirements": [
        {
            "class": "ShellCommandRequirement"
        },
        {
            "class": "InlineJavascriptRequirement"
        },
        {
            "dockerPull": "broadinstitute/genomes-in-the-cloud:2.2.2-1466113830",
            "class": "DockerRequirement"
        }
    ],
    "outputs": [
        {
            "id": "taskOut",
            "outputBinding": {
                "glob": "$(inputs.out)"
            },
            "type": "string"
        }
    ],
    "arguments": [
        {
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T VariantAnnotator \\\t\t\t-R $(inputs.ref.path) \\\t\t\t$(\"--input_file \" + inputs.input_file) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t$(\"-nt\" + inputs.ntVal) \\\t\t\t-alwaysAppendDbsnpId $(inputs.alwaysAppendDbsnpId) \\\t\t\t-A $(inputs.annotation) \\\t\t\t-comp $(inputs.comp) \\\t\t\t$(\"-D \" + inputs.dbsnp) \\\t\t\t-XA $(inputs.excludeAnnotation) \\\t\t\t-E $(inputs.expression) \\\t\t\t-G $(inputs.group) \\\t\t\t-ls $(inputs.list) \\\t\t\t-mvq $(inputs.MendelViolationGenotypeQualityThreshold) \\\t\t\t-o $(inputs.out) \\\t\t\t-resource $(inputs.resource) \\\t\t\t-rac $(inputs.resourceAlleleConcordance) \\\t\t\t$(\"-snpEffFile \" + inputs.snpEffFile) \\\t\t\t-all $(inputs.useAllAnnotations) \\\t\t\t-V $(inputs.variant) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}