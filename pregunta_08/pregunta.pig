/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.tsv' AS (letters:CHARARRAY, 
                          dict_letters:BAG{t: TUPLE()},
                          map_letters:MAP[]);

lines = FOREACH data GENERATE FLATTEN(dict_letters), FLATTEN(map_letters);

new_data = FOREACH lines GENERATE FLATTEN($0), FLATTEN($1);

grouped = GROUP new_data BY ($0, $1);

count_grouped = FOREACH grouped GENERATE group, COUNT(new_data);

STORE count_grouped INTO 'output' USING PigStorage(',');