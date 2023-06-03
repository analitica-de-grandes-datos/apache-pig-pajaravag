/*
Pregunta
===========================================================================

El archivo `data.csv` tiene la siguiente estructura:

  driverId       INT
  truckId        INT
  eventTime      STRING
  eventType      STRING
  longitude      DOUBLE
  latitude       DOUBLE
  eventKey       STRING
  correlationId  STRING
  driverName     STRING
  routeId        BIGINT
  routeName      STRING
  eventDate      STRING

Escriba un script en Pig que carge los datos y obtenga los primeros 10 
registros del archivo para las primeras tres columnas, y luego, ordenados 
por driverId, truckId, y eventTime. 

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

         >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.csv' USING PigStorage(',') AS (
        col1:int, col2:int, col3:chararray, col4:chararray,
        col5:float, col6:float, col7:chararray, col8:long,
        col9:chararray, col10:long, col11:chararray, col12:chararray
        );

selected_columns = FOREACH lines GENERATE col1, col2, col3;

s = LIMIT selected_columns 10;

ordered_data = ORDER s BY col1, col2, col3; 

STORE ordered_data INTO 'output' USING PigStorage(',');