/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.tsv' AS (letter:CHARARRAY, reg:CHARARRAY, list:CHARARRAY);

lines = FOREACH data GENERATE FLATTEN(TOKENIZE(list, '[],#')) AS list_keys;

triplet = FILTER lines BY (list_keys MATCHES '[a-z]{3}');

triplet_group = GROUP triplet BY list_keys;

triplet_count = FOREACH triplet_group GENERATE group, COUNT(triplet);

STORE triplet_count INTO 'output' USING PigStorage(',');