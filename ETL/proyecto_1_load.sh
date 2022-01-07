#!/bin/bash

psql -f upload.sql service=fuentes_datos

psql -c '\copy raw.precios (estacion_servicio,regular,premium,diesel) from precios.csv with (format csv, header);' service=fuentes_datos

psql -c '\copy raw.estaciones (id_estacion,nombre,longitud,latitud) from estaciones.csv with (format csv, header);' service=fuentes_datos
