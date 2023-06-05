/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta en SQL.

   SELECT
       color
   FROM 
       u 
   WHERE 
       color 
   LIKE 'b%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

         >>> Escriba su respuesta a partir de este punto <<< 
*/

data = LOAD 'data.csv' USING PigStorage(',') AS (col1:int, 
                          col2:CHARARRAY,
                          col3:CHARARRAY,
                          col4:CHARARRAY,
                          col5:CHARARRAY,
                          col6:int);

colors = FOREACH data GENERATE col5 AS color;

filtered_data = FILTER colors BY LOWER(SUBSTRING(color, 0, 1)) MATCHES '^b';

STORE filtered_data INTO 'output';
--DUMP filtered_data;