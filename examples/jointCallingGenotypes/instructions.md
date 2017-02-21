This workflow in WDL, installation instructions: https://software.broadinstitute.org/wdl/userguide/article?id=7614
`manualCWL` is an example of how wdl2cwl should operate on this workflow. `automatedCWL` is the way it actually has worked.
The following tweaks are necessary to make `automatedCWL` work


Running instructions:

1. install `wdl2cwl` via pip or from source
2. change paths in the job `cwlJointCallingGenotypesJob.json`
3. `cd wdl2cwl/examples/jointCallingGenotypes`
4. run `wdl2cwl jointCallingGenotypes.wdl`
5. In generated files `HaplotypeCallerERC.cwl` and `GenotypeGVCFs.cwl` change `RefFasta` input parameter to include secondaryFiles:
 ```
{
    "id": "RefFasta",
    "type": "File",
    "secondaryFiles": [
        "^.dict",
        ".fai"]
}
```
6. enjoy: `cwl-runner automatedCWL/jointCallingGenotypes.cwl cwlJointCallingGenotypesJob.json`