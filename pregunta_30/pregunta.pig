/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el codigo en Pig para manipulación de fechas que genere la siguiente
salida.

   1971-07-08,08,8,jue,jueves
   1974-05-23,23,23,jue,jueves
   1973-04-22,22,22,dom,domingo
   1975-01-29,29,29,mie,miercoles
   1974-07-03,03,3,mie,miercoles
   1974-10-18,18,18,vie,viernes
   1970-10-05,05,5,lun,lunes
   1969-02-24,24,24,lun,lunes
   1974-10-17,17,17,jue,jueves
   1975-02-28,28,28,vie,viernes
   1969-12-07,07,7,dom,domingo
   1973-12-24,24,24,lun,lunes
   1970-08-27,27,27,jue,jueves
   1972-12-12,12,12,mar,martes
   1970-07-01,01,1,mie,miercoles
   1974-02-11,11,11,lun,lunes
   1973-04-01,01,1,dom,domingo
   1973-04-29,29,29,dom,domingo

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

dates = FOREACH data GENERATE col4 AS date;

processed_data = FOREACH dates {
        year = GetYear(ToDate(date, 'yyyy-MM-dd'));
        date_format = ToDate(date, 'yyyy-MM-dd', 'GMT');
        --month_name = ToString(date_format, 'MMM');
        --month_number = ToString(date_format, 'MM');
        day = GetDay(date_format);
        day_number = ToString(date_format, 'dd');
        day_name = ToString(date_format, 'EEEE');
        --month_number_short = ToString(date_format, 'M');

        day_name = CASE day_name
                WHEN 'Monday' THEN 'lunes'
                WHEN 'Tuesday' THEN 'martes'
                WHEN 'Wednesday' THEN 'miercoles'
                WHEN 'Thursday' THEN 'jueves'
                WHEN 'Friday' THEN 'viernes'
                WHEN 'Saturday' THEN 'sabado'
                WHEN 'Sunday' THEN 'domingo'
                ELSE day_name
        END;

        GENERATE date, day_number, day, SUBSTRING(day_name, 0, 3), day_name; 
}

STORE processed_data into 'output' USING PigStorage(',');
--DUMP processed_data
