
wdl_code = """
task my_task {
  File file
  command {
    ./my_binary --input=${file} > results
  }
  output {
    File results = "results"
  }
}

workflow my_wf {
  call my_task
}
"""

wdl_code2 = """
task my_task {
  command {
    true
  }
}
workflow test {
  Int a = (1 + 2) * 3
  call my_task {
    input: var=a*2, var2="file"+".txt"
  }
}
"""

wdl_code3 = """
task ps {
  command {
    ps
  }
  output {
    File procs = stdout()
  }
}

task cgrep {
  String pattern
  File in_file
  command {
    grep '${pattern}' ${in_file} | wc -l
  }
  output {
    Int count = read_int(stdout())
  }
}

task wc {
  File in_file
  command {
    cat ${in_file} | wc -l
  }
  output {
    Int count = read_int(stdout())
  }
}

workflow three_step {
  call ps
  call cgrep {
    input: in_file=ps.procs
  }
  call wc {
    input: in_file=ps.procs
  }
}
"""