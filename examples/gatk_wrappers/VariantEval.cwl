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
            "id": "ancestralAlignments",
            "type": "File?",
            "doc": "Fasta file with ancestral alleles"
        },
        {
            "id": "comp",
            "type": "string[]?",
            "doc": "Input comparison file(s)"
        },
        {
            "id": "dbsnp",
            "type": "string?",
            "doc": "dbSNP file"
        },
        {
            "id": "doNotUseAllStandardModules",
            "type": "boolean?",
            "doc": "Do not use the standard modules by default (instead, only those that are specified with the -EV option)"
        },
        {
            "id": "doNotUseAllStandardStratifications",
            "type": "boolean?",
            "doc": "Do not use the standard stratification modules by default (instead, only those that are specified with the -S option)"
        },
        {
            "id": "eval",
            "type": "string[]",
            "doc": "Input evaluation file(s)"
        },
        {
            "id": "evalModule",
            "type": "string?",
            "doc": "One or more specific eval modules to apply to the eval track(s) (in addition to the standard modules, unless -noEV is specified)"
        },
        {
            "id": "goldStandard",
            "type": "string?",
            "doc": "Evaluations that count calls at sites of true variation (e.g., indel calls) will use this argument as their gold standard for comparison"
        },
        {
            "id": "keepAC0",
            "type": "boolean?",
            "doc": "If provided, modules that track polymorphic sites will not require that a site have AC > 0 when the input eval has genotypes"
        },
        {
            "id": "known_names",
            "type": "string?",
            "doc": "Name of ROD bindings containing variant sites that should be treated as known when splitting eval rods into known and novel subsets"
        },
        {
            "id": "knownCNVs",
            "type": "string?",
            "doc": "File containing tribble-readable features describing a known list of copy number variants"
        },
        {
            "id": "list",
            "type": "boolean?",
            "doc": "List the available eval modules and exit"
        },
        {
            "id": "mendelianViolationQualThreshold",
            "type": "float?",
            "doc": "Minimum genotype QUAL score for each trio member required to accept a site as a violation. Default is 50."
        },
        {
            "id": "mergeEvals",
            "type": "boolean?",
            "doc": "If provided, all -eval tracks will be merged into a single eval track"
        },
        {
            "id": "minPhaseQuality",
            "type": "float?",
            "doc": "Minimum phasing quality"
        },
        {
            "id": "out",
            "type": "string?",
            "doc": "An output file created by the walker.  Will overwrite contents if file exists"
        },
        {
            "id": "requireStrictAlleleMatch",
            "type": "boolean?",
            "doc": "If provided only comp and eval tracks with exactly matching reference and alternate alleles will be counted as overlapping"
        },
        {
            "id": "sample",
            "type": "string?",
            "doc": "Derive eval and comp contexts using only these sample genotypes, when genotypes are available in the original context"
        },
        {
            "id": "samplePloidy",
            "type": "int?",
            "doc": "Per-sample ploidy (number of chromosomes per sample)"
        },
        {
            "id": "select_exps",
            "type": "string[]?",
            "doc": "One or more stratifications to use when evaluating the data"
        },
        {
            "id": "select_names",
            "type": "string[]?",
            "doc": "Names to use for the list of stratifications (must be a 1-to-1 mapping)"
        },
        {
            "id": "stratificationModule",
            "type": "string?",
            "doc": "One or more specific stratification modules to apply to the eval track(s) (in addition to the standard stratifications, unless -noS is specified)"
        },
        {
            "id": "stratIntervals",
            "type": "string?",
            "doc": "File containing tribble-readable features for the IntervalStratificiation"
        }
    ],
    "id": "VariantEval",
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
            "valueFrom": "\t\tjava -jar $(inputs.gatk.path) \\\t\t\t-T VariantEval \\\t\t\t-R $(inputs.ref.path) \\\t\t\t$(\"--intervals \" + inputs.intervals) \\\t\t\t$(\"-nt\" + inputs.ntVal) \\\t\t\t$(\"-aa \" + inputs.ancestralAlignments) \\\t\t\t-comp $(inputs.comp) \\\t\t\t$(\"-D \" + inputs.dbsnp) \\\t\t\t-noEV $(inputs.doNotUseAllStandardModules) \\\t\t\t-noST $(inputs.doNotUseAllStandardStratifications) \\\t\t\t-eval $(inputs.eval) \\\t\t\t-EV $(inputs.evalModule) \\\t\t\t$(\"-gold \" + inputs.goldStandard) \\\t\t\t-keepAC0 $(inputs.keepAC0) \\\t\t\t-knownName $(inputs.known_names) \\\t\t\t$(\"-knownCNVs \" + inputs.knownCNVs) \\\t\t\t-ls $(inputs.list) \\\t\t\t-mvq $(inputs.mendelianViolationQualThreshold) \\\t\t\t-mergeEvals $(inputs.mergeEvals) \\\t\t\t-mpq $(inputs.minPhaseQuality) \\\t\t\t-o $(inputs.out) \\\t\t\t-strict $(inputs.requireStrictAlleleMatch) \\\t\t\t$(\"-sn \" + inputs.sample) \\\t\t\t-ploidy $(inputs.samplePloidy) \\\t\t\t-select $(inputs.select_exps) \\\t\t\t-selectName $(inputs.select_names) \\\t\t\t-ST $(inputs.stratificationModule) \\\t\t\t$(\"-stratIntervals \" + inputs.stratIntervals) \\\t\t\t$(inputs.userString) \t",
            "shellQuote": false
        }
    ],
    "cwlVersion": "v1.0"
}