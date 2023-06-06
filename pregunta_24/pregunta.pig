/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       REGEX_EXTRACT(birthday, '....-..-..', 2) 
   FROM 
       u;

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

meses = FOREACH data GENERATE SUBSTRING(col4, 5, 7) AS mes;

STORE meses INTO 'output';

--DUMP meses;

