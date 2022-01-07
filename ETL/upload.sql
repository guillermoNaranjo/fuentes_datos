DROP SCHEMA IF EXISTS raw CASCADE;

CREATE SCHEMA raw;

DROP TABLE IF EXISTS raw.estaciones;

--DROP SEQUENCE IF EXISTS proyecto.raw.estaciones_id_seq;


--DROP SEQUENCE IF EXISTS proyecto.raw.precios_id_seq;

CREATE TABLE raw.estaciones(
  --id numeric primary key,
  id_estacion numeric,
  nombre varchar,
  longitud numeric,
  latitud numeric
);

--CREATE SEQUENCE estaciones_id_seq START 1 INCREMENT 1;
--ALTER TABLE raw.estaciones ALTER COLUMN id SET DEFAULT nextval('estaciones_id_seq');

DROP TABLE IF EXISTS raw.precios;

CREATE TABLE raw.precios(
  --id numeric primary key,
  estacion_servicio numeric,
  regular numeric,
  premium numeric,
  diesel numeric
);

--CREATE SEQUENCE precios_id_seq START 1 INCREMENT 1;
--ALTER TABLE raw.precios ALTER COLUMN id SET DEFAULT nextval('precios_id_seq');
