task inc {
  Int i

  command <<<
  python -c "print(${i} + 1)"
  >>>

  output {
    Int incremented = read_int(stdout())
  }
}

task sum {
  Array[Int] ints

  command <<<
  python -c "print(${sep="+" ints})"
  >>>

  output {
    Int sum = read_int(stdout())
  }
}

workflow wf {
  Array[Int] integers = [1,2,3,4,5]
  scatter(i in integers) {
    call inc {input: i=i}
    call inc as inc2 {input: i=inc.incremented}
  }
  call sum {input: ints = inc2.incremented}
}
