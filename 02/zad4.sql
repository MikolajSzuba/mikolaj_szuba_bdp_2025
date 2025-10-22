\c cw2_db;

CREATE TABLE mapa.buildings (
    id SERIAL PRIMARY KEY,
    geometry GEOMETRY(POLYGON) NOT NULL,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE mapa.roads (
    id SERIAL PRIMARY KEY,
    geometry GEOMETRY(LINESTRING) NOT NULL,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE mapa.poi (
    id SERIAL PRIMARY KEY,
    geometry GEOMETRY(POINT) NOT NULL,
    name VARCHAR(100) NOT NULL
);