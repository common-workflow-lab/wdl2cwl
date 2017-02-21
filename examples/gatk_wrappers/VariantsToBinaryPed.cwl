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
            "id": "intervals",
            "type": "string[]?",
            "doc": "One or more genomic intervals over which to operate"
        },
        {
            "id": "bed",
            "type": "string",
            "doc": "output bed file"
        },
        {
            "id": "bim",
            "type": "string",
            "doc": "output map file"
        },
        {
            "id": "checkAlternateAlleles",
            "type": "boolean?",
            "doc": "Checks that alternate alleles actually appear in samples, erroring out if they do not"
        },
        {
            "id": "dbsnp",
            "type": "string?",
            "doc": "dbSNP file"
        },
        {
            "id": "fam",
            "type": "string",
            "doc": "output fam file"
        },
        {
            "id": "majorAlleleFirst",
            "type": "boolean?",
            "doc": "Sets the major allele to be 'reference' for the bim file, rather than the ref allele"
        },
        {
            "id": "metaData",
            "type": "File",
            "doc": "Sample metadata file"
        },
        {
            "id": "minGenotypeQuality",
            "type": "int",
            "doc": "If genotype quality is lower than this value, output NO_CALL"
        },
        {
            "id": "outputMode",
            "type": "string?",
            "doc": "The output file mode (SNP major or individual major)"
        },
        {
            "id": "variant",
            "type": "string",
            "doc": "Input VCF file"
        }
    ],
    "id": "VariantsToBinaryPed",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T VariantsToBinaryPed \\\t\t\t-R $(inputs.ref.path) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t-bed $(inputs.bed) \\\t\t\t-bim $(inputs.bim) \\\t\t\tcheckAlternateAlleles $(inputs.checkAlternateAlleles) \\\t\t\t$(\"-D \" + inputs.dbsnp) \\\t\t\t-fam $(inputs.fam) \\\t\t\tmajorAlleleFirst $(inputs.majorAlleleFirst) \\\t\t\t-m $(inputs.metaData.path) \\\t\t\t-mgq $(inputs.minGenotypeQuality) \\\t\t\t-mode $(inputs.outputMode) \\\t\t\t-V $(inputs.variant) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}