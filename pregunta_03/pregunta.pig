/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

lines = LOAD 'data.tsv' AS (col1:chararray, col2:chararray, col3:int);

selected_columns = FOREACH lines GENERATE col3;

ordered_data = ORDER selected_columns BY col3; 

s = LIMIT ordered_data 5;

STORE s INTO 'output';