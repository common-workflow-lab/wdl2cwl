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
            "id": "ntVal",
            "type": "int?"
        },
        {
            "id": "concordance",
            "type": "string?",
            "doc": "Output variants also called in this comparison track"
        },
        {
            "id": "discordance",
            "type": "string?",
            "doc": "Output variants not called in this comparison track"
        },
        {
            "id": "exclude_sample_expressions",
            "type": "string?",
            "doc": "List of sample expressions to exclude"
        },
        {
            "id": "exclude_sample_file",
            "type": "string?",
            "doc": "List of samples to exclude"
        },
        {
            "id": "exclude_sample_name",
            "type": "string?",
            "doc": "Exclude genotypes from this sample"
        },
        {
            "id": "excludeFiltered",
            "type": "boolean?",
            "doc": "Don't include filtered sites"
        },
        {
            "id": "excludeIDs",
            "type": "File?",
            "doc": "List of variant IDs to select"
        },
        {
            "id": "excludeNonVariants",
            "type": "boolean?",
            "doc": "Don't include non-variant sites"
        },
        {
            "id": "forceValidOutput",
            "type": "boolean?",
            "doc": "Forces output VCF to be compliant to up-to-date version"
        },
        {
            "id": "invertMendelianViolation",
            "type": "boolean?",
            "doc": "Output non-mendelian violation sites only"
        },
        {
            "id": "invertselect",
            "type": "boolean?",
            "doc": "Invert the selection criteria for -select"
        },
        {
            "id": "keepIDs",
            "type": "File?",
            "doc": "List of variant IDs to select"
        },
        {
            "id": "keepOriginalAC",
            "type": "boolean?",
            "doc": "Store the original AC, AF, and AN values after subsetting"
        },
        {
            "id": "keepOriginalDP",
            "type": "boolean?",
            "doc": "Store the original DP value after subsetting"
        },
        {
            "id": "maxFilteredGenotypes",
            "type": "int?",
            "doc": "Maximum number of samples filtered at the genotype level"
        },
        {
            "id": "maxFractionFilteredGenotypes",
            "type": "float?",
            "doc": "Maximum fraction of samples filtered at the genotype level"
        },
        {
            "id": "maxIndelSize",
            "type": "int?",
            "doc": "Maximum size of indels to include"
        },
        {
            "id": "maxNOCALLfraction",
            "type": "float?",
            "doc": "Maximum fraction of samples with no-call genotypes"
        },
        {
            "id": "maxNOCALLnumber",
            "type": "int?",
            "doc": "Maximum number of samples with no-call genotypes"
        },
        {
            "id": "mendelianViolation",
            "type": "boolean?",
            "doc": "Output mendelian violation sites only"
        },
        {
            "id": "mendelianViolationQualThreshold",
            "type": "float?",
            "doc": "Minimum GQ score for each trio member to accept a site as a violation"
        },
        {
            "id": "minFilteredGenotypes",
            "type": "int?",
            "doc": "Minimum number of samples filtered at the genotype level"
        },
        {
            "id": "minFractionFilteredGenotypes",
            "type": "float?",
            "doc": "Maximum fraction of samples filtered at the genotype level"
        },
        {
            "id": "minIndelSize",
            "type": "int?",
            "doc": "Minimum size of indels to include"
        },
        {
            "id": "out",
            "type": "string?",
            "doc": "File to which variants should be written"
        },
        {
            "id": "preserveAlleles",
            "type": "boolean?",
            "doc": "Preserve original alleles, do not trim"
        },
        {
            "id": "remove_fraction_genotypes",
            "type": "float?",
            "doc": "Select a fraction of genotypes at random from the input and sets them to no-call"
        },
        {
            "id": "removeUnusedAlternates",
            "type": "boolean?",
            "doc": "Remove alternate alleles not present in any genotypes"
        },
        {
            "id": "restrictAllelesTo",
            "type": "string?",
            "doc": "Select only variants of a particular allelicity"
        },
        {
            "id": "sample_expressions",
            "type": "string?",
            "doc": "Regular expression to select multiple samples"
        },
        {
            "id": "sample_file",
            "type": "string?",
            "doc": "File containing a list of samples to include"
        },
        {
            "id": "sample_name",
            "type": "string?",
            "doc": "Include genotypes from this sample"
        },
        {
            "id": "select_random_fraction",
            "type": "float?",
            "doc": "Select a fraction of variants at random from the input"
        },
        {
            "id": "selectexpressions",
            "type": "string[]?",
            "doc": "One or more criteria to use when selecting the data"
        },
        {
            "id": "selectTypeToExclude",
            "type": "string[]?",
            "doc": "Do not select certain type of variants from the input file"
        },
        {
            "id": "selectTypeToInclude",
            "type": "string[]?",
            "doc": "Select only a certain type of variants from the input file"
        },
        {
            "id": "setFilteredGtToNocall",
            "type": "boolean?",
            "doc": "Set filtered genotypes to no-call"
        },
        {
            "id": "variant",
            "type": "string",
            "doc": "Input VCF file"
        }
    ],
    "id": "SelectVariants",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T SelectVariants \\\t\t\t-R $(inputs.ref.path) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t$(\"-nt\" + inputs.ntVal) \\\t\t\t$(\"-conc \" + inputs.concordance) \\\t\t\t$(\"-disc \" + inputs.discordance) \\\t\t\t-xl_se $(inputs.exclude_sample_expressions) \\\t\t\t-xl_sf $(inputs.exclude_sample_file) \\\t\t\t-xl_sn $(inputs.exclude_sample_name) \\\t\t\t-ef $(inputs.excludeFiltered) \\\t\t\t$(\"-xlIDs \" + inputs.excludeIDs) \\\t\t\t-env $(inputs.excludeNonVariants) \\\t\t\tforceValidOutput $(inputs.forceValidOutput) \\\t\t\t-invMv $(inputs.invertMendelianViolation) \\\t\t\t-invertSelect $(inputs.invertselect) \\\t\t\t$(\"-IDs \" + inputs.keepIDs) \\\t\t\t-keepOriginalAC $(inputs.keepOriginalAC) \\\t\t\t-keepOriginalDP $(inputs.keepOriginalDP) \\\t\t\tmaxFilteredGenotypes $(inputs.maxFilteredGenotypes) \\\t\t\tmaxFractionFilteredGenotypes $(inputs.maxFractionFilteredGenotypes) \\\t\t\tmaxIndelSize $(inputs.maxIndelSize) \\\t\t\tmaxNOCALLfraction $(inputs.maxNOCALLfraction) \\\t\t\tmaxNOCALLnumber $(inputs.maxNOCALLnumber) \\\t\t\t-mv $(inputs.mendelianViolation) \\\t\t\t-mvq $(inputs.mendelianViolationQualThreshold) \\\t\t\tminFilteredGenotypes $(inputs.minFilteredGenotypes) \\\t\t\tminFractionFilteredGenotypes $(inputs.minFractionFilteredGenotypes) \\\t\t\tminIndelSize $(inputs.minIndelSize) \\\t\t\t-o $(inputs.out) \\\t\t\t-noTrim $(inputs.preserveAlleles) \\\t\t\t-fractionGenotypes $(inputs.remove_fraction_genotypes) \\\t\t\t-trimAlternates $(inputs.removeUnusedAlternates) \\\t\t\t-restrictAllelesTo $(inputs.restrictAllelesTo) \\\t\t\t$(\"-se \" + inputs.sample_expressions) \\\t\t\t$(\"-sf \" + inputs.sample_file) \\\t\t\t-sn $(inputs.sample_name) \\\t\t\t-fraction $(inputs.select_random_fraction) \\\t\t\t-select $(inputs.selectexpressions) \\\t\t\t-xlSelectType $(inputs.selectTypeToExclude) \\\t\t\t-selectType $(inputs.selectTypeToInclude) \\\t\t\tsetFilteredGtToNocall $(inputs.setFilteredGtToNocall) \\\t\t\t-V $(inputs.variant) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}