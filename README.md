Converter from the Broad Institute's Workflow Definition
Language (WDL) to the Common Workflow Language.

Generates a set of CWL files from a WDL workflow which can be executed with a CWL implementation.


## Installation

`pip install --process-dependency-links wdl2cwl`

wdl2cwl depends on the fork of [pywdl](https://github.com/anton-khodak/pywdl), so `--process-dependency-links` option 
 is required.

## Usage: 

Pass a wdl workflow or a directory with wdl files to wdl2cwl

```wdl2cwl workflow.wdl```

By default, a directory with a name of the wdl file will be created and all generated CWL files will be placed in that directory.

Additional options
`'-d', '--directory'` - Target directory to place CWL files
`'-q', '--quiet'` - Do not print generated tools to stdout
`--no-folder` - Do not create a separate folder for each CWL toolset (convenient whilst bulk conversion of standalone tools, not workflows)

## Notes on autoconverting

Not every WDL workflow can be automatically mapped to CWL. Sometimes some additional tweaks after CWL generation are required:

#### Secondary files

If any of the input parameters include files that must be processed together, they should be mentioned in `secondaryFiles` field:


```
secondaryFiles
- .fai
- ^.dict
```

#### Runtime (WDL)
docker [] -> DockerRequirement, only one image

resources -> ResourceRequirement, megabytes -> mebibytes string

#### Outputs 
If the output {...} section is omitted in WDL, then the CWL workflow includes
all outputs from all calls in its final output.


#### WDL standard library functions
Not all WDL [functions](https://github.com/broadinstitute/wdl/blob/develop/SPEC.md#standard-library) are covered.

Some of WDL functions can be effectively replaced by a CWL expression. For instance, if you need to get the basename of a file,
sub - effectively replaced by inputs.path.basename

##### read_X() functions:
if an input parameter is read from a file by a function like read_tsv or read_csv, it must start with a backslash.
wdl2cwl has to transform file inputs in plain strings to a CWL File object.
wdl2cwl only recognizes a filepath in a .txt file if it starts with a backslash. Moreover, all strings starting with '/'
will be treated as filepathes.

#### Resource and docker requirements: 

Resource requirements in WDL are set in megabytes vs mebibytes in CWL


## References:

CWL spec
https://github.com/common-workflow-language/common-workflow-language

WDL spec
https://github.com/broadinstitute/wdl

Python WDL parser
https://github.com/broadinstitute/pywdl

cwl2wdl (convert the other way)
https://github.com/adamstruck/cwl2wdl

