/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.tsv' AS (letter:CHARARRAY, reg:CHARARRAY, list:CHARARRAY);

data2 = FOREACH data GENERATE FLATTEN(TOKENIZE(reg)) AS low_letter;

data2 = FILTER data2 BY (low_letter MATCHES '[a-z]');

letters = GROUP data2 BY low_letter;

letters_count = FOREACH letters GENERATE group, COUNT(data2); 

STORE letters_count INTO 'output' USING PigStorage(',');
