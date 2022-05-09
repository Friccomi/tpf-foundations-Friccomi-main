El dataset seleccionado se tomo de https://www.argentina.gob.ar/economia/politicaeconomica/regionalysectorial/informesproductivos/datasets

Se seleccionaron: oleaginosa.csv, trigo.csv, maiz.csv

## La estructura es la siguiente:

sector_id,  sector_nombre,  variable_id,  actividad_producto_nombre,  indicador,  unidad_de_medida,  fuente,  frecuencia_nombre,  cobertura_nombre,
  alcance_tipo,  alcance_id,  alcance_nombre,  indice_tiempo,  valor

El indice de tiempo es el mes. Es decir por cada mes obtengo la informacion.

## Consultas:

1-Superficie de Soja Sembrada vs Cosechada (ha)  en todos los años registrados.

2-Superficie sembra por año de Soja, Maiz, Trigo y Girasol.

3-Superficie cosechada por año de Soja, Maiz, Trigo y Girasol.

4-Toneladas cosechadas por año de Soja, Maiz, Trigo y Girasol.

5-Comparacion entre los precios del Aceite de Soja: PRECIO EXTERNO_FOB PUERTOS ARGENTINOS,PRECIO INTERNACIONAL_FUTURO CHICAGO, PRECIO EXTERNO_FOB ROTTERDAM del 2019 a la fecha.

## Pasos a seguir para obtener los informes:

1-Bajar todos los archivos a un directorio en Linux.

2-Revisar permisos del archivo corre.sh

3-Ejecutar: ./corre.sh

4-Al finalizar todo el proceso se mostraran los cinco informes, los mismos estan en un directorio, dentro del directorio que se corrio el proceso, llamado reports. 

