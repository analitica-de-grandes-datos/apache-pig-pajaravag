/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.tsv' AS (col1:CHARARRAY, col2:CHARARRAY, col3:CHARARRAY);

lines = FOREACH data GENERATE col1 AS elements_col1, 
                        COUNT(TOKENIZE(col2, ',')) AS elements_col2, 
                        COUNT(TOKENIZE(col3, ',')) AS elements_col3;

ordered_lines = ORDER lines BY elements_col1,
                                elements_col2,
                                elements_col3; 

STORE ordered_lines INTO 'output' USING PigStorage(',');