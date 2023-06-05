/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname,
       color
   FROM 
       u 
   WHERE color = 'blue' AND firstname LIKE 'Z%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

*/

data = LOAD 'data.csv' USING PigStorage(',') AS (col1:int, 
                          col2:CHARARRAY,
                          col3:CHARARRAY,
                          col4:CHARARRAY,
                          col5:CHARARRAY,
                          col6:int);

colors = FOREACH data GENERATE col2 AS firstname, col5 AS color;

filtered_data = FILTER colors BY (SUBSTRING(firstname, 0, 1) MATCHES '^Z' AND LOWER(color) MATCHES 'blue');

STORE filtered_data INTO 'output' USING PigStorage(' ');
--DUMP filtered_data;