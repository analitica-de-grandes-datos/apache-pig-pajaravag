/*
Pregunta
===========================================================================

Ordene el archivo `data.tsv`  por letra y valor (3ra columna). Escriba el
resultado separado por comas.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

     >>> Escriba el codigo del mapper a partir de este punto <<<
*/
lines = LOAD 'data.tsv' AS (col1:chararray, col2:chararray, col3:chararray);

ordered_data = ORDER lines BY col1, col3; 
--words = FOREACH lines GENERATE FLATTEN(TOKENIZE(line)) AS word;

--grouped = GROUP words BY word;

--wordcount = FOREACH grouped GENERATE group, COUNT(words);

STORE ordered_data INTO 'output' USING PigStorage(',');