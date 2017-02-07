#/usr/bin/env cwl-runner
cwlVersion: v1.0
class: ExpressionTool

requirements:
- class: InlineJavascriptRequirement

inputs:
  infile:
    type: File
    inputBinding:
      loadContents: true

outputs:
  inputSamples:
    type: Any

expression: "${var lines = inputs.infile.contents.split('\\n');
               var nblines = lines.length;
               var arrayofarrays = [];
               for (var i = 0; i < nblines; i++) {
                 var line = lines[i].split('\t');

                  for (var j=0; j < line.length; j++){
                    if (line[j].startsWith('/')){
                      line[j] =
                         {
                        'class': 'File',
                        'location': 'file://'+ line[j]
                         };
                      }
                  }
                  arrayofarrays.push(line);
                }
               return {'inputSamples': arrayofarrays } ;
              }"