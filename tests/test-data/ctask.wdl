task wc2_tool {
  File file1
  command {
    cat ${file1} | wc -w
  }
  output {
    Int count = read_int(stdout())
  }
}

workflow count_lines4_wf {
  File inputSamplesFile
  Array[Array[File]] inputSamples = read_tsv(inputSamplesFile)  
  Array[File] files = inputSamples[0]
  scatter(f in files) {
    call wc2_tool {
      input: file1=f,
        RefFasta=f
    }
  }
  output {
    wc2_tool.count
  }
}