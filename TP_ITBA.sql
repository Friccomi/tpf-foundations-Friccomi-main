--
-- PostgreSQL database dump
--

-- Dumped from database version 10.17
-- Dumped by pg_dump version 13.3

-- Started on 2021-07-15 09:46:35

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


CREATE DATABASE db_itba;

CREATE user tp_itba WITH PASSWORD 'itba';

GRANT ALL PRIVILEGES ON DATABASE "db_itba" to tp_itba;


 ---create role tp_itba with 
 ---login
 ---superuser
--- INHERIT
--- CREATEDB
--- CREATEROLE
--- NOREPLICATION
--- PASSWORD 'tp_itba';

--- DROP DATABASE itba;
--
-- TOC entry 2909 (class 1262 OID 24578)
-- Name: itba; Type: DATABASE; Schema: -; Owner: tp_itba
--

ALTER DATABASE db_itba OWNER TO tp_itba;

\connect db_itba tp_itba

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 8 (class 2615 OID 24579)
-- Name: TP_ITBA; Type: SCHEMA; Schema: -; Owner: tp_itba
--

CREATE SCHEMA "TP_ITBA";


ALTER SCHEMA "TP_ITBA" OWNER TO tp_itba;

SET default_tablespace = '';

--
-- TOC entry 197 (class 1259 OID 24595)
-- Name: alcances; Type: TABLE; Schema: TP_ITBA; Owner: tp_itba
--

CREATE TABLE "TP_ITBA".alcances (
    alcance_id integer NOT NULL,
    alcance_nombre character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE "TP_ITBA".alcances OWNER TO tp_itba;

--
-- TOC entry 211 (class 1259 OID 24768)
-- Name: datos_csv_cereales_oil; Type: TABLE; Schema: TP_ITBA; Owner: postgres
--

CREATE TABLE "TP_ITBA".datos_csv_cereales_oil (
    sector_id integer NOT NULL,
    sector_nombre character varying(57) NOT NULL,
    variable_id integer NOT NULL,
    actividad_producto_nombre character varying(63) DEFAULT NULL::character varying,
    indicador character varying(54) NOT NULL,
    unidad_de_medida character varying(50) DEFAULT NULL::character varying,
    fuente character varying(50) DEFAULT NULL::character varying,
    frecuencia_nombre character varying(50) DEFAULT NULL::character varying,
    cobertura_nombre character varying(50) DEFAULT NULL::character varying,
    alcance_tipo character varying(50) DEFAULT NULL::character varying,
    alcance_id integer NOT NULL,
    alcance_nombre character varying(50) DEFAULT NULL::character varying,
    indice_tiempo date NOT NULL,
    valor character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE "TP_ITBA".datos_csv_cereales_oil OWNER TO tp_itba;

--
-- TOC entry 214 (class 1259 OID 25127)
-- Name: productos; Type: TABLE; Schema: TP_ITBA; Owner: postgres
--

CREATE TABLE "TP_ITBA".productos (
    sector_id integer NOT NULL,
    variable_id integer NOT NULL,
    indicador_id integer DEFAULT 0 NOT NULL,
    medida_id integer DEFAULT 0 NOT NULL,
    fuente_id integer DEFAULT 0 NOT NULL,
    frecuencia_id integer DEFAULT 0 NOT NULL,
    tipo_cobertura_id integer,
    alcance_tipo_id integer DEFAULT 0 NOT NULL,
    alcance_id integer NOT NULL,
    indice_tiempo date NOT NULL,
    valor numeric
);


ALTER TABLE "TP_ITBA".productos OWNER TO tp_itba;

--
-- TOC entry 198 (class 1259 OID 24601)
-- Name: sectores; Type: TABLE; Schema: TP_ITBA; Owner: tp_itba
--

CREATE TABLE "TP_ITBA".sectores (
    sector_id integer NOT NULL,
    sector_nombre character varying(40) DEFAULT NULL::character varying
);


ALTER TABLE "TP_ITBA".sectores OWNER TO tp_itba;

--
-- TOC entry 200 (class 1259 OID 24699)
-- Name: tipos_alcances; Type: TABLE; Schema: TP_ITBA; Owner: postgres
--

CREATE TABLE "TP_ITBA".tipos_alcances (
    alcance_tipo_id smallint NOT NULL,
    alcance_tipo_nombre character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE "TP_ITBA".tipos_alcances OWNER TO tp_itba;

--
-- TOC entry 199 (class 1259 OID 24694)
-- Name: tipos_alcances_seq; Type: SEQUENCE; Schema: TP_ITBA; Owner: postgres
--

CREATE SEQUENCE "TP_ITBA".tipos_alcances_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "TP_ITBA".tipos_alcances_seq OWNER TO tp_itba;

--
-- TOC entry 2910 (class 0 OID 0)
-- Dependencies: 199
-- Name: tipos_alcances_seq; Type: SEQUENCE OWNED BY; Schema: TP_ITBA; Owner: postgres
--

ALTER SEQUENCE "TP_ITBA".tipos_alcances_seq OWNED BY "TP_ITBA".tipos_alcances.alcance_tipo_id;


--
-- TOC entry 202 (class 1259 OID 24710)
-- Name: tipos_cobertura; Type: TABLE; Schema: TP_ITBA; Owner: postgres
--

CREATE TABLE "TP_ITBA".tipos_cobertura (
    tipos_cobertura_id smallint NOT NULL,
    cobertura_nombre character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE "TP_ITBA".tipos_cobertura OWNER TO tp_itba;

--
-- TOC entry 201 (class 1259 OID 24708)
-- Name: tipos_cobertura_seq; Type: SEQUENCE; Schema: TP_ITBA; Owner: tp_itba
--

CREATE SEQUENCE "TP_ITBA".tipos_cobertura_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "TP_ITBA".tipos_cobertura_seq OWNER TO tp_itba;

--
-- TOC entry 2911 (class 0 OID 0)
-- Dependencies: 201
-- Name: tipos_cobertura_seq; Type: SEQUENCE OWNED BY; Schema: TP_ITBA; Owner: postgres
--

ALTER SEQUENCE "TP_ITBA".tipos_cobertura_seq OWNED BY "TP_ITBA".tipos_cobertura.tipos_cobertura_id;


--
-- TOC entry 213 (class 1259 OID 24785)
-- Name: tipos_frecuencias; Type: TABLE; Schema: TP_ITBA; Owner: postgres
--

CREATE TABLE "TP_ITBA".tipos_frecuencias (
    frecuencia_id smallint NOT NULL,
    frecuencia_nombre character varying(100) DEFAULT NULL::character varying
);


ALTER TABLE "TP_ITBA".tipos_frecuencias OWNER TO tp_itba;

--
-- TOC entry 212 (class 1259 OID 24783)
-- Name: tipos_frecuencias_seq; Type: SEQUENCE; Schema: TP_ITBA; Owner: postgres
--

CREATE SEQUENCE "TP_ITBA".tipos_frecuencias_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "TP_ITBA".tipos_frecuencias_seq OWNER TO tp_itba;

--
-- TOC entry 2912 (class 0 OID 0)
-- Dependencies: 212
-- Name: tipos_frecuencias_seq; Type: SEQUENCE OWNED BY; Schema: TP_ITBA; Owner: postgres
--

ALTER SEQUENCE "TP_ITBA".tipos_frecuencias_seq OWNED BY "TP_ITBA".tipos_frecuencias.frecuencia_id;


--
-- TOC entry 204 (class 1259 OID 24723)
-- Name: tipos_fuentes; Type: TABLE; Schema: TP_ITBA; Owner: postgres
--

CREATE TABLE "TP_ITBA".tipos_fuentes (
    fuente_id smallint NOT NULL,
    fuente_nombre character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE "TP_ITBA".tipos_fuentes OWNER TO tp_itba;

--
-- TOC entry 203 (class 1259 OID 24721)
-- Name: tipos_fuentes_seq; Type: SEQUENCE; Schema: TP_ITBA; Owner: postgres
--

CREATE SEQUENCE "TP_ITBA".tipos_fuentes_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "TP_ITBA".tipos_fuentes_seq OWNER TO tp_itba;

--
-- TOC entry 2913 (class 0 OID 0)
-- Dependencies: 203
-- Name: tipos_fuentes_seq; Type: SEQUENCE OWNED BY; Schema: TP_ITBA; Owner: postgres
--

ALTER SEQUENCE "TP_ITBA".tipos_fuentes_seq OWNED BY "TP_ITBA".tipos_fuentes.fuente_id;


--
-- TOC entry 206 (class 1259 OID 24741)
-- Name: tipos_indicadores; Type: TABLE; Schema: TP_ITBA; Owner: postgres
--

CREATE TABLE "TP_ITBA".tipos_indicadores (
    indicador_id smallint NOT NULL,
    indicador_nombre character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE "TP_ITBA".tipos_indicadores OWNER TO tp_itba;

--
-- TOC entry 205 (class 1259 OID 24739)
-- Name: tipos_indicadores_seq; Type: SEQUENCE; Schema: TP_ITBA; Owner: postgres
--

CREATE SEQUENCE "TP_ITBA".tipos_indicadores_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "TP_ITBA".tipos_indicadores_seq OWNER TO tp_itba;

--
-- TOC entry 2914 (class 0 OID 0)
-- Dependencies: 205
-- Name: tipos_indicadores_seq; Type: SEQUENCE OWNED BY; Schema: TP_ITBA; Owner: postgres
--

ALTER SEQUENCE "TP_ITBA".tipos_indicadores_seq OWNED BY "TP_ITBA".tipos_indicadores.indicador_id;


--
-- TOC entry 208 (class 1259 OID 24750)
-- Name: unidades_medida; Type: TABLE; Schema: TP_ITBA; Owner: postgres
--

CREATE TABLE "TP_ITBA".unidades_medida (
    medida_id smallint NOT NULL,
    medida_nombre character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE "TP_ITBA".unidades_medida OWNER TO tp_itba;

--
-- TOC entry 207 (class 1259 OID 24748)
-- Name: unidades_medida_seq; Type: SEQUENCE; Schema: TP_ITBA; Owner: postgres
--

CREATE SEQUENCE "TP_ITBA".unidades_medida_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "TP_ITBA".unidades_medida_seq OWNER TO tp_itba;

--
-- TOC entry 2915 (class 0 OID 0)
-- Dependencies: 207
-- Name: unidades_medida_seq; Type: SEQUENCE OWNED BY; Schema: TP_ITBA; Owner: postgres
--

ALTER SEQUENCE "TP_ITBA".unidades_medida_seq OWNED BY "TP_ITBA".unidades_medida.medida_id;


--
-- TOC entry 210 (class 1259 OID 24761)
-- Name: variables; Type: TABLE; Schema: TP_ITBA; Owner: postgres
--

CREATE TABLE "TP_ITBA".variables (
    variable_id smallint NOT NULL,
    actividad_producto_nombre character varying(100) DEFAULT NULL::character varying
);


ALTER TABLE "TP_ITBA".variables OWNER TO tp_itba;

--
-- TOC entry 209 (class 1259 OID 24759)
-- Name: variables_seq; Type: SEQUENCE; Schema: TP_ITBA; Owner: postgres
--

CREATE SEQUENCE "TP_ITBA".variables_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "TP_ITBA".variables_seq OWNER TO tp_itba;

--
-- TOC entry 2916 (class 0 OID 0)
-- Dependencies: 209
-- Name: variables_seq; Type: SEQUENCE OWNED BY; Schema: TP_ITBA; Owner: postgres
--

ALTER SEQUENCE "TP_ITBA".variables_seq OWNED BY "TP_ITBA".variables.variable_id;


--
-- TOC entry 2726 (class 2604 OID 24702)
-- Name: tipos_alcances alcance_tipo_id; Type: DEFAULT; Schema: TP_ITBA; Owner: postgres
--

ALTER TABLE ONLY "TP_ITBA".tipos_alcances ALTER COLUMN alcance_tipo_id SET DEFAULT nextval('"TP_ITBA".tipos_alcances_seq'::regclass);


--
-- TOC entry 2728 (class 2604 OID 24713)
-- Name: tipos_cobertura tipos_cobertura_id; Type: DEFAULT; Schema: TP_ITBA; Owner: postgres
--

ALTER TABLE ONLY "TP_ITBA".tipos_cobertura ALTER COLUMN tipos_cobertura_id SET DEFAULT nextval('"TP_ITBA".tipos_cobertura_seq'::regclass);


--
-- TOC entry 2746 (class 2604 OID 24788)
-- Name: tipos_frecuencias frecuencia_id; Type: DEFAULT; Schema: TP_ITBA; Owner: postgres
--

ALTER TABLE ONLY "TP_ITBA".tipos_frecuencias ALTER COLUMN frecuencia_id SET DEFAULT nextval('"TP_ITBA".tipos_frecuencias_seq'::regclass);


--
-- TOC entry 2730 (class 2604 OID 24726)
-- Name: tipos_fuentes fuente_id; Type: DEFAULT; Schema: TP_ITBA; Owner: postgres
--

ALTER TABLE ONLY "TP_ITBA".tipos_fuentes ALTER COLUMN fuente_id SET DEFAULT nextval('"TP_ITBA".tipos_fuentes_seq'::regclass);


--
-- TOC entry 2732 (class 2604 OID 24744)
-- Name: tipos_indicadores indicador_id; Type: DEFAULT; Schema: TP_ITBA; Owner: postgres
--

ALTER TABLE ONLY "TP_ITBA".tipos_indicadores ALTER COLUMN indicador_id SET DEFAULT nextval('"TP_ITBA".tipos_indicadores_seq'::regclass);


--
-- TOC entry 2734 (class 2604 OID 24753)
-- Name: unidades_medida medida_id; Type: DEFAULT; Schema: TP_ITBA; Owner: postgres
--

ALTER TABLE ONLY "TP_ITBA".unidades_medida ALTER COLUMN medida_id SET DEFAULT nextval('"TP_ITBA".unidades_medida_seq'::regclass);


--
-- TOC entry 2736 (class 2604 OID 24764)
-- Name: variables variable_id; Type: DEFAULT; Schema: TP_ITBA; Owner: postgres
--

ALTER TABLE ONLY "TP_ITBA".variables ALTER COLUMN variable_id SET DEFAULT nextval('"TP_ITBA".variables_seq'::regclass);


--
-- TOC entry 2755 (class 2606 OID 24600)
-- Name: alcances alcances_pkey; Type: CONSTRAINT; Schema: TP_ITBA; Owner: tp_itba
--

ALTER TABLE ONLY "TP_ITBA".alcances
    ADD CONSTRAINT alcances_pkey PRIMARY KEY (alcance_id);


--
-- TOC entry 2773 (class 2606 OID 25137)
-- Name: productos productos_pk; Type: CONSTRAINT; Schema: TP_ITBA; Owner: postgres
--

ALTER TABLE ONLY "TP_ITBA".productos
    ADD CONSTRAINT productos_pk PRIMARY KEY (sector_id, variable_id, indicador_id, medida_id, alcance_id, indice_tiempo);


--
-- TOC entry 2757 (class 2606 OID 24606)
-- Name: sectores sectores_pkey; Type: CONSTRAINT; Schema: TP_ITBA; Owner: tp_itba
--

ALTER TABLE ONLY "TP_ITBA".sectores
    ADD CONSTRAINT sectores_pkey PRIMARY KEY (sector_id);


--
-- TOC entry 2759 (class 2606 OID 24705)
-- Name: tipos_alcances tipos_alcances_pkey; Type: CONSTRAINT; Schema: TP_ITBA; Owner: postgres
--

ALTER TABLE ONLY "TP_ITBA".tipos_alcances
    ADD CONSTRAINT tipos_alcances_pkey PRIMARY KEY (alcance_tipo_id);


--
-- TOC entry 2761 (class 2606 OID 24716)
-- Name: tipos_cobertura tipos_cobertura_pkey; Type: CONSTRAINT; Schema: TP_ITBA; Owner: postgres
--

ALTER TABLE ONLY "TP_ITBA".tipos_cobertura
    ADD CONSTRAINT tipos_cobertura_pkey PRIMARY KEY (tipos_cobertura_id);


--
-- TOC entry 2771 (class 2606 OID 24791)
-- Name: tipos_frecuencias tipos_frecuencias_pkey; Type: CONSTRAINT; Schema: TP_ITBA; Owner: postgres
--

ALTER TABLE ONLY "TP_ITBA".tipos_frecuencias
    ADD CONSTRAINT tipos_frecuencias_pkey PRIMARY KEY (frecuencia_id);


--
-- TOC entry 2763 (class 2606 OID 24729)
-- Name: tipos_fuentes tipos_fuentes_pkey; Type: CONSTRAINT; Schema: TP_ITBA; Owner: postgres
--

ALTER TABLE ONLY "TP_ITBA".tipos_fuentes
    ADD CONSTRAINT tipos_fuentes_pkey PRIMARY KEY (fuente_id);


--
-- TOC entry 2765 (class 2606 OID 24747)
-- Name: tipos_indicadores tipos_indicadores_pkey; Type: CONSTRAINT; Schema: TP_ITBA; Owner: postgres
--

ALTER TABLE ONLY "TP_ITBA".tipos_indicadores
    ADD CONSTRAINT tipos_indicadores_pkey PRIMARY KEY (indicador_id);


--
-- TOC entry 2767 (class 2606 OID 24756)
-- Name: unidades_medida unidades_medida_pkey; Type: CONSTRAINT; Schema: TP_ITBA; Owner: postgres
--

ALTER TABLE ONLY "TP_ITBA".unidades_medida
    ADD CONSTRAINT unidades_medida_pkey PRIMARY KEY (medida_id);


--
-- TOC entry 2769 (class 2606 OID 24767)
-- Name: variables variables_pkey; Type: CONSTRAINT; Schema: TP_ITBA; Owner: postgres
--

ALTER TABLE ONLY "TP_ITBA".variables
    ADD CONSTRAINT variables_pkey PRIMARY KEY (variable_id);


--
-- TOC entry 2774 (class 2606 OID 25138)
-- Name: productos Sector_FK; Type: FK CONSTRAINT; Schema: TP_ITBA; Owner: postgres
--

ALTER TABLE ONLY "TP_ITBA".productos
    ADD CONSTRAINT "Sector_FK" FOREIGN KEY (sector_id) REFERENCES "TP_ITBA".sectores(sector_id);


--
-- TOC entry 2782 (class 2606 OID 25178)
-- Name: productos alcance_FK; Type: FK CONSTRAINT; Schema: TP_ITBA; Owner: postgres
--

ALTER TABLE ONLY "TP_ITBA".productos
    ADD CONSTRAINT "alcance_FK" FOREIGN KEY (alcance_id) REFERENCES "TP_ITBA".alcances(alcance_id);


--
-- TOC entry 2779 (class 2606 OID 25163)
-- Name: productos frecuencia_FK; Type: FK CONSTRAINT; Schema: TP_ITBA; Owner: postgres
--

ALTER TABLE ONLY "TP_ITBA".productos
    ADD CONSTRAINT "frecuencia_FK" FOREIGN KEY (frecuencia_id) REFERENCES "TP_ITBA".tipos_frecuencias(frecuencia_id);


--
-- TOC entry 2778 (class 2606 OID 25158)
-- Name: productos fuente_FK; Type: FK CONSTRAINT; Schema: TP_ITBA; Owner: postgres
--

ALTER TABLE ONLY "TP_ITBA".productos
    ADD CONSTRAINT "fuente_FK" FOREIGN KEY (fuente_id) REFERENCES "TP_ITBA".tipos_fuentes(fuente_id);


--
-- TOC entry 2776 (class 2606 OID 25148)
-- Name: productos indicador_FK; Type: FK CONSTRAINT; Schema: TP_ITBA; Owner: postgres
--

ALTER TABLE ONLY "TP_ITBA".productos
    ADD CONSTRAINT "indicador_FK" FOREIGN KEY (indicador_id) REFERENCES "TP_ITBA".tipos_indicadores(indicador_id);


--
-- TOC entry 2777 (class 2606 OID 25153)
-- Name: productos medida_FK; Type: FK CONSTRAINT; Schema: TP_ITBA; Owner: postgres
--

ALTER TABLE ONLY "TP_ITBA".productos
    ADD CONSTRAINT "medida_FK" FOREIGN KEY (medida_id) REFERENCES "TP_ITBA".unidades_medida(medida_id);


--
-- TOC entry 2781 (class 2606 OID 25173)
-- Name: productos tipo_calcances_FK; Type: FK CONSTRAINT; Schema: TP_ITBA; Owner: postgres
--

ALTER TABLE ONLY "TP_ITBA".productos
    ADD CONSTRAINT "tipo_calcances_FK" FOREIGN KEY (alcance_tipo_id) REFERENCES "TP_ITBA".tipos_alcances(alcance_tipo_id);


--
-- TOC entry 2780 (class 2606 OID 25168)
-- Name: productos tipo_cobertura_FK; Type: FK CONSTRAINT; Schema: TP_ITBA; Owner: postgres
--

ALTER TABLE ONLY "TP_ITBA".productos
    ADD CONSTRAINT "tipo_cobertura_FK" FOREIGN KEY (tipo_cobertura_id) REFERENCES "TP_ITBA".tipos_cobertura(tipos_cobertura_id);


--
-- TOC entry 2775 (class 2606 OID 25143)
-- Name: productos variables_FK; Type: FK CONSTRAINT; Schema: TP_ITBA; Owner: postgres
--

ALTER TABLE ONLY "TP_ITBA".productos
    ADD CONSTRAINT "variables_FK" FOREIGN KEY (variable_id) REFERENCES "TP_ITBA".variables(variable_id);

-- Para saber que se creo toda la estructura de Tablas y se puede empezar a correr el armar.py
CREATE TABLE "TP_ITBA".banderas (
    bandera_id smallint NOT NULL,
    Tarea character varying(100) DEFAULT NULL::character varying
);
insert into "TP_ITBA".banderas values(1,'Armado de tablas');


-- Completed on 2021-07-15 09:46:35
--
-- PostgreSQL database dump complete
--

