--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: auditoria; Type: SCHEMA; Schema: -; Owner: wwwcrapp
--

CREATE SCHEMA auditoria;


ALTER SCHEMA auditoria OWNER TO wwwcrapp;

SET search_path = auditoria, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auditoria; Type: TABLE; Schema: auditoria; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE auditoria (
    fecha date,
    nombre_disparador text,
    tipo_disparador text,
    nivel_disparador text,
    comando text,
    tabla text,
    sql_realizado text,
    ip text,
    usuario text,
    mac text,
    codigo integer NOT NULL,
    hora character varying(9)
);


ALTER TABLE auditoria.auditoria OWNER TO wwwcrapp;

--
-- Name: auditoria_codigo_seq; Type: SEQUENCE; Schema: auditoria; Owner: wwwcrapp
--

CREATE SEQUENCE auditoria_codigo_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE auditoria.auditoria_codigo_seq OWNER TO wwwcrapp;

--
-- Name: auditoria_codigo_seq; Type: SEQUENCE OWNED BY; Schema: auditoria; Owner: wwwcrapp
--

ALTER SEQUENCE auditoria_codigo_seq OWNED BY auditoria.codigo;


--
-- Name: auditoria_codigo_seq; Type: SEQUENCE SET; Schema: auditoria; Owner: wwwcrapp
--

SELECT pg_catalog.setval('auditoria_codigo_seq', 453, true);


--
-- Name: inicio_sesion; Type: TABLE; Schema: auditoria; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE inicio_sesion (
    id integer NOT NULL,
    usuario character varying(25) NOT NULL,
    fecha date NOT NULL,
    hora time without time zone NOT NULL,
    ip character varying(15)
);


ALTER TABLE auditoria.inicio_sesion OWNER TO wwwcrapp;

--
-- Name: inicio_sesion_id_seq; Type: SEQUENCE; Schema: auditoria; Owner: wwwcrapp
--

CREATE SEQUENCE inicio_sesion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE auditoria.inicio_sesion_id_seq OWNER TO wwwcrapp;

--
-- Name: inicio_sesion_id_seq; Type: SEQUENCE OWNED BY; Schema: auditoria; Owner: wwwcrapp
--

ALTER SEQUENCE inicio_sesion_id_seq OWNED BY inicio_sesion.id;


--
-- Name: inicio_sesion_id_seq; Type: SEQUENCE SET; Schema: auditoria; Owner: wwwcrapp
--

SELECT pg_catalog.setval('inicio_sesion_id_seq', 53, true);


SET search_path = public, pg_catalog;

--
-- Name: agencia; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE agencia (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    ci_rif character varying(15),
    direccion text,
    telefono character varying(12),
    id_estado character varying(5),
    ciudad character varying(50),
    disponible double precision,
    id_banquero character varying(10) NOT NULL,
    premio_max double precision DEFAULT 0,
    porcentaje_venta double precision DEFAULT 0
);


ALTER TABLE public.agencia OWNER TO wwwcrapp;

--
-- Name: apuesta; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE apuesta (
    id real NOT NULL,
    fecha date NOT NULL,
    hora time without time zone,
    monto double precision NOT NULL,
    premio double precision NOT NULL,
    estatus character varying(10),
    id_seguridad character varying(10),
    tipo character varying(15),
    id_agencia integer NOT NULL
);


ALTER TABLE public.apuesta OWNER TO wwwcrapp;

--
-- Name: apuesta_detalle; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE apuesta_detalle (
    id integer NOT NULL,
    id_apuesta real NOT NULL,
    id_deporte real,
    id_logro real,
    campo_logro character varying(20),
    equipo character varying(100),
    nro_logro character varying(5),
    descripcion_logro character varying(100)
);


ALTER TABLE public.apuesta_detalle OWNER TO wwwcrapp;

--
-- Name: logro_basquetbol; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE logro_basquetbol (
    id real NOT NULL,
    encuentro character varying(50) NOT NULL,
    equipo1 character varying(50) NOT NULL,
    equipo2 character varying(50) NOT NULL,
    favorito character varying(2) NOT NULL,
    fecha date NOT NULL,
    hora time without time zone NOT NULL,
    ganador1 character varying(5),
    ganador2 character varying(5),
    runline1 character varying(5),
    runline2 character varying(5),
    v_runline double precision,
    altabaja1 character varying(5),
    altabaja2 character varying(5),
    v_altabaja double precision,
    estatus character varying(10) NOT NULL,
    id_liga real NOT NULL
);


ALTER TABLE public.logro_basquetbol OWNER TO wwwcrapp;

--
-- Name: resultado_basquetbol; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE resultado_basquetbol (
    id real NOT NULL,
    id_logro real NOT NULL,
    encuentro character varying(50),
    fecha date NOT NULL,
    ganador character varying(100),
    runline character varying(50),
    total_puntos integer,
    marcador character varying(10),
    estatus character varying(15) NOT NULL
);


ALTER TABLE public.resultado_basquetbol OWNER TO wwwcrapp;

--
-- Name: apuesta_basquetbol_resultado; Type: VIEW; Schema: public; Owner: wwwcrapp
--

CREATE VIEW apuesta_basquetbol_resultado AS
    SELECT a.id, a.id_seguridad, a.id_agencia, a.fecha, a.monto, a.premio, a.estatus AS estatus_apuesta, b.campo_logro, b.equipo, d.v_altabaja, c.encuentro, c.ganador, c.runline, c.total_puntos, c.estatus AS estatus_resultado FROM apuesta a, apuesta_detalle b, resultado_basquetbol c, logro_basquetbol d WHERE ((((b.id_deporte = (2)::real) AND (a.id = b.id_apuesta)) AND (b.id_logro = c.id_logro)) AND (c.id_logro = d.id)) ORDER BY a.id, b.id;


ALTER TABLE public.apuesta_basquetbol_resultado OWNER TO wwwcrapp;

--
-- Name: logro_beisbol; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE logro_beisbol (
    id real NOT NULL,
    encuentro character varying(50) NOT NULL,
    equipo1 character varying(50) NOT NULL,
    equipo2 character varying(50) NOT NULL,
    lanzador1 character varying(50),
    lanzador2 character varying(50),
    favorito character varying(2) NOT NULL,
    fecha date NOT NULL,
    hora time without time zone NOT NULL,
    ganador1 character varying(5),
    ganador2 character varying(5),
    runline1 character varying(5),
    runline2 character varying(5),
    v_runline double precision,
    altabaja1 character varying(5),
    altabaja2 character varying(5),
    v_altabaja double precision,
    p_inning1 character varying(5),
    p_inning2 character varying(5),
    g_mediojuego1 character varying(5),
    g_mediojuego2 character varying(5),
    ab_mediojuego1 character varying(5),
    ab_mediojuego2 character varying(5),
    v_ab_mediojuego double precision,
    p_anotar1 character varying(5),
    p_anotar2 character varying(5),
    estatus character varying(10) NOT NULL,
    id_liga real NOT NULL
);


ALTER TABLE public.logro_beisbol OWNER TO wwwcrapp;

--
-- Name: resultado_beisbol; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE resultado_beisbol (
    id real NOT NULL,
    id_logro real NOT NULL,
    encuentro character varying(50),
    fecha date NOT NULL,
    ganador character varying(100),
    runline character varying(50),
    p_inning character varying(50),
    g_mediojuego character varying(50),
    p_anotar character varying(50),
    marcador character varying(10),
    total_carreras integer,
    total_carreras_5to integer,
    estatus character varying(15) NOT NULL
);


ALTER TABLE public.resultado_beisbol OWNER TO wwwcrapp;

--
-- Name: apuesta_beisbol_resultado; Type: VIEW; Schema: public; Owner: wwwcrapp
--

CREATE VIEW apuesta_beisbol_resultado AS
    SELECT a.id, a.id_seguridad, a.id_agencia, a.fecha, a.monto, a.premio, a.estatus AS estatus_apuesta, b.campo_logro, b.equipo, d.v_altabaja, d.v_ab_mediojuego, c.encuentro, c.ganador, c.runline, c.p_inning, c.g_mediojuego, c.p_anotar, c.total_carreras, c.total_carreras_5to, c.estatus AS estatus_resultado FROM apuesta a, apuesta_detalle b, resultado_beisbol c, logro_beisbol d WHERE ((((b.id_deporte = (1)::real) AND (a.id = b.id_apuesta)) AND (b.id_logro = c.id_logro)) AND (c.id_logro = d.id)) ORDER BY a.id, b.id;


ALTER TABLE public.apuesta_beisbol_resultado OWNER TO wwwcrapp;

--
-- Name: apuesta_detalle_id_seq; Type: SEQUENCE; Schema: public; Owner: wwwcrapp
--

CREATE SEQUENCE apuesta_detalle_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.apuesta_detalle_id_seq OWNER TO wwwcrapp;

--
-- Name: apuesta_detalle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wwwcrapp
--

ALTER SEQUENCE apuesta_detalle_id_seq OWNED BY apuesta_detalle.id;


--
-- Name: apuesta_detalle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wwwcrapp
--

SELECT pg_catalog.setval('apuesta_detalle_id_seq', 254, true);


--
-- Name: logro_futbol; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE logro_futbol (
    id real NOT NULL,
    encuentro character varying(50) NOT NULL,
    equipo1 character varying(50) NOT NULL,
    equipo2 character varying(50) NOT NULL,
    favorito character varying(2) NOT NULL,
    fecha date NOT NULL,
    hora time without time zone NOT NULL,
    ganador1 character varying(5),
    ganador2 character varying(5),
    empate character varying(5),
    runline1 character varying(5),
    runline2 character varying(5),
    v_runline double precision,
    altabaja1 character varying(5),
    altabaja2 character varying(5),
    v_altabaja double precision,
    estatus character varying(10) NOT NULL,
    id_liga real NOT NULL
);


ALTER TABLE public.logro_futbol OWNER TO wwwcrapp;

--
-- Name: resultado_futbol; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE resultado_futbol (
    id real NOT NULL,
    id_logro real NOT NULL,
    encuentro character varying(50),
    fecha date NOT NULL,
    ganador character varying(100),
    runline character varying(100),
    total_goles integer,
    marcador character varying(10),
    estatus character varying(15) NOT NULL
);


ALTER TABLE public.resultado_futbol OWNER TO wwwcrapp;

--
-- Name: apuesta_futbol_resultado; Type: VIEW; Schema: public; Owner: wwwcrapp
--

CREATE VIEW apuesta_futbol_resultado AS
    SELECT a.id, a.id_seguridad, a.id_agencia, a.fecha, a.monto, a.premio, a.estatus AS estatus_apuesta, b.campo_logro, b.equipo, d.v_altabaja, c.encuentro, c.ganador, c.runline, c.total_goles, c.estatus AS estatus_resultado FROM apuesta a, apuesta_detalle b, resultado_futbol c, logro_futbol d WHERE ((((b.id_deporte = (3)::real) AND (a.id = b.id_apuesta)) AND (b.id_logro = c.id_logro)) AND (c.id_logro = d.id)) ORDER BY a.id, b.id;


ALTER TABLE public.apuesta_futbol_resultado OWNER TO wwwcrapp;

--
-- Name: banquero; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE banquero (
    cedula character varying(10) NOT NULL,
    nombre character varying(50) NOT NULL,
    direccion text,
    telefono character varying(12),
    correo character varying(50)
);


ALTER TABLE public.banquero OWNER TO wwwcrapp;

--
-- Name: deporte; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE deporte (
    id real NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public.deporte OWNER TO wwwcrapp;

--
-- Name: empresa; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE empresa (
    rif character varying(15) NOT NULL,
    nombre character varying(50) NOT NULL,
    nombre_comercial character varying(50),
    direccion text,
    telefono character varying(12)
);


ALTER TABLE public.empresa OWNER TO wwwcrapp;

--
-- Name: estado; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE estado (
    codigo character varying(5) NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public.estado OWNER TO wwwcrapp;

--
-- Name: liga; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE liga (
    id real NOT NULL,
    id_deporte real NOT NULL,
    nombre character varying(50) NOT NULL,
    pais character varying(100),
    estatus character varying(20)
);


ALTER TABLE public.liga OWNER TO wwwcrapp;

--
-- Name: logro_boxeo; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE logro_boxeo (
    id real NOT NULL,
    encuentro character varying(50) NOT NULL,
    equipo1 character varying(50) NOT NULL,
    equipo2 character varying(50) NOT NULL,
    favorito character varying(2) NOT NULL,
    fecha date NOT NULL,
    hora time without time zone NOT NULL,
    ganador1 character varying(5),
    ganador2 character varying(5),
    estatus character varying(10) NOT NULL,
    id_liga real NOT NULL
);


ALTER TABLE public.logro_boxeo OWNER TO wwwcrapp;

--
-- Name: logro_formula1; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE logro_formula1 (
    id real NOT NULL,
    encuentro character varying(50) NOT NULL,
    equipo1 character varying(50) NOT NULL,
    ganador1 character varying(5),
    equipo2 character varying(50) NOT NULL,
    ganador2 character varying(5),
    equipo3 character varying(50) NOT NULL,
    ganador3 character varying(5),
    equipo4 character varying(50) NOT NULL,
    ganador4 character varying(5),
    equipo5 character varying(50) NOT NULL,
    ganador5 character varying(5),
    equipo6 character varying(50) NOT NULL,
    ganador6 character varying(5),
    equipo7 character varying(50) NOT NULL,
    ganador7 character varying(5),
    equipo8 character varying(50) NOT NULL,
    ganador8 character varying(5),
    equipo9 character varying(50) NOT NULL,
    ganador9 character varying(5),
    equipo10 character varying(50) NOT NULL,
    ganador10 character varying(5),
    equipo11 character varying(50) NOT NULL,
    ganador11 character varying(5),
    equipo12 character varying(50) NOT NULL,
    ganador12 character varying(5),
    equipo13 character varying(50) NOT NULL,
    ganador13 character varying(5),
    equipo14 character varying(50) NOT NULL,
    ganador14 character varying(5),
    equipo15 character varying(50) NOT NULL,
    ganador15 character varying(5),
    equipo16 character varying(50) NOT NULL,
    ganador16 character varying(5),
    equipo17 character varying(50) NOT NULL,
    ganador17 character varying(5),
    equipo18 character varying(50) NOT NULL,
    ganador18 character varying(5),
    equipo19 character varying(50) NOT NULL,
    ganador19 character varying(5),
    equipo20 character varying(50) NOT NULL,
    ganador20 character varying(5),
    equipo21 character varying(50) NOT NULL,
    ganador21 character varying(5),
    equipo22 character varying(50) NOT NULL,
    ganador22 character varying(5),
    equipo23 character varying(50) NOT NULL,
    ganador23 character varying(5),
    equipo24 character varying(50) NOT NULL,
    ganador24 character varying(5),
    favorito character varying(2) NOT NULL,
    fecha date NOT NULL,
    hora time without time zone NOT NULL,
    estatus character varying(10) NOT NULL,
    id_liga real NOT NULL
);


ALTER TABLE public.logro_formula1 OWNER TO wwwcrapp;

--
-- Name: logro_futbol_americano; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE logro_futbol_americano (
    id real NOT NULL,
    encuentro character varying(50) NOT NULL,
    equipo1 character varying(50) NOT NULL,
    equipo2 character varying(50) NOT NULL,
    favorito character varying(2) NOT NULL,
    fecha date NOT NULL,
    hora time without time zone NOT NULL,
    ganador1 character varying(5),
    ganador2 character varying(5),
    runline1 character varying(5),
    runline2 character varying(5),
    v_runline double precision,
    altabaja1 character varying(5),
    altabaja2 character varying(5),
    v_altabaja double precision,
    estatus character varying(10) NOT NULL,
    id_liga real NOT NULL
);


ALTER TABLE public.logro_futbol_americano OWNER TO wwwcrapp;

--
-- Name: logro_hockey; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE logro_hockey (
    id real NOT NULL,
    encuentro character varying(50) NOT NULL,
    equipo1 character varying(50) NOT NULL,
    equipo2 character varying(50) NOT NULL,
    favorito character varying(2) NOT NULL,
    fecha date NOT NULL,
    hora time without time zone NOT NULL,
    ganador1 character varying(5),
    ganador2 character varying(5),
    runline1 character varying(5),
    runline2 character varying(5),
    v_runline double precision,
    altabaja1 character varying(5),
    altabaja2 character varying(5),
    v_altabaja double precision,
    estatus character varying(10) NOT NULL,
    id_liga real NOT NULL
);


ALTER TABLE public.logro_hockey OWNER TO wwwcrapp;

--
-- Name: logro_tennis; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE logro_tennis (
    id real NOT NULL,
    encuentro character varying(50) NOT NULL,
    equipo1 character varying(50) NOT NULL,
    equipo2 character varying(50) NOT NULL,
    favorito character varying(2) NOT NULL,
    fecha date NOT NULL,
    hora time without time zone NOT NULL,
    ganador1 character varying(5),
    ganador2 character varying(5),
    estatus character varying(10) NOT NULL,
    id_liga real NOT NULL
);


ALTER TABLE public.logro_tennis OWNER TO wwwcrapp;

--
-- Name: menu; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE menu (
    id integer NOT NULL,
    superior integer NOT NULL,
    descripcion character varying(50),
    enlace character varying(250) NOT NULL,
    nivel integer
);


ALTER TABLE public.menu OWNER TO wwwcrapp;

--
-- Name: perfil; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE perfil (
    id character varying(2) NOT NULL,
    nombre character varying(20) NOT NULL,
    acceso_menu text
);


ALTER TABLE public.perfil OWNER TO wwwcrapp;

--
-- Name: resultado_boxeo; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE resultado_boxeo (
    id real NOT NULL,
    id_logro real NOT NULL,
    encuentro character varying(50),
    fecha date NOT NULL,
    ganador character varying(100),
    marcador character varying(30),
    estatus character varying(15) NOT NULL
);


ALTER TABLE public.resultado_boxeo OWNER TO wwwcrapp;

--
-- Name: resultado_formula1; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE resultado_formula1 (
    id real NOT NULL,
    id_logro real NOT NULL,
    encuentro character varying(50),
    fecha date NOT NULL,
    ganador character varying(100),
    tiempo character varying(30),
    estatus character varying(15) NOT NULL
);


ALTER TABLE public.resultado_formula1 OWNER TO wwwcrapp;

--
-- Name: resultado_futbol_americano; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE resultado_futbol_americano (
    id real NOT NULL,
    id_logro real NOT NULL,
    encuentro character varying(50),
    fecha date NOT NULL,
    ganador character varying(100),
    runline character varying(100),
    total_goles integer,
    marcador character varying(10),
    estatus character varying(15) NOT NULL
);


ALTER TABLE public.resultado_futbol_americano OWNER TO wwwcrapp;

--
-- Name: resultado_hockey; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE resultado_hockey (
    id real NOT NULL,
    id_logro real NOT NULL,
    encuentro character varying(50),
    fecha date NOT NULL,
    ganador character varying(100),
    runline character varying(100),
    total_goles integer,
    marcador character varying(10),
    estatus character varying(15) NOT NULL
);


ALTER TABLE public.resultado_hockey OWNER TO wwwcrapp;

--
-- Name: resultado_tennis; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE resultado_tennis (
    id real NOT NULL,
    id_logro real NOT NULL,
    encuentro character varying(50),
    fecha date NOT NULL,
    ganador character varying(100),
    marcador character varying(30),
    estatus character varying(15) NOT NULL
);


ALTER TABLE public.resultado_tennis OWNER TO wwwcrapp;

--
-- Name: usuario; Type: TABLE; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE TABLE usuario (
    usuario character varying(25) NOT NULL,
    clave character varying(25) NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion text,
    tipo character varying(15) NOT NULL,
    estatus character varying(5),
    id_agencia integer NOT NULL,
    cookie character varying(100),
    nro_pcs integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.usuario OWNER TO wwwcrapp;

SET search_path = auditoria, pg_catalog;

--
-- Name: codigo; Type: DEFAULT; Schema: auditoria; Owner: wwwcrapp
--

ALTER TABLE ONLY auditoria ALTER COLUMN codigo SET DEFAULT nextval('auditoria_codigo_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: auditoria; Owner: wwwcrapp
--

ALTER TABLE ONLY inicio_sesion ALTER COLUMN id SET DEFAULT nextval('inicio_sesion_id_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: wwwcrapp
--

ALTER TABLE ONLY apuesta_detalle ALTER COLUMN id SET DEFAULT nextval('apuesta_detalle_id_seq'::regclass);


SET search_path = auditoria, pg_catalog;

--
-- Data for Name: auditoria; Type: TABLE DATA; Schema: auditoria; Owner: wwwcrapp
--

COPY auditoria (fecha, nombre_disparador, tipo_disparador, nivel_disparador, comando, tabla, sql_realizado, ip, usuario, mac, codigo, hora) FROM stdin;
\.


--
-- Data for Name: inicio_sesion; Type: TABLE DATA; Schema: auditoria; Owner: wwwcrapp
--

COPY inicio_sesion (id, usuario, fecha, hora, ip) FROM stdin;
\.


SET search_path = public, pg_catalog;

--
-- Data for Name: agencia; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY agencia (id, nombre, ci_rif, direccion, telefono, id_estado, ciudad, disponible, id_banquero, premio_max, porcentaje_venta) FROM stdin;
1	BETCES	15743511	SIN REGISTRO	04148070580	19	CUMANÁ	100000	15743511	10000	0
\.


--
-- Data for Name: apuesta; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia) FROM stdin;
\.


--
-- Data for Name: apuesta_detalle; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY apuesta_detalle (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro) FROM stdin;
\.


--
-- Data for Name: banquero; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY banquero (cedula, nombre, direccion, telefono, correo) FROM stdin;
15743511	CÉSAR RAMOS	SIN REGISTRO	04148070580	cesar3r2@gmail.com
\.


--
-- Data for Name: deporte; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY deporte (id, nombre) FROM stdin;
1	Béisbol
2	Básquetbol
3	Fútbol
4	Fútbol Americano
5	Hockey
6	Tennis
7	Boxeo
8	Fórmula 1
\.


--
-- Data for Name: empresa; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY empresa (rif, nombre, nombre_comercial, direccion, telefono) FROM stdin;
15743511	BetCES Parley	BetCES Parley	SIN REGISTRO	04148070580
\.


--
-- Data for Name: estado; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY estado (codigo, nombre) FROM stdin;
10	DELTA AMACURO
11	FALCÓN
12	GUÁRICO
13	LARA
14	MÉRIDA
15	MIRANDA
16	MONAGAS
17	NUEVA ESPARTA
18	PORTUGUESA
19	SUCRE
20	TÁCHIRA
21	TRUJILLO
22	YARACUY
23	ZULIA
24	VARGAS
25	DEPENDENCIAS FEDERALES
01	DISTRITO CAPITAL
02	AMAZONAS
03	ANZOÁTEGUI
04	APURE
05	ARAGUA
06	BARINAS
07	BOLÍVAR
08	CARABOBO
09	COJEDES
\.


--
-- Data for Name: liga; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY liga (id, id_deporte, nombre, pais, estatus) FROM stdin;
4	2	NBA	EEUU	ACTIVA
1	1	MLB	EEUU	ACTIVA
20	7	WBO	EEUU	ACTIVA
21	8	CAMPEONATO F1 2012	MUNDIAL	ACTIVA
7	3	LFP	ESPAÑA	ACTIVA
13	4	NFL	EEUU	ACTIVA
14	5	NHL	EEUU	ACTIVA
18	6	WIMBLEDON	INGLATERRA	ACTIVA
6	2	LBP	VENEZUELA	INACTIVA
5	2	NCAA	EEUU	INACTIVA
3	1	SERIE DEL CARIBE	AMÉRICA LATINA	INACTIVA
2	1	LVBP	VENEZUELA	INACTIVA
8	3	CALCIO	ITALIA	INACTIVA
9	3	PREMIER LEAGUE	INGLATERRA	INACTIVA
10	3	BUNDESLIGA	ALEMANIA	INACTIVA
11	3	CHAMPIONS LEAGUE	EUROPA	INACTIVA
12	3	EUROPA LEAGUE	EUROPA	INACTIVA
15	3	EUROCOPA 2012	EUROPA	INACTIVA
22	3	COPA LIBERTADORES	AMÉRICA LATINA	INACTIVA
17	6	ROLAND GARROS	FRANCIA	INACTIVA
19	6	US OPEN	EEUU	INACTIVA
16	6	AUSTRALIA OPEN	AUSTRALIA	INACTIVA
\.


--
-- Data for Name: logro_basquetbol; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY logro_basquetbol (id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, estatus, id_liga) FROM stdin;
\.


--
-- Data for Name: logro_beisbol; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY logro_beisbol (id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) FROM stdin;
\.


--
-- Data for Name: logro_boxeo; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY logro_boxeo (id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, estatus, id_liga) FROM stdin;
\.


--
-- Data for Name: logro_formula1; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY logro_formula1 (id, encuentro, equipo1, ganador1, equipo2, ganador2, equipo3, ganador3, equipo4, ganador4, equipo5, ganador5, equipo6, ganador6, equipo7, ganador7, equipo8, ganador8, equipo9, ganador9, equipo10, ganador10, equipo11, ganador11, equipo12, ganador12, equipo13, ganador13, equipo14, ganador14, equipo15, ganador15, equipo16, ganador16, equipo17, ganador17, equipo18, ganador18, equipo19, ganador19, equipo20, ganador20, equipo21, ganador21, equipo22, ganador22, equipo23, ganador23, equipo24, ganador24, favorito, fecha, hora, estatus, id_liga) FROM stdin;
\.


--
-- Data for Name: logro_futbol; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY logro_futbol (id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, empate, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, estatus, id_liga) FROM stdin;
\.


--
-- Data for Name: logro_futbol_americano; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY logro_futbol_americano (id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, estatus, id_liga) FROM stdin;
\.


--
-- Data for Name: logro_hockey; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY logro_hockey (id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, estatus, id_liga) FROM stdin;
\.


--
-- Data for Name: logro_tennis; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY logro_tennis (id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, estatus, id_liga) FROM stdin;
\.


--
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY menu (id, superior, descripcion, enlace, nivel) FROM stdin;
1	0	inicio	inicio.php	0
9	0	administración	sistema/admon/administracion.php	0
3	0	apuestas	sistema/apuestas/apuestas.php	0
4	0	consultas	sistema/consultas/consultas.php	0
5	0	reportes	sistema/reportes/reportes.php	0
301	3	Béisbol	sistema/apuestas/beisbol.php	0
303	3	Fútbol	sistema/apuestas/futbol.php	0
501	5	Apuestas Registradas	sistema/reportes/apuestas.php	0
2	0	procesos	sistema/procesos/procesos.php	0
201	2	Cargar Logros	sistema/procesos/cargar_logros.php	0
202	2	Cargar Resultados	sistema/procesos/cargar_resultados.php	0
901	9	Empresa	sistema/admon/empresa_list.php	0
302	3	Básquetbol	sistema/apuestas/basquetbol.php	0
401	4	Ver Ticket	sistema/consultas/ticket.php	0
304	3	Fútbol Americano	sistema/apuestas/futbol_americano.php	0
502	5	Movimientos de Caja	sistema/reportes/movimientos_caja.php	0
404	4	Resultados Diarios	sistema/consultas/resultados_diarios.php	0
403	4	Logros Diarios	sistema/consultas/logros_diarios.php	0
402	4	Apuestas Detalladas	sistema/consultas/apuestas_detalladas.php	0
207	2	Procesar Ganadores	sistema/procesos/procesar_ganadores.php	0
204	2	Anular Ticket	sistema/procesos/anular_ticket.php	0
205	2	Reimprimir Ticket	sistema/procesos/reimprimir_ticket.php	0
206	2	Pagar Premio	sistema/procesos/pagar_premio.php	0
203	2	Calculadora Parley	sistema/procesos/calculadora.php	0
903	9	Agencias	sistema/admon/agencias_list.php	0
902	9	Banqueros	sistema/admon/banqueros_list.php	0
904	9	Usuarios	sistema/admon/usuarios_list.php	0
905	9	Perfiles	sistema/admon/perfiles_list.php	0
906	9	Mi Agencia	sistema/admon/mi_agencia.php	0
907	9	Ligas Activas	sistema/admon/ligas_activas.php	0
908	9	Cambiar Contraseña	sistema/admon/cambiar_clave.php	0
305	3	Hockey	sistema/apuestas/hockey.php	0
306	3	Tennis	sistema/apuestas/tennis.php	0
307	3	Boxeo	sistema/apuestas/boxeo.php	0
308	3	Fórmula 1	sistema/apuestas/formula1.php	0
503	5	Movimientos de Agencias	sistema/reportes/movimientos_agencias.php	0
504	5	Porcentajes de Ventas	sistema/reportes/porcentajes_ventas.php	0
\.


--
-- Data for Name: perfil; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY perfil (id, nombre, acceso_menu) FROM stdin;
5	Transcriptor	1,2,4,9,201,202,203,403,404,908
4	Taquilla	1,2,3,4,9,203,205,206,301,302,303,304,305,306,307,308,401,402,403,404,908
3	Agencia	1,2,4,5,9,201,203,204,205,206,401,402,403,404,501,502,906,908
1	Administrador	0,1,2,3,4,5,9,201,202,203,204,205,206,207,301,302,303,304,305,306,307,308,401,402,403,404,501,502,503,504,901,902,903,904,905,906,907,908
2	Banquero	0,1,2,4,5,9,203,204,206,402,403,404,501,502,503,504,903,904,908
\.


--
-- Data for Name: resultado_basquetbol; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY resultado_basquetbol (id, id_logro, encuentro, fecha, ganador, runline, total_puntos, marcador, estatus) FROM stdin;
\.


--
-- Data for Name: resultado_beisbol; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, p_inning, g_mediojuego, p_anotar, marcador, total_carreras, total_carreras_5to, estatus) FROM stdin;
\.


--
-- Data for Name: resultado_boxeo; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY resultado_boxeo (id, id_logro, encuentro, fecha, ganador, marcador, estatus) FROM stdin;
\.


--
-- Data for Name: resultado_formula1; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY resultado_formula1 (id, id_logro, encuentro, fecha, ganador, tiempo, estatus) FROM stdin;
\.


--
-- Data for Name: resultado_futbol; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY resultado_futbol (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) FROM stdin;
\.


--
-- Data for Name: resultado_futbol_americano; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY resultado_futbol_americano (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) FROM stdin;
\.


--
-- Data for Name: resultado_hockey; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY resultado_hockey (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) FROM stdin;
\.


--
-- Data for Name: resultado_tennis; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY resultado_tennis (id, id_logro, encuentro, fecha, ganador, marcador, estatus) FROM stdin;
\.


--
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: wwwcrapp
--

COPY usuario (usuario, clave, nombre, descripcion, tipo, estatus, id_agencia, cookie, nro_pcs) FROM stdin;
cesar3r2	YzE1NzQzNTExYw==	CÉSAR RAMOS	Ninguna	1	1	1	\N	0
\.


SET search_path = auditoria, pg_catalog;

--
-- Name: codigo; Type: CONSTRAINT; Schema: auditoria; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY auditoria
    ADD CONSTRAINT codigo PRIMARY KEY (codigo);


--
-- Name: inicio_sesion_pkey; Type: CONSTRAINT; Schema: auditoria; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY inicio_sesion
    ADD CONSTRAINT inicio_sesion_pkey PRIMARY KEY (id);


SET search_path = public, pg_catalog;

--
-- Name: agencia_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY agencia
    ADD CONSTRAINT agencia_pkey PRIMARY KEY (id);


--
-- Name: apuesta_detalle_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY apuesta_detalle
    ADD CONSTRAINT apuesta_detalle_pkey PRIMARY KEY (id, id_apuesta);


--
-- Name: apuesta_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY apuesta
    ADD CONSTRAINT apuesta_pkey PRIMARY KEY (id);


--
-- Name: banquero_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY banquero
    ADD CONSTRAINT banquero_pkey PRIMARY KEY (cedula);


--
-- Name: deporte_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY deporte
    ADD CONSTRAINT deporte_pkey PRIMARY KEY (id);


--
-- Name: empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY empresa
    ADD CONSTRAINT empresa_pkey PRIMARY KEY (rif);


--
-- Name: estado_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY estado
    ADD CONSTRAINT estado_pkey PRIMARY KEY (codigo);


--
-- Name: l_basquetbol_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY logro_basquetbol
    ADD CONSTRAINT l_basquetbol_pkey PRIMARY KEY (id);


--
-- Name: l_beisbol_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY logro_beisbol
    ADD CONSTRAINT l_beisbol_pkey PRIMARY KEY (id);


--
-- Name: l_boxeo_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY logro_boxeo
    ADD CONSTRAINT l_boxeo_pkey PRIMARY KEY (id);


--
-- Name: l_f1_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY logro_formula1
    ADD CONSTRAINT l_f1_pkey PRIMARY KEY (id);


--
-- Name: l_futbol_amer_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY logro_futbol_americano
    ADD CONSTRAINT l_futbol_amer_pkey PRIMARY KEY (id);


--
-- Name: l_futbol_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY logro_futbol
    ADD CONSTRAINT l_futbol_pkey PRIMARY KEY (id);


--
-- Name: l_hockey_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY logro_hockey
    ADD CONSTRAINT l_hockey_pkey PRIMARY KEY (id);


--
-- Name: l_tennis_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY logro_tennis
    ADD CONSTRAINT l_tennis_pkey PRIMARY KEY (id);


--
-- Name: liga_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY liga
    ADD CONSTRAINT liga_pkey PRIMARY KEY (id);


--
-- Name: menu_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT menu_pkey PRIMARY KEY (id);


--
-- Name: perfil_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY perfil
    ADD CONSTRAINT perfil_pkey PRIMARY KEY (id);


--
-- Name: resultado_basquetbol_id_logro_key; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY resultado_basquetbol
    ADD CONSTRAINT resultado_basquetbol_id_logro_key UNIQUE (id_logro);


--
-- Name: resultado_basquetbol_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY resultado_basquetbol
    ADD CONSTRAINT resultado_basquetbol_pkey PRIMARY KEY (id);


--
-- Name: resultado_beisbol_id_logro_key; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY resultado_beisbol
    ADD CONSTRAINT resultado_beisbol_id_logro_key UNIQUE (id_logro);


--
-- Name: resultado_beisbol_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY resultado_beisbol
    ADD CONSTRAINT resultado_beisbol_pkey PRIMARY KEY (id);


--
-- Name: resultado_boxeo_id_logro_key; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY resultado_boxeo
    ADD CONSTRAINT resultado_boxeo_id_logro_key UNIQUE (id_logro);


--
-- Name: resultado_boxeo_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY resultado_boxeo
    ADD CONSTRAINT resultado_boxeo_pkey PRIMARY KEY (id);


--
-- Name: resultado_f1_id_logro_key; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY resultado_formula1
    ADD CONSTRAINT resultado_f1_id_logro_key UNIQUE (id_logro);


--
-- Name: resultado_f1_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY resultado_formula1
    ADD CONSTRAINT resultado_f1_pkey PRIMARY KEY (id);


--
-- Name: resultado_futbol_amer_id_logro_key; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY resultado_futbol_americano
    ADD CONSTRAINT resultado_futbol_amer_id_logro_key UNIQUE (id_logro);


--
-- Name: resultado_futbol_amer_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY resultado_futbol_americano
    ADD CONSTRAINT resultado_futbol_amer_pkey PRIMARY KEY (id);


--
-- Name: resultado_futbol_id_logro_key; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY resultado_futbol
    ADD CONSTRAINT resultado_futbol_id_logro_key UNIQUE (id_logro);


--
-- Name: resultado_futbol_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY resultado_futbol
    ADD CONSTRAINT resultado_futbol_pkey PRIMARY KEY (id);


--
-- Name: resultado_hockey_id_logro_key; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY resultado_hockey
    ADD CONSTRAINT resultado_hockey_id_logro_key UNIQUE (id_logro);


--
-- Name: resultado_hockey_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY resultado_hockey
    ADD CONSTRAINT resultado_hockey_pkey PRIMARY KEY (id);


--
-- Name: resultado_tennis_id_logro_key; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY resultado_tennis
    ADD CONSTRAINT resultado_tennis_id_logro_key UNIQUE (id_logro);


--
-- Name: resultado_tennis_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY resultado_tennis
    ADD CONSTRAINT resultado_tennis_pkey PRIMARY KEY (id);


--
-- Name: usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: wwwcrapp; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (usuario);


--
-- Name: fki_apu_age; Type: INDEX; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE INDEX fki_apu_age ON apuesta USING btree (id_agencia);


--
-- Name: fki_banquero; Type: INDEX; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE INDEX fki_banquero ON agencia USING btree (id_banquero);


--
-- Name: fki_liga_dep; Type: INDEX; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE INDEX fki_liga_dep ON liga USING btree (id_deporte);


--
-- Name: fki_logro_res; Type: INDEX; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE INDEX fki_logro_res ON resultado_beisbol USING btree (id_logro);


--
-- Name: fki_usu_age; Type: INDEX; Schema: public; Owner: wwwcrapp; Tablespace: 
--

CREATE INDEX fki_usu_age ON usuario USING btree (id_agencia);


--
-- Name: age; Type: FK CONSTRAINT; Schema: public; Owner: wwwcrapp
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT age FOREIGN KEY (id_agencia) REFERENCES agencia(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: apuesta_detalle_id_apuesta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wwwcrapp
--

ALTER TABLE ONLY apuesta_detalle
    ADD CONSTRAINT apuesta_detalle_id_apuesta_fkey FOREIGN KEY (id_apuesta) REFERENCES apuesta(id);


--
-- Name: banquero; Type: FK CONSTRAINT; Schema: public; Owner: wwwcrapp
--

ALTER TABLE ONLY agencia
    ADD CONSTRAINT banquero FOREIGN KEY (id_banquero) REFERENCES banquero(cedula) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: liga_dep; Type: FK CONSTRAINT; Schema: public; Owner: wwwcrapp
--

ALTER TABLE ONLY liga
    ADD CONSTRAINT liga_dep FOREIGN KEY (id_deporte) REFERENCES deporte(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: auditoria; Type: ACL; Schema: -; Owner: wwwcrapp
--

REVOKE ALL ON SCHEMA auditoria FROM PUBLIC;
REVOKE ALL ON SCHEMA auditoria FROM wwwcrapp;
GRANT ALL ON SCHEMA auditoria TO wwwcrapp;
GRANT ALL ON SCHEMA auditoria TO wwwcrapp_bd;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


SET search_path = auditoria, pg_catalog;

--
-- Name: auditoria; Type: ACL; Schema: auditoria; Owner: wwwcrapp
--

REVOKE ALL ON TABLE auditoria FROM PUBLIC;
REVOKE ALL ON TABLE auditoria FROM wwwcrapp;
GRANT ALL ON TABLE auditoria TO wwwcrapp;
GRANT ALL ON TABLE auditoria TO wwwcrapp_bd;


--
-- Name: auditoria_codigo_seq; Type: ACL; Schema: auditoria; Owner: wwwcrapp
--

REVOKE ALL ON SEQUENCE auditoria_codigo_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE auditoria_codigo_seq FROM wwwcrapp;
GRANT ALL ON SEQUENCE auditoria_codigo_seq TO wwwcrapp;
GRANT ALL ON SEQUENCE auditoria_codigo_seq TO wwwcrapp_bd;


--
-- Name: inicio_sesion; Type: ACL; Schema: auditoria; Owner: wwwcrapp
--

REVOKE ALL ON TABLE inicio_sesion FROM PUBLIC;
REVOKE ALL ON TABLE inicio_sesion FROM wwwcrapp;
GRANT ALL ON TABLE inicio_sesion TO wwwcrapp;
GRANT ALL ON TABLE inicio_sesion TO wwwcrapp_bd;


--
-- Name: inicio_sesion_id_seq; Type: ACL; Schema: auditoria; Owner: wwwcrapp
--

REVOKE ALL ON SEQUENCE inicio_sesion_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE inicio_sesion_id_seq FROM wwwcrapp;
GRANT ALL ON SEQUENCE inicio_sesion_id_seq TO wwwcrapp;
GRANT ALL ON SEQUENCE inicio_sesion_id_seq TO wwwcrapp_bd;


SET search_path = public, pg_catalog;

--
-- Name: agencia; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE agencia FROM PUBLIC;
REVOKE ALL ON TABLE agencia FROM wwwcrapp;
GRANT ALL ON TABLE agencia TO wwwcrapp;
GRANT ALL ON TABLE agencia TO wwwcrapp_bd;


--
-- Name: apuesta; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE apuesta FROM PUBLIC;
REVOKE ALL ON TABLE apuesta FROM wwwcrapp;
GRANT ALL ON TABLE apuesta TO wwwcrapp;
GRANT ALL ON TABLE apuesta TO wwwcrapp_bd;


--
-- Name: apuesta_detalle; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE apuesta_detalle FROM PUBLIC;
REVOKE ALL ON TABLE apuesta_detalle FROM wwwcrapp;
GRANT ALL ON TABLE apuesta_detalle TO wwwcrapp;
GRANT ALL ON TABLE apuesta_detalle TO wwwcrapp_bd;


--
-- Name: logro_basquetbol; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE logro_basquetbol FROM PUBLIC;
REVOKE ALL ON TABLE logro_basquetbol FROM wwwcrapp;
GRANT ALL ON TABLE logro_basquetbol TO wwwcrapp;
GRANT ALL ON TABLE logro_basquetbol TO wwwcrapp_bd;


--
-- Name: resultado_basquetbol; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE resultado_basquetbol FROM PUBLIC;
REVOKE ALL ON TABLE resultado_basquetbol FROM wwwcrapp;
GRANT ALL ON TABLE resultado_basquetbol TO wwwcrapp;
GRANT ALL ON TABLE resultado_basquetbol TO wwwcrapp_bd;


--
-- Name: apuesta_basquetbol_resultado; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE apuesta_basquetbol_resultado FROM PUBLIC;
REVOKE ALL ON TABLE apuesta_basquetbol_resultado FROM wwwcrapp;
GRANT ALL ON TABLE apuesta_basquetbol_resultado TO wwwcrapp;
GRANT ALL ON TABLE apuesta_basquetbol_resultado TO wwwcrapp_bd;


--
-- Name: logro_beisbol; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE logro_beisbol FROM PUBLIC;
REVOKE ALL ON TABLE logro_beisbol FROM wwwcrapp;
GRANT ALL ON TABLE logro_beisbol TO wwwcrapp;
GRANT ALL ON TABLE logro_beisbol TO wwwcrapp_bd;


--
-- Name: resultado_beisbol; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE resultado_beisbol FROM PUBLIC;
REVOKE ALL ON TABLE resultado_beisbol FROM wwwcrapp;
GRANT ALL ON TABLE resultado_beisbol TO wwwcrapp;
GRANT ALL ON TABLE resultado_beisbol TO wwwcrapp_bd;


--
-- Name: apuesta_beisbol_resultado; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE apuesta_beisbol_resultado FROM PUBLIC;
REVOKE ALL ON TABLE apuesta_beisbol_resultado FROM wwwcrapp;
GRANT ALL ON TABLE apuesta_beisbol_resultado TO wwwcrapp;
GRANT ALL ON TABLE apuesta_beisbol_resultado TO wwwcrapp_bd;


--
-- Name: apuesta_detalle_id_seq; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON SEQUENCE apuesta_detalle_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE apuesta_detalle_id_seq FROM wwwcrapp;
GRANT ALL ON SEQUENCE apuesta_detalle_id_seq TO wwwcrapp;
GRANT ALL ON SEQUENCE apuesta_detalle_id_seq TO wwwcrapp_bd;


--
-- Name: logro_futbol; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE logro_futbol FROM PUBLIC;
REVOKE ALL ON TABLE logro_futbol FROM wwwcrapp;
GRANT ALL ON TABLE logro_futbol TO wwwcrapp;
GRANT ALL ON TABLE logro_futbol TO wwwcrapp_bd;


--
-- Name: resultado_futbol; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE resultado_futbol FROM PUBLIC;
REVOKE ALL ON TABLE resultado_futbol FROM wwwcrapp;
GRANT ALL ON TABLE resultado_futbol TO wwwcrapp;
GRANT ALL ON TABLE resultado_futbol TO wwwcrapp_bd;


--
-- Name: apuesta_futbol_resultado; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE apuesta_futbol_resultado FROM PUBLIC;
REVOKE ALL ON TABLE apuesta_futbol_resultado FROM wwwcrapp;
GRANT ALL ON TABLE apuesta_futbol_resultado TO wwwcrapp;
GRANT ALL ON TABLE apuesta_futbol_resultado TO wwwcrapp_bd;


--
-- Name: banquero; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE banquero FROM PUBLIC;
REVOKE ALL ON TABLE banquero FROM wwwcrapp;
GRANT ALL ON TABLE banquero TO wwwcrapp;
GRANT ALL ON TABLE banquero TO wwwcrapp_bd;


--
-- Name: deporte; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE deporte FROM PUBLIC;
REVOKE ALL ON TABLE deporte FROM wwwcrapp;
GRANT ALL ON TABLE deporte TO wwwcrapp;
GRANT ALL ON TABLE deporte TO wwwcrapp_bd;


--
-- Name: empresa; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE empresa FROM PUBLIC;
REVOKE ALL ON TABLE empresa FROM wwwcrapp;
GRANT ALL ON TABLE empresa TO wwwcrapp;
GRANT ALL ON TABLE empresa TO wwwcrapp_bd;


--
-- Name: estado; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE estado FROM PUBLIC;
REVOKE ALL ON TABLE estado FROM wwwcrapp;
GRANT ALL ON TABLE estado TO wwwcrapp;
GRANT ALL ON TABLE estado TO wwwcrapp_bd;


--
-- Name: liga; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE liga FROM PUBLIC;
REVOKE ALL ON TABLE liga FROM wwwcrapp;
GRANT ALL ON TABLE liga TO wwwcrapp;
GRANT ALL ON TABLE liga TO wwwcrapp_bd;


--
-- Name: logro_boxeo; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE logro_boxeo FROM PUBLIC;
REVOKE ALL ON TABLE logro_boxeo FROM wwwcrapp;
GRANT ALL ON TABLE logro_boxeo TO wwwcrapp;
GRANT ALL ON TABLE logro_boxeo TO wwwcrapp_bd;


--
-- Name: logro_formula1; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE logro_formula1 FROM PUBLIC;
REVOKE ALL ON TABLE logro_formula1 FROM wwwcrapp;
GRANT ALL ON TABLE logro_formula1 TO wwwcrapp;
GRANT ALL ON TABLE logro_formula1 TO wwwcrapp_bd;


--
-- Name: logro_futbol_americano; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE logro_futbol_americano FROM PUBLIC;
REVOKE ALL ON TABLE logro_futbol_americano FROM wwwcrapp;
GRANT ALL ON TABLE logro_futbol_americano TO wwwcrapp;
GRANT ALL ON TABLE logro_futbol_americano TO wwwcrapp_bd;


--
-- Name: logro_hockey; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE logro_hockey FROM PUBLIC;
REVOKE ALL ON TABLE logro_hockey FROM wwwcrapp;
GRANT ALL ON TABLE logro_hockey TO wwwcrapp;
GRANT ALL ON TABLE logro_hockey TO wwwcrapp_bd;


--
-- Name: logro_tennis; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE logro_tennis FROM PUBLIC;
REVOKE ALL ON TABLE logro_tennis FROM wwwcrapp;
GRANT ALL ON TABLE logro_tennis TO wwwcrapp;
GRANT ALL ON TABLE logro_tennis TO wwwcrapp_bd;


--
-- Name: menu; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE menu FROM PUBLIC;
REVOKE ALL ON TABLE menu FROM wwwcrapp;
GRANT ALL ON TABLE menu TO wwwcrapp;
GRANT ALL ON TABLE menu TO wwwcrapp_bd;


--
-- Name: perfil; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE perfil FROM PUBLIC;
REVOKE ALL ON TABLE perfil FROM wwwcrapp;
GRANT ALL ON TABLE perfil TO wwwcrapp;
GRANT ALL ON TABLE perfil TO wwwcrapp_bd;


--
-- Name: resultado_boxeo; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE resultado_boxeo FROM PUBLIC;
REVOKE ALL ON TABLE resultado_boxeo FROM wwwcrapp;
GRANT ALL ON TABLE resultado_boxeo TO wwwcrapp;
GRANT ALL ON TABLE resultado_boxeo TO wwwcrapp_bd;


--
-- Name: resultado_formula1; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE resultado_formula1 FROM PUBLIC;
REVOKE ALL ON TABLE resultado_formula1 FROM wwwcrapp;
GRANT ALL ON TABLE resultado_formula1 TO wwwcrapp;
GRANT ALL ON TABLE resultado_formula1 TO wwwcrapp_bd;


--
-- Name: resultado_futbol_americano; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE resultado_futbol_americano FROM PUBLIC;
REVOKE ALL ON TABLE resultado_futbol_americano FROM wwwcrapp;
GRANT ALL ON TABLE resultado_futbol_americano TO wwwcrapp;
GRANT ALL ON TABLE resultado_futbol_americano TO wwwcrapp_bd;


--
-- Name: resultado_hockey; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE resultado_hockey FROM PUBLIC;
REVOKE ALL ON TABLE resultado_hockey FROM wwwcrapp;
GRANT ALL ON TABLE resultado_hockey TO wwwcrapp;
GRANT ALL ON TABLE resultado_hockey TO wwwcrapp_bd;


--
-- Name: resultado_tennis; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE resultado_tennis FROM PUBLIC;
REVOKE ALL ON TABLE resultado_tennis FROM wwwcrapp;
GRANT ALL ON TABLE resultado_tennis TO wwwcrapp;
GRANT ALL ON TABLE resultado_tennis TO wwwcrapp_bd;


--
-- Name: usuario; Type: ACL; Schema: public; Owner: wwwcrapp
--

REVOKE ALL ON TABLE usuario FROM PUBLIC;
REVOKE ALL ON TABLE usuario FROM wwwcrapp;
GRANT ALL ON TABLE usuario TO wwwcrapp;
GRANT ALL ON TABLE usuario TO wwwcrapp_bd;


--
-- PostgreSQL database dump complete
--

