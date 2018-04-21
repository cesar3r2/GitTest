--
-- PostgreSQL database dump
--

-- Dumped from database version 9.0.4
-- Dumped by pg_dump version 9.0.4
-- Started on 2016-07-10 12:48:59

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 6 (class 2615 OID 85644)
-- Name: auditoria; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA auditoria;


ALTER SCHEMA auditoria OWNER TO admin;

--
-- TOC entry 385 (class 2612 OID 11574)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE OR REPLACE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- TOC entry 19 (class 1255 OID 93902)
-- Dependencies: 7
-- Name: procesar_apuestas_detalles(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION procesar_apuestas_detalles() RETURNS void
    LANGUAGE sql
    AS $$/* ===== BEISBOL ===== */
-- GANADOR
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo!=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

-- RUNLINE
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runline1', 'runline2') and a.equipo=c.runline and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runline1', 'runline2') and a.equipo!=c.runline and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

-- SUPER RUNLINE
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('srunline1', 'srunline2') and a.equipo=c.srunline and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('srunline1', 'srunline2') and a.equipo!=c.srunline and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

-- ALTA
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja1' and c.total_carreras>b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja2' and c.total_carreras>b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

-- BAJA
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja2' and c.total_carreras<b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja1' and c.total_carreras<b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

-- ALTABAJA ANULADA
update apuesta_detalle set estatus='ANULADA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('altabaja1', 'altabaja2') and c.total_carreras=b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

--GANAR MITAD
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('g_mediojuego1', 'g_mediojuego2') and a.equipo=c.g_mediojuego and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('g_mediojuego1', 'g_mediojuego2') and a.equipo!=c.g_mediojuego and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

-- RUNLINE MITAD
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runlinem1', 'runlinem2') and a.equipo=c.runlinem and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runlinem1', 'runlinem2') and a.equipo!=c.runlinem and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

-- ALTA MITAD
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='ab_mediojuego1' and c.total_carreras_5to>b.v_ab_mediojuego and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='ab_mediojuego2' and c.total_carreras_5to>b.v_ab_mediojuego and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

-- BAJA MITAD
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='ab_mediojuego2' and c.total_carreras_5to<b.v_ab_mediojuego and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='ab_mediojuego1' and c.total_carreras_5to<b.v_ab_mediojuego and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

-- ALTABAJA MITAD ANULADA
update apuesta_detalle set estatus='ANULADA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ab_mediojuego1', 'ab_mediojuego2') and c.total_carreras_5to=b.v_ab_mediojuego and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

-- PRIMER INNING SI
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='p_inning1' and c.p_inning='SI' and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='p_inning2' and c.p_inning='SI' and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

-- PRIMER INNING NO
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='p_inning2' and c.p_inning='NO' and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='p_inning1' and c.p_inning='NO' and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

-- ANOTAR PRIMERO
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('p_anotar1', 'p_anotar2') and a.equipo=c.p_anotar and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('p_anotar1', 'p_anotar2') and a.equipo!=c.p_anotar and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

/* ===== BASQUETBOL ===== */
-- GANADOR
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo!=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

-- RUNLINE
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runline1', 'runline2') and a.equipo=c.runline and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runline1', 'runline2') and a.equipo!=c.runline and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

-- ALTA
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja1' and c.total_puntos>b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja2' and c.total_puntos>b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

-- BAJA
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja2' and c.total_puntos<b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja1' and c.total_puntos<b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

-- ALTABAJA ANULADA
update apuesta_detalle set estatus='ANULADA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('altabaja1', 'altabaja2') and c.total_puntos=b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

-- GANADOR MITAD
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganadorm1', 'ganadorm2') and a.equipo=c.ganadorm and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganadorm1', 'ganadorm2') and a.equipo!=c.ganadorm and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

-- RUNLINE MITAD
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runlinem1', 'runlinem2') and a.equipo=c.runlinem and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runlinem1', 'runlinem2') and a.equipo!=c.runlinem and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

-- ALTA MITAD
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabajam1' and c.total_puntosm>b.v_altabaja_m and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabajam2' and c.total_puntosm>b.v_altabaja_m and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

-- BAJA MITAD
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabajam2' and c.total_puntosm<b.v_altabaja_m and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabajam1' and c.total_puntosm<b.v_altabaja_m and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

-- ALTABAJA MITAD ANULADA
update apuesta_detalle set estatus='ANULADA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('altabajam1', 'altabajam2') and c.total_puntosm=b.v_altabaja_m and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

/* ===== FUTBOL ===== */
-- GANADOR
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol b, resultado_futbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='3');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol b, resultado_futbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo!=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='3');

-- EMPATE
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol b, resultado_futbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='empate' and c.ganador='EMPATE' and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='3');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol b, resultado_futbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='empate' and c.ganador!='EMPATE' and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='3');

-- RUNLINE
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol b, resultado_futbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runline1', 'runline2') and a.equipo=c.runline and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='3');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol b, resultado_futbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runline1', 'runline2') and a.equipo!=c.runline and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='3');

-- ALTA
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol b, resultado_futbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja1' and c.total_goles>b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='3');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol b, resultado_futbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja2' and c.total_goles>b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='3');

-- BAJA
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol b, resultado_futbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja2' and c.total_goles<b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='3');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol b, resultado_futbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja1' and c.total_goles<b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='3');

-- ALTABAJA ANULADA
update apuesta_detalle set estatus='ANULADA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol b, resultado_futbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('altabaja1', 'altabaja2') and c.total_goles=b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='3');

/* ===== FUTBOL AMERICANO ===== */
-- GANADOR
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol_americano b, resultado_futbol_americano c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='4');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol_americano b, resultado_futbol_americano c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo!=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='4');

-- RUNLINE
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol_americano b, resultado_futbol_americano c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runline1', 'runline2') and a.equipo=c.runline and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='4');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol_americano b, resultado_futbol_americano c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runline1', 'runline2') and a.equipo!=c.runline and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='4');

-- ALTA
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol_americano b, resultado_futbol_americano c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja1' and c.total_goles>b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='4');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol_americano b, resultado_futbol_americano c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja2' and c.total_goles>b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='4');

-- BAJA
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol_americano b, resultado_futbol_americano c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja2' and c.total_goles<b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='4');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol_americano b, resultado_futbol_americano c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja1' and c.total_goles<b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='4');

-- ALTABAJA ANULADA
update apuesta_detalle set estatus='ANULADA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol_americano b, resultado_futbol_americano c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('altabaja1', 'altabaja2') and c.total_goles=b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='4');

/* ===== HOCKEY ===== */
-- GANADOR
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_hockey b, resultado_hockey c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='5');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_hockey b, resultado_hockey c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo!=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='5');

-- RUNLINE
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_hockey b, resultado_hockey c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runline1', 'runline2') and a.equipo=c.runline and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='5');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_hockey b, resultado_hockey c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runline1', 'runline2') and a.equipo!=c.runline and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='5');

-- ALTA
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_hockey b, resultado_hockey c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja1' and c.total_goles>b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='5');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_hockey b, resultado_hockey c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja2' and c.total_goles>b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='5');

-- BAJA
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_hockey b, resultado_hockey c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja2' and c.total_goles<b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='5');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_hockey b, resultado_hockey c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja1' and c.total_goles<b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='5');

-- ALTABAJA ANULADA
update apuesta_detalle set estatus='ANULADA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_hockey b, resultado_hockey c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('altabaja1', 'altabaja2') and c.total_goles=b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='5');

/* ===== TENNIS ===== */
-- GANADOR
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_tennis b, resultado_tennis c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='6');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_tennis b, resultado_tennis c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo!=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='6');

/* ===== BOXEO ===== */
-- GANADOR
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_boxeo b, resultado_boxeo c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='7');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_boxeo b, resultado_boxeo c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo!=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='7');

/* ===== FÓRMULA 1 ===== */
-- GANADOR
update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_formula1 b, resultado_formula1 c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2', 'ganador3', 'ganador4', 'ganador5', 'ganador6', 'ganador7', 'ganador8', 'ganador9', 'ganador10', 'ganador11', 'ganador12', 'ganador13', 'ganador14', 'ganador15', 'ganador16', 'ganador17', 'ganador18', 'ganador19', 'ganador20', 'ganador21', 'ganador22', 'ganador23', 'ganador24') and a.equipo=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='8');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_formula1 b, resultado_formula1 c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2', 'ganador3', 'ganador4', 'ganador5', 'ganador6', 'ganador7', 'ganador8', 'ganador9', 'ganador10', 'ganador11', 'ganador12', 'ganador13', 'ganador14', 'ganador15', 'ganador16', 'ganador17', 'ganador18', 'ganador19', 'ganador20', 'ganador21', 'ganador22', 'ganador23', 'ganador24') and a.equipo!=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='8');$$;


ALTER FUNCTION public.procesar_apuestas_detalles() OWNER TO admin;

SET search_path = auditoria, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1577 (class 1259 OID 85645)
-- Dependencies: 6
-- Name: auditoria; Type: TABLE; Schema: auditoria; Owner: admin; Tablespace: 
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


ALTER TABLE auditoria.auditoria OWNER TO admin;

--
-- TOC entry 1578 (class 1259 OID 85651)
-- Dependencies: 1577 6
-- Name: auditoria_codigo_seq; Type: SEQUENCE; Schema: auditoria; Owner: admin
--

CREATE SEQUENCE auditoria_codigo_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auditoria.auditoria_codigo_seq OWNER TO admin;

--
-- TOC entry 2029 (class 0 OID 0)
-- Dependencies: 1578
-- Name: auditoria_codigo_seq; Type: SEQUENCE OWNED BY; Schema: auditoria; Owner: admin
--

ALTER SEQUENCE auditoria_codigo_seq OWNED BY auditoria.codigo;


--
-- TOC entry 2030 (class 0 OID 0)
-- Dependencies: 1578
-- Name: auditoria_codigo_seq; Type: SEQUENCE SET; Schema: auditoria; Owner: admin
--

SELECT pg_catalog.setval('auditoria_codigo_seq', 2609, true);


--
-- TOC entry 1579 (class 1259 OID 85653)
-- Dependencies: 6
-- Name: inicio_sesion; Type: TABLE; Schema: auditoria; Owner: admin; Tablespace: 
--

CREATE TABLE inicio_sesion (
    id integer NOT NULL,
    usuario character varying(25) NOT NULL,
    fecha date NOT NULL,
    hora time without time zone NOT NULL,
    ip character varying(15)
);


ALTER TABLE auditoria.inicio_sesion OWNER TO admin;

--
-- TOC entry 1580 (class 1259 OID 85656)
-- Dependencies: 6 1579
-- Name: incio_sesion_id_seq; Type: SEQUENCE; Schema: auditoria; Owner: admin
--

CREATE SEQUENCE incio_sesion_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auditoria.incio_sesion_id_seq OWNER TO admin;

--
-- TOC entry 2031 (class 0 OID 0)
-- Dependencies: 1580
-- Name: incio_sesion_id_seq; Type: SEQUENCE OWNED BY; Schema: auditoria; Owner: admin
--

ALTER SEQUENCE incio_sesion_id_seq OWNED BY inicio_sesion.id;


--
-- TOC entry 2032 (class 0 OID 0)
-- Dependencies: 1580
-- Name: incio_sesion_id_seq; Type: SEQUENCE SET; Schema: auditoria; Owner: admin
--

SELECT pg_catalog.setval('incio_sesion_id_seq', 47, true);


SET search_path = public, pg_catalog;

--
-- TOC entry 1581 (class 1259 OID 85658)
-- Dependencies: 1893 1894 1895 7
-- Name: agencia; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE agencia (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    ci_rif character varying(15),
    direccion text,
    telefono character varying(12),
    correo character varying(50),
    id_estado character varying(5),
    ciudad character varying(50),
    disponible double precision,
    id_banquero character varying(10) NOT NULL,
    premio_max double precision DEFAULT 0,
    porcentaje_venta double precision DEFAULT 0,
    porcentaje_utilidad double precision DEFAULT 0,
    estatus character varying(10),
    porcentaje_derecho double precision,
    monto_max double precision,
    monto_derecho double precision,
    id_grupo character varying(5),
    monto_min double precision
);


ALTER TABLE public.agencia OWNER TO admin;

--
-- TOC entry 1582 (class 1259 OID 85667)
-- Dependencies: 7
-- Name: apuesta; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
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
    id_agencia integer NOT NULL,
    usuario character varying(20)
);


ALTER TABLE public.apuesta OWNER TO admin;

--
-- TOC entry 1583 (class 1259 OID 85670)
-- Dependencies: 7
-- Name: apuesta_detalle; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE apuesta_detalle (
    id integer NOT NULL,
    id_apuesta real NOT NULL,
    id_deporte real,
    id_logro real,
    campo_logro character varying(20),
    equipo character varying(100),
    nro_logro character varying(5),
    descripcion_logro character varying(100),
    estatus character varying(10) NOT NULL
);


ALTER TABLE public.apuesta_detalle OWNER TO admin;

--
-- TOC entry 1608 (class 1259 OID 85921)
-- Dependencies: 7
-- Name: logro_beisbol; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
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
    srunline1 character varying(5),
    srunline2 character varying(5),
    v_srunline double precision,
    altabaja1 character varying(5),
    altabaja2 character varying(5),
    v_altabaja double precision,
    g_mediojuego1 character varying(5),
    g_mediojuego2 character varying(5),
    runline_m1 character varying(5),
    runline_m2 character varying(5),
    v_runline_m double precision,
    ab_mediojuego1 character varying(5),
    ab_mediojuego2 character varying(5),
    v_ab_mediojuego double precision,
    p_inning1 character varying(5),
    p_inning2 character varying(5),
    p_anotar1 character varying(5),
    p_anotar2 character varying(5),
    estatus character varying(10) NOT NULL,
    id_liga real NOT NULL
);


ALTER TABLE public.logro_beisbol OWNER TO admin;

--
-- TOC entry 1611 (class 1259 OID 93870)
-- Dependencies: 7
-- Name: resultado_beisbol; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE resultado_beisbol (
    id real NOT NULL,
    id_logro real NOT NULL,
    encuentro character varying(50),
    fecha date NOT NULL,
    ganador character varying(100),
    runline character varying(50),
    srunline character varying(50),
    marcador character varying(10),
    total_carreras integer,
    g_mediojuego character varying(50),
    runlinem character varying(50),
    marcadorm character varying(10),
    total_carreras_5to integer,
    p_inning character varying(50),
    p_anotar character varying(50),
    estatus character varying(15) NOT NULL
);


ALTER TABLE public.resultado_beisbol OWNER TO admin;

--
-- TOC entry 1612 (class 1259 OID 93896)
-- Dependencies: 1699 7
-- Name: apuesta_beisbol; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW apuesta_beisbol AS
    SELECT a.id AS id_det, a.id_apuesta AS id_apu, a.id_deporte, a.id_logro, a.campo_logro, a.equipo, a.descripcion_logro, a.estatus AS estatus_apu, b.id AS id_log, b.v_runline, b.v_srunline, b.v_altabaja, b.v_runline_m, b.v_ab_mediojuego, b.estatus AS estatus_log, c.id AS id_res, c.encuentro, c.ganador, c.runline, c.srunline, c.total_carreras, c.g_mediojuego, c.runlinem, c.total_carreras_5to, c.p_inning, c.p_anotar, c.estatus AS estatus_res FROM apuesta_detalle a, logro_beisbol b, resultado_beisbol c WHERE ((a.id_logro = b.id) AND (b.id = c.id_logro));


ALTER TABLE public.apuesta_beisbol OWNER TO admin;

--
-- TOC entry 1584 (class 1259 OID 85695)
-- Dependencies: 1583 7
-- Name: apuesta_detalle_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE apuesta_detalle_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apuesta_detalle_id_seq OWNER TO admin;

--
-- TOC entry 2038 (class 0 OID 0)
-- Dependencies: 1584
-- Name: apuesta_detalle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE apuesta_detalle_id_seq OWNED BY apuesta_detalle.id;


--
-- TOC entry 2039 (class 0 OID 0)
-- Dependencies: 1584
-- Name: apuesta_detalle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('apuesta_detalle_id_seq', 116, true);


--
-- TOC entry 1587 (class 1259 OID 85708)
-- Dependencies: 7
-- Name: banquero; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE banquero (
    cedula character varying(10) NOT NULL,
    nombre character varying(50) NOT NULL,
    direccion text,
    telefono character varying(12),
    correo character varying(50)
);


ALTER TABLE public.banquero OWNER TO admin;

--
-- TOC entry 1588 (class 1259 OID 85714)
-- Dependencies: 7
-- Name: deporte; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE deporte (
    id real NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public.deporte OWNER TO admin;

--
-- TOC entry 1589 (class 1259 OID 85717)
-- Dependencies: 7
-- Name: empresa; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE empresa (
    rif character varying(15) NOT NULL,
    nombre character varying(50) NOT NULL,
    nombre_comercial character varying(50),
    direccion text,
    telefono character varying(12)
);


ALTER TABLE public.empresa OWNER TO admin;

--
-- TOC entry 1590 (class 1259 OID 85723)
-- Dependencies: 7
-- Name: estado; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE estado (
    codigo character varying(5) NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public.estado OWNER TO admin;

--
-- TOC entry 1591 (class 1259 OID 85726)
-- Dependencies: 7
-- Name: grupo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE grupo (
    id character varying(5) NOT NULL,
    id_banquero character varying(10) NOT NULL,
    nombre character varying(20)
);


ALTER TABLE public.grupo OWNER TO admin;

--
-- TOC entry 1592 (class 1259 OID 85729)
-- Dependencies: 7
-- Name: jugada_anulada; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE jugada_anulada (
    id real NOT NULL,
    id_apuesta real NOT NULL,
    id_deporte real NOT NULL,
    id_logro real NOT NULL,
    campo_logro character varying(20),
    equipo character varying(100),
    nro_logro character varying(5),
    descripcion_logro character varying(100),
    estatus character varying(10) NOT NULL
);


ALTER TABLE public.jugada_anulada OWNER TO admin;

--
-- TOC entry 1593 (class 1259 OID 85732)
-- Dependencies: 7
-- Name: liga; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE liga (
    id real NOT NULL,
    id_deporte real NOT NULL,
    nombre character varying(50) NOT NULL,
    pais character varying(100),
    estatus character varying(20)
);


ALTER TABLE public.liga OWNER TO admin;

--
-- TOC entry 1609 (class 1259 OID 93835)
-- Dependencies: 7
-- Name: logro_basquetbol; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
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
    ganadorm1 character varying(5),
    ganadorm2 character varying(5),
    runlinem1 character varying(5),
    runlinem2 character varying(5),
    v_runline_m double precision,
    altabajam1 character varying(5),
    altabajam2 character varying(5),
    v_altabaja_m double precision,
    estatus character varying(10) NOT NULL,
    id_liga real NOT NULL
);


ALTER TABLE public.logro_basquetbol OWNER TO admin;

--
-- TOC entry 1594 (class 1259 OID 85735)
-- Dependencies: 7
-- Name: logro_boxeo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
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


ALTER TABLE public.logro_boxeo OWNER TO admin;

--
-- TOC entry 1595 (class 1259 OID 85738)
-- Dependencies: 7
-- Name: logro_formula1; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
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


ALTER TABLE public.logro_formula1 OWNER TO admin;

--
-- TOC entry 1585 (class 1259 OID 85697)
-- Dependencies: 7
-- Name: logro_futbol; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
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


ALTER TABLE public.logro_futbol OWNER TO admin;

--
-- TOC entry 1596 (class 1259 OID 85744)
-- Dependencies: 7
-- Name: logro_futbol_americano; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
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


ALTER TABLE public.logro_futbol_americano OWNER TO admin;

--
-- TOC entry 1597 (class 1259 OID 85747)
-- Dependencies: 7
-- Name: logro_hockey; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
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


ALTER TABLE public.logro_hockey OWNER TO admin;

--
-- TOC entry 1598 (class 1259 OID 85750)
-- Dependencies: 7
-- Name: logro_tennis; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
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


ALTER TABLE public.logro_tennis OWNER TO admin;

--
-- TOC entry 1599 (class 1259 OID 85753)
-- Dependencies: 7
-- Name: menu; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE menu (
    id integer NOT NULL,
    superior integer NOT NULL,
    descripcion character varying(50),
    enlace character varying(250) NOT NULL,
    nivel integer,
    icono character varying(20)
);


ALTER TABLE public.menu OWNER TO admin;

--
-- TOC entry 1600 (class 1259 OID 85756)
-- Dependencies: 7
-- Name: notificacion; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE notificacion (
    id character varying(5) NOT NULL,
    descripcion text,
    estatus character varying(10)
);


ALTER TABLE public.notificacion OWNER TO admin;

--
-- TOC entry 1601 (class 1259 OID 85762)
-- Dependencies: 7
-- Name: perfil; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE perfil (
    id character varying(2) NOT NULL,
    nombre character varying(20) NOT NULL,
    acceso_menu text
);


ALTER TABLE public.perfil OWNER TO admin;

--
-- TOC entry 1610 (class 1259 OID 93841)
-- Dependencies: 7
-- Name: resultado_basquetbol; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
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
    ganadorm character varying(100),
    runlinem character varying(50),
    total_puntosm integer,
    marcadorm character varying(10),
    estatus character varying(15) NOT NULL
);


ALTER TABLE public.resultado_basquetbol OWNER TO admin;

--
-- TOC entry 1602 (class 1259 OID 85768)
-- Dependencies: 7
-- Name: resultado_boxeo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
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


ALTER TABLE public.resultado_boxeo OWNER TO admin;

--
-- TOC entry 1603 (class 1259 OID 85775)
-- Dependencies: 7
-- Name: resultado_formula1; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
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


ALTER TABLE public.resultado_formula1 OWNER TO admin;

--
-- TOC entry 1586 (class 1259 OID 85700)
-- Dependencies: 7
-- Name: resultado_futbol; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
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


ALTER TABLE public.resultado_futbol OWNER TO admin;

--
-- TOC entry 1604 (class 1259 OID 85778)
-- Dependencies: 7
-- Name: resultado_futbol_americano; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
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


ALTER TABLE public.resultado_futbol_americano OWNER TO admin;

--
-- TOC entry 1605 (class 1259 OID 85781)
-- Dependencies: 7
-- Name: resultado_hockey; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
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


ALTER TABLE public.resultado_hockey OWNER TO admin;

--
-- TOC entry 1606 (class 1259 OID 85784)
-- Dependencies: 7
-- Name: resultado_tennis; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
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


ALTER TABLE public.resultado_tennis OWNER TO admin;

--
-- TOC entry 1607 (class 1259 OID 85787)
-- Dependencies: 1897 7
-- Name: usuario; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
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


ALTER TABLE public.usuario OWNER TO admin;

SET search_path = auditoria, pg_catalog;

--
-- TOC entry 1891 (class 2604 OID 85794)
-- Dependencies: 1578 1577
-- Name: codigo; Type: DEFAULT; Schema: auditoria; Owner: admin
--

ALTER TABLE auditoria ALTER COLUMN codigo SET DEFAULT nextval('auditoria_codigo_seq'::regclass);


--
-- TOC entry 1892 (class 2604 OID 85795)
-- Dependencies: 1580 1579
-- Name: id; Type: DEFAULT; Schema: auditoria; Owner: admin
--

ALTER TABLE inicio_sesion ALTER COLUMN id SET DEFAULT nextval('incio_sesion_id_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- TOC entry 1896 (class 2604 OID 85796)
-- Dependencies: 1584 1583
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE apuesta_detalle ALTER COLUMN id SET DEFAULT nextval('apuesta_detalle_id_seq'::regclass);


SET search_path = auditoria, pg_catalog;

--
-- TOC entry 1991 (class 0 OID 85645)
-- Dependencies: 1577
-- Data for Name: auditoria; Type: TABLE DATA; Schema: auditoria; Owner: admin
--

COPY auditoria (fecha, nombre_disparador, tipo_disparador, nivel_disparador, comando, tabla, sql_realizado, ip, usuario, mac, codigo, hora) FROM stdin;
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-16, 10:16:08, 127.0.0.1)	127.0.0.1	cesar		1	10:16:08
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_futbol(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, empate, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, estatus, id_liga) VALUES (11006, ECU/EEU, ECUADOR, EEUU, 2, 2016-06-16, 21:30:00, 155, 150, 205, -135, -125, 0, -155, 105, 2, ACTIVO, 23)	127.0.0.1	cesar		2	10:16:44
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_futbol(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, empate, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, estatus, id_liga) VALUES (11007, COL/PER, COLOMBIA, PERU, 1, 2016-06-17, 20:00:00, -210, 500, 235, -135, -125, 1, -155, 105, 2, ACTIVO, 23)	127.0.0.1	cesar		3	10:16:44
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_futbol(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, empate, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, estatus, id_liga) VALUES (11008, VEN/ARG, VENEZUELA, ARGENTINA, 2, 2016-06-18, 19:00:00, 800, -400, 400, -125, -125, 1.5, -150, 120, 2.5, ACTIVO, 23)	127.0.0.1	cesar		4	10:16:44
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_futbol(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, empate, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, estatus, id_liga) VALUES (11009, CHI/MEX, CHILE, MEXICO, 2, 2016-06-18, 22:00:00, 180, 160, 200, -110, -120, 0, -140, 120, 2, ACTIVO, 23)	127.0.0.1	cesar		5	10:16:44
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (67, CIN/ATL, CINCINNATI, ATLANTA, D. Straily, M. Wisler, 2, 2016-06-16, 12:10:00, -110, -110, -225, 175, 1.5, -225, 175, 2.5, -120, -120, 8, 100, -150, -110, -110, -225, 175, 0.5, -120, -120, 4, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		6	11:23:39
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (68, PIR/MET, PIRATES, METS, J. Nicasio, B Colon, 2, 2016-06-16, 19:10:00, 105, -125, -205, 165, 1.5, -205, 165, 2.5, -120, -120, 7.5, 105, -165, 105, -125, -205, 165, 0.5, -120, -120, 4, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		7	11:23:39
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (69, MIL/DOD, MILWAUKEE, DODGERS, J. Guerra, S. Kazmir (Z), 2, 2016-06-16, 22:10:00, 130, -160, -170, 130, 1.5, -170, 130, 2.5, -120, -120, 7.5, 105, -165, 130, -160, -170, 130, 0.5, -120, -120, 4, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		8	11:23:39
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (70, NAT/PAD, NATIONALS, PADRES, T Roark, E Johnson, 1, 2016-06-16, 22:10:00, -160, 140, 100, -140, 1.5, 100, -140, 2.5, -120, -120, 8, 100, -150, -160, 140, 100, -140, 0.5, -120, -120, 4, -180, 130, ACTIVO, 1)	127.0.0.1	cesar		9	11:23:39
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (71, SEA/TAM, SEATTLE, TAMPA, J. Paxton (Z), B Snell (z), 2, 2016-06-16, 13:10:00, 100, -120, -210, 170, 1.5, -210, 170, 2.5, -120, -120, 7.5, 105, -165, 100, -120, -210, 170, 0.5, -120, -120, 4, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		10	11:23:39
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (72, TEX/OAK, TEXAS, OAKLAND, C. Lewis, D. Mengden, 1, 2016-06-16, 15:35:00, -125, 105, 135, -175, 1.5, 135, -175, 2.5, -120, -120, 8.5, -105, -145, -125, 105, 135, -175, 0.5, -120, -120, 4.5, -150, 100, ACTIVO, 1)	127.0.0.1	cesar		11	11:23:39
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (73, BAL/BOS, BALTIMORE, BOSTON, T. Wilson, E. Rodriguez (Z), 2, 2016-06-16, 19:10:00, 125, -145, -185, 145, 1.5, -185, 145, 2.5, -120, -120, 9.5, -120, -130, 125, -145, -185, 145, 0.5, -120, -120, 5, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		12	11:23:39
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (74, YAN/MIN, YANKEES, MINNESOTA, C Sabathia (Z), K Gibson, 1, 2016-06-16, 20:10:00, -140, 120, 120, -160, 1.5, 120, -160, 2.5, -120, -120, 8.5, -105, -145, -140, 120, 120, -160, 0.5, -120, -120, 4.5, -160, 110, ACTIVO, 1)	127.0.0.1	cesar		13	11:23:39
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (7, 2016-06-16, 14:13:39, 50, 698.71, PENDIENTE, 27973632, PARLEY, 1, cesar)	127.0.0.1	cesar		59	14:13:39
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (75, DET/KAN, DETROIT, KANSAS, J Verlander, D. Duffy (Z), 1, 2016-06-16, 20:15:00, -120, 100, 140, -180, 1.5, 140, -180, 2.5, -120, -120, 7.5, 105, -165, -120, 100, 140, -180, 0.5, -120, -120, 4, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		14	11:23:39
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (76, TOR/PHI, TORONTO, PHILLIES, J. Happ (Z), A. Nola, 1, 2016-06-16, 19:05:00, -150, 130, 110, -150, 1.5, 110, -150, 2.5, -120, -120, 8, 100, -150, -150, 130, 110, -150, 0.5, -120, -120, 4, -180, 130, ACTIVO, 1)	127.0.0.1	cesar		15	11:23:39
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (1, 2016-06-16, 11:41:29, 50, 700.47, PENDIENTE, 31220092, PARLEY, 1, cesar)	127.0.0.1	cesar		16	11:41:29
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (1, 1, 67, runline1, CINCINNATI, -225, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		17	11:41:29
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (1, 1, 70, srunline2, PADRES, -140, SRLINE(+2,5), PENDIENTE)	127.0.0.1	cesar		18	11:41:29
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (1, 1, 71, runlinem1, SEATTLE, -210, RLMITAD(+0,5), PENDIENTE)	127.0.0.1	cesar		19	11:41:29
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (1, 1, 71, p_inning1, SEA/TAM, 105, 1ERINN(SI), PENDIENTE)	127.0.0.1	cesar		20	11:41:29
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (1, 1, 71, p_anotar2, TAMPA, -115, A1ERO, PENDIENTE)	127.0.0.1	cesar		21	11:41:29
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (2, 2016-06-16, 11:42:08, 50, 609.50, PENDIENTE, 21802062, PARLEY, 1, cesar)	127.0.0.1	cesar		22	11:42:08
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (2, 1, 68, srunline2, METS, 165, SRLINE(-2,5), PENDIENTE)	127.0.0.1	cesar		23	11:42:08
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (2, 1, 69, runline2, DODGERS, 130, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		24	11:42:08
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (2, 1, 70, runlinem1, NATIONALS, 100, RLMITAD(-0,5), PENDIENTE)	127.0.0.1	cesar		25	11:42:08
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (3, 2016-06-16, 11:51:25, 50, 247.54, PENDIENTE, 46524047, PARLEY, 1, cesar)	127.0.0.1	cesar		26	11:51:25
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (3, 1, 67, runlinem1, CINCINNATI, -225, RLMITAD(+0,5), PENDIENTE)	127.0.0.1	cesar		27	11:51:25
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (3, 1, 67, altabaja1, CIN/ATL, -120, AB/ALTA(8,0), PENDIENTE)	127.0.0.1	cesar		28	11:51:25
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (3, 1, 67, p_anotar2, ATLANTA, -115, A1ERO, PENDIENTE)	127.0.0.1	cesar		29	11:51:25
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (4, 2016-06-16, 11:52:35, 50, 729.67, PENDIENTE, 36542968, PARLEY, 1, cesar)	127.0.0.1	cesar		30	11:52:35
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (4, 1, 69, ganador1, MILWAUKEE, 130, GANAR, PENDIENTE)	127.0.0.1	cesar		31	11:52:35
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (4, 1, 71, runlinem2, TAMPA, 170, RLMITAD(-0,5), PENDIENTE)	127.0.0.1	cesar		32	11:52:35
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (4, 1, 72, srunline1, TEXAS, 135, SRLINE(-2,5), PENDIENTE)	127.0.0.1	cesar		33	11:52:35
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, p_inning, g_mediojuego, runlinem, p_anotar, marcador, total_carreras, total_carreras_5to, estatus) VALUES (1,67, CIN/ATL, 2016-06-16, CINCINNATI, CINCINNATI, NO, CINCINNATI, CINCINNATI, 6x0, 6, 3, FINALIZADO)	127.0.0.1	cesar		34	12:17:42
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, p_inning, g_mediojuego, runlinem, p_anotar, marcador, total_carreras, total_carreras_5to, estatus) VALUES (1,67, CIN/ATL, 2016-06-16, CINCINNATI, CINCINNATI, CINCINNATI, NO, CINCINNATI, CINCINNATI, CINCINNATI, 6x0, 6, 3, FINALIZADO)	127.0.0.1	cesar		35	12:18:15
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE resultado_beisbol SET ganador=CINCINNATI, runline=CINCINNATI, srunline=ATLANTA, p_inning=NO, g_mediojuego=CINCINNATI, runlinem=ATLANTA, p_anotar=CINCINNATI, marcador=6x0, total_carreras=6, total_carreras_5to=3, estatus=FINALIZADO WHERE id=1	127.0.0.1	cesar		36	13:13:32
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE resultado_beisbol SET ganador=CINCINNATI, runline=CINCINNATI, srunline=CINCINNATI, p_inning=NO, g_mediojuego=CINCINNATI, runlinem=CINCINNATI, p_anotar=CINCINNATI, marcador=6x0, total_carreras=6, total_carreras_5to=3, estatus=FINALIZADO WHERE id=1	127.0.0.1	cesar		37	13:13:47
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, p_inning, g_mediojuego, runlinem, p_anotar, marcador, total_carreras, total_carreras_5to, estatus) VALUES (2,68, PIR/MET, 2016-06-16, PIRATES, PIRATES, 0, SI, PIRATES, 0, PIRATES, 5x0, 5, 2, FINALIZADO)	127.0.0.1	cesar		38	13:14:31
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE resultado_beisbol SET ganador=PIRATES, runline=PIRATES, srunline=PIRATES, p_inning=SI, g_mediojuego=PIRATES, runlinem=PIRATES, p_anotar=PIRATES, marcador=5x0, total_carreras=5, total_carreras_5to=2, estatus=FINALIZADO WHERE id=2	127.0.0.1	cesar		39	13:14:54
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (5, 2016-06-16, 13:45:43, 50, 1018.48, PENDIENTE, 38092041, PARLEY, 1, cesar)	127.0.0.1	cesar		40	13:45:43
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (5, 1, 68, p_inning1, PIR/MET, 105, 1ERINN(SI), PENDIENTE)	127.0.0.1	cesar		41	13:45:43
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (5, 1, 69, p_inning1, MIL/DOD, 105, 1ERINN(SI), PENDIENTE)	127.0.0.1	cesar		42	13:45:43
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (5, 1, 69, p_anotar2, DODGERS, -115, A1ERO, PENDIENTE)	127.0.0.1	cesar		43	13:45:43
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (5, 1, 70, p_inning2, NAT/PAD, -150, 1ERINN(NO), PENDIENTE)	127.0.0.1	cesar		44	13:45:43
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (5, 1, 70, p_anotar1, NATIONALS, -180, A1ERO, PENDIENTE)	127.0.0.1	cesar		45	13:45:43
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_basquetbol(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, ganadorm1, ganadorm2, runlinem1, runlinem2, v_runline_m, altabajam1, altabajam2, v_altabaja_m, estatus, id_liga) VALUES (1, CHI/MIA, CHICAGO, MIAMI, 2, 2016-06-16, 21:00:00, 200, -250, -110, -110, 5.5, -110, -110, 204.5, 200, -250, -110, -110, 3.5, -110, -110, 104.5, ACTIVO, 4)	127.0.0.1	cesar		46	13:57:58
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_basquetbol(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, ganadorm1, ganadorm2, runlinem1, runlinem2, v_runline_m, altabajam1, altabajam2, v_altabaja_m, estatus, id_liga) VALUES (2, GSW/CLE, GSWARRIORS, CLEVELAND, 2, 2016-06-16, 21:00:00, 125, -145, -110, -110, 2.5, -110, -110, 207.5, 125, -145, -110, -110, 1.5, -110, -110, 107.5, ACTIVO, 4)	127.0.0.1	cesar		47	13:57:58
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_basquetbol(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, ganadorm1, ganadorm2, runlinem1, runlinem2, v_runline_m, altabajam1, altabajam2, v_altabaja_m, estatus, id_liga) VALUES (3, ORL/DAL, ORLANDO, DALLAS, 2, 2016-06-16, 21:00:00, 200, -250, -110, -110, 5.5, -110, -110, 204.5, 200, -250, -110, -110, 3.5, -110, -110, 104.5, ACTIVO, 4)	127.0.0.1	cesar		48	13:57:58
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_basquetbol(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, ganadorm1, ganadorm2, runlinem1, runlinem2, v_runline_m, altabajam1, altabajam2, v_altabaja_m, estatus, id_liga) VALUES (4, IND/LAK, INDIANA, LAKERS, 2, 2016-06-16, 21:00:00, 125, -145, -110, -110, 2.5, -110, -110, 207.5, 125, -145, -110, -110, 1.5, -110, -110, 107.5, ACTIVO, 4)	127.0.0.1	cesar		49	13:57:58
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_basquetbol(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, ganadorm1, ganadorm2, runlinem1, runlinem2, v_runline_m, altabajam1, altabajam2, v_altabaja_m, estatus, id_liga) VALUES (5, TOR/DEN, TORONTO, DENVER, 2, 2016-06-16, 21:00:00, 125, -145, -110, -110, 2.5, -110, -110, 207.5, 125, -145, -110, -110, 1.5, -110, -110, 107.5, ACTIVO, 4)	127.0.0.1	cesar		50	13:57:58
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (6, 2016-06-16, 14:12:06, 50, 2999.36, PENDIENTE, 29662780, PARLEY, 1, cesar)	127.0.0.1	cesar		51	14:12:06
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (6, 2, 1, ganadorm2, MIAMI, -250, GMITAD, PENDIENTE)	127.0.0.1	cesar		52	14:12:06
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (6, 2, 2, altabaja2, GSW/CLE, -110, AB/BAJA(207,5), PENDIENTE)	127.0.0.1	cesar		53	14:12:06
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (6, 2, 3, runline2, DALLAS, -110, RLINE(-5,5), PENDIENTE)	127.0.0.1	cesar		54	14:12:06
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (6, 2, 4, ganador2, LAKERS, -145, GANAR, PENDIENTE)	127.0.0.1	cesar		55	14:12:06
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (6, 2, 5, altabajam1, TOR/DEN, -110, ABM/ALTA(207,5), PENDIENTE)	127.0.0.1	cesar		56	14:12:06
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (6, 2, 5, runlinem1, TORONTO, -110, RLMITAD(+1,5), PENDIENTE)	127.0.0.1	cesar		57	14:12:06
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (6, 2, 2, runline1, GSWARRIORS, -110, RLINE(+2,5), PENDIENTE)	127.0.0.1	cesar		58	14:12:06
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (7, 1, 68, ab_mediojuego1, PIR/MET, -120, ABM/ALTA(4,0), PENDIENTE)	127.0.0.1	cesar		60	14:13:39
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (7, 2, 1, runlinem2, MIAMI, -110, RLMITAD(-3,5), PENDIENTE)	127.0.0.1	cesar		61	14:13:39
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (7, 2, 2, ganadorm2, CLEVELAND, -145, GMITAD, PENDIENTE)	127.0.0.1	cesar		62	14:13:39
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (7, 1, 68, srunline1, PIRATES, -205, SRLINE(+2,5), PENDIENTE)	127.0.0.1	cesar		63	14:13:39
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (7, 1, 69, runlinem1, MILWAUKEE, -170, RLMITAD(+0,5), PENDIENTE)	127.0.0.1	cesar		64	14:13:39
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (9, 2016-06-16, 14:18:02, 50, 820.76, PENDIENTE, 40616149, PARLEY, 1, cesar)	127.0.0.1	cesar		69	14:18:02
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (9, 1, 68, p_inning1, PIR/MET, 105, P-INNG(SI), PENDIENTE)	127.0.0.1	cesar		70	14:18:02
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (9, 1, 69, p_anotar1, MILWAUKEE, -135, P-ANOT, PENDIENTE)	127.0.0.1	cesar		71	14:18:02
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (9, 1, 69, ganador1, MILWAUKEE, 130, GANAR, PENDIENTE)	127.0.0.1	cesar		72	14:18:02
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (9, 1, 70, runline1, NATIONALS, 100, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		73	14:18:02
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (11, 2016-06-16, 14:21:13, 50, 2441.81, PENDIENTE, 42953491, PARLEY, 1, cesar)	127.0.0.1	cesar		79	14:21:13
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (11, 1, 68, p_anotar1, PIRATES, -135, P-ANOT, PENDIENTE)	127.0.0.1	cesar		80	14:21:13
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (11, 1, 69, p_inning1, MIL/DOD, 105, P-INNG(SI), PENDIENTE)	127.0.0.1	cesar		81	14:21:13
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (11, 1, 68, altabaja2, PIR/MET, -120, AB/BAJA(7,5), PENDIENTE)	127.0.0.1	cesar		82	14:21:13
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (11, 1, 69, srunline1, MILWAUKEE, -170, SRLINE(+2,5), PENDIENTE)	127.0.0.1	cesar		83	14:21:13
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (11, 1, 70, srunline1, NATIONALS, 100, SRLINE(-2,5), PENDIENTE)	127.0.0.1	cesar		84	14:21:13
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (11, 1, 72, srunline1, TEXAS, 135, SRLINE(-2,5), PENDIENTE)	127.0.0.1	cesar		85	14:21:13
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (8, 2016-06-16, 14:14:49, 50, 255.12, PENDIENTE, 17992553, PARLEY, 1, cesar)	127.0.0.1	cesar		65	14:14:49
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (8, 2, 1, ganadorm2, MIAMI, -250, GMITAD, PENDIENTE)	127.0.0.1	cesar		66	14:14:49
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (8, 2, 2, runline1, GSWARRIORS, -110, RLINE(+2,5), PENDIENTE)	127.0.0.1	cesar		67	14:14:49
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (8, 2, 2, altabaja2, GSW/CLE, -110, AB/BAJA(207,5), PENDIENTE)	127.0.0.1	cesar		68	14:14:49
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (10, 2016-06-16, 14:20:12, 50, 468.97, PENDIENTE, 99222717, PARLEY, 1, cesar)	127.0.0.1	cesar		74	14:20:12
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (10, 1, 68, p_inning1, PIR/MET, 105, P-INNG(SI), PENDIENTE)	127.0.0.1	cesar		75	14:20:12
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (10, 1, 69, p_anotar1, MILWAUKEE, -135, P-ANOT, PENDIENTE)	127.0.0.1	cesar		76	14:20:12
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (10, 1, 70, p_anotar1, NATIONALS, -180, P-ANOT, PENDIENTE)	127.0.0.1	cesar		77	14:20:12
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (10, 1, 72, p_inning2, TEX/OAK, -145, P-INNG(NO), PENDIENTE)	127.0.0.1	cesar		78	14:20:12
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (12, 2016-06-16, 14:21:28, 50, 1463.48, PENDIENTE, 60100402, PARLEY, 1, cesar)	127.0.0.1	cesar		86	14:21:28
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (12, 1, 69, runlinem2, DODGERS, 130, RLMITAD(-0,5), PENDIENTE)	127.0.0.1	cesar		87	14:21:28
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (12, 1, 72, runlinem1, TEXAS, 135, RLMITAD(-0,5), PENDIENTE)	127.0.0.1	cesar		88	14:21:28
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (12, 1, 70, runline2, PADRES, -140, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		89	14:21:28
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (12, 1, 72, p_inning2, TEX/OAK, -145, P-INNG(NO), PENDIENTE)	127.0.0.1	cesar		90	14:21:28
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (12, 1, 73, p_anotar2, BOSTON, -115, P-ANOT, PENDIENTE)	127.0.0.1	cesar		91	14:21:28
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-16, 15:45:26, 127.0.0.1)	127.0.0.1	cesar		92	15:45:26
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (13, 2016-06-16, 15:46:15, 50, 19281.63, PENDIENTE, 43189697, PARLEY, 1, cesar)	127.0.0.1	cesar		93	15:46:15
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (13, 2, 1, ganador1, CHICAGO, 200, GANAR, PENDIENTE)	127.0.0.1	cesar		94	15:46:16
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (13, 2, 2, runline1, GSWARRIORS, -110, RLINE(+2,5), PENDIENTE)	127.0.0.1	cesar		95	15:46:16
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (13, 2, 2, altabaja2, GSW/CLE, -110, AB/BAJA(207,5), PENDIENTE)	127.0.0.1	cesar		96	15:46:16
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (13, 2, 3, ganador1, ORLANDO, 200, GANAR, PENDIENTE)	127.0.0.1	cesar		97	15:46:16
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (13, 2, 4, ganador2, LAKERS, -145, GANAR, PENDIENTE)	127.0.0.1	cesar		98	15:46:16
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (13, 2, 5, runline1, TORONTO, -110, RLINE(+2,5), PENDIENTE)	127.0.0.1	cesar		99	15:46:16
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (13, 2, 4, altabaja1, IND/LAK, -110, AB/ALTA(207,5), PENDIENTE)	127.0.0.1	cesar		100	15:46:16
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (13, 2, 5, altabajam1, TOR/DEN, -110, ABM/ALTA(207,5), PENDIENTE)	127.0.0.1	cesar		101	15:46:16
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (14, 2016-06-16, 15:46:44, 50, 4442.49, PENDIENTE, 22340393, PARLEY, 1, cesar)	127.0.0.1	cesar		102	15:46:44
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (14, 1, 68, runlinem1, PIRATES, -205, RLMITAD(+0,5), PENDIENTE)	127.0.0.1	cesar		103	15:46:44
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (14, 1, 68, altabaja2, PIR/MET, -120, AB/BAJA(7,5), PENDIENTE)	127.0.0.1	cesar		104	15:46:44
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (14, 1, 69, ab_mediojuego2, MIL/DOD, -120, ABM/BAJA(4,0), PENDIENTE)	127.0.0.1	cesar		105	15:46:44
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (14, 1, 70, g_mediojuego1, NATIONALS, -160, GMITAD, PENDIENTE)	127.0.0.1	cesar		106	15:46:44
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (14, 2, 1, ganadorm1, CHICAGO, 200, GMITAD, PENDIENTE)	127.0.0.1	cesar		107	15:46:44
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (14, 2, 2, runlinem1, GSWARRIORS, -110, RLMITAD(+1,5), PENDIENTE)	127.0.0.1	cesar		108	15:46:44
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (14, 2, 2, altabajam2, GSW/CLE, -110, ABM/BAJA(207,5), PENDIENTE)	127.0.0.1	cesar		109	15:46:44
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_basquetbol (id, id_logro, encuentro, fecha, ganador, runline, total_puntos, marcador, ganadorm, runlinem, total_puntosm, marcadorm, estatus) VALUES (1,1, CHI/MIA, 2016-06-16, CHICAGO, CHICAGO, 193, 100x93, CHICAGO, CHICAGO, 108, 59x49, FINALIZADO)	127.0.0.1	cesar		110	16:03:33
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_basquetbol (id, id_logro, encuentro, fecha, ganador, runline, total_puntos, marcador, ganadorm, runlinem, total_puntosm, marcadorm, estatus) VALUES (2,2, GSW/CLE, 2016-06-16, GSWARRIORS, GSWARRIORS, 200, 102x98, GSWARRIORS, CLEVELAND, 101, 49x52, FINALIZADO)	127.0.0.1	cesar		111	16:04:22
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_basquetbol (id, id_logro, encuentro, fecha, ganador, runline, total_puntos, marcador, ganadorm, runlinem, total_puntosm, marcadorm, estatus) VALUES (2,2, GSW/CLE, 2016-06-16, GSWARRIORS, GSWARRIORS, 200, 102x98, CLEVELAND, GSWARRIORS, 99, 49x50, FINALIZADO)	127.0.0.1	cesar		112	16:06:18
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE resultado_basquetbol SET ganador=CHICAGO, runline=CHICAGO, total_puntos=193,  marcador=100x93, ganadorm=EMPATE, runlinem=EMPATE, total_puntosm=98,  marcadorm=49x49, estatus=FINALIZADO WHERE id=1	127.0.0.1	cesar		113	16:19:18
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE resultado_basquetbol SET ganador=GSWARRIORS, runline=GSWARRIORS, total_puntos=200,  marcador=102x98, ganadorm=GSWARRIORS, runlinem=GSWARRIORS, total_puntosm=104,  marcadorm=54x50, estatus=FINALIZADO WHERE id=2	127.0.0.1	cesar		114	16:20:18
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (1,67, CIN/ATL, 2016-06-16, CINCINNATI, CINCINNATI, CINCINNATI, 9x4, 13, CINCINNATI, CINCINNATI, 4x1, 5, SI, CINCINNATI, FINALIZADO)	127.0.0.1	cesar		115	16:37:10
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE resultado_beisbol SET ganador=CINCINNATI, runline=CINCINNATI, srunline=CINCINNATI, p_inning=NO, g_mediojuego=EMPATE, runlinem=EMPATE, p_anotar=CINCINNATI, marcador=19x5, marcadorm=4x4, total_carreras=24, total_carreras_5to=8, estatus=FINALIZADO WHERE id=1	127.0.0.1	cesar		116	16:43:15
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE resultado_beisbol SET ganador=CINCINNATI, runline=CINCINNATI, srunline=CINCINNATI, p_inning=SI, g_mediojuego=CINCINNATI, runlinem=CINCINNATI, p_anotar=CINCINNATI, marcador=19x5, marcadorm=8x4, total_carreras=24, total_carreras_5to=12, estatus=FINALIZADO WHERE id=1	127.0.0.1	cesar		117	16:43:42
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-16, 20:08:48, 127.0.0.1)	127.0.0.1	cesar		118	20:08:48
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (15, 2016-06-16, 20:57:38, 50, 546.69, PENDIENTE, 52239685, PARLEY, 1, cesar)	127.0.0.1	cesar		119	20:57:38
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (15, 2, 1, ganadorm1, CHICAGO, 200, GMITAD, PENDIENTE)	127.0.0.1	cesar		120	20:57:38
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (15, 2, 1, altabaja2, CHI/MIA, -110, AB/BAJA(204,5), PENDIENTE)	127.0.0.1	cesar		121	20:57:38
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (15, 2, 2, altabaja2, GSW/CLE, -110, AB/BAJA(207,5), PENDIENTE)	127.0.0.1	cesar		122	20:57:38
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (20, 6, 2, 1, ganadorm2, MIAMI, -250, GMITAD, PENDIENTE)	127.0.0.1	cesar		123	20:57:56
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (32, 8, 2, 1, ganadorm2, MIAMI, -250, GMITAD, PENDIENTE)	127.0.0.1	cesar		124	20:57:56
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (66, 14, 2, 1, ganadorm1, CHICAGO, 200, GMITAD, PENDIENTE)	127.0.0.1	cesar		125	20:57:56
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (69, 15, 2, 1, ganadorm1, CHICAGO, 200, GMITAD, PENDIENTE)	127.0.0.1	cesar		126	20:57:57
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=20 AND id_apuesta=6	127.0.0.1	cesar		127	20:57:57
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=32 AND id_apuesta=8	127.0.0.1	cesar		128	20:57:57
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=66 AND id_apuesta=14	127.0.0.1	cesar		129	20:57:57
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=69 AND id_apuesta=15	127.0.0.1	cesar		130	20:57:57
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (16, 2016-06-16, 20:58:46, 50, 1095.87, PENDIENTE, 21972351, PARLEY, 1, cesar)	127.0.0.1	cesar		131	20:58:46
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (16, 2, 1, ganadorm2, MIAMI, -250, GMITAD, PENDIENTE)	127.0.0.1	cesar		132	20:58:46
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (16, 2, 1, altabaja2, CHI/MIA, -110, AB/BAJA(204,5), PENDIENTE)	127.0.0.1	cesar		133	20:58:46
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (16, 2, 2, runline2, CLEVELAND, -110, RLINE(-2,5), PENDIENTE)	127.0.0.1	cesar		134	20:58:46
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (16, 2, 3, altabaja1, ORL/DAL, -110, AB/ALTA(204,5), PENDIENTE)	127.0.0.1	cesar		135	20:58:46
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (16, 2, 4, ganador1, INDIANA, 125, GANAR, PENDIENTE)	127.0.0.1	cesar		136	20:58:46
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (20, 6, 2, 1, ganadorm2, MIAMI, -250, GMITAD, PENDIENTE)	127.0.0.1	cesar		137	20:59:31
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (32, 8, 2, 1, ganadorm2, MIAMI, -250, GMITAD, PENDIENTE)	127.0.0.1	cesar		138	20:59:31
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (66, 14, 2, 1, ganadorm1, CHICAGO, 200, GMITAD, PENDIENTE)	127.0.0.1	cesar		139	20:59:31
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (69, 15, 2, 1, ganadorm1, CHICAGO, 200, GMITAD, PENDIENTE)	127.0.0.1	cesar		140	20:59:31
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM jugada_anulada WHERE id=20 AND id_apuesta=6	127.0.0.1	cesar		141	20:59:31
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM jugada_anulada WHERE id=32 AND id_apuesta=8	127.0.0.1	cesar		142	20:59:31
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM jugada_anulada WHERE id=66 AND id_apuesta=14	127.0.0.1	cesar		143	20:59:31
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM jugada_anulada WHERE id=69 AND id_apuesta=15	127.0.0.1	cesar		144	20:59:31
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (72, 16, 2, 1, ganadorm2, MIAMI, -250, GMITAD, PENDIENTE)	127.0.0.1	cesar		145	20:59:46
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (20, 6, 2, 1, ganadorm2, MIAMI, -250, GMITAD, PENDIENTE)	127.0.0.1	cesar		146	20:59:46
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (32, 8, 2, 1, ganadorm2, MIAMI, -250, GMITAD, PENDIENTE)	127.0.0.1	cesar		147	20:59:46
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (66, 14, 2, 1, ganadorm1, CHICAGO, 200, GMITAD, PENDIENTE)	127.0.0.1	cesar		148	20:59:46
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (69, 15, 2, 1, ganadorm1, CHICAGO, 200, GMITAD, PENDIENTE)	127.0.0.1	cesar		149	20:59:46
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=72 AND id_apuesta=16	127.0.0.1	cesar		150	20:59:46
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=20 AND id_apuesta=6	127.0.0.1	cesar		151	20:59:46
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=32 AND id_apuesta=8	127.0.0.1	cesar		152	20:59:46
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=66 AND id_apuesta=14	127.0.0.1	cesar		153	20:59:46
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=69 AND id_apuesta=15	127.0.0.1	cesar		154	20:59:46
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (17, 2016-06-16, 21:02:03, 50, 782.77, PENDIENTE, 85168457, PARLEY, 1, cesar)	127.0.0.1	cesar		155	21:02:03
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (17, 2, 4, ganador1, INDIANA, 125, GANAR, PENDIENTE)	127.0.0.1	cesar		156	21:02:03
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (17, 2, 4, altabaja2, IND/LAK, -110, AB/BAJA(210,0), PENDIENTE)	127.0.0.1	cesar		157	21:02:03
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (17, 2, 5, runline2, DENVER, -110, RLINE(-5,0), PENDIENTE)	127.0.0.1	cesar		158	21:02:03
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (17, 2, 5, altabajam2, TOR/DEN, -110, ABM/BAJA(212,0), PENDIENTE)	127.0.0.1	cesar		159	21:02:03
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (18, 2016-06-16, 21:02:28, 50, 782.77, PENDIENTE, 23746643, PARLEY, 1, cesar)	127.0.0.1	cesar		160	21:02:28
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (18, 2, 4, ganador1, INDIANA, 125, GANAR, PENDIENTE)	127.0.0.1	cesar		161	21:02:28
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (18, 2, 4, altabaja2, IND/LAK, -110, AB/BAJA(210,0), PENDIENTE)	127.0.0.1	cesar		162	21:02:28
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (18, 2, 5, runline2, DENVER, -110, RLINE(-5,0), PENDIENTE)	127.0.0.1	cesar		163	21:02:28
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (18, 2, 5, altabaja2, TOR/DEN, -110, AB/BAJA(212,0), PENDIENTE)	127.0.0.1	cesar		164	21:02:28
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (19, 2016-06-16, 21:02:42, 50, 2348.30, PENDIENTE, 75750427, PARLEY, 1, cesar)	127.0.0.1	cesar		165	21:02:42
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (19, 2, 3, ganador1, ORLANDO, 200, GANAR, PENDIENTE)	127.0.0.1	cesar		166	21:02:42
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (19, 2, 4, runline1, INDIANA, -110, RLINE(+6,0), PENDIENTE)	127.0.0.1	cesar		167	21:02:42
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (19, 2, 4, altabaja2, IND/LAK, -110, AB/BAJA(210,0), PENDIENTE)	127.0.0.1	cesar		168	21:02:42
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (19, 2, 5, ganador1, TORONTO, 125, GANAR, PENDIENTE)	127.0.0.1	cesar		169	21:02:42
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (19, 2, 5, altabaja2, TOR/DEN, -110, AB/BAJA(212,0), PENDIENTE)	127.0.0.1	cesar		170	21:02:42
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (20, 2016-06-16, 21:02:58, 50, 3619.92, PENDIENTE, 58040466, PARLEY, 1, cesar)	127.0.0.1	cesar		171	21:02:58
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (20, 2, 1, runline1, CHICAGO, -110, RLINE(+5,5), PENDIENTE)	127.0.0.1	cesar		172	21:02:58
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (20, 2, 2, ganador2, CLEVELAND, -145, GANAR, PENDIENTE)	127.0.0.1	cesar		173	21:02:58
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (20, 2, 3, runline1, ORLANDO, -110, RLINE(+5,5), PENDIENTE)	127.0.0.1	cesar		174	21:02:58
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (20, 2, 4, ganador2, LAKERS, -145, GANAR, PENDIENTE)	127.0.0.1	cesar		175	21:02:58
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (20, 2, 4, altabajam1, IND/LAK, -110, ABM/ALTA(210,0), PENDIENTE)	127.0.0.1	cesar		176	21:02:58
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (20, 2, 5, altabajam1, TOR/DEN, -110, ABM/ALTA(212,0), PENDIENTE)	127.0.0.1	cesar		177	21:02:58
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (20, 2, 5, runline1, TORONTO, -110, RLINE(+5,0), PENDIENTE)	127.0.0.1	cesar		178	21:02:58
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (21, 2016-06-16, 21:03:11, 50, 1775.13, PENDIENTE, 54901123, PARLEY, 1, cesar)	127.0.0.1	cesar		179	21:03:11
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (21, 2, 1, runline2, MIAMI, -110, RLINE(-5,5), PENDIENTE)	127.0.0.1	cesar		180	21:03:11
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (21, 2, 3, ganador2, DALLAS, -250, GANAR, PENDIENTE)	127.0.0.1	cesar		181	21:03:11
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (21, 2, 4, runline1, INDIANA, -110, RLINE(+6,0), PENDIENTE)	127.0.0.1	cesar		182	21:03:11
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (21, 2, 4, altabaja2, IND/LAK, -110, AB/BAJA(210,0), PENDIENTE)	127.0.0.1	cesar		183	21:03:11
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (21, 2, 5, runlinem2, DENVER, -110, RLMITAD(-2,0), PENDIENTE)	127.0.0.1	cesar		184	21:03:11
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (21, 2, 5, altabaja2, TOR/DEN, -110, AB/BAJA(212,0), PENDIENTE)	127.0.0.1	cesar		185	21:03:11
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_basquetbol (id, id_logro, encuentro, fecha, ganador, runline, total_puntos, marcador, ganadorm, runlinem, total_puntosm, marcadorm, estatus) VALUES (3,4, IND/LAK, 2016-06-16, INDIANA, INDIANA, 210, 110x100, EMPATE, EMPATE, 103, 53x50, FINALIZADO)	127.0.0.1	cesar		186	21:03:52
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (60, 13, 2, 4, altabaja1, IND/LAK, -110, AB/ALTA(207,5), PENDIENTE)	127.0.0.1	cesar		187	21:04:23
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (78, 17, 2, 4, altabaja2, IND/LAK, -110, AB/BAJA(210,0), PENDIENTE)	127.0.0.1	cesar		188	21:04:23
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (82, 18, 2, 4, altabaja2, IND/LAK, -110, AB/BAJA(210,0), PENDIENTE)	127.0.0.1	cesar		189	21:04:23
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (87, 19, 2, 4, altabaja2, IND/LAK, -110, AB/BAJA(210,0), PENDIENTE)	127.0.0.1	cesar		190	21:04:23
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=8 AND estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		259	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (100, 21, 2, 4, altabaja2, IND/LAK, -110, AB/BAJA(210,0), PENDIENTE)	127.0.0.1	cesar		191	21:04:23
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=60 AND id_apuesta=13	127.0.0.1	cesar		192	21:04:23
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=78 AND id_apuesta=17	127.0.0.1	cesar		193	21:04:23
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=82 AND id_apuesta=18	127.0.0.1	cesar		194	21:04:23
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=87 AND id_apuesta=19	127.0.0.1	cesar		195	21:04:23
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=100 AND id_apuesta=21	127.0.0.1	cesar		196	21:04:23
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (94, 20, 2, 4, altabajam1, IND/LAK, -110, ABM/ALTA(210,0), PENDIENTE)	127.0.0.1	cesar		197	21:05:40
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=94 AND id_apuesta=20	127.0.0.1	cesar		198	21:05:40
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (22, 2016-06-16, 21:07:21, 50, 1494.37, PENDIENTE, 70682983, PARLEY, 1, cesar)	127.0.0.1	cesar		199	21:07:21
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (22, 2, 1, altabajam1, CHI/MIA, -110, ABM/ALTA(104,5), PENDIENTE)	127.0.0.1	cesar		200	21:07:21
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (22, 2, 2, altabajam1, GSW/CLE, -110, ABM/ALTA(107,5), PENDIENTE)	127.0.0.1	cesar		201	21:07:21
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (22, 2, 4, altabajam1, IND/LAK, -110, ABM/ALTA(103,0), PENDIENTE)	127.0.0.1	cesar		202	21:07:21
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (22, 2, 4, runlinem2, LAKERS, -110, RLMITAD(-2,0), PENDIENTE)	127.0.0.1	cesar		203	21:07:21
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (22, 2, 5, ganadorm1, TORONTO, 125, GMITAD, PENDIENTE)	127.0.0.1	cesar		204	21:07:21
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (23, 2016-06-16, 21:07:32, 50, 307.91, PENDIENTE, 47257385, PARLEY, 1, cesar)	127.0.0.1	cesar		205	21:07:32
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (23, 2, 4, ganadorm2, LAKERS, -145, GMITAD, PENDIENTE)	127.0.0.1	cesar		206	21:07:32
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (23, 2, 4, altabajam2, IND/LAK, -110, ABM/BAJA(103,0), PENDIENTE)	127.0.0.1	cesar		207	21:07:32
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (23, 2, 5, runlinem2, DENVER, -110, RLMITAD(-2,0), PENDIENTE)	127.0.0.1	cesar		208	21:07:32
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (24, 2016-06-16, 21:07:47, 50, 1122.21, PENDIENTE, 64404296, PARLEY, 1, cesar)	127.0.0.1	cesar		209	21:07:47
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (24, 2, 4, runlinem2, LAKERS, -110, RLMITAD(-2,0), PENDIENTE)	127.0.0.1	cesar		210	21:07:47
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (24, 2, 5, ganadorm2, DENVER, -145, GMITAD, PENDIENTE)	127.0.0.1	cesar		211	21:07:47
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (24, 2, 3, runline1, ORLANDO, -110, RLINE(+5,5), PENDIENTE)	127.0.0.1	cesar		212	21:07:47
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (24, 2, 1, runline2, MIAMI, -110, RLINE(-5,5), PENDIENTE)	127.0.0.1	cesar		213	21:07:47
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (24, 2, 2, runline1, GSWARRIORS, -110, RLINE(+2,5), PENDIENTE)	127.0.0.1	cesar		214	21:07:47
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (108, 23, 2, 4, ganadorm2, LAKERS, -145, GMITAD, PENDIENTE)	127.0.0.1	cesar		215	21:08:02
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=108 AND id_apuesta=23	127.0.0.1	cesar		216	21:08:02
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (106, 22, 2, 4, runlinem2, LAKERS, -110, RLMITAD(-2,0), PENDIENTE)	127.0.0.1	cesar		217	21:08:23
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (111, 24, 2, 4, runlinem2, LAKERS, -110, RLMITAD(-2,0), PENDIENTE)	127.0.0.1	cesar		218	21:08:23
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=106 AND id_apuesta=22	127.0.0.1	cesar		219	21:08:23
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=111 AND id_apuesta=24	127.0.0.1	cesar		220	21:08:23
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=24 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		258	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (105, 22, 2, 4, altabajam1, IND/LAK, -110, ABM/ALTA(103,0), PENDIENTE)	127.0.0.1	cesar		221	21:08:48
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (109, 23, 2, 4, altabajam2, IND/LAK, -110, ABM/BAJA(103,0), PENDIENTE)	127.0.0.1	cesar		222	21:08:48
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=105 AND id_apuesta=22	127.0.0.1	cesar		223	21:08:48
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=109 AND id_apuesta=23	127.0.0.1	cesar		224	21:08:48
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_basquetbol (id, id_logro, encuentro, fecha, ganador, runline, total_puntos, marcador, ganadorm, runlinem, total_puntosm, marcadorm, estatus) VALUES (4,5, TOR/DEN, 2016-06-16, TORONTO, TORONTO, 220, 120x100, TORONTO, TORONTO, 102, 52x50, FINALIZADO)	127.0.0.1	cesar		225	21:10:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (24, 6, 2, 5, altabajam1, TOR/DEN, -110, ABM/ALTA(207,5), PENDIENTE)	127.0.0.1	cesar		226	21:10:32
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (61, 13, 2, 5, altabajam1, TOR/DEN, -110, ABM/ALTA(207,5), PENDIENTE)	127.0.0.1	cesar		227	21:10:32
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (80, 17, 2, 5, altabajam2, TOR/DEN, -110, ABM/BAJA(212,0), PENDIENTE)	127.0.0.1	cesar		228	21:10:32
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (95, 20, 2, 5, altabajam1, TOR/DEN, -110, ABM/ALTA(212,0), PENDIENTE)	127.0.0.1	cesar		229	21:10:32
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=24 AND id_apuesta=6	127.0.0.1	cesar		230	21:10:32
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=61 AND id_apuesta=13	127.0.0.1	cesar		231	21:10:32
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=80 AND id_apuesta=17	127.0.0.1	cesar		232	21:10:32
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=95 AND id_apuesta=20	127.0.0.1	cesar		233	21:10:32
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE fecha=2016-06-16 AND estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		234	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=1 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		235	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=2 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		236	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=3 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		237	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=4 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		238	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=5 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		239	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=6 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		240	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=7 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		241	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=8 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		242	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=9 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		243	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=10 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		244	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=11 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		245	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=12 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		246	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=13 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		247	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=14 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		248	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=15 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		249	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=16 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		250	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=17 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		251	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=18 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		252	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=19 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		253	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=20 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		254	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=21 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		255	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=22 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		256	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=23 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		257	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=GANADORA WHERE id_apuesta=8 AND estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		260	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=15 AND estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		261	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=GANADORA WHERE id_apuesta=15 AND estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		262	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE fecha=2016-06-16 AND estatus=PENDIENTE	127.0.0.1	cesar		263	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=1 AND estatus=PENDIENTE	127.0.0.1	cesar		264	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=2 AND estatus=PENDIENTE	127.0.0.1	cesar		265	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=3 AND estatus=PENDIENTE	127.0.0.1	cesar		266	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=4 AND estatus=PENDIENTE	127.0.0.1	cesar		267	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=5 AND estatus=PENDIENTE	127.0.0.1	cesar		268	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=6 AND estatus=PENDIENTE	127.0.0.1	cesar		269	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=7 AND estatus=PENDIENTE	127.0.0.1	cesar		270	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=8 AND estatus=PENDIENTE	127.0.0.1	cesar		271	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=9 AND estatus=PENDIENTE	127.0.0.1	cesar		272	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=10 AND estatus=PENDIENTE	127.0.0.1	cesar		273	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=11 AND estatus=PENDIENTE	127.0.0.1	cesar		274	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=12 AND estatus=PENDIENTE	127.0.0.1	cesar		275	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=13 AND estatus=PENDIENTE	127.0.0.1	cesar		276	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=14 AND estatus=PENDIENTE	127.0.0.1	cesar		277	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=15 AND estatus=PENDIENTE	127.0.0.1	cesar		278	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=16 AND estatus=PENDIENTE	127.0.0.1	cesar		279	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=17 AND estatus=PENDIENTE	127.0.0.1	cesar		280	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=18 AND estatus=PENDIENTE	127.0.0.1	cesar		281	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=19 AND estatus=PENDIENTE	127.0.0.1	cesar		282	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=20 AND estatus=PENDIENTE	127.0.0.1	cesar		283	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=21 AND estatus=PENDIENTE	127.0.0.1	cesar		284	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=22 AND estatus=PENDIENTE	127.0.0.1	cesar		285	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=23 AND estatus=PENDIENTE	127.0.0.1	cesar		286	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=24 AND estatus=PENDIENTE	127.0.0.1	cesar		287	21:12:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE resultado_beisbol SET ganador=CINCINNATI, runline=CINCINNATI, srunline=CINCINNATI, p_inning=SI, g_mediojuego=CINCINNATI, runlinem=CINCINNATI, p_anotar=CINCINNATI, marcador=8x0, marcadorm=4x0, total_carreras=8, total_carreras_5to=4, estatus=FINALIZADO WHERE id=1	127.0.0.1	cesar		288	21:14:29
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (25, 2016-06-16, 21:15:09, 50, 273.09, PENDIENTE, 47666625, PARLEY, 1, cesar)	127.0.0.1	cesar		289	21:15:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (25, 1, 69, altabaja1, MIL/DOD, -120, AB/ALTA(7,5), PENDIENTE)	127.0.0.1	cesar		290	21:15:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (25, 1, 70, altabaja2, NAT/PAD, -120, AB/BAJA(8,0), PENDIENTE)	127.0.0.1	cesar		291	21:15:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (25, 1, 70, ganador1, NATIONALS, -160, GANAR, PENDIENTE)	127.0.0.1	cesar		292	21:15:09
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (26, 2016-06-16, 21:15:21, 50, 457.56, PENDIENTE, 79384155, PARLEY, 1, cesar)	127.0.0.1	cesar		293	21:15:21
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (26, 1, 70, altabaja1, NAT/PAD, -120, AB/ALTA(8,0), PENDIENTE)	127.0.0.1	cesar		294	21:15:21
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (26, 1, 69, ab_mediojuego1, MIL/DOD, -120, ABM/ALTA(4,0), PENDIENTE)	127.0.0.1	cesar		295	21:15:21
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (26, 1, 69, runline1, MILWAUKEE, -170, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		296	21:15:21
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (26, 1, 70, runline2, PADRES, -140, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		297	21:15:21
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (27, 2016-06-16, 21:15:39, 50, 628.11, PENDIENTE, 81960449, PARLEY, 1, cesar)	127.0.0.1	cesar		298	21:15:39
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (27, 1, 69, ganador1, MILWAUKEE, 130, GANAR, PENDIENTE)	127.0.0.1	cesar		299	21:15:39
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (27, 1, 70, ganador1, NATIONALS, -160, GANAR, PENDIENTE)	127.0.0.1	cesar		300	21:15:39
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (27, 1, 69, altabaja1, MIL/DOD, -120, AB/ALTA(7,5), PENDIENTE)	127.0.0.1	cesar		301	21:15:39
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (27, 1, 70, altabaja1, NAT/PAD, -120, AB/ALTA(8,0), PENDIENTE)	127.0.0.1	cesar		302	21:15:39
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (28, 2016-06-16, 21:15:53, 50, 533.82, PENDIENTE, 43964233, PARLEY, 1, cesar)	127.0.0.1	cesar		303	21:15:53
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (28, 1, 69, runline1, MILWAUKEE, -170, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		304	21:15:53
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (28, 1, 70, runline1, NATIONALS, 100, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		305	21:15:53
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (28, 1, 70, ab_mediojuego1, NAT/PAD, -120, ABM/ALTA(4,0), PENDIENTE)	127.0.0.1	cesar		306	21:15:53
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (28, 1, 69, ab_mediojuego1, MIL/DOD, -120, ABM/ALTA(4,0), PENDIENTE)	127.0.0.1	cesar		307	21:15:53
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (2,70, NAT/PAD, 2016-06-16, NATIONALS, NATIONALS, NATIONALS, 6x2, 8, NATIONALS, NATIONALS, 4x0, 4, SI, NATIONALS, FINALIZADO)	127.0.0.1	cesar		308	21:16:29
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (126, 27, 1, 70, altabaja1, NAT/PAD, -120, AB/ALTA(8,0), PENDIENTE)	127.0.0.1	cesar		309	21:16:53
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (117, 25, 1, 70, altabaja2, NAT/PAD, -120, AB/BAJA(8,0), PENDIENTE)	127.0.0.1	cesar		310	21:16:53
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (119, 26, 1, 70, altabaja1, NAT/PAD, -120, AB/ALTA(8,0), PENDIENTE)	127.0.0.1	cesar		311	21:16:53
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=126 AND id_apuesta=27	127.0.0.1	cesar		312	21:16:53
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=117 AND id_apuesta=25	127.0.0.1	cesar		313	21:16:53
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=119 AND id_apuesta=26	127.0.0.1	cesar		314	21:16:53
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (129, 28, 1, 70, ab_mediojuego1, NAT/PAD, -120, ABM/ALTA(4,0), PENDIENTE)	127.0.0.1	cesar		315	21:17:12
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=129 AND id_apuesta=28	127.0.0.1	cesar		316	21:17:12
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE fecha=2016-06-16 AND estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		317	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=1 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		318	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=2 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		319	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=3 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		320	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=4 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		321	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=5 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		322	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=6 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		323	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=7 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		324	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=8 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		325	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=9 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		326	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=10 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		327	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=11 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		328	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=12 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		329	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=13 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		330	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=14 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		331	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=15 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		332	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=16 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		333	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=17 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		334	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=18 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		335	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=19 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		336	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=20 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		337	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=21 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		338	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=22 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		339	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=23 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		340	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=24 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		341	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=25 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		342	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=26 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		343	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=27 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		344	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_apuesta=28 estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		345	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=8 AND estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		346	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=GANADORA WHERE id_apuesta=8 AND estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		347	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=15 AND estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		348	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=GANADORA WHERE id_apuesta=15 AND estatus NOT IN (PAGADA, ANULADA)	127.0.0.1	cesar		349	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE fecha=2016-06-16 AND estatus=PENDIENTE	127.0.0.1	cesar		350	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=1 AND estatus=PENDIENTE	127.0.0.1	cesar		351	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=2 AND estatus=PENDIENTE	127.0.0.1	cesar		352	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=3 AND estatus=PENDIENTE	127.0.0.1	cesar		353	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=4 AND estatus=PENDIENTE	127.0.0.1	cesar		354	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=5 AND estatus=PENDIENTE	127.0.0.1	cesar		355	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=6 AND estatus=PENDIENTE	127.0.0.1	cesar		356	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=7 AND estatus=PENDIENTE	127.0.0.1	cesar		357	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=8 AND estatus=PENDIENTE	127.0.0.1	cesar		358	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=9 AND estatus=PENDIENTE	127.0.0.1	cesar		359	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=10 AND estatus=PENDIENTE	127.0.0.1	cesar		360	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=11 AND estatus=PENDIENTE	127.0.0.1	cesar		361	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=12 AND estatus=PENDIENTE	127.0.0.1	cesar		362	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=13 AND estatus=PENDIENTE	127.0.0.1	cesar		363	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=14 AND estatus=PENDIENTE	127.0.0.1	cesar		364	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=15 AND estatus=PENDIENTE	127.0.0.1	cesar		365	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=16 AND estatus=PENDIENTE	127.0.0.1	cesar		366	21:17:59
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=8	127.0.0.1	cesar		935	20:03:27
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=17 AND estatus=PENDIENTE	127.0.0.1	cesar		367	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=18 AND estatus=PENDIENTE	127.0.0.1	cesar		368	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=19 AND estatus=PENDIENTE	127.0.0.1	cesar		369	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=20 AND estatus=PENDIENTE	127.0.0.1	cesar		370	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=21 AND estatus=PENDIENTE	127.0.0.1	cesar		371	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=22 AND estatus=PENDIENTE	127.0.0.1	cesar		372	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=23 AND estatus=PENDIENTE	127.0.0.1	cesar		373	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=24 AND estatus=PENDIENTE	127.0.0.1	cesar		374	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=25 AND estatus=PENDIENTE	127.0.0.1	cesar		375	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=26 AND estatus=PENDIENTE	127.0.0.1	cesar		376	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=27 AND estatus=PENDIENTE	127.0.0.1	cesar		377	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PERDEDORA WHERE id_apuesta=28 AND estatus=PENDIENTE	127.0.0.1	cesar		378	21:17:59
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (29, 2016-06-16, 21:21:23, 50, 766.74, PENDIENTE, 61196289, PARLEY, 1, cesar)	127.0.0.1	cesar		379	21:21:23
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (29, 2, 5, runline2, DENVER, -110, RLINE(-5,0), PENDIENTE)	127.0.0.1	cesar		380	21:21:23
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (29, 3, 11006, ganador1, ECUADOR, 155, GANAR, PENDIENTE)	127.0.0.1	cesar		381	21:21:23
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (29, 2, 3, ganador2, DALLAS, -250, GANAR, PENDIENTE)	127.0.0.1	cesar		382	21:21:23
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (29, 2, 4, ganador1, INDIANA, 125, GANAR, PENDIENTE)	127.0.0.1	cesar		383	21:21:23
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (30, 2016-06-16, 21:21:33, 50, 340.63, PENDIENTE, 72627563, PARLEY, 1, cesar)	127.0.0.1	cesar		384	21:21:33
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (30, 3, 11006, runline1, ECUADOR, -135, RLINE(+0,0), PENDIENTE)	127.0.0.1	cesar		385	21:21:33
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (30, 3, 11006, altabaja2, ECU/EEU, 105, AB/BAJA(2,0), PENDIENTE)	127.0.0.1	cesar		386	21:21:33
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (30, 2, 5, altabaja2, TOR/DEN, -110, AB/BAJA(212,0), PENDIENTE)	127.0.0.1	cesar		387	21:21:33
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (31, 2016-06-16, 21:21:41, 50, 392.60, PENDIENTE, 63772583, PARLEY, 1, cesar)	127.0.0.1	cesar		388	21:21:41
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (31, 3, 11006, ganador2, EEUU, 150, GANAR, PENDIENTE)	127.0.0.1	cesar		389	21:21:41
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (31, 3, 11006, altabaja1, ECU/EEU, -155, AB/ALTA(2,0), PENDIENTE)	127.0.0.1	cesar		390	21:21:41
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (31, 2, 5, runlinem2, DENVER, -110, RLMITAD(-2,0), PENDIENTE)	127.0.0.1	cesar		391	21:21:41
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (32, 2016-06-16, 21:21:49, 50, 352.23, PENDIENTE, 54917602, PARLEY, 1, cesar)	127.0.0.1	cesar		392	21:21:49
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (32, 3, 11006, runline2, EEUU, -125, RLINE(-0,0), PENDIENTE)	127.0.0.1	cesar		393	21:21:49
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (32, 3, 11006, altabaja2, ECU/EEU, 105, AB/BAJA(2,0), PENDIENTE)	127.0.0.1	cesar		394	21:21:49
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (32, 2, 4, altabajam1, IND/LAK, -110, ABM/ALTA(103,0), PENDIENTE)	127.0.0.1	cesar		395	21:21:49
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_futbol (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (3,11006, ECU/EEU, 2016-06-16, EEUU, EEUU, 2, 0x2, FINALIZADO)	127.0.0.1	cesar		396	21:22:30
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (136, 30, 3, 11006, altabaja2, ECU/EEU, 105, AB/BAJA(2,0), PENDIENTE)	127.0.0.1	cesar		397	21:22:40
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (139, 31, 3, 11006, altabaja1, ECU/EEU, -155, AB/ALTA(2,0), PENDIENTE)	127.0.0.1	cesar		398	21:22:40
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (142, 32, 3, 11006, altabaja2, ECU/EEU, 105, AB/BAJA(2,0), PENDIENTE)	127.0.0.1	cesar		399	21:22:40
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=136 AND id_apuesta=30	127.0.0.1	cesar		400	21:22:40
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=139 AND id_apuesta=31	127.0.0.1	cesar		401	21:22:40
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM apuesta_detalle WHERE id=142 AND id_apuesta=32	127.0.0.1	cesar		402	21:22:40
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (136, 30, 3, 11006, altabaja2, ECU/EEU, 105, AB/BAJA(2,0), PENDIENTE)	127.0.0.1	cesar		403	21:23:26
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (139, 31, 3, 11006, altabaja1, ECU/EEU, -155, AB/ALTA(2,0), PENDIENTE)	127.0.0.1	cesar		404	21:23:26
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (142, 32, 3, 11006, altabaja2, ECU/EEU, 105, AB/BAJA(2,0), PENDIENTE)	127.0.0.1	cesar		405	21:23:26
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM jugada_anulada WHERE id=136 AND id_apuesta=30	127.0.0.1	cesar		406	21:23:26
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM jugada_anulada WHERE id=139 AND id_apuesta=31	127.0.0.1	cesar		407	21:23:26
2016-06-16	AUDITORIA	ALTER	STATEMENT	DELETE	TABLA	DELETE FROM jugada_anulada WHERE id=142 AND id_apuesta=32	127.0.0.1	cesar		408	21:23:26
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (1, 2016-06-16, 21:39:14, 50, 12768.67, PENDIENTE, 79485778, PARLEY, 1, cesar)	127.0.0.1	cesar		409	21:39:14
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (1, 1, 68, ganador2, METS, -125, GANAR, PENDIENTE)	127.0.0.1	cesar		410	21:39:14
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (1, 1, 69, runline2, DODGERS, 130, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		411	21:39:14
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (1, 1, 70, srunline1, NATIONALS, 100, SRLINE(-2,5), PENDIENTE)	127.0.0.1	cesar		412	21:39:14
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (1, 1, 70, altabaja2, NAT/PAD, -120, AB/BAJA(8,0), PENDIENTE)	127.0.0.1	cesar		413	21:39:14
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (1, 1, 71, g_mediojuego1, SEATTLE, 100, GMITAD, PENDIENTE)	127.0.0.1	cesar		414	21:39:14
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (1, 1, 72, runlinem1, TEXAS, 135, RLMITAD(-0,5), PENDIENTE)	127.0.0.1	cesar		415	21:39:14
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (1, 1, 73, ab_mediojuego1, BAL/BOS, -120, ABM/ALTA(5,0), PENDIENTE)	127.0.0.1	cesar		416	21:39:14
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (1, 1, 74, p_inning1, YAN/MIN, -105, P-INNG(SI), PENDIENTE)	127.0.0.1	cesar		417	21:39:14
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (2, 2016-06-16, 21:39:25, 50, 4339.22, PENDIENTE, 56060180, PARLEY, 1, cesar)	127.0.0.1	cesar		418	21:39:25
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (2, 1, 76, p_anotar1, TORONTO, -180, P-ANOT, PENDIENTE)	127.0.0.1	cesar		419	21:39:25
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (2, 2, 1, ganador1, CHICAGO, 200, GANAR, PENDIENTE)	127.0.0.1	cesar		420	21:39:25
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (2, 2, 2, runline1, GSWARRIORS, -110, RLINE(+2,5), PENDIENTE)	127.0.0.1	cesar		421	21:39:25
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (2, 2, 3, altabaja1, ORL/DAL, -110, AB/ALTA(204,5), PENDIENTE)	127.0.0.1	cesar		422	21:39:25
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (2, 2, 3, ganadorm2, DALLAS, -250, GMITAD, PENDIENTE)	127.0.0.1	cesar		423	21:39:25
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (2, 2, 4, runlinem1, INDIANA, -110, RLMITAD(+2,0), PENDIENTE)	127.0.0.1	cesar		424	21:39:25
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (2, 2, 5, altabajam1, TOR/DEN, -110, ABM/ALTA(102,0), PENDIENTE)	127.0.0.1	cesar		425	21:39:25
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (3, 2016-06-16, 21:39:35, 50, 400.45, PENDIENTE, 67491455, PARLEY, 1, cesar)	127.0.0.1	cesar		426	21:39:35
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=7	127.0.0.1	cesar		936	20:03:27
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (3, 3, 11006, ganador1, ECUADOR, 155, GANAR, PENDIENTE)	127.0.0.1	cesar		427	21:39:35
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (3, 3, 11006, altabaja1, ECU/EEU, -155, AB/ALTA(2,0), PENDIENTE)	127.0.0.1	cesar		428	21:39:35
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (3, 2, 5, altabaja2, TOR/DEN, -110, AB/BAJA(212,0), PENDIENTE)	127.0.0.1	cesar		429	21:39:35
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (5, 2016-06-16, 21:55:57, 50, 209.53, PENDIENTE, 38042602, PARLEY, 1, cesar)	127.0.0.1	cesar		434	21:55:57
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (5, 1, 67, runline1, CINCINNATI, -225, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		435	21:55:57
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (5, 1, 67, p_inning2, CIN/ATL, -150, P-INNG(NO), PENDIENTE)	127.0.0.1	cesar		436	21:55:57
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (5, 1, 67, p_anotar1, CINCINNATI, -135, P-ANOT, PENDIENTE)	127.0.0.1	cesar		437	21:55:57
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (4, 2016-06-16, 21:52:50, 50, 342.60, PENDIENTE, 76277770, PARLEY, 1, cesar)	127.0.0.1	cesar		430	21:52:50
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (4, 1, 70, ganador1, NATIONALS, -160, GANAR, PENDIENTE)	127.0.0.1	cesar		431	21:52:50
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (4, 1, 70, altabaja1, NAT/PAD, -120, AB/ALTA(8,0), PENDIENTE)	127.0.0.1	cesar		432	21:52:50
2016-06-16	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (4, 1, 70, p_anotar2, PADRES, 130, P-ANOT, PENDIENTE)	127.0.0.1	cesar		433	21:52:50
2016-06-17	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-17, 17:16:32, 127.0.0.1)	127.0.0.1	cesar		438	17:16:32
2016-06-17	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_basquetbol (id, id_logro, encuentro, fecha, ganador, runline, total_puntos, marcador, ganadorm, runlinem, total_puntosm, marcadorm, estatus) VALUES (5,3, ORL/DAL, 2016-06-16, DALLAS, DALLAS, 220, 100x120, DALLAS, DALLAS, 110, 50x60, FINALIZADO)	127.0.0.1	cesar		439	19:13:39
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-18, 16:49:36, 127.0.0.1)	127.0.0.1	cesar		440	16:49:36
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (1, 2016-06-18, 17:23:42, 50, 1860.00, PENDIENTE, 67477722, PARLEY, 1, cesar)	127.0.0.1	cesar		441	17:23:42
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (1, 3, 11007, ganador1, COLOMBIA, -210, GANAR, PENDIENTE)	127.0.0.1	cesar		442	17:23:42
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (1, 3, 11008, ganador1, VENEZUELA, 800, GANAR, PENDIENTE)	127.0.0.1	cesar		443	17:23:42
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (1, 3, 11009, ganador1, CHILE, 180, GANAR, PENDIENTE)	127.0.0.1	cesar		444	17:23:42
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (2, 2016-06-18, 17:23:51, 50, 2512.50, PENDIENTE, 23765869, PARLEY, 1, cesar)	127.0.0.1	cesar		445	17:23:51
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (2, 3, 11007, empate, COL/PER, 235, EMPATE, PENDIENTE)	127.0.0.1	cesar		446	17:23:51
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (2, 3, 11008, empate, VEN/ARG, 400, EMPATE, PENDIENTE)	127.0.0.1	cesar		447	17:23:51
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (2, 3, 11009, empate, CHI/MEX, 200, EMPATE, PENDIENTE)	127.0.0.1	cesar		448	17:23:51
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (3, 2016-06-18, 17:24:02, 50, 1447.60, PENDIENTE, 90340270, PARLEY, 1, cesar)	127.0.0.1	cesar		449	17:24:02
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (3, 3, 11007, runline1, COLOMBIA, -135, RLINE(-1,0), PENDIENTE)	127.0.0.1	cesar		450	17:24:02
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (3, 3, 11008, runline1, VENEZUELA, -125, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		451	17:24:02
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (3, 3, 11008, altabaja2, VEN/ARG, 120, AB/BAJA(2,5), PENDIENTE)	127.0.0.1	cesar		452	17:24:02
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (3, 3, 11009, runline1, CHILE, -110, RLINE(+0,0), PENDIENTE)	127.0.0.1	cesar		453	17:24:02
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (3, 3, 11009, altabaja2, CHI/MEX, 120, AB/BAJA(2,0), PENDIENTE)	127.0.0.1	cesar		454	17:24:02
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (4, 2016-06-18, 17:24:18, 50, 10894.29, PENDIENTE, 72630310, PARLEY, 1, cesar)	127.0.0.1	cesar		455	17:24:18
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (4, 3, 11007, ganador1, COLOMBIA, -210, GANAR, PENDIENTE)	127.0.0.1	cesar		456	17:24:18
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (4, 3, 11007, altabaja2, COL/PER, 105, AB/BAJA(2,0), PENDIENTE)	127.0.0.1	cesar		457	17:24:18
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (4, 3, 11008, ganador1, VENEZUELA, 800, GANAR, PENDIENTE)	127.0.0.1	cesar		458	17:24:18
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (4, 3, 11008, altabaja1, VEN/ARG, -150, AB/ALTA(2,5), PENDIENTE)	127.0.0.1	cesar		459	17:24:18
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (4, 3, 11009, ganador1, CHILE, 180, GANAR, PENDIENTE)	127.0.0.1	cesar		460	17:24:18
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (4, 3, 11009, altabaja1, CHI/MEX, -140, AB/ALTA(2,0), PENDIENTE)	127.0.0.1	cesar		461	17:24:18
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (5, 2016-06-18, 17:24:34, 50, 9673.95, PENDIENTE, 54920349, PARLEY, 1, cesar)	127.0.0.1	cesar		462	17:24:34
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (5, 3, 11007, ganador2, PERU, 500, GANAR, PENDIENTE)	127.0.0.1	cesar		463	17:24:34
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (5, 3, 11007, altabaja2, COL/PER, 105, AB/BAJA(2,0), PENDIENTE)	127.0.0.1	cesar		464	17:24:34
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (5, 3, 11008, ganador2, ARGENTINA, -400, GANAR, PENDIENTE)	127.0.0.1	cesar		465	17:24:34
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (5, 3, 11008, altabaja2, VEN/ARG, 120, AB/BAJA(2,5), PENDIENTE)	127.0.0.1	cesar		466	17:24:34
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (5, 3, 11009, ganador2, MEXICO, 160, GANAR, PENDIENTE)	127.0.0.1	cesar		467	17:24:34
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (5, 3, 11009, altabaja2, CHI/MEX, 120, AB/BAJA(2,0), PENDIENTE)	127.0.0.1	cesar		468	17:24:34
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (6, 2016-06-18, 17:24:48, 50, 1396.04, PENDIENTE, 16924133, PARLEY, 1, cesar)	127.0.0.1	cesar		469	17:24:48
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (6, 3, 11007, runline2, PERU, -125, RLINE(+1,0), PENDIENTE)	127.0.0.1	cesar		470	17:24:48
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (6, 3, 11008, runline2, ARGENTINA, -125, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		471	17:24:48
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (6, 3, 11009, runline2, MEXICO, -120, RLINE(-0,0), PENDIENTE)	127.0.0.1	cesar		472	17:24:48
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (6, 3, 11008, altabaja1, VEN/ARG, -150, AB/ALTA(2,5), PENDIENTE)	127.0.0.1	cesar		473	17:24:48
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (6, 3, 11007, altabaja1, COL/PER, -155, AB/ALTA(2,0), PENDIENTE)	127.0.0.1	cesar		474	17:24:48
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (6, 3, 11009, altabaja1, CHI/MEX, -140, AB/ALTA(2,0), PENDIENTE)	127.0.0.1	cesar		475	17:24:48
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (7, 2016-06-18, 17:24:57, 50, 2967.58, PENDIENTE, 63212280, PARLEY, 1, cesar)	127.0.0.1	cesar		476	17:24:57
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (7, 3, 11007, runline1, COLOMBIA, -135, RLINE(-1,0), PENDIENTE)	127.0.0.1	cesar		477	17:24:57
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (7, 3, 11008, runline1, VENEZUELA, -125, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		478	17:24:57
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (7, 3, 11009, runline1, CHILE, -110, RLINE(+0,0), PENDIENTE)	127.0.0.1	cesar		479	17:24:57
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (7, 3, 11009, altabaja2, CHI/MEX, 120, AB/BAJA(2,0), PENDIENTE)	127.0.0.1	cesar		480	17:24:57
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (7, 3, 11008, altabaja2, VEN/ARG, 120, AB/BAJA(2,5), PENDIENTE)	127.0.0.1	cesar		481	17:24:57
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (7, 3, 11007, altabaja2, COL/PER, 105, AB/BAJA(2,0), PENDIENTE)	127.0.0.1	cesar		482	17:24:57
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (8, 2016-06-18, 17:25:06, 50, 1405.87, PENDIENTE, 19500427, PARLEY, 1, cesar)	127.0.0.1	cesar		483	17:25:06
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (8, 3, 11007, runline1, COLOMBIA, -135, RLINE(-1,0), PENDIENTE)	127.0.0.1	cesar		484	17:25:06
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (8, 3, 11008, runline1, VENEZUELA, -125, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		485	17:25:06
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (8, 3, 11009, runline1, CHILE, -110, RLINE(+0,0), PENDIENTE)	127.0.0.1	cesar		486	17:25:06
2016-06-25	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-25, 21:27:32, 127.0.0.1)	127.0.0.1	cesar		896	21:27:32
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (8, 3, 11007, altabaja1, COL/PER, -155, AB/ALTA(2,0), PENDIENTE)	127.0.0.1	cesar		487	17:25:06
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (8, 3, 11008, altabaja1, VEN/ARG, -150, AB/ALTA(2,5), PENDIENTE)	127.0.0.1	cesar		488	17:25:06
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (8, 3, 11009, altabaja1, CHI/MEX, -140, AB/ALTA(2,0), PENDIENTE)	127.0.0.1	cesar		489	17:25:06
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (9, 2016-06-18, 17:25:14, 50, 11809.91, PENDIENTE, 10645446, PARLEY, 1, cesar)	127.0.0.1	cesar		490	17:25:14
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (9, 3, 11007, empate, COL/PER, 235, EMPATE, PENDIENTE)	127.0.0.1	cesar		491	17:25:14
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (9, 3, 11008, empate, VEN/ARG, 400, EMPATE, PENDIENTE)	127.0.0.1	cesar		492	17:25:14
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (9, 3, 11009, empate, CHI/MEX, 200, EMPATE, PENDIENTE)	127.0.0.1	cesar		493	17:25:14
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (9, 3, 11009, altabaja1, CHI/MEX, -140, AB/ALTA(2,0), PENDIENTE)	127.0.0.1	cesar		494	17:25:14
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (9, 3, 11008, altabaja1, VEN/ARG, -150, AB/ALTA(2,5), PENDIENTE)	127.0.0.1	cesar		495	17:25:14
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (9, 3, 11007, altabaja1, COL/PER, -155, AB/ALTA(2,0), PENDIENTE)	127.0.0.1	cesar		496	17:25:14
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_futbol (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (1,11007, COL/PER, 2016-06-18, COLOMBIA, COLOMBIA, 2, 2x0, FINALIZADO)	127.0.0.1	cesar		497	17:28:30
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_futbol (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (2,11008, VEN/ARG, 2016-06-18, VENEZUELA, VENEZUELA, 3, 3x0, FINALIZADO)	127.0.0.1	cesar		498	17:28:41
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_futbol (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (3,11009, CHI/MEX, 2016-06-18, CHILE, CHILE, 1, 1x0, FINALIZADO)	127.0.0.1	cesar		499	17:28:56
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (10, 2016-06-18, 17:36:59, 50, 1230.06, PENDIENTE, 96550292, PARLEY, 1, cesar)	127.0.0.1	cesar		500	17:36:59
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (10, 2, 1, ganador1, CHICAGO, 200, GANAR, PENDIENTE)	127.0.0.1	cesar		501	17:36:59
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (10, 2, 1, altabaja2, CHI/MIA, -110, AB/BAJA(204,5), PENDIENTE)	127.0.0.1	cesar		502	17:36:59
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (10, 2, 2, ganador1, GSWARRIORS, 125, GANAR, PENDIENTE)	127.0.0.1	cesar		503	17:36:59
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (10, 2, 2, altabaja2, GSW/CLE, -110, AB/BAJA(207,5), PENDIENTE)	127.0.0.1	cesar		504	17:36:59
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (11, 2016-06-18, 17:37:10, 50, 431.07, PENDIENTE, 73124694, PARLEY, 1, cesar)	127.0.0.1	cesar		505	17:37:10
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (11, 2, 1, ganador2, MIAMI, -250, GANAR, PENDIENTE)	127.0.0.1	cesar		506	17:37:10
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (11, 2, 1, altabaja1, CHI/MIA, -110, AB/ALTA(204,5), PENDIENTE)	127.0.0.1	cesar		507	17:37:10
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (11, 2, 2, ganador2, CLEVELAND, -145, GANAR, PENDIENTE)	127.0.0.1	cesar		508	17:37:10
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (11, 2, 2, altabaja1, GSW/CLE, -110, AB/ALTA(207,5), PENDIENTE)	127.0.0.1	cesar		509	17:37:10
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_basquetbol (id, id_logro, encuentro, fecha, ganador, runline, total_puntos, marcador, ganadorm, runlinem, total_puntosm, marcadorm, estatus) VALUES (1,1, CHI/MIA, 2016-06-18, CHICAGO, CHICAGO, 190, 100x90, CHICAGO, CHICAGO, 90, 50x40, FINALIZADO)	127.0.0.1	cesar		510	17:37:41
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_basquetbol (id, id_logro, encuentro, fecha, ganador, runline, total_puntos, marcador, ganadorm, runlinem, total_puntosm, marcadorm, estatus) VALUES (2,2, GSW/CLE, 2016-06-18, GSWARRIORS, GSWARRIORS, 182, 102x80, GSWARRIORS, GSWARRIORS, 90, 50x40, FINALIZADO)	127.0.0.1	cesar		511	17:38:01
2016-06-18	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE resultado_futbol SET ganador=EMPATE, runline=EMPATE, total_goles=6,  marcador=3x3, estatus=FINALIZADO WHERE id=2	127.0.0.1	cesar		512	18:04:01
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=2	127.0.0.1	cesar		932	20:03:27
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (1, 2016-06-18, 18:14:07, 50, 279.20, PENDIENTE, 15438232, PARLEY, 1, cesar)	127.0.0.1	cesar		513	18:14:07
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (1, 1, 1, ganador1, CINCINNATI, -110, GANAR, PENDIENTE)	127.0.0.1	cesar		514	18:14:07
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (1, 1, 2, ganador2, METS, -125, GANAR, PENDIENTE)	127.0.0.1	cesar		515	18:14:07
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (1, 1, 3, ganador2, DODGERS, -160, GANAR, PENDIENTE)	127.0.0.1	cesar		516	18:14:07
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (2, 2016-06-18, 18:14:20, 50, 450.07, PENDIENTE, 12298889, PARLEY, 1, cesar)	127.0.0.1	cesar		517	18:14:20
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (2, 1, 1, ganador2, ATLANTA, -110, GANAR, PENDIENTE)	127.0.0.1	cesar		518	18:14:20
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (2, 1, 3, ganador1, MILWAUKEE, 130, GANAR, PENDIENTE)	127.0.0.1	cesar		519	18:14:20
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (2, 1, 2, ganador1, PIRATES, 105, GANAR, PENDIENTE)	127.0.0.1	cesar		520	18:14:20
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (3, 2016-06-18, 18:14:26, 50, 450.07, PENDIENTE, 73157653, PARLEY, 1, cesar)	127.0.0.1	cesar		521	18:14:26
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (3, 1, 1, ganador1, CINCINNATI, -110, GANAR, PENDIENTE)	127.0.0.1	cesar		522	18:14:26
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (3, 1, 2, ganador1, PIRATES, 105, GANAR, PENDIENTE)	127.0.0.1	cesar		523	18:14:26
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (3, 1, 3, ganador1, MILWAUKEE, 130, GANAR, PENDIENTE)	127.0.0.1	cesar		524	18:14:26
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (4, 2016-06-18, 18:14:32, 50, 279.20, PENDIENTE, 44016418, PARLEY, 1, cesar)	127.0.0.1	cesar		525	18:14:32
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (4, 1, 1, ganador2, ATLANTA, -110, GANAR, PENDIENTE)	127.0.0.1	cesar		526	18:14:32
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (4, 1, 2, ganador2, METS, -125, GANAR, PENDIENTE)	127.0.0.1	cesar		527	18:14:32
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (4, 1, 3, ganador2, DODGERS, -160, GANAR, PENDIENTE)	127.0.0.1	cesar		528	18:14:32
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (5, 2016-06-18, 18:14:37, 50, 170.66, PENDIENTE, 49732055, PARLEY, 1, cesar)	127.0.0.1	cesar		529	18:14:37
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (5, 1, 1, runline1, CINCINNATI, -225, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		530	18:14:37
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (5, 1, 2, runline1, PIRATES, -205, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		531	18:14:37
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (5, 1, 3, runline1, MILWAUKEE, -170, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		532	18:14:37
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (6, 2016-06-18, 18:14:43, 50, 838.06, PENDIENTE, 20590820, PARLEY, 1, cesar)	127.0.0.1	cesar		533	18:14:43
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (6, 1, 1, runline2, ATLANTA, 175, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		534	18:14:43
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (6, 1, 2, runline2, METS, 165, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		535	18:14:43
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (6, 1, 3, runline2, DODGERS, 130, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		536	18:14:43
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (7, 2016-06-18, 18:14:49, 50, 170.66, PENDIENTE, 81449584, PARLEY, 1, cesar)	127.0.0.1	cesar		537	18:14:49
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (7, 1, 1, srunline1, CINCINNATI, -225, SRLINE(+2,5), PENDIENTE)	127.0.0.1	cesar		538	18:14:49
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (7, 1, 2, srunline1, PIRATES, -205, SRLINE(+2,5), PENDIENTE)	127.0.0.1	cesar		539	18:14:49
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (7, 1, 3, srunline1, MILWAUKEE, -170, SRLINE(+2,5), PENDIENTE)	127.0.0.1	cesar		540	18:14:49
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (8, 2016-06-18, 18:14:55, 50, 838.06, PENDIENTE, 52308349, PARLEY, 1, cesar)	127.0.0.1	cesar		541	18:14:55
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (8, 1, 1, srunline2, ATLANTA, 175, SRLINE(-2,5), PENDIENTE)	127.0.0.1	cesar		542	18:14:55
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (8, 1, 2, srunline2, METS, 165, SRLINE(-2,5), PENDIENTE)	127.0.0.1	cesar		543	18:14:55
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (8, 1, 3, srunline2, DODGERS, 130, SRLINE(-2,5), PENDIENTE)	127.0.0.1	cesar		544	18:14:55
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (9, 2016-06-18, 18:15:02, 50, 917.89, PENDIENTE, 78310241, PARLEY, 1, cesar)	127.0.0.1	cesar		545	18:15:02
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (9, 1, 1, altabaja1, CIN/ATL, -120, AB/ALTA(8,0), PENDIENTE)	127.0.0.1	cesar		546	18:15:02
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (9, 1, 2, altabaja1, PIR/MET, -120, AB/ALTA(7,5), PENDIENTE)	127.0.0.1	cesar		547	18:15:02
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (9, 1, 3, altabaja1, MIL/DOD, -120, AB/ALTA(7,5), PENDIENTE)	127.0.0.1	cesar		548	18:15:02
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (9, 1, 4, ganador1, NATIONALS, -160, GANAR, PENDIENTE)	127.0.0.1	cesar		549	18:15:02
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (9, 1, 5, ganador2, TAMPA, -120, GANAR, PENDIENTE)	127.0.0.1	cesar		550	18:15:02
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (10, 2016-06-18, 18:15:10, 50, 937.05, PENDIENTE, 69455261, PARLEY, 1, cesar)	127.0.0.1	cesar		551	18:15:10
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (10, 1, 1, altabaja2, CIN/ATL, -120, AB/BAJA(8,0), PENDIENTE)	127.0.0.1	cesar		552	18:15:10
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (10, 1, 2, altabaja2, PIR/MET, -120, AB/BAJA(7,5), PENDIENTE)	127.0.0.1	cesar		553	18:15:10
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (10, 1, 3, altabaja2, MIL/DOD, -120, AB/BAJA(7,5), PENDIENTE)	127.0.0.1	cesar		554	18:15:10
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (10, 1, 6, ganador1, TEXAS, -125, GANAR, PENDIENTE)	127.0.0.1	cesar		555	18:15:10
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (10, 1, 7, ganador2, BOSTON, -145, GANAR, PENDIENTE)	127.0.0.1	cesar		556	18:15:10
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (11, 2016-06-18, 18:15:15, 50, 450.07, PENDIENTE, 75170898, PARLEY, 1, cesar)	127.0.0.1	cesar		557	18:15:15
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (11, 1, 1, g_mediojuego1, CINCINNATI, -110, GMITAD, PENDIENTE)	127.0.0.1	cesar		558	18:15:15
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (11, 1, 2, g_mediojuego1, PIRATES, 105, GMITAD, PENDIENTE)	127.0.0.1	cesar		559	18:15:15
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (11, 1, 3, g_mediojuego1, MILWAUKEE, 130, GMITAD, PENDIENTE)	127.0.0.1	cesar		560	18:15:15
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (12, 2016-06-18, 18:15:22, 50, 279.20, PENDIENTE, 11172790, PARLEY, 1, cesar)	127.0.0.1	cesar		561	18:15:22
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (12, 1, 1, g_mediojuego2, ATLANTA, -110, GMITAD, PENDIENTE)	127.0.0.1	cesar		562	18:15:22
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (12, 1, 2, g_mediojuego2, METS, -125, GMITAD, PENDIENTE)	127.0.0.1	cesar		563	18:15:22
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (12, 1, 3, g_mediojuego2, DODGERS, -160, GMITAD, PENDIENTE)	127.0.0.1	cesar		564	18:15:22
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (13, 2016-06-18, 18:15:28, 50, 170.66, PENDIENTE, 72031555, PARLEY, 1, cesar)	127.0.0.1	cesar		565	18:15:28
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (13, 1, 1, runlinem1, CINCINNATI, -225, RLMITAD(+0,5), PENDIENTE)	127.0.0.1	cesar		566	18:15:28
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (13, 1, 2, runlinem1, PIRATES, -205, RLMITAD(+0,5), PENDIENTE)	127.0.0.1	cesar		567	18:15:28
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (13, 1, 3, runlinem1, MILWAUKEE, -170, RLMITAD(+0,5), PENDIENTE)	127.0.0.1	cesar		568	18:15:28
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (14, 2016-06-18, 18:15:33, 50, 838.06, PENDIENTE, 77747192, PARLEY, 1, cesar)	127.0.0.1	cesar		569	18:15:33
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (14, 1, 1, runlinem2, ATLANTA, 175, RLMITAD(-0,5), PENDIENTE)	127.0.0.1	cesar		570	18:15:33
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (14, 1, 2, runlinem2, METS, 165, RLMITAD(-0,5), PENDIENTE)	127.0.0.1	cesar		571	18:15:33
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (14, 1, 3, runlinem2, DODGERS, 130, RLMITAD(-0,5), PENDIENTE)	127.0.0.1	cesar		572	18:15:33
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (15, 2016-06-18, 18:15:39, 50, 308.10, PENDIENTE, 48605957, PARLEY, 1, cesar)	127.0.0.1	cesar		573	18:15:39
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (15, 1, 1, ab_mediojuego1, CIN/ATL, -120, ABM/ALTA(4,0), PENDIENTE)	127.0.0.1	cesar		574	18:15:39
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (15, 1, 2, ab_mediojuego1, PIR/MET, -120, ABM/ALTA(4,0), PENDIENTE)	127.0.0.1	cesar		575	18:15:39
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (15, 1, 3, ab_mediojuego1, MIL/DOD, -120, ABM/ALTA(4,0), PENDIENTE)	127.0.0.1	cesar		576	18:15:39
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (16, 2016-06-18, 18:15:44, 50, 308.10, PENDIENTE, 54321594, PARLEY, 1, cesar)	127.0.0.1	cesar		577	18:15:44
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (16, 1, 1, ab_mediojuego2, CIN/ATL, -120, ABM/BAJA(4,0), PENDIENTE)	127.0.0.1	cesar		578	18:15:44
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (16, 1, 2, ab_mediojuego2, PIR/MET, -120, ABM/BAJA(4,0), PENDIENTE)	127.0.0.1	cesar		579	18:15:44
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (16, 1, 3, ab_mediojuego2, MIL/DOD, -120, ABM/BAJA(4,0), PENDIENTE)	127.0.0.1	cesar		580	18:15:44
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (17, 2016-06-18, 18:15:49, 50, 420.25, PENDIENTE, 60037231, PARLEY, 1, cesar)	127.0.0.1	cesar		581	18:15:49
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (17, 1, 1, p_inning1, CIN/ATL, 100, P-INNG(SI), PENDIENTE)	127.0.0.1	cesar		582	18:15:49
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (17, 1, 2, p_inning1, PIR/MET, 105, P-INNG(SI), PENDIENTE)	127.0.0.1	cesar		583	18:15:49
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (17, 1, 3, p_inning1, MIL/DOD, 105, P-INNG(SI), PENDIENTE)	127.0.0.1	cesar		584	18:15:49
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (18, 2016-06-18, 18:15:54, 50, 214.95, PENDIENTE, 65752868, PARLEY, 1, cesar)	127.0.0.1	cesar		585	18:15:54
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (18, 1, 1, p_inning2, CIN/ATL, -150, P-INNG(NO), PENDIENTE)	127.0.0.1	cesar		586	18:15:54
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (18, 1, 2, p_inning2, PIR/MET, -165, P-INNG(NO), PENDIENTE)	127.0.0.1	cesar		587	18:15:54
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (18, 1, 3, p_inning2, MIL/DOD, -165, P-INNG(NO), PENDIENTE)	127.0.0.1	cesar		588	18:15:54
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (19, 2016-06-18, 18:16:00, 50, 263.74, PENDIENTE, 36611633, PARLEY, 1, cesar)	127.0.0.1	cesar		589	18:16:00
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (19, 1, 1, p_anotar1, CINCINNATI, -135, P-ANOT, PENDIENTE)	127.0.0.1	cesar		590	18:16:00
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (19, 1, 2, p_anotar1, PIRATES, -135, P-ANOT, PENDIENTE)	127.0.0.1	cesar		591	18:16:00
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (19, 1, 3, p_anotar1, MILWAUKEE, -135, P-ANOT, PENDIENTE)	127.0.0.1	cesar		592	18:16:00
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (20, 2016-06-18, 18:16:05, 50, 326.73, PENDIENTE, 42327270, PARLEY, 1, cesar)	127.0.0.1	cesar		593	18:16:05
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (20, 1, 1, p_anotar2, ATLANTA, -115, P-ANOT, PENDIENTE)	127.0.0.1	cesar		594	18:16:05
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (20, 1, 2, p_anotar2, METS, -115, P-ANOT, PENDIENTE)	127.0.0.1	cesar		595	18:16:05
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (20, 1, 3, p_anotar2, DODGERS, -115, P-ANOT, PENDIENTE)	127.0.0.1	cesar		596	18:16:05
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (1,1, CIN/ATL, 2016-06-18, ATLANTA, ATLANTA, ATLANTA, 0x9, 9, ATLANTA, ATLANTA, 0x4, 4, SI, ATLANTA, FINALIZADO)	127.0.0.1	cesar		597	18:16:52
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (2,2, PIR/MET, 2016-06-18, METS, METS, METS, 0x8, 8, METS, METS, 0x5, 5, SI, METS, FINALIZADO)	127.0.0.1	cesar		598	18:17:11
2016-06-18	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (3,3, MIL/DOD, 2016-06-18, DODGERS, DODGERS, DODGERS, 3x9, 12, DODGERS, DODGERS, 0x3, 3, SI, DODGERS, FINALIZADO)	127.0.0.1	cesar		599	18:17:41
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-20, 21:11:35, 127.0.0.1)	127.0.0.1	cesar		600	21:11:35
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-20, 21:14:15, 127.0.0.1)	127.0.0.1	cesar		601	21:14:15
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-20, 21:22:29, 127.0.0.1)	127.0.0.1	cesar		602	21:22:29
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-20, 21:26:40, 127.0.0.1)	127.0.0.1	cesar		603	21:26:40
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-20, 21:59:01, 127.0.0.1)	127.0.0.1	cesar		604	21:59:01
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-20, 22:10:34, 127.0.0.1)	127.0.0.1	cesar		605	22:10:34
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-20, 22:10:53, 127.0.0.1)	127.0.0.1	cesar		606	22:10:53
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (21, 2016-06-20, 22:41:14, 50, 687.59, PENDIENTE, 66763610, PARLEY, 1, cesar)	127.0.0.1	cesar		607	22:41:14
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (21, 1, 1, runlinem2, ATLANTA, 175, RLMITAD(-0,5), PENDIENTE)	127.0.0.1	cesar		608	22:41:14
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (21, 1, 2, altabaja1, PIR/MET, -120, AB/ALTA(7,5), PENDIENTE)	127.0.0.1	cesar		609	22:41:14
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (21, 1, 2, runline1, PIRATES, -205, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		610	22:41:14
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (21, 1, 3, altabaja1, MIL/DOD, -120, AB/ALTA(7,5), PENDIENTE)	127.0.0.1	cesar		611	22:41:14
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (22, 2016-06-20, 22:41:41, 50, 3803.86, PENDIENTE, 25628051, PARLEY, 1, cesar)	127.0.0.1	cesar		612	22:41:41
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (22, 2, 1, ganador1, CHICAGO, 200, GANAR, PENDIENTE)	127.0.0.1	cesar		613	22:41:41
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (22, 2, 1, altabaja2, CHI/MIA, -110, AB/BAJA(204,5), PENDIENTE)	127.0.0.1	cesar		614	22:41:41
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (22, 2, 2, runline1, GSWARRIORS, -110, RLINE(+2,5), PENDIENTE)	127.0.0.1	cesar		615	22:41:41
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (22, 2, 3, altabaja1, ORL/DAL, -110, AB/ALTA(204,5), PENDIENTE)	127.0.0.1	cesar		616	22:41:41
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (22, 2, 3, runline2, DALLAS, -110, RLINE(-5,5), PENDIENTE)	127.0.0.1	cesar		617	22:41:41
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (22, 2, 4, runlinem2, LAKERS, -110, RLMITAD(-2,0), PENDIENTE)	127.0.0.1	cesar		618	22:41:41
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (23, 2016-06-20, 22:41:55, 50, 1043.69, PENDIENTE, 77631835, PARLEY, 1, cesar)	127.0.0.1	cesar		619	22:41:55
2016-06-25	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-25, 21:29:15, 127.0.0.1)	127.0.0.1	cesar		897	21:29:15
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (23, 2, 1, ganadorm1, CHICAGO, 200, GMITAD, PENDIENTE)	127.0.0.1	cesar		620	22:41:55
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (23, 2, 1, altabajam2, CHI/MIA, -110, ABM/BAJA(104,5), PENDIENTE)	127.0.0.1	cesar		621	22:41:55
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (23, 2, 2, runlinem1, GSWARRIORS, -110, RLMITAD(+1,5), PENDIENTE)	127.0.0.1	cesar		622	22:41:55
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (23, 2, 2, altabajam1, GSW/CLE, -110, ABM/ALTA(107,5), PENDIENTE)	127.0.0.1	cesar		623	22:41:55
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_basquetbol (id, id_logro, encuentro, fecha, ganador, runline, total_puntos, marcador, ganadorm, runlinem, total_puntosm, marcadorm, estatus) VALUES (1,1, CHI/MIA, 2016-06-20, CHICAGO, CHICAGO, 220, 120x100, CHICAGO, CHICAGO, 104, 55x49, FINALIZADO)	127.0.0.1	cesar		644	22:48:12
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_basquetbol (id, id_logro, encuentro, fecha, ganador, runline, total_puntos, marcador, ganadorm, runlinem, total_puntosm, marcadorm, estatus) VALUES (2,2, GSW/CLE, 2016-06-20, GSWARRIORS, GSWARRIORS, 211, 110x101, GSWARRIORS, GSWARRIORS, 104, 55x49, FINALIZADO)	127.0.0.1	cesar		645	22:48:38
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (24, 2016-06-20, 22:42:14, 50, 3366.63, PENDIENTE, 45351257, PARLEY, 1, cesar)	127.0.0.1	cesar		624	22:42:14
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (24, 2, 5, runlinem2, DENVER, -110, RLMITAD(-2,0), PENDIENTE)	127.0.0.1	cesar		625	22:42:14
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (24, 2, 5, altabajam1, TOR/DEN, -110, ABM/ALTA(102,0), PENDIENTE)	127.0.0.1	cesar		626	22:42:14
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (24, 2, 4, ganadorm2, LAKERS, -145, GMITAD, PENDIENTE)	127.0.0.1	cesar		627	22:42:14
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (24, 2, 3, altabaja2, ORL/DAL, -110, AB/BAJA(204,5), PENDIENTE)	127.0.0.1	cesar		628	22:42:14
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (24, 2, 3, ganador1, ORLANDO, 200, GANAR, PENDIENTE)	127.0.0.1	cesar		629	22:42:14
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (24, 2, 2, runline1, GSWARRIORS, -110, RLINE(+2,5), PENDIENTE)	127.0.0.1	cesar		630	22:42:14
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (25, 2016-06-20, 22:42:30, 50, 1230.06, PENDIENTE, 27641296, PARLEY, 1, cesar)	127.0.0.1	cesar		631	22:42:30
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (25, 2, 2, runline2, CLEVELAND, -110, RLINE(-2,5), PENDIENTE)	127.0.0.1	cesar		632	22:42:30
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (25, 2, 2, altabaja1, GSW/CLE, -110, AB/ALTA(207,5), PENDIENTE)	127.0.0.1	cesar		633	22:42:30
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (25, 2, 1, ganador1, CHICAGO, 200, GANAR, PENDIENTE)	127.0.0.1	cesar		634	22:42:30
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (25, 2, 5, ganador1, TORONTO, 125, GANAR, PENDIENTE)	127.0.0.1	cesar		635	22:42:30
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (26, 2016-06-20, 22:46:59, 50, 1012.50, PENDIENTE, 11142578, PARLEY, 1, cesar)	127.0.0.1	cesar		636	22:46:59
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (26, 2, 2, ganador1, GSWARRIORS, 125, GANAR, PENDIENTE)	127.0.0.1	cesar		637	22:46:59
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (26, 2, 3, ganador1, ORLANDO, 200, GANAR, PENDIENTE)	127.0.0.1	cesar		638	22:46:59
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (26, 2, 1, ganador1, CHICAGO, 200, GANAR, PENDIENTE)	127.0.0.1	cesar		639	22:46:59
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (27, 2016-06-20, 22:47:08, 50, 644.32, PENDIENTE, 57430725, PARLEY, 1, cesar)	127.0.0.1	cesar		640	22:47:08
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (27, 2, 2, ganador1, GSWARRIORS, 125, GANAR, PENDIENTE)	127.0.0.1	cesar		641	22:47:08
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (27, 2, 2, altabaja1, GSW/CLE, -110, AB/ALTA(207,5), PENDIENTE)	127.0.0.1	cesar		642	22:47:08
2016-06-20	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (27, 2, 1, ganador1, CHICAGO, 200, GANAR, PENDIENTE)	127.0.0.1	cesar		643	22:47:08
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-21, 20:56:42, 127.0.0.1)	127.0.0.1	cesar		646	20:56:42
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-21, 21:02:44, 127.0.0.1)	127.0.0.1	cesar		647	21:02:44
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (28, 2016-06-21, 21:58:44, 50, 11195.36, PENDIENTE, 67999572, PARLEY, 1, cesar)	127.0.0.1	cesar		648	21:58:44
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (28, 3, 11008, ganador1, VENEZUELA, 800, GANAR, PENDIENTE)	127.0.0.1	cesar		649	21:58:44
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (28, 3, 11008, altabaja1, VEN/ARG, -150, AB/ALTA(2,5), PENDIENTE)	127.0.0.1	cesar		650	21:58:44
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (28, 3, 7013, ganador2, ALEMANIA, 115, GANAR, PENDIENTE)	127.0.0.1	cesar		651	21:58:44
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (28, 3, 7013, altabaja1, ALB/ALE, 125, AB/ALTA(2,5), PENDIENTE)	127.0.0.1	cesar		652	21:58:44
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=15	127.0.0.1	cesar		933	20:03:27
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (28, 3, 7016, runline1, ESPANA, -125, RLINE(+1,0), PENDIENTE)	127.0.0.1	cesar		653	21:58:44
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (28, 3, 7016, altabaja1, ESP/FRA, -140, AB/ALTA(2,5), PENDIENTE)	127.0.0.1	cesar		654	21:58:44
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (29, 2016-06-21, 21:59:04, 50, 8445.94, PENDIENTE, 90862121, PARLEY, 1, cesar)	127.0.0.1	cesar		655	21:59:04
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (29, 3, 11008, ganador2, ARGENTINA, -400, GANAR, PENDIENTE)	127.0.0.1	cesar		656	21:59:04
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (29, 3, 11008, altabaja2, VEN/ARG, 120, AB/BAJA(2,5), PENDIENTE)	127.0.0.1	cesar		657	21:59:04
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (29, 3, 7013, empate, ALB/ALE, 225, EMPATE, PENDIENTE)	127.0.0.1	cesar		658	21:59:04
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (29, 3, 7013, altabaja1, ALB/ALE, 125, AB/ALTA(2,5), PENDIENTE)	127.0.0.1	cesar		659	21:59:04
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (29, 3, 7016, empate, ESP/FRA, 300, EMPATE, PENDIENTE)	127.0.0.1	cesar		660	21:59:04
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (29, 3, 7016, altabaja2, ESP/FRA, 110, AB/BAJA(2,5), PENDIENTE)	127.0.0.1	cesar		661	21:59:04
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (30, 2016-06-21, 21:59:22, 50, 50000.00, PENDIENTE, 93438415, PARLEY, 1, cesar)	127.0.0.1	cesar		662	21:59:22
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (30, 3, 11008, ganador1, VENEZUELA, 800, GANAR, PENDIENTE)	127.0.0.1	cesar		663	21:59:22
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (30, 3, 11008, altabaja2, VEN/ARG, 120, AB/BAJA(2,5), PENDIENTE)	127.0.0.1	cesar		664	21:59:22
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (30, 3, 7013, ganador1, ALBANIA, 205, GANAR, PENDIENTE)	127.0.0.1	cesar		665	21:59:22
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (30, 3, 7013, altabaja2, ALB/ALE, -145, AB/BAJA(2,5), PENDIENTE)	127.0.0.1	cesar		666	21:59:22
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (30, 3, 7016, ganador1, ESPANA, 470, GANAR, PENDIENTE)	127.0.0.1	cesar		667	21:59:22
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (30, 3, 7016, altabaja2, ESP/FRA, 110, AB/BAJA(2,5), PENDIENTE)	127.0.0.1	cesar		668	21:59:22
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (31, 2016-06-21, 21:59:29, 50, 3250.00, PENDIENTE, 29440307, PARLEY, 1, cesar)	127.0.0.1	cesar		669	21:59:29
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (31, 3, 11008, empate, VEN/ARG, 400, EMPATE, PENDIENTE)	127.0.0.1	cesar		670	21:59:29
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (31, 3, 7013, empate, ALB/ALE, 225, EMPATE, PENDIENTE)	127.0.0.1	cesar		671	21:59:29
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (31, 3, 7016, empate, ESP/FRA, 300, EMPATE, PENDIENTE)	127.0.0.1	cesar		672	21:59:29
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (32, 2016-06-21, 21:59:40, 50, 303.53, PENDIENTE, 96014709, PARLEY, 1, cesar)	127.0.0.1	cesar		673	21:59:40
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (32, 3, 11008, runline2, ARGENTINA, -125, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		674	21:59:40
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (32, 3, 7013, runline2, ALEMANIA, -155, RLINE(-0,0), PENDIENTE)	127.0.0.1	cesar		675	21:59:40
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (32, 3, 7016, runline2, FRANCIA, 105, RLINE(-1,0), PENDIENTE)	127.0.0.1	cesar		676	21:59:40
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (33, 2016-06-21, 21:59:46, 50, 390.31, PENDIENTE, 66873474, PARLEY, 1, cesar)	127.0.0.1	cesar		677	21:59:46
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (33, 3, 11008, altabaja2, VEN/ARG, 120, AB/BAJA(2,5), PENDIENTE)	127.0.0.1	cesar		678	21:59:46
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_boxeo (id, id_logro, encuentro, fecha, ganador, marcador, estatus) VALUES (2,2, ALV/MAY, 2016-06-21, MAYWEATHER, 2, FINALIZADO)	127.0.0.1	cesar		831	22:54:52
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (33, 3, 7013, altabaja2, ALB/ALE, -145, AB/BAJA(2,5), PENDIENTE)	127.0.0.1	cesar		679	21:59:46
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (33, 3, 7016, altabaja2, ESP/FRA, 110, AB/BAJA(2,5), PENDIENTE)	127.0.0.1	cesar		680	21:59:46
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (34, 2016-06-21, 21:59:53, 50, 321.43, PENDIENTE, 92875366, PARLEY, 1, cesar)	127.0.0.1	cesar		681	21:59:53
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (34, 3, 11008, altabaja1, VEN/ARG, -150, AB/ALTA(2,5), PENDIENTE)	127.0.0.1	cesar		682	21:59:53
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (34, 3, 7013, altabaja1, ALB/ALE, 125, AB/ALTA(2,5), PENDIENTE)	127.0.0.1	cesar		683	21:59:53
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (34, 3, 7016, altabaja1, ESP/FRA, -140, AB/ALTA(2,5), PENDIENTE)	127.0.0.1	cesar		684	21:59:53
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (35, 2016-06-21, 22:00:00, 50, 201.56, PENDIENTE, 28877258, PARLEY, 1, cesar)	127.0.0.1	cesar		685	22:00:00
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (35, 3, 11008, ganador2, ARGENTINA, -400, GANAR, PENDIENTE)	127.0.0.1	cesar		686	22:00:00
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (35, 3, 7013, ganador2, ALEMANIA, 115, GANAR, PENDIENTE)	127.0.0.1	cesar		687	22:00:00
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (35, 3, 7016, ganador2, FRANCIA, -200, GANAR, PENDIENTE)	127.0.0.1	cesar		688	22:00:00
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (36, 2016-06-21, 22:00:09, 50, 7823.25, PENDIENTE, 75165405, PARLEY, 1, cesar)	127.0.0.1	cesar		689	22:00:09
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (36, 3, 11008, ganador1, VENEZUELA, 800, GANAR, PENDIENTE)	127.0.0.1	cesar		690	22:00:10
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (36, 3, 7013, ganador1, ALBANIA, 205, GANAR, PENDIENTE)	127.0.0.1	cesar		691	22:00:10
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (36, 3, 7016, ganador1, ESPANA, 470, GANAR, PENDIENTE)	127.0.0.1	cesar		692	22:00:10
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_futbol (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (1,7013, ALB/ALE, 2016-06-21, ALEMANIA, ALEMANIA, 3, 0x3, FINALIZADO)	127.0.0.1	cesar		693	22:01:43
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_futbol (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (2,7016, ESP/FRA, 2016-06-21, ESPANA, ESPANA, 2, 2x0, FINALIZADO)	127.0.0.1	cesar		694	22:01:54
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_futbol (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (3,11008, VEN/ARG, 2016-06-21, VENEZUELA, VENEZUELA, 2, 2x0, FINALIZADO)	127.0.0.1	cesar		695	22:02:04
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_futbol_americano(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, estatus, id_liga) VALUES (1, PAT/DEN, PATRIOTS, DENVER, 2, 2016-06-21, 23:55:00, 150, -300, -110, -110, 4.5, -110, -110, 55.5, ACTIVO, 13)	127.0.0.1	cesar		696	22:15:06
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_futbol_americano(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, estatus, id_liga) VALUES (2, SF4/SEA, SF49ERS, SEATTLE, 2, 2016-06-21, 23:55:00, 140, -280, -115, -105, 3.5, -110, -110, 38.5, ACTIVO, 13)	127.0.0.1	cesar		697	22:15:06
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_futbol_americano(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, estatus, id_liga) VALUES (3, KAN/CAR, KANSAS, CAROLINA, 2, 2016-06-21, 23:55:00, 110, -130, -110, -110, 2, -110, -110, 48.5, ACTIVO, 13)	127.0.0.1	cesar		698	22:15:06
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (37, 2016-06-21, 22:15:19, 50, 630.00, PENDIENTE, 35411376, PARLEY, 1, cesar)	127.0.0.1	cesar		699	22:15:19
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (37, 4, 1, ganador1, PATRIOTS, 150, GANAR, PENDIENTE)	127.0.0.1	cesar		700	22:15:19
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (37, 4, 2, ganador1, SF49ERS, 140, GANAR, PENDIENTE)	127.0.0.1	cesar		701	22:15:19
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (37, 4, 3, ganador1, KANSAS, 110, GANAR, PENDIENTE)	127.0.0.1	cesar		702	22:15:19
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (38, 2016-06-21, 22:15:33, 50, 160.07, PENDIENTE, 87415161, PARLEY, 1, cesar)	127.0.0.1	cesar		703	22:15:33
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (38, 4, 1, ganador2, DENVER, -300, GANAR, PENDIENTE)	127.0.0.1	cesar		704	22:15:33
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (38, 4, 2, ganador2, SEATTLE, -280, GANAR, PENDIENTE)	127.0.0.1	cesar		705	22:15:33
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (38, 4, 3, ganador2, CAROLINA, -130, GANAR, PENDIENTE)	127.0.0.1	cesar		706	22:15:33
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (39, 2016-06-21, 22:15:42, 50, 2370.52, PENDIENTE, 43703308, PARLEY, 1, cesar)	127.0.0.1	cesar		707	22:15:42
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (39, 4, 1, runline1, PATRIOTS, -110, RLINE(+4,5), PENDIENTE)	127.0.0.1	cesar		708	22:15:42
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (39, 4, 2, runline1, SF49ERS, -115, RLINE(+3,5), PENDIENTE)	127.0.0.1	cesar		709	22:15:42
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (39, 4, 3, runline1, KANSAS, -110, RLINE(+2,0), PENDIENTE)	127.0.0.1	cesar		710	22:15:42
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (39, 4, 1, altabaja1, PAT/DEN, -110, AB/ALTA(55,5), PENDIENTE)	127.0.0.1	cesar		711	22:15:42
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (39, 4, 2, altabaja1, SF4/SEA, -110, AB/ALTA(38,5), PENDIENTE)	127.0.0.1	cesar		712	22:15:42
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (39, 4, 3, altabaja1, KAN/CAR, -110, AB/ALTA(48,5), PENDIENTE)	127.0.0.1	cesar		713	22:15:42
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (40, 2016-06-21, 22:15:51, 50, 2475.53, PENDIENTE, 89991455, PARLEY, 1, cesar)	127.0.0.1	cesar		714	22:15:51
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (40, 4, 1, runline2, DENVER, -110, RLINE(-4,5), PENDIENTE)	127.0.0.1	cesar		715	22:15:51
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (40, 4, 2, runline2, SEATTLE, -105, RLINE(-3,5), PENDIENTE)	127.0.0.1	cesar		716	22:15:51
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (40, 4, 3, runline2, CAROLINA, -110, RLINE(-2,0), PENDIENTE)	127.0.0.1	cesar		717	22:15:51
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (40, 4, 1, altabaja2, PAT/DEN, -110, AB/BAJA(55,5), PENDIENTE)	127.0.0.1	cesar		718	22:15:51
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_boxeo (id, id_logro, encuentro, fecha, ganador, marcador, estatus) VALUES (3,3, BRA/PAC, 2016-06-21, PACQUIAO, 3, FINALIZADO)	127.0.0.1	cesar		832	22:55:00
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (40, 4, 2, altabaja2, SF4/SEA, -110, AB/BAJA(38,5), PENDIENTE)	127.0.0.1	cesar		719	22:15:51
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (40, 4, 3, altabaja2, KAN/CAR, -110, AB/BAJA(48,5), PENDIENTE)	127.0.0.1	cesar		720	22:15:51
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (41, 2016-06-21, 22:15:59, 50, 446.15, PENDIENTE, 81136474, PARLEY, 1, cesar)	127.0.0.1	cesar		721	22:15:59
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (41, 4, 1, ganador1, PATRIOTS, 150, GANAR, PENDIENTE)	127.0.0.1	cesar		722	22:15:59
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (41, 4, 2, runline1, SF49ERS, -115, RLINE(+3,5), PENDIENTE)	127.0.0.1	cesar		723	22:15:59
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (41, 4, 3, altabaja1, KAN/CAR, -110, AB/ALTA(48,5), PENDIENTE)	127.0.0.1	cesar		724	22:15:59
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (43, 2016-06-21, 22:16:14, 50, 329.72, PENDIENTE, 98283386, PARLEY, 1, cesar)	127.0.0.1	cesar		729	22:16:14
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (43, 4, 3, ganador2, CAROLINA, -130, GANAR, PENDIENTE)	127.0.0.1	cesar		730	22:16:14
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (43, 4, 2, runline2, SEATTLE, -105, RLINE(-3,5), PENDIENTE)	127.0.0.1	cesar		731	22:16:14
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (43, 4, 1, altabaja2, PAT/DEN, -110, AB/BAJA(55,5), PENDIENTE)	127.0.0.1	cesar		732	22:16:14
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (44, 2016-06-21, 22:16:33, 50, 3565.94, PENDIENTE, 66002807, PARLEY, 1, cesar)	127.0.0.1	cesar		733	22:16:33
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (44, 4, 1, ganador1, PATRIOTS, 150, GANAR, PENDIENTE)	127.0.0.1	cesar		734	22:16:33
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (44, 4, 1, altabaja1, PAT/DEN, -110, AB/ALTA(55,5), PENDIENTE)	127.0.0.1	cesar		735	22:16:33
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (44, 4, 2, altabaja1, SF4/SEA, -110, AB/ALTA(38,5), PENDIENTE)	127.0.0.1	cesar		736	22:16:33
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (44, 4, 2, runline2, SEATTLE, -105, RLINE(-3,5), PENDIENTE)	127.0.0.1	cesar		737	22:16:33
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (44, 4, 3, ganador1, KANSAS, 110, GANAR, PENDIENTE)	127.0.0.1	cesar		738	22:16:33
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (44, 4, 3, altabaja2, KAN/CAR, -110, AB/BAJA(48,5), PENDIENTE)	127.0.0.1	cesar		739	22:16:33
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (45, 2016-06-21, 22:16:40, 50, 340.69, PENDIENTE, 92004699, PARLEY, 1, cesar)	127.0.0.1	cesar		740	22:16:40
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (45, 4, 3, runline2, CAROLINA, -110, RLINE(-2,0), PENDIENTE)	127.0.0.1	cesar		741	22:16:40
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (45, 4, 2, runline1, SF49ERS, -115, RLINE(+3,5), PENDIENTE)	127.0.0.1	cesar		742	22:16:40
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (45, 4, 1, runline2, DENVER, -110, RLINE(-4,5), PENDIENTE)	127.0.0.1	cesar		743	22:16:40
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (42, 2016-06-21, 22:16:06, 50, 248.48, PENDIENTE, 17138366, PARLEY, 1, cesar)	127.0.0.1	cesar		725	22:16:06
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (42, 4, 1, ganador2, DENVER, -300, GANAR, PENDIENTE)	127.0.0.1	cesar		726	22:16:06
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (42, 4, 2, runline2, SEATTLE, -105, RLINE(-3,5), PENDIENTE)	127.0.0.1	cesar		727	22:16:06
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (42, 4, 3, altabaja2, KAN/CAR, -110, AB/BAJA(48,5), PENDIENTE)	127.0.0.1	cesar		728	22:16:06
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_futbol_americano (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (1,1, PAT/DEN, 2016-06-21, PATRIOTS, PATRIOTS, 43, 23x20, FINALIZADO)	127.0.0.1	cesar		744	22:16:59
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_futbol_americano (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (2,2, SF4/SEA, 2016-06-21, SF49ERS, SF49ERS, 53, 32x21, FINALIZADO)	127.0.0.1	cesar		745	22:17:13
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_futbol_americano (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (3,3, KAN/CAR, 2016-06-21, CAROLINA, CAROLINA, 50, 20x30, FINALIZADO)	127.0.0.1	cesar		746	22:17:26
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_hockey(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, estatus, id_liga) VALUES (1, ANA/LAN, ANAHEIM, LANGELES, 2, 2016-06-21, 23:55:00, 135, -155, -280, 180, 1.5, -120, -120, 5, ACTIVO, 14)	127.0.0.1	cesar		747	22:34:15
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_hockey(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, estatus, id_liga) VALUES (2, MIN/CHI, MINNESOTA, CHICAGO, 2, 2016-06-21, 23:55:00, 170, -210, -200, 120, 1.5, -135, -105, 5, ACTIVO, 14)	127.0.0.1	cesar		748	22:34:15
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_hockey(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, estatus, id_liga) VALUES (3, PIT/NYR, PITTSBURGH, NYRANGERS, 2, 2016-06-21, 23:55:00, -110, -120, -285, 185, 1.5, -135, -105, 5, ACTIVO, 14)	127.0.0.1	cesar		749	22:34:15
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_hockey(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, estatus, id_liga) VALUES (4, BOS/MON, BOSTON, MONTREAL, 1, 2016-06-21, 23:55:00, -140, 120, 200, -300, 1.5, -120, -120, 5, ACTIVO, 14)	127.0.0.1	cesar		750	22:34:15
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_hockey(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, estatus, id_liga) VALUES (5, LAN/ANA, LANGELES, ANAHEIM, 2, 2016-06-21, 23:55:00, 110, -130, -300, 200, 1.5, -110, -130, 5, ACTIVO, 14)	127.0.0.1	cesar		751	22:34:15
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (46, 2016-06-21, 22:34:37, 50, 605.66, PENDIENTE, 81152954, PARLEY, 1, cesar)	127.0.0.1	cesar		752	22:34:37
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (46, 5, 1, ganador1, ANAHEIM, 135, GANAR, PENDIENTE)	127.0.0.1	cesar		753	22:34:37
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (46, 5, 2, ganador1, MINNESOTA, 170, GANAR, PENDIENTE)	127.0.0.1	cesar		754	22:34:37
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (46, 5, 3, ganador1, PITTSBURGH, -110, GANAR, PENDIENTE)	127.0.0.1	cesar		755	22:34:37
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (47, 2016-06-21, 22:34:49, 50, 1236.72, PENDIENTE, 22870483, PARLEY, 1, cesar)	127.0.0.1	cesar		756	22:34:49
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (47, 5, 1, ganador2, LANGELES, -155, GANAR, PENDIENTE)	127.0.0.1	cesar		757	22:34:49
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (47, 5, 2, ganador2, CHICAGO, -210, GANAR, PENDIENTE)	127.0.0.1	cesar		758	22:34:49
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (47, 5, 3, ganador2, NYRANGERS, -120, GANAR, PENDIENTE)	127.0.0.1	cesar		759	22:34:49
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (47, 5, 1, altabaja1, ANA/LAN, -120, AB/ALTA(5,0), PENDIENTE)	127.0.0.1	cesar		760	22:34:49
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (47, 5, 2, altabaja1, MIN/CHI, -135, AB/ALTA(5,0), PENDIENTE)	127.0.0.1	cesar		761	22:34:49
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (47, 5, 3, altabaja1, PIT/NYR, -135, AB/ALTA(5,0), PENDIENTE)	127.0.0.1	cesar		762	22:34:49
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (48, 2016-06-21, 22:35:00, 50, 960.89, PENDIENTE, 89444885, PARLEY, 1, cesar)	127.0.0.1	cesar		763	22:35:00
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (48, 5, 1, runline1, ANAHEIM, -280, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		764	22:35:00
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (48, 5, 2, runline1, MINNESOTA, -200, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		765	22:35:00
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (48, 5, 3, runline1, PITTSBURGH, -285, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		766	22:35:00
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (48, 5, 1, altabaja2, ANA/LAN, -120, AB/BAJA(5,0), PENDIENTE)	127.0.0.1	cesar		767	22:35:00
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (48, 5, 2, altabaja2, MIN/CHI, -105, AB/BAJA(5,0), PENDIENTE)	127.0.0.1	cesar		768	22:35:00
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (48, 5, 3, altabaja2, PIT/NYR, -105, AB/BAJA(5,0), PENDIENTE)	127.0.0.1	cesar		769	22:35:00
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (49, 2016-06-21, 22:35:17, 50, 1031.21, PENDIENTE, 36878051, PARLEY, 1, cesar)	127.0.0.1	cesar		770	22:35:17
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (49, 5, 1, ganador1, ANAHEIM, 135, GANAR, PENDIENTE)	127.0.0.1	cesar		771	22:35:17
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (49, 5, 2, runline1, MINNESOTA, -200, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		772	22:35:17
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (49, 5, 3, altabaja1, PIT/NYR, -135, AB/ALTA(5,0), PENDIENTE)	127.0.0.1	cesar		773	22:35:17
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (49, 5, 3, ganador2, NYRANGERS, -120, GANAR, PENDIENTE)	127.0.0.1	cesar		774	22:35:17
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (49, 5, 1, altabaja2, ANA/LAN, -120, AB/BAJA(5,0), PENDIENTE)	127.0.0.1	cesar		775	22:35:17
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (50, 2016-06-21, 22:35:27, 50, 2418.45, PENDIENTE, 48309326, PARLEY, 1, cesar)	127.0.0.1	cesar		776	22:35:27
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (50, 5, 1, ganador2, LANGELES, -155, GANAR, PENDIENTE)	127.0.0.1	cesar		777	22:35:28
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (50, 5, 2, ganador2, CHICAGO, -210, GANAR, PENDIENTE)	127.0.0.1	cesar		778	22:35:28
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (50, 5, 2, altabaja2, MIN/CHI, -105, AB/BAJA(5,0), PENDIENTE)	127.0.0.1	cesar		779	22:35:28
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (50, 5, 1, altabaja2, ANA/LAN, -120, AB/BAJA(5,0), PENDIENTE)	127.0.0.1	cesar		780	22:35:28
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (50, 5, 3, altabaja2, PIT/NYR, -105, AB/BAJA(5,0), PENDIENTE)	127.0.0.1	cesar		781	22:35:28
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (50, 5, 3, runline2, NYRANGERS, 185, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		782	22:35:28
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_hockey (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (1,1, ANA/LAN, 2016-06-21, ANAHEIM, ANAHEIM, 6, 5x1, FINALIZADO)	127.0.0.1	cesar		783	22:35:58
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_hockey (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (2,2, MIN/CHI, 2016-06-21, MINNESOTA, MINNESOTA, 4, 3x1, FINALIZADO)	127.0.0.1	cesar		784	22:36:07
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_hockey (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (3,3, PIT/NYR, 2016-06-21, PITTSBURGH, PITTSBURGH, 5, 4x1, FINALIZADO)	127.0.0.1	cesar		785	22:36:18
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_tennis(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, estatus, id_liga) VALUES (1, RAO/BEC, RAONIC, BECKER, 1, 2016-06-21, 23:55:00, -1200, 600, ACTIVO, 33)	127.0.0.1	cesar		786	22:44:12
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_tennis(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, estatus, id_liga) VALUES (2, ISN/BER, ISNER, BERDYCH, 2, 2016-06-21, 23:55:00, 180, -300, ACTIVO, 33)	127.0.0.1	cesar		787	22:44:12
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_tennis(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, estatus, id_liga) VALUES (3, MUR/DJO, MURRAY, DJOKOVIC, 2, 2016-06-21, 23:55:00, 250, -350, ACTIVO, 33)	127.0.0.1	cesar		788	22:44:13
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_tennis(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, estatus, id_liga) VALUES (4, FED/NIS, FEDERER, NISHIKORI, 1, 2016-06-21, 23:55:00, -800, 400, ACTIVO, 33)	127.0.0.1	cesar		789	22:44:13
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_tennis(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, estatus, id_liga) VALUES (5, NAD/RAO, NADAL, RAONIC, 1, 2016-06-21, 23:55:00, -1000, 500, ACTIVO, 33)	127.0.0.1	cesar		790	22:44:13
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_boxeo (id, id_logro, encuentro, fecha, ganador, marcador, estatus) VALUES (1,1, GAR/MAT, 2016-06-21, GARCIA, 1, FINALIZADO)	127.0.0.1	cesar		830	22:54:42
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_boxeo(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, estatus, id_liga) VALUES (1, GAR/MAT, GARCIA, MATTHYSSE, 2, 2016-06-21, 23:55:00, 180, -280, ACTIVO, 20)	127.0.0.1	cesar		791	22:45:08
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_boxeo(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, estatus, id_liga) VALUES (2, ALV/MAY, ALVAREZ, MAYWEATHER, 2, 2016-06-21, 23:55:00, 220, -300, ACTIVO, 20)	127.0.0.1	cesar		792	22:45:08
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_boxeo(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, estatus, id_liga) VALUES (3, BRA/PAC, BRADLEY, PACQUIAO, 2, 2016-06-21, 23:55:00, 180, -240, ACTIVO, 20)	127.0.0.1	cesar		793	22:45:08
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (51, 2016-06-21, 22:46:30, 50, 89.38, PENDIENTE, 68202819, PARLEY, 1, cesar)	127.0.0.1	cesar		794	22:46:30
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (51, 6, 4, ganador1, FEDERER, -800, GANAR, PENDIENTE)	127.0.0.1	cesar		795	22:46:30
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (51, 6, 5, ganador1, NADAL, -1000, GANAR, PENDIENTE)	127.0.0.1	cesar		796	22:46:30
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (51, 6, 1, ganador1, RAONIC, -1200, GANAR, PENDIENTE)	127.0.0.1	cesar		797	22:46:30
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (51, 6, 2, ganador2, BERDYCH, -300, GANAR, PENDIENTE)	127.0.0.1	cesar		798	22:46:30
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (52, 2016-06-21, 22:47:06, 50, 284.38, PENDIENTE, 73355407, PARLEY, 1, cesar)	127.0.0.1	cesar		799	22:47:06
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (52, 6, 1, ganador1, RAONIC, -1200, GANAR, PENDIENTE)	127.0.0.1	cesar		800	22:47:06
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (52, 6, 2, ganador2, BERDYCH, -300, GANAR, PENDIENTE)	127.0.0.1	cesar		801	22:47:06
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (52, 6, 3, ganador1, MURRAY, 250, GANAR, PENDIENTE)	127.0.0.1	cesar		802	22:47:06
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (52, 6, 4, ganador1, FEDERER, -800, GANAR, PENDIENTE)	127.0.0.1	cesar		803	22:47:06
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (53, 2016-06-21, 22:47:22, 50, 3858.75, PENDIENTE, 55645446, PARLEY, 1, cesar)	127.0.0.1	cesar		804	22:47:22
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (53, 6, 1, ganador2, BECKER, 600, GANAR, PENDIENTE)	127.0.0.1	cesar		805	22:47:22
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (53, 6, 2, ganador1, ISNER, 180, GANAR, PENDIENTE)	127.0.0.1	cesar		806	22:47:22
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (53, 6, 3, ganador1, MURRAY, 250, GANAR, PENDIENTE)	127.0.0.1	cesar		807	22:47:22
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (53, 6, 4, ganador1, FEDERER, -800, GANAR, PENDIENTE)	127.0.0.1	cesar		808	22:47:22
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (54, 2016-06-21, 22:47:32, 50, 79.55, PENDIENTE, 67076721, PARLEY, 1, cesar)	127.0.0.1	cesar		809	22:47:32
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (54, 6, 3, ganador2, DJOKOVIC, -350, GANAR, PENDIENTE)	127.0.0.1	cesar		810	22:47:32
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (54, 6, 4, ganador1, FEDERER, -800, GANAR, PENDIENTE)	127.0.0.1	cesar		811	22:47:32
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (54, 6, 5, ganador1, NADAL, -1000, GANAR, PENDIENTE)	127.0.0.1	cesar		812	22:47:32
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_tennis (id, id_logro, encuentro, fecha, ganador, marcador, estatus) VALUES (1,1, RAO/BEC, 2016-06-21, RAONIC, 1, FINALIZADO)	127.0.0.1	cesar		813	22:47:47
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_tennis (id, id_logro, encuentro, fecha, ganador, marcador, estatus) VALUES (2,2, ISN/BER, 2016-06-21, BERDYCH, 2, FINALIZADO)	127.0.0.1	cesar		814	22:47:56
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_tennis (id, id_logro, encuentro, fecha, ganador, marcador, estatus) VALUES (3,3, MUR/DJO, 2016-06-21, DJOKOVIC, 3, FINALIZADO)	127.0.0.1	cesar		815	22:48:09
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_tennis (id, id_logro, encuentro, fecha, ganador, marcador, estatus) VALUES (4,5, NAD/RAO, 2016-06-21, NADAL, 4, FINALIZADO)	127.0.0.1	cesar		816	22:48:17
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_tennis (id, id_logro, encuentro, fecha, ganador, marcador, estatus) VALUES (5,4, FED/NIS, 2016-06-21, FEDERER, 5, FINALIZADO)	127.0.0.1	cesar		817	22:48:26
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (55, 2016-06-21, 22:52:54, 50, 264.44, PENDIENTE, 93163757, PARLEY, 1, cesar)	127.0.0.1	cesar		818	22:52:54
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (55, 7, 2, ganador2, MAYWEATHER, -300, GANAR, PENDIENTE)	127.0.0.1	cesar		819	22:52:54
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (55, 7, 3, ganador2, PACQUIAO, -240, GANAR, PENDIENTE)	127.0.0.1	cesar		820	22:52:54
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (55, 7, 1, ganador1, GARCIA, 180, GANAR, PENDIENTE)	127.0.0.1	cesar		821	22:52:54
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (56, 2016-06-21, 22:53:03, 50, 1254.40, PENDIENTE, 49451904, PARLEY, 1, cesar)	127.0.0.1	cesar		822	22:53:03
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (56, 7, 1, ganador1, GARCIA, 180, GANAR, PENDIENTE)	127.0.0.1	cesar		823	22:53:03
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (56, 7, 2, ganador1, ALVAREZ, 220, GANAR, PENDIENTE)	127.0.0.1	cesar		824	22:53:03
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (56, 7, 3, ganador1, BRADLEY, 180, GANAR, PENDIENTE)	127.0.0.1	cesar		825	22:53:03
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (57, 2016-06-21, 22:53:18, 50, 307.62, PENDIENTE, 66598815, PARLEY, 1, cesar)	127.0.0.1	cesar		826	22:53:18
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (57, 7, 1, ganador2, MATTHYSSE, -280, GANAR, PENDIENTE)	127.0.0.1	cesar		827	22:53:18
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (57, 7, 2, ganador1, ALVAREZ, 220, GANAR, PENDIENTE)	127.0.0.1	cesar		828	22:53:18
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (57, 7, 3, ganador2, PACQUIAO, -240, GANAR, PENDIENTE)	127.0.0.1	cesar		829	22:53:18
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_formula1(id, encuentro, equipo1, ganador1, equipo2, ganador2, equipo3, ganador3, equipo4, ganador4, equipo5, ganador5, equipo6, ganador6, equipo7, ganador7, equipo8, ganador8, equipo9, ganador9, equipo10, ganador10, equipo11, ganador11, equipo12, ganador12, equipo13, ganador13, equipo14, ganador14, equipo15, ganador15, equipo16, ganador16, equipo17, ganador17, equipo18, ganador18, equipo19, ganador19, equipo20, ganador20, equipo21, ganador21, equipo22, ganador22, equipo23, ganador23, equipo24, ganador24, favorito, fecha, hora, estatus, id_liga) VALUES (1, GP INGLATERRA, GASQUET, RUSSELL, ROSBERG, 1442, HAMILTON, 290, BUTTON, 1442, VETTEL, 150, WEBBER, 1142, PEREZ, 2942, RAIKKONEN, 1042, MALDONADO, 2942, GROSJEAN, 942, SCHUMACHER, 1542, KOBAYASHI, 1942, DIRESTA, 1942, HULKENBERG, 1942, SENNA, 1942, MASSA, 1942, VERGENE, 1942, RICCIARDO, 1942, KOVALAINEN, 1942, PETROV, 1942, GLOCK, 1942, PIC, 1942, KARTHIKEYAN, 1942, DELAROSA, 1942, 6, 2016-06-21, 23:00:00, ACTIVO, 21)	127.0.0.1	cesar		833	23:01:03
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_formula1(id, encuentro, equipo1, ganador1, equipo2, ganador2, equipo3, ganador3, equipo4, ganador4, equipo5, ganador5, equipo6, ganador6, equipo7, ganador7, equipo8, ganador8, equipo9, ganador9, equipo10, ganador10, equipo11, ganador11, equipo12, ganador12, equipo13, ganador13, equipo14, ganador14, equipo15, ganador15, equipo16, ganador16, equipo17, ganador17, equipo18, ganador18, equipo19, ganador19, equipo20, ganador20, equipo21, ganador21, equipo22, ganador22, equipo23, ganador23, equipo24, ganador24, favorito, fecha, hora, estatus, id_liga) VALUES (1, GP INGLATERRA, GASQUET, RUSSELL, ROSBERG, 1442, HAMILTON, 290, BUTTON, 1442, VETTEL, 150, WEBBER, 1142, PEREZ, 2942, RAIKKONEN, 1042, MALDONADO, 2942, GROSJEAN, 942, SCHUMACHER, 1542, KOBAYASHI, 1942, DIRESTA, 1942, HULKENBERG, 1942, SENNA, 1942, MASSA, 1942, VERGENE, 1942, RICCIARDO, 1942, KOVALAINEN, 1942, PETROV, 1942, GLOCK, 1942, PIC, 1942, KARTHIKEYAN, 1942, DELAROSA, 1942, 6, 2016-06-21, 23:55:00, ACTIVO, 21)	127.0.0.1	cesar		834	23:02:39
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_formula1(id, encuentro, equipo1, ganador1, equipo2, ganador2, equipo3, ganador3, equipo4, ganador4, equipo5, ganador5, equipo6, ganador6, equipo7, ganador7, equipo8, ganador8, equipo9, ganador9, equipo10, ganador10, equipo11, ganador11, equipo12, ganador12, equipo13, ganador13, equipo14, ganador14, equipo15, ganador15, equipo16, ganador16, equipo17, ganador17, equipo18, ganador18, equipo19, ganador19, equipo20, ganador20, equipo21, ganador21, equipo22, ganador22, equipo23, ganador23, equipo24, ganador24, favorito, fecha, hora, estatus, id_liga) VALUES (1, GP INGLATERRA, GASQUET, RUSSELL, ROSBERG, 1442, HAMILTON, 290, BUTTON, 1442, VETTEL, 150, WEBBER, 1142, PEREZ, 2942, RAIKKONEN, 1042, MALDONADO, 2942, GROSJEAN, 942, SCHUMACHER, 1542, KOBAYASHI, 1942, DIRESTA, 1942, HULKENBERG, 1942, SENNA, 1942, MASSA, 1942, VERGENE, 1942, RICCIARDO, 1942, KOVALAINEN, 1942, PETROV, 1942, GLOCK, 1942, PIC, 1942, KARTHIKEYAN, 1942, DELAROSA, 1942, 6, 2016-06-21, 23:55:00, ACTIVO, 21)	127.0.0.1	cesar		835	23:03:15
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_formula1(id, encuentro, equipo1, ganador1, equipo2, ganador2, equipo3, ganador3, equipo4, ganador4, equipo5, ganador5, equipo6, ganador6, equipo7, ganador7, equipo8, ganador8, equipo9, ganador9, equipo10, ganador10, equipo11, ganador11, equipo12, ganador12, equipo13, ganador13, equipo14, ganador14, equipo15, ganador15, equipo16, ganador16, equipo17, ganador17, equipo18, ganador18, equipo19, ganador19, equipo20, ganador20, equipo21, ganador21, equipo22, ganador22, equipo23, ganador23, equipo24, ganador24, favorito, fecha, hora, estatus, id_liga) VALUES (1, GP INGLATERRA, GASQUET, RUSSELL, ROSBERG, 1442, HAMILTON, 290, BUTTON, 1442, VETTEL, 150, WEBBER, 1142, PEREZ, 2942, RAIKKONEN, 1042, MALDONADO, 2942, GROSJEAN, 942, SCHUMACHER, 1542, KOBAYASHI, 1942, DIRESTA, 1942, HULKENBERG, 1942, SENNA, 1942, MASSA, 1942, VERGENE, 1942, RICCIARDO, 1942, KOVALAINEN, 1942, PETROV, 1942, GLOCK, 1942, PIC, 1942, KARTHIKEYAN, 1942, DELAROSA, 1942, 6, 2016-06-21, 23:55:00, ACTIVO, 21)	127.0.0.1	cesar		836	23:04:29
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (60, 2016-06-21, 23:07:19, 50, 1231.50, PENDIENTE, 91968994, PARLEY, 1, cesar)	127.0.0.1	cesar		846	23:07:19
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=9	127.0.0.1	cesar		934	20:03:27
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_formula1(id, encuentro, equipo1, ganador1, equipo2, ganador2, equipo3, ganador3, equipo4, ganador4, equipo5, ganador5, equipo6, ganador6, equipo7, ganador7, equipo8, ganador8, equipo9, ganador9, equipo10, ganador10, equipo11, ganador11, equipo12, ganador12, equipo13, ganador13, equipo14, ganador14, equipo15, ganador15, equipo16, ganador16, equipo17, ganador17, equipo18, ganador18, equipo19, ganador19, equipo20, ganador20, equipo21, ganador21, equipo22, ganador22, equipo23, ganador23, equipo24, ganador24, favorito, fecha, hora, estatus, id_liga) VALUES (1, GP INGLATERRA, GASQUET, 300, ROSBERG, 1442, HAMILTON, 290, BUTTON, 1442, VETTEL, 150, WEBBER, 1142, PEREZ, 2942, RAIKKONEN, 1042, MALDONADO, 2942, GROSJEAN, 942, SCHUMACHER, 1542, KOBAYASHI, 1942, DIRESTA, 1942, HULKENBERG, 1942, SENNA, 1942, MASSA, 1942, VERGENE, 1942, RICCIARDO, 1942, KOVALAINEN, 1942, PETROV, 1942, GLOCK, 1942, PIC, 1942, KARTHIKEYAN, 1942, DELAROSA, 1942, 6, 2016-06-21, 23:55:00, ACTIVO, 21)	127.0.0.1	cesar		837	23:06:27
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (58, 2016-06-21, 23:06:51, 50, 282.05, PENDIENTE, 77961425, PARLEY, 1, cesar)	127.0.0.1	cesar		838	23:06:51
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (58, 8, 1, ganador3, HAMILTON, 290, GANAR, PENDIENTE)	127.0.0.1	cesar		839	23:06:51
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (58, 6, 3, ganador2, DJOKOVIC, -350, GANAR, PENDIENTE)	127.0.0.1	cesar		840	23:06:51
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (58, 6, 4, ganador1, FEDERER, -800, GANAR, PENDIENTE)	127.0.0.1	cesar		841	23:06:51
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (59, 2016-06-21, 23:07:02, 50, 1732.03, PENDIENTE, 54535827, PARLEY, 1, cesar)	127.0.0.1	cesar		842	23:07:02
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (59, 8, 1, ganador8, RAIKKONEN, 1042, GANAR, PENDIENTE)	127.0.0.1	cesar		843	23:07:02
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (59, 7, 1, ganador1, GARCIA, 180, GANAR, PENDIENTE)	127.0.0.1	cesar		844	23:07:02
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (59, 6, 1, ganador1, RAONIC, -1200, GANAR, PENDIENTE)	127.0.0.1	cesar		845	23:07:02
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (60, 8, 1, ganador11, SCHUMACHER, 1542, GANAR, PENDIENTE)	127.0.0.1	cesar		847	23:07:19
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (60, 7, 2, ganador2, MAYWEATHER, -300, GANAR, PENDIENTE)	127.0.0.1	cesar		848	23:07:19
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (60, 6, 4, ganador1, FEDERER, -800, GANAR, PENDIENTE)	127.0.0.1	cesar		849	23:07:19
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_formula1 (id, id_logro, encuentro, fecha, ganador, tiempo, estatus) VALUES (1,1, GP INGLATERRA, 2016-06-21, SCHUMACHER, 0, FINALIZADO)	127.0.0.1	cesar		850	23:07:37
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (61, 2016-06-21, 23:17:15, 50, 522.68, PENDIENTE, 17272949, PARLEY, 1, cesar)	127.0.0.1	cesar		851	23:17:15
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (61, 1, 1, p_inning1, CIN/ATL, 100, P/INNG(SI), PENDIENTE)	127.0.0.1	cesar		852	23:17:15
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (61, 1, 1, p_anotar2, ATLANTA, -115, P/ANOT, PENDIENTE)	127.0.0.1	cesar		853	23:17:15
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (61, 1, 2, p_anotar1, PIRATES, -135, P/ANOT, PENDIENTE)	127.0.0.1	cesar		854	23:17:15
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (61, 1, 2, p_inning2, PIR/MET, -165, P/INNG(NO), PENDIENTE)	127.0.0.1	cesar		855	23:17:15
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (62, 2016-06-21, 23:17:41, 50, 958.71, PENDIENTE, 10994262, PARLEY, 1, cesar)	127.0.0.1	cesar		856	23:17:41
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (62, 1, 1, altabaja1, CIN/ATL, -120, AB/ALTA(8,0), PENDIENTE)	127.0.0.1	cesar		857	23:17:41
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (62, 1, 1, runline1, CINCINNATI, -225, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		858	23:17:41
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (62, 1, 1, p_anotar1, CINCINNATI, -135, P/ANOT, PENDIENTE)	127.0.0.1	cesar		859	23:17:41
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (62, 1, 2, runline1, PIRATES, -205, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		860	23:17:41
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (62, 1, 2, p_inning2, PIR/MET, -165, P/INNG(NO), PENDIENTE)	127.0.0.1	cesar		861	23:17:41
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (62, 1, 2, p_anotar1, PIRATES, -135, P/ANOT, PENDIENTE)	127.0.0.1	cesar		862	23:17:41
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (63, 2016-06-21, 23:32:15, 50, 313.68, PENDIENTE, 56087646, PARLEY, 1, cesar)	127.0.0.1	cesar		863	23:32:15
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (63, 1, 1, altabaja1, CIN/ATL, -120, AB/ALTA(8,0), PENDIENTE)	127.0.0.1	cesar		864	23:32:15
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (63, 1, 2, srunline1, PIRATES, -205, SRLINE(+2,5), PENDIENTE)	127.0.0.1	cesar		865	23:32:15
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (63, 1, 3, ganador1, MILWAUKEE, 130, GANAR, PENDIENTE)	127.0.0.1	cesar		866	23:32:15
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (64, 2016-06-21, 23:35:01, 50, 6669.00, PENDIENTE, 29846801, PARLEY, 1, cesar)	127.0.0.1	cesar		867	23:35:01
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (64, 3, 7016, ganador1, ESPANA, 470, GANAR, PENDIENTE)	127.0.0.1	cesar		868	23:35:01
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (64, 3, 7017, runline1, GALES, 160, RLINE(+0,0), PENDIENTE)	127.0.0.1	cesar		869	23:35:01
2016-06-21	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (64, 3, 7019, ganador1, IRLNORTE, 800, GANAR, PENDIENTE)	127.0.0.1	cesar		870	23:35:01
2016-06-22	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-22, 20:20:05, 127.0.0.1)	127.0.0.1	cesar		871	20:20:05
2016-06-22	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-22, 22:37:03, 127.0.0.1)	127.0.0.1	cesar		872	22:37:03
2016-06-22	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-22, 22:48:45, 127.0.0.1)	127.0.0.1	cesar		873	22:48:45
2016-06-22	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-22, 22:48:57, 127.0.0.1)	127.0.0.1	cesar		874	22:48:57
2016-06-22	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-22, 22:53:03, 127.0.0.1)	127.0.0.1	cesar		875	22:53:03
2016-06-22	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-22, 22:53:42, 127.0.0.1)	127.0.0.1	cesar		876	22:53:42
2016-06-22	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-22, 23:07:29, 127.0.0.1)	127.0.0.1	cesar		877	23:07:29
2016-06-22	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-22, 23:09:20, 127.0.0.1)	127.0.0.1	cesar		878	23:09:20
2016-06-22	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (65, 2016-06-22, 23:11:45, 50, 4369.96, PENDIENTE, 36251831, PARLEY, 1, cesar)	127.0.0.1	cesar		879	23:11:45
2016-06-22	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (65, 1, 1, ganador1, CINCINNATI, -110, GANAR, PENDIENTE)	127.0.0.1	cesar		880	23:11:45
2016-06-22	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (65, 1, 2, runline1, PIRATES, -205, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		881	23:11:45
2016-06-22	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (65, 1, 3, srunline1, MILWAUKEE, -170, SRLINE(+2,5), PENDIENTE)	127.0.0.1	cesar		882	23:11:45
2016-06-22	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (65, 1, 4, altabaja1, NAT/PAD, -120, AB/ALTA(8,0), PENDIENTE)	127.0.0.1	cesar		883	23:11:45
2016-06-22	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (65, 1, 5, runlinem1, SEATTLE, -210, RLMITAD(+0,5), PENDIENTE)	127.0.0.1	cesar		884	23:11:45
2016-06-22	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (65, 1, 5, ab_mediojuego2, SEA/TAM, -120, ABM/BAJA(4,0), PENDIENTE)	127.0.0.1	cesar		885	23:11:45
2016-06-22	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (65, 1, 6, p_inning1, TEX/OAK, -105, P/INNG(SI), PENDIENTE)	127.0.0.1	cesar		886	23:11:45
2016-06-22	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (65, 1, 6, p_anotar2, OAKLAND, 100, P/ANOT, PENDIENTE)	127.0.0.1	cesar		887	23:11:45
2016-06-22	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (66, 2016-06-22, 23:19:26, 50, 4384.26, PENDIENTE, 77233581, PARLEY, 1, cesar)	127.0.0.1	cesar		888	23:19:26
2016-06-22	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (66, 1, 1, ganador1, CINCINNATI, -110, GANAR, PENDIENTE)	127.0.0.1	cesar		889	23:19:26
2016-06-22	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (66, 1, 3, ganador1, MILWAUKEE, 130, GANAR, PENDIENTE)	127.0.0.1	cesar		890	23:19:26
2016-06-22	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (66, 1, 4, ganador1, NATIONALS, -160, GANAR, PENDIENTE)	127.0.0.1	cesar		891	23:19:26
2016-06-22	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (66, 1, 7, ganador1, BALTIMORE, 125, GANAR, PENDIENTE)	127.0.0.1	cesar		892	23:19:26
2016-06-22	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (66, 1, 8, srunline2, MINNESOTA, -160, SRLINE(+2,5), PENDIENTE)	127.0.0.1	cesar		893	23:19:26
2016-06-22	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (66, 1, 5, ab_mediojuego1, SEA/TAM, -120, ABM/ALTA(4,0), PENDIENTE)	127.0.0.1	cesar		894	23:19:26
2016-06-22	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (66, 1, 6, ab_mediojuego1, TEX/OAK, -120, ABM/ALTA(4,5), PENDIENTE)	127.0.0.1	cesar		895	23:19:26
2016-06-25	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (67, 2016-06-25, 21:56:19, 50, 350.88, PENDIENTE, 47089843, PARLEY, 1, cesar)	127.0.0.1	cesar		898	21:56:19
2016-06-25	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (67, 1, 1, runline1, CINCINNATI, -225, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		899	21:56:20
2016-06-25	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (67, 1, 1, altabaja2, CIN/ATL, -120, AB/BAJA(8,0), PENDIENTE)	127.0.0.1	cesar		900	21:56:20
2016-06-25	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (67, 1, 2, runlinem2, METS, 165, RLMITAD(-0,5), PENDIENTE)	127.0.0.1	cesar		901	21:56:20
2016-06-26	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-26, 09:27:52, 127.0.0.1)	127.0.0.1	cesar		902	09:27:52
2016-06-26	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-26, 21:35:42, 127.0.0.1)	127.0.0.1	cesar		903	21:35:42
2016-06-26	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (68, 2016-06-26, 21:49:14, 50, 2511.25, PENDIENTE, 47471618, PARLEY, 1, cesar)	127.0.0.1	cesar		904	21:49:14
2016-06-26	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (68, 1, 1, ab_mediojuego1, CIN/ATL, -120, ABM/ALTA(4,0), PENDIENTE)	127.0.0.1	cesar		905	21:49:14
2016-06-26	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (68, 1, 2, ganador1, PIRATES, 105, GANAR, PENDIENTE)	127.0.0.1	cesar		906	21:49:14
2016-06-26	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (68, 1, 3, runline1, MILWAUKEE, -170, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		907	21:49:14
2016-06-26	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (68, 1, 3, altabaja1, MIL/DOD, -120, AB/ALTA(7,5), PENDIENTE)	127.0.0.1	cesar		908	21:49:14
2016-06-26	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (68, 1, 4, altabaja1, NAT/PAD, -120, AB/ALTA(8,0), PENDIENTE)	127.0.0.1	cesar		909	21:49:14
2016-06-26	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (68, 1, 7, srunline1, BALTIMORE, -185, SRLINE(+2,5), PENDIENTE)	127.0.0.1	cesar		910	21:49:14
2016-06-26	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (68, 1, 8, srunline2, MINNESOTA, -160, SRLINE(+2,5), PENDIENTE)	127.0.0.1	cesar		911	21:49:14
2016-06-26	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (69, 2016-06-26, 22:21:44, 1000, 5627.98, PENDIENTE, 26570129, PARLEY, 1, cesar)	127.0.0.1	cesar		912	22:21:44
2016-06-26	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (69, 3, 11008, ganador2, ARGENTINA, -400, GANAR, PENDIENTE)	127.0.0.1	cesar		913	22:21:44
2016-06-26	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (69, 3, 11007, ganador1, COLOMBIA, -210, GANAR, PENDIENTE)	127.0.0.1	cesar		914	22:21:44
2016-06-26	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (69, 3, 11006, empate, ECU/EEU, 205, EMPATE, PENDIENTE)	127.0.0.1	cesar		915	22:21:44
2016-06-26	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE agencia SET nombre=INV. JD00, ci_rif=12345678, direccion=SIN REGISTRO, telefono=04123123123, correo=cesar3r2@gmail.com, id_estado=19, ciudad=CUMANÁ, disponible=50000, premio_max=5000, porcentaje_venta=15, porcentaje_utilidad=10, id_banquero=15743511, estatus=ACTIVA, porcentaje_derecho=12, monto_max=1000, monto_derecho=500, id_grupo=1, monto_min=10 WHERE id=2	127.0.0.1	cesar		916	22:23:45
2016-06-27	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-27, 19:57:50, 127.0.0.1)	127.0.0.1	cesar		917	19:57:50
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=ACTIVA WHERE id=4	127.0.0.1	cesar		918	20:03:27
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=ACTIVA WHERE id=1	127.0.0.1	cesar		919	20:03:27
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=ACTIVA WHERE id=20	127.0.0.1	cesar		920	20:03:27
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=ACTIVA WHERE id=21	127.0.0.1	cesar		921	20:03:27
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=ACTIVA WHERE id=23	127.0.0.1	cesar		922	20:03:27
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=ACTIVA WHERE id=24	127.0.0.1	cesar		923	20:03:27
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=ACTIVA WHERE id=13	127.0.0.1	cesar		924	20:03:27
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=ACTIVA WHERE id=14	127.0.0.1	cesar		925	20:03:27
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=ACTIVA WHERE id=18	127.0.0.1	cesar		926	20:03:27
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=ACTIVA WHERE id=33	127.0.0.1	cesar		927	20:03:27
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=0	127.0.0.1	cesar		928	20:03:27
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=5	127.0.0.1	cesar		929	20:03:27
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=6	127.0.0.1	cesar		930	20:03:27
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=3	127.0.0.1	cesar		931	20:03:27
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=22	127.0.0.1	cesar		937	20:03:27
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=11	127.0.0.1	cesar		938	20:03:27
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=12	127.0.0.1	cesar		939	20:03:27
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=10	127.0.0.1	cesar		940	20:03:27
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=17	127.0.0.1	cesar		941	20:03:27
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=19	127.0.0.1	cesar		942	20:03:27
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=16	127.0.0.1	cesar		943	20:03:27
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=ACTIVA WHERE id=4	127.0.0.1	cesar		944	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=ACTIVA WHERE id=1	127.0.0.1	cesar		945	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=ACTIVA WHERE id=20	127.0.0.1	cesar		946	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=ACTIVA WHERE id=21	127.0.0.1	cesar		947	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=ACTIVA WHERE id=24	127.0.0.1	cesar		948	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=ACTIVA WHERE id=23	127.0.0.1	cesar		949	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=ACTIVA WHERE id=13	127.0.0.1	cesar		950	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=ACTIVA WHERE id=14	127.0.0.1	cesar		951	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=ACTIVA WHERE id=33	127.0.0.1	cesar		952	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=0	127.0.0.1	cesar		953	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=6	127.0.0.1	cesar		954	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=5	127.0.0.1	cesar		955	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=3	127.0.0.1	cesar		956	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=2	127.0.0.1	cesar		957	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=9	127.0.0.1	cesar		958	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=8	127.0.0.1	cesar		959	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=7	127.0.0.1	cesar		960	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=22	127.0.0.1	cesar		961	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=11	127.0.0.1	cesar		962	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=12	127.0.0.1	cesar		963	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=10	127.0.0.1	cesar		964	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=15	127.0.0.1	cesar		965	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=18	127.0.0.1	cesar		966	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=16	127.0.0.1	cesar		967	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=19	127.0.0.1	cesar		968	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE liga set estatus=INACTIVA WHERE id=17	127.0.0.1	cesar		969	20:12:16
2016-06-27	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (70, 2016-06-27, 20:13:12, 50, 2020.27, PENDIENTE, 48982238, PARLEY, 1, cesar)	127.0.0.1	cesar		970	20:13:12
2016-06-27	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (70, 1, 1, runline1, CINCINNATI, -225, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		971	20:13:12
2016-06-27	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (70, 1, 1, altabaja2, CIN/ATL, -120, AB/BAJA(8,0), PENDIENTE)	127.0.0.1	cesar		972	20:13:12
2016-06-27	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (70, 1, 2, g_mediojuego1, PIRATES, 105, GMITAD, PENDIENTE)	127.0.0.1	cesar		973	20:13:12
2016-06-27	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (70, 1, 2, ab_mediojuego2, PIR/MET, -120, ABM/BAJA(4,0), PENDIENTE)	127.0.0.1	cesar		974	20:13:12
2016-06-27	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (70, 1, 3, p_inning2, MIL/DOD, -165, P/INNG(NO), PENDIENTE)	127.0.0.1	cesar		975	20:13:12
2016-06-27	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (70, 1, 4, p_anotar1, NATIONALS, -180, P/ANOT, PENDIENTE)	127.0.0.1	cesar		976	20:13:12
2016-06-27	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (70, 1, 3, ganador2, DODGERS, -160, GANAR, PENDIENTE)	127.0.0.1	cesar		977	20:13:12
2016-06-27	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (71, 2016-06-27, 21:25:06, 50, 423.50, PENDIENTE, 66434020, PARLEY, 1, cesar)	127.0.0.1	cesar		978	21:25:06
2016-06-27	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (71, 1, 10, runline1, TORONTO, 110, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		979	21:25:06
2016-06-27	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (71, 1, 9, altabaja1, DET/KAN, -120, AB/ALTA(7,5), PENDIENTE)	127.0.0.1	cesar		980	21:25:06
2016-06-27	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (71, 1, 8, srunline1, YANKEES, 120, SRLINE(-2,5), PENDIENTE)	127.0.0.1	cesar		981	21:25:06
2016-06-27	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_boxeo (id, id_logro, encuentro, fecha, ganador, marcador, estatus) VALUES (3,3, BRA/PAC, 2016-06-27, PACQUIAO, 123, FINALIZADO)	127.0.0.1	cesar		982	21:56:01
2016-06-27	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_tennis (id, id_logro, encuentro, fecha, ganador, marcador, estatus) VALUES (5,4, FED/NIS, 2016-06-27, FEDERER, 12, FINALIZADO)	127.0.0.1	cesar		983	21:57:43
2016-06-27	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_hockey (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (4,4, BOS/MON, 2016-06-27, BOSTON, BOSTON, 4, 4x0, FINALIZADO)	127.0.0.1	cesar		984	21:59:29
2016-06-27	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_hockey (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (5,5, LAN/ANA, 2016-06-27, LANGELES, LANGELES, 3, 3x0, FINALIZADO)	127.0.0.1	cesar		985	21:59:38
2016-06-27	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_futbol_americano (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (3,3, KAN/CAR, 2016-06-27, KANSAS, KANSAS, 46, 34x12, FINALIZADO)	127.0.0.1	cesar		986	22:00:45
2016-06-27	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-27, 22:47:51, 127.0.0.1)	127.0.0.1	cesar		987	22:47:51
2016-06-28	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-28, 20:21:19, 127.0.0.1)	127.0.0.1	cesar		988	20:21:19
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=4	127.0.0.1	cesar		989	20:59:24
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=1	127.0.0.1	cesar		990	21:04:11
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=2	127.0.0.1	cesar		991	21:05:17
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=3	127.0.0.1	cesar		992	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=5	127.0.0.1	cesar		993	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=6	127.0.0.1	cesar		994	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=7	127.0.0.1	cesar		995	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=8	127.0.0.1	cesar		996	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=9	127.0.0.1	cesar		997	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=10	127.0.0.1	cesar		998	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=31	127.0.0.1	cesar		999	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=32	127.0.0.1	cesar		1000	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=33	127.0.0.1	cesar		1001	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=34	127.0.0.1	cesar		1002	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=35	127.0.0.1	cesar		1003	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=36	127.0.0.1	cesar		1004	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=37	127.0.0.1	cesar		1005	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=38	127.0.0.1	cesar		1006	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=39	127.0.0.1	cesar		1007	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=40	127.0.0.1	cesar		1008	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=41	127.0.0.1	cesar		1009	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=42	127.0.0.1	cesar		1010	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=43	127.0.0.1	cesar		1011	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=44	127.0.0.1	cesar		1012	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=45	127.0.0.1	cesar		1013	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=46	127.0.0.1	cesar		1014	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=47	127.0.0.1	cesar		1015	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=48	127.0.0.1	cesar		1016	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=49	127.0.0.1	cesar		1017	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=50	127.0.0.1	cesar		1018	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=51	127.0.0.1	cesar		1019	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=52	127.0.0.1	cesar		1020	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=53	127.0.0.1	cesar		1021	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=54	127.0.0.1	cesar		1022	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=55	127.0.0.1	cesar		1023	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=56	127.0.0.1	cesar		1024	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=57	127.0.0.1	cesar		1025	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=58	127.0.0.1	cesar		1026	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=59	127.0.0.1	cesar		1027	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=60	127.0.0.1	cesar		1028	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=61	127.0.0.1	cesar		1029	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=62	127.0.0.1	cesar		1030	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=63	127.0.0.1	cesar		1031	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=64	127.0.0.1	cesar		1032	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=65	127.0.0.1	cesar		1033	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=66	127.0.0.1	cesar		1034	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=67	127.0.0.1	cesar		1035	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=68	127.0.0.1	cesar		1036	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=69	127.0.0.1	cesar		1037	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=70	127.0.0.1	cesar		1038	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=71	127.0.0.1	cesar		1039	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=4	127.0.0.1	cesar		1040	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=1	127.0.0.1	cesar		1041	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=11	127.0.0.1	cesar		1042	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=12	127.0.0.1	cesar		1043	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=13	127.0.0.1	cesar		1044	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=14	127.0.0.1	cesar		1045	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=15	127.0.0.1	cesar		1046	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=16	127.0.0.1	cesar		1047	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=17	127.0.0.1	cesar		1048	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=18	127.0.0.1	cesar		1049	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=19	127.0.0.1	cesar		1050	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=20	127.0.0.1	cesar		1051	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=21	127.0.0.1	cesar		1052	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=22	127.0.0.1	cesar		1053	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=23	127.0.0.1	cesar		1054	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=24	127.0.0.1	cesar		1055	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=25	127.0.0.1	cesar		1056	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=26	127.0.0.1	cesar		1057	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=27	127.0.0.1	cesar		1058	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=28	127.0.0.1	cesar		1059	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=29	127.0.0.1	cesar		1060	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=30	127.0.0.1	cesar		1061	21:06:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=3	127.0.0.1	cesar		1062	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=5	127.0.0.1	cesar		1063	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=2	127.0.0.1	cesar		1064	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=6	127.0.0.1	cesar		1065	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=7	127.0.0.1	cesar		1066	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=8	127.0.0.1	cesar		1067	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=9	127.0.0.1	cesar		1068	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=10	127.0.0.1	cesar		1069	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=31	127.0.0.1	cesar		1070	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=32	127.0.0.1	cesar		1071	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=33	127.0.0.1	cesar		1072	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=34	127.0.0.1	cesar		1073	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=35	127.0.0.1	cesar		1074	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=36	127.0.0.1	cesar		1075	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=37	127.0.0.1	cesar		1076	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=38	127.0.0.1	cesar		1077	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=39	127.0.0.1	cesar		1078	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=40	127.0.0.1	cesar		1079	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=50	127.0.0.1	cesar		1080	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=51	127.0.0.1	cesar		1081	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=52	127.0.0.1	cesar		1082	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=53	127.0.0.1	cesar		1083	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=54	127.0.0.1	cesar		1084	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=55	127.0.0.1	cesar		1085	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=56	127.0.0.1	cesar		1086	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=57	127.0.0.1	cesar		1087	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=58	127.0.0.1	cesar		1088	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=59	127.0.0.1	cesar		1089	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=60	127.0.0.1	cesar		1090	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=61	127.0.0.1	cesar		1091	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=62	127.0.0.1	cesar		1092	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=63	127.0.0.1	cesar		1093	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=64	127.0.0.1	cesar		1094	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=65	127.0.0.1	cesar		1095	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=66	127.0.0.1	cesar		1096	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=67	127.0.0.1	cesar		1097	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=68	127.0.0.1	cesar		1098	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=69	127.0.0.1	cesar		1099	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=70	127.0.0.1	cesar		1100	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=71	127.0.0.1	cesar		1101	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=4	127.0.0.1	cesar		1102	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=1	127.0.0.1	cesar		1103	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=11	127.0.0.1	cesar		1104	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=12	127.0.0.1	cesar		1105	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=13	127.0.0.1	cesar		1106	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=41	127.0.0.1	cesar		1107	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=42	127.0.0.1	cesar		1108	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=43	127.0.0.1	cesar		1109	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=44	127.0.0.1	cesar		1110	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=45	127.0.0.1	cesar		1111	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=46	127.0.0.1	cesar		1112	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=47	127.0.0.1	cesar		1113	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=48	127.0.0.1	cesar		1114	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=49	127.0.0.1	cesar		1115	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=14	127.0.0.1	cesar		1116	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=15	127.0.0.1	cesar		1117	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=16	127.0.0.1	cesar		1118	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=17	127.0.0.1	cesar		1119	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=18	127.0.0.1	cesar		1120	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=19	127.0.0.1	cesar		1121	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=20	127.0.0.1	cesar		1122	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=21	127.0.0.1	cesar		1123	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=22	127.0.0.1	cesar		1124	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=23	127.0.0.1	cesar		1125	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=24	127.0.0.1	cesar		1126	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=25	127.0.0.1	cesar		1127	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=26	127.0.0.1	cesar		1128	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=27	127.0.0.1	cesar		1129	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=28	127.0.0.1	cesar		1130	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=29	127.0.0.1	cesar		1131	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=30	127.0.0.1	cesar		1132	21:31:49
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=3	127.0.0.1	cesar		1133	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=5	127.0.0.1	cesar		1134	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=2	127.0.0.1	cesar		1135	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=6	127.0.0.1	cesar		1136	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=7	127.0.0.1	cesar		1137	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=8	127.0.0.1	cesar		1138	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=9	127.0.0.1	cesar		1139	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=10	127.0.0.1	cesar		1140	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=31	127.0.0.1	cesar		1141	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=32	127.0.0.1	cesar		1142	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=33	127.0.0.1	cesar		1143	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=34	127.0.0.1	cesar		1144	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=35	127.0.0.1	cesar		1145	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=36	127.0.0.1	cesar		1146	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=37	127.0.0.1	cesar		1147	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=38	127.0.0.1	cesar		1148	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=39	127.0.0.1	cesar		1149	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=40	127.0.0.1	cesar		1150	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=60	127.0.0.1	cesar		1151	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=61	127.0.0.1	cesar		1152	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=62	127.0.0.1	cesar		1153	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=63	127.0.0.1	cesar		1154	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=64	127.0.0.1	cesar		1155	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=65	127.0.0.1	cesar		1156	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=66	127.0.0.1	cesar		1157	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=67	127.0.0.1	cesar		1158	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=68	127.0.0.1	cesar		1159	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=69	127.0.0.1	cesar		1160	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=70	127.0.0.1	cesar		1161	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=71	127.0.0.1	cesar		1162	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=4	127.0.0.1	cesar		1163	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=1	127.0.0.1	cesar		1164	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=11	127.0.0.1	cesar		1165	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=12	127.0.0.1	cesar		1166	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=13	127.0.0.1	cesar		1167	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=50	127.0.0.1	cesar		1168	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=51	127.0.0.1	cesar		1169	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=52	127.0.0.1	cesar		1170	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=53	127.0.0.1	cesar		1171	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=54	127.0.0.1	cesar		1172	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=55	127.0.0.1	cesar		1173	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=56	127.0.0.1	cesar		1174	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=57	127.0.0.1	cesar		1175	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=58	127.0.0.1	cesar		1176	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=59	127.0.0.1	cesar		1177	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=41	127.0.0.1	cesar		1178	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=42	127.0.0.1	cesar		1179	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=43	127.0.0.1	cesar		1180	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=44	127.0.0.1	cesar		1181	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=45	127.0.0.1	cesar		1182	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=46	127.0.0.1	cesar		1183	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=47	127.0.0.1	cesar		1184	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=48	127.0.0.1	cesar		1185	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=49	127.0.0.1	cesar		1186	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=14	127.0.0.1	cesar		1187	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=15	127.0.0.1	cesar		1188	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=16	127.0.0.1	cesar		1189	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=17	127.0.0.1	cesar		1190	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=18	127.0.0.1	cesar		1191	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=19	127.0.0.1	cesar		1192	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=20	127.0.0.1	cesar		1193	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=21	127.0.0.1	cesar		1194	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=22	127.0.0.1	cesar		1195	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=23	127.0.0.1	cesar		1196	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=24	127.0.0.1	cesar		1197	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=25	127.0.0.1	cesar		1198	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=26	127.0.0.1	cesar		1199	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=27	127.0.0.1	cesar		1200	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=28	127.0.0.1	cesar		1201	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=29	127.0.0.1	cesar		1202	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=30	127.0.0.1	cesar		1203	21:36:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (4,4, NAT/PAD, 2016-06-28, PADRES, PADRES, PADRES, 0x9, 9, PADRES, PADRES, 0x6, 6, SI, PADRES, FINALIZADO)	127.0.0.1	cesar		1204	21:38:31
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=9	127.0.0.1	cesar		1205	21:39:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=10	127.0.0.1	cesar		1206	21:39:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=64	127.0.0.1	cesar		1207	21:39:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=65	127.0.0.1	cesar		1208	21:39:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=66	127.0.0.1	cesar		1209	21:39:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=68	127.0.0.1	cesar		1210	21:39:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=69	127.0.0.1	cesar		1211	21:39:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=70	127.0.0.1	cesar		1212	21:39:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=71	127.0.0.1	cesar		1213	21:39:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=22	127.0.0.1	cesar		1214	21:39:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=24	127.0.0.1	cesar		1215	21:39:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=25	127.0.0.1	cesar		1216	21:39:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=26	127.0.0.1	cesar		1217	21:39:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (5,5, SEA/TAM, 2016-06-28, TAMPA, TAMPA, TAMPA, 0x6, 6, TAMPA, TAMPA, 0x5, 5, SI, TAMPA, FINALIZADO)	127.0.0.1	cesar		1218	21:40:02
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=9	127.0.0.1	cesar		1219	21:40:10
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=10	127.0.0.1	cesar		1220	21:40:10
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=64	127.0.0.1	cesar		1221	21:40:10
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=65	127.0.0.1	cesar		1222	21:40:10
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=66	127.0.0.1	cesar		1223	21:40:10
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=68	127.0.0.1	cesar		1224	21:40:10
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=69	127.0.0.1	cesar		1225	21:40:10
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=71	127.0.0.1	cesar		1226	21:40:10
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=22	127.0.0.1	cesar		1227	21:40:10
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=24	127.0.0.1	cesar		1228	21:40:11
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=25	127.0.0.1	cesar		1229	21:40:11
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=26	127.0.0.1	cesar		1230	21:40:11
2016-06-28	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (72, 2016-06-28, 21:50:38, 50, 237.66, PENDIENTE, 71916198, PARLEY, 1, cesar)	127.0.0.1	cesar		1231	21:50:38
2016-06-28	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (72, 1, 3, ganador2, DODGERS, -160, GANAR, PENDIENTE)	127.0.0.1	cesar		1232	21:50:38
2016-06-28	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (72, 1, 4, ganador1, NATIONALS, -160, GANAR, PENDIENTE)	127.0.0.1	cesar		1233	21:50:38
2016-06-28	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (72, 1, 2, ganador2, METS, -125, GANAR, PENDIENTE)	127.0.0.1	cesar		1234	21:50:38
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=72	127.0.0.1	cesar		1235	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=3	127.0.0.1	cesar		1236	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=5	127.0.0.1	cesar		1237	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=2	127.0.0.1	cesar		1238	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=6	127.0.0.1	cesar		1239	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=7	127.0.0.1	cesar		1240	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=8	127.0.0.1	cesar		1241	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=31	127.0.0.1	cesar		1242	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=32	127.0.0.1	cesar		1243	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=33	127.0.0.1	cesar		1244	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=34	127.0.0.1	cesar		1245	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=35	127.0.0.1	cesar		1246	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=36	127.0.0.1	cesar		1247	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=37	127.0.0.1	cesar		1248	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=38	127.0.0.1	cesar		1249	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=39	127.0.0.1	cesar		1250	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=40	127.0.0.1	cesar		1251	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=60	127.0.0.1	cesar		1252	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=61	127.0.0.1	cesar		1253	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=62	127.0.0.1	cesar		1254	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=63	127.0.0.1	cesar		1255	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=67	127.0.0.1	cesar		1256	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=4	127.0.0.1	cesar		1257	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=1	127.0.0.1	cesar		1258	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=11	127.0.0.1	cesar		1259	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=12	127.0.0.1	cesar		1260	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=13	127.0.0.1	cesar		1261	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=70	127.0.0.1	cesar		1262	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=9	127.0.0.1	cesar		1263	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=10	127.0.0.1	cesar		1264	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=64	127.0.0.1	cesar		1265	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=65	127.0.0.1	cesar		1266	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=66	127.0.0.1	cesar		1267	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=68	127.0.0.1	cesar		1268	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=69	127.0.0.1	cesar		1269	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=71	127.0.0.1	cesar		1270	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=50	127.0.0.1	cesar		1271	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=51	127.0.0.1	cesar		1272	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=52	127.0.0.1	cesar		1273	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=53	127.0.0.1	cesar		1274	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=54	127.0.0.1	cesar		1275	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=55	127.0.0.1	cesar		1276	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=56	127.0.0.1	cesar		1277	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=57	127.0.0.1	cesar		1278	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=58	127.0.0.1	cesar		1279	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=59	127.0.0.1	cesar		1280	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=41	127.0.0.1	cesar		1281	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=42	127.0.0.1	cesar		1282	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=43	127.0.0.1	cesar		1283	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=44	127.0.0.1	cesar		1284	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=45	127.0.0.1	cesar		1285	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=46	127.0.0.1	cesar		1286	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=47	127.0.0.1	cesar		1287	21:52:54
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=48	127.0.0.1	cesar		1288	21:52:55
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=49	127.0.0.1	cesar		1289	21:52:55
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=22	127.0.0.1	cesar		1290	21:52:55
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=24	127.0.0.1	cesar		1291	21:52:55
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=25	127.0.0.1	cesar		1292	21:52:55
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=26	127.0.0.1	cesar		1293	21:52:55
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=14	127.0.0.1	cesar		1294	21:52:55
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=15	127.0.0.1	cesar		1295	21:52:55
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=16	127.0.0.1	cesar		1296	21:52:55
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=17	127.0.0.1	cesar		1297	21:52:55
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=18	127.0.0.1	cesar		1298	21:52:55
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=19	127.0.0.1	cesar		1299	21:52:55
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=20	127.0.0.1	cesar		1300	21:52:55
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=21	127.0.0.1	cesar		1301	21:52:55
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=23	127.0.0.1	cesar		1302	21:52:55
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=27	127.0.0.1	cesar		1303	21:52:55
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=28	127.0.0.1	cesar		1304	21:52:55
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=29	127.0.0.1	cesar		1305	21:52:55
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=30	127.0.0.1	cesar		1306	21:52:55
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PAGADA WHERE id=4 AND id_seguridad=44016418	127.0.0.1	cesar		1307	22:10:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PAGADA WHERE id_apuesta=4	127.0.0.1	cesar		1308	22:10:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (73, 2016-06-28, 22:15:02, 50, 990.00, PENDIENTE, 71454772, PARLEY, 1, cesar)	127.0.0.1	cesar		1309	22:15:02
2016-06-28	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (73, 3, 7014, ganador1, AUSTRIA, 200, GANAR, PENDIENTE)	127.0.0.1	cesar		1310	22:15:02
2016-06-28	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (73, 3, 7017, ganador2, HUNGRIA, 100, GANAR, PENDIENTE)	127.0.0.1	cesar		1311	22:15:02
2016-06-28	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (73, 3, 7018, empate, ING/IRL, 230, EMPATE, PENDIENTE)	127.0.0.1	cesar		1312	22:15:02
2016-06-28	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_futbol (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (4,7014, AUS/BEL, 2016-06-28, 0, 0, 0, 0x0, SUSPENDIDO)	127.0.0.1	cesar		1313	22:15:35
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=73	127.0.0.1	cesar		1314	22:16:51
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=10	127.0.0.1	cesar		1315	22:16:51
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=64	127.0.0.1	cesar		1316	22:16:51
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=65	127.0.0.1	cesar		1317	22:16:51
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=66	127.0.0.1	cesar		1318	22:16:51
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=68	127.0.0.1	cesar		1319	22:16:51
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=69	127.0.0.1	cesar		1320	22:16:51
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=71	127.0.0.1	cesar		1321	22:16:51
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=22	127.0.0.1	cesar		1322	22:16:51
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=24	127.0.0.1	cesar		1323	22:16:51
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=25	127.0.0.1	cesar		1324	22:16:51
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=26	127.0.0.1	cesar		1325	22:16:51
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=72	127.0.0.1	cesar		1326	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=3	127.0.0.1	cesar		1327	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=5	127.0.0.1	cesar		1328	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=2	127.0.0.1	cesar		1329	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=6	127.0.0.1	cesar		1330	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=7	127.0.0.1	cesar		1331	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=8	127.0.0.1	cesar		1332	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=31	127.0.0.1	cesar		1333	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=32	127.0.0.1	cesar		1334	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=33	127.0.0.1	cesar		1335	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=34	127.0.0.1	cesar		1336	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=35	127.0.0.1	cesar		1337	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=36	127.0.0.1	cesar		1338	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=37	127.0.0.1	cesar		1339	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=38	127.0.0.1	cesar		1340	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=39	127.0.0.1	cesar		1341	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=40	127.0.0.1	cesar		1342	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=60	127.0.0.1	cesar		1343	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=61	127.0.0.1	cesar		1344	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=62	127.0.0.1	cesar		1345	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=63	127.0.0.1	cesar		1346	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=67	127.0.0.1	cesar		1347	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=1	127.0.0.1	cesar		1348	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=11	127.0.0.1	cesar		1349	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=12	127.0.0.1	cesar		1350	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=13	127.0.0.1	cesar		1351	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=70	127.0.0.1	cesar		1352	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=4	127.0.0.1	cesar		1353	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=73	127.0.0.1	cesar		1354	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=10	127.0.0.1	cesar		1355	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=9	127.0.0.1	cesar		1356	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=64	127.0.0.1	cesar		1357	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=65	127.0.0.1	cesar		1358	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=66	127.0.0.1	cesar		1359	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=68	127.0.0.1	cesar		1360	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=69	127.0.0.1	cesar		1361	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=71	127.0.0.1	cesar		1362	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=50	127.0.0.1	cesar		1363	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=51	127.0.0.1	cesar		1364	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=52	127.0.0.1	cesar		1365	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=53	127.0.0.1	cesar		1366	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=54	127.0.0.1	cesar		1367	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=55	127.0.0.1	cesar		1368	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=56	127.0.0.1	cesar		1369	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=57	127.0.0.1	cesar		1370	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=58	127.0.0.1	cesar		1371	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=59	127.0.0.1	cesar		1372	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=41	127.0.0.1	cesar		1373	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=42	127.0.0.1	cesar		1374	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=43	127.0.0.1	cesar		1375	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=44	127.0.0.1	cesar		1376	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=45	127.0.0.1	cesar		1377	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=46	127.0.0.1	cesar		1378	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=47	127.0.0.1	cesar		1379	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=48	127.0.0.1	cesar		1380	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=49	127.0.0.1	cesar		1381	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=14	127.0.0.1	cesar		1382	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=15	127.0.0.1	cesar		1383	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=16	127.0.0.1	cesar		1384	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=17	127.0.0.1	cesar		1385	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=22	127.0.0.1	cesar		1386	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=24	127.0.0.1	cesar		1387	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=25	127.0.0.1	cesar		1388	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=26	127.0.0.1	cesar		1389	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=18	127.0.0.1	cesar		1390	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=19	127.0.0.1	cesar		1391	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=20	127.0.0.1	cesar		1392	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=21	127.0.0.1	cesar		1393	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=23	127.0.0.1	cesar		1394	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=27	127.0.0.1	cesar		1395	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=28	127.0.0.1	cesar		1396	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=29	127.0.0.1	cesar		1397	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=30	127.0.0.1	cesar		1398	22:21:13
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=36	127.0.0.1	cesar		1399	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=37	127.0.0.1	cesar		1400	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=38	127.0.0.1	cesar		1401	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=39	127.0.0.1	cesar		1402	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=40	127.0.0.1	cesar		1403	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=60	127.0.0.1	cesar		1404	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=61	127.0.0.1	cesar		1405	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=62	127.0.0.1	cesar		1406	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=63	127.0.0.1	cesar		1407	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=67	127.0.0.1	cesar		1408	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=1	127.0.0.1	cesar		1409	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=11	127.0.0.1	cesar		1410	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=12	127.0.0.1	cesar		1411	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=13	127.0.0.1	cesar		1412	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=70	127.0.0.1	cesar		1413	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=4	127.0.0.1	cesar		1414	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=73	127.0.0.1	cesar		1415	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=72	127.0.0.1	cesar		1416	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=3	127.0.0.1	cesar		1417	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=5	127.0.0.1	cesar		1418	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=2	127.0.0.1	cesar		1419	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=6	127.0.0.1	cesar		1420	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=7	127.0.0.1	cesar		1421	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=8	127.0.0.1	cesar		1422	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=31	127.0.0.1	cesar		1423	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=32	127.0.0.1	cesar		1424	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=33	127.0.0.1	cesar		1425	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=34	127.0.0.1	cesar		1426	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=35	127.0.0.1	cesar		1427	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=54	127.0.0.1	cesar		1428	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=55	127.0.0.1	cesar		1429	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=56	127.0.0.1	cesar		1430	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=57	127.0.0.1	cesar		1431	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=58	127.0.0.1	cesar		1432	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=59	127.0.0.1	cesar		1433	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=41	127.0.0.1	cesar		1434	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=42	127.0.0.1	cesar		1435	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=43	127.0.0.1	cesar		1436	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=44	127.0.0.1	cesar		1437	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=45	127.0.0.1	cesar		1438	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=46	127.0.0.1	cesar		1439	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=47	127.0.0.1	cesar		1440	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=48	127.0.0.1	cesar		1441	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=49	127.0.0.1	cesar		1442	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=10	127.0.0.1	cesar		1443	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=9	127.0.0.1	cesar		1444	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=64	127.0.0.1	cesar		1445	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=65	127.0.0.1	cesar		1446	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=66	127.0.0.1	cesar		1447	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=68	127.0.0.1	cesar		1448	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=69	127.0.0.1	cesar		1449	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=71	127.0.0.1	cesar		1450	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=50	127.0.0.1	cesar		1451	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=51	127.0.0.1	cesar		1452	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=52	127.0.0.1	cesar		1453	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=53	127.0.0.1	cesar		1454	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=14	127.0.0.1	cesar		1455	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=15	127.0.0.1	cesar		1456	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=16	127.0.0.1	cesar		1457	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=17	127.0.0.1	cesar		1458	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=22	127.0.0.1	cesar		1459	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=24	127.0.0.1	cesar		1460	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=25	127.0.0.1	cesar		1461	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus= WHERE id=26	127.0.0.1	cesar		1462	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=18	127.0.0.1	cesar		1463	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=19	127.0.0.1	cesar		1464	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=20	127.0.0.1	cesar		1465	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=21	127.0.0.1	cesar		1466	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=23	127.0.0.1	cesar		1467	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=27	127.0.0.1	cesar		1468	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=28	127.0.0.1	cesar		1469	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=29	127.0.0.1	cesar		1470	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=30	127.0.0.1	cesar		1471	22:22:08
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=36	127.0.0.1	cesar		1472	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=37	127.0.0.1	cesar		1473	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=38	127.0.0.1	cesar		1474	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=39	127.0.0.1	cesar		1475	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=40	127.0.0.1	cesar		1476	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=60	127.0.0.1	cesar		1477	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=61	127.0.0.1	cesar		1478	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=62	127.0.0.1	cesar		1479	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=63	127.0.0.1	cesar		1480	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=67	127.0.0.1	cesar		1481	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=1	127.0.0.1	cesar		1482	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=11	127.0.0.1	cesar		1483	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=12	127.0.0.1	cesar		1484	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=13	127.0.0.1	cesar		1485	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=70	127.0.0.1	cesar		1486	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=4	127.0.0.1	cesar		1487	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=73	127.0.0.1	cesar		1488	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=72	127.0.0.1	cesar		1489	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=3	127.0.0.1	cesar		1490	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=5	127.0.0.1	cesar		1491	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=2	127.0.0.1	cesar		1492	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=6	127.0.0.1	cesar		1493	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=7	127.0.0.1	cesar		1494	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=8	127.0.0.1	cesar		1495	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=31	127.0.0.1	cesar		1496	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=32	127.0.0.1	cesar		1497	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=33	127.0.0.1	cesar		1498	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=34	127.0.0.1	cesar		1499	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=35	127.0.0.1	cesar		1500	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=54	127.0.0.1	cesar		1501	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=55	127.0.0.1	cesar		1502	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=56	127.0.0.1	cesar		1503	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=57	127.0.0.1	cesar		1504	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=58	127.0.0.1	cesar		1505	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=59	127.0.0.1	cesar		1506	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=41	127.0.0.1	cesar		1507	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=42	127.0.0.1	cesar		1508	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=43	127.0.0.1	cesar		1509	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=44	127.0.0.1	cesar		1510	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=45	127.0.0.1	cesar		1511	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=46	127.0.0.1	cesar		1512	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=47	127.0.0.1	cesar		1513	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=48	127.0.0.1	cesar		1514	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=49	127.0.0.1	cesar		1515	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=10	127.0.0.1	cesar		1516	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=9	127.0.0.1	cesar		1517	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=64	127.0.0.1	cesar		1518	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=65	127.0.0.1	cesar		1519	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=66	127.0.0.1	cesar		1520	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=68	127.0.0.1	cesar		1521	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=69	127.0.0.1	cesar		1522	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=71	127.0.0.1	cesar		1523	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=50	127.0.0.1	cesar		1524	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=51	127.0.0.1	cesar		1525	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=52	127.0.0.1	cesar		1526	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=53	127.0.0.1	cesar		1527	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=14	127.0.0.1	cesar		1528	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=15	127.0.0.1	cesar		1529	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=16	127.0.0.1	cesar		1530	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=17	127.0.0.1	cesar		1531	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=22	127.0.0.1	cesar		1532	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=24	127.0.0.1	cesar		1533	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=25	127.0.0.1	cesar		1534	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=26	127.0.0.1	cesar		1535	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=18	127.0.0.1	cesar		1536	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=19	127.0.0.1	cesar		1537	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=20	127.0.0.1	cesar		1538	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=21	127.0.0.1	cesar		1539	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=23	127.0.0.1	cesar		1540	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=27	127.0.0.1	cesar		1541	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=28	127.0.0.1	cesar		1542	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=29	127.0.0.1	cesar		1543	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=30	127.0.0.1	cesar		1544	22:23:16
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=73	127.0.0.1	cesar		1545	22:24:01
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=65	127.0.0.1	cesar		1546	22:24:01
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=66	127.0.0.1	cesar		1547	22:24:01
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=68	127.0.0.1	cesar		1548	22:24:01
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=69	127.0.0.1	cesar		1549	22:24:01
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=71	127.0.0.1	cesar		1550	22:24:01
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=10	127.0.0.1	cesar		1551	22:24:01
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=64	127.0.0.1	cesar		1552	22:24:01
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=22	127.0.0.1	cesar		1553	22:24:01
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=24	127.0.0.1	cesar		1554	22:24:01
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=25	127.0.0.1	cesar		1555	22:24:01
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=26	127.0.0.1	cesar		1556	22:24:01
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=70	127.0.0.1	cesar		1557	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=4	127.0.0.1	cesar		1558	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=72	127.0.0.1	cesar		1559	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=3	127.0.0.1	cesar		1560	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=5	127.0.0.1	cesar		1561	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=2	127.0.0.1	cesar		1562	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=6	127.0.0.1	cesar		1563	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=7	127.0.0.1	cesar		1564	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=8	127.0.0.1	cesar		1565	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=31	127.0.0.1	cesar		1566	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=32	127.0.0.1	cesar		1567	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=33	127.0.0.1	cesar		1568	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=34	127.0.0.1	cesar		1569	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=35	127.0.0.1	cesar		1570	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=73	127.0.0.1	cesar		1571	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=36	127.0.0.1	cesar		1572	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=37	127.0.0.1	cesar		1573	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=38	127.0.0.1	cesar		1574	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=39	127.0.0.1	cesar		1575	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=40	127.0.0.1	cesar		1576	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=60	127.0.0.1	cesar		1577	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=61	127.0.0.1	cesar		1578	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=62	127.0.0.1	cesar		1579	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=63	127.0.0.1	cesar		1580	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=67	127.0.0.1	cesar		1581	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=1	127.0.0.1	cesar		1582	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=11	127.0.0.1	cesar		1583	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=12	127.0.0.1	cesar		1584	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=13	127.0.0.1	cesar		1585	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=50	127.0.0.1	cesar		1586	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=51	127.0.0.1	cesar		1587	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=52	127.0.0.1	cesar		1588	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=53	127.0.0.1	cesar		1589	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=65	127.0.0.1	cesar		1590	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=66	127.0.0.1	cesar		1591	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=68	127.0.0.1	cesar		1592	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=69	127.0.0.1	cesar		1593	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=71	127.0.0.1	cesar		1594	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=10	127.0.0.1	cesar		1595	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=64	127.0.0.1	cesar		1596	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=54	127.0.0.1	cesar		1597	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=55	127.0.0.1	cesar		1598	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=56	127.0.0.1	cesar		1599	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=57	127.0.0.1	cesar		1600	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=58	127.0.0.1	cesar		1601	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=59	127.0.0.1	cesar		1602	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=41	127.0.0.1	cesar		1603	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=42	127.0.0.1	cesar		1604	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=43	127.0.0.1	cesar		1605	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=44	127.0.0.1	cesar		1606	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=45	127.0.0.1	cesar		1607	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=46	127.0.0.1	cesar		1608	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=47	127.0.0.1	cesar		1609	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=48	127.0.0.1	cesar		1610	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=49	127.0.0.1	cesar		1611	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=9	127.0.0.1	cesar		1612	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=14	127.0.0.1	cesar		1613	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=15	127.0.0.1	cesar		1614	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=16	127.0.0.1	cesar		1615	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=17	127.0.0.1	cesar		1616	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=18	127.0.0.1	cesar		1617	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=19	127.0.0.1	cesar		1618	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=20	127.0.0.1	cesar		1619	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=21	127.0.0.1	cesar		1620	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=23	127.0.0.1	cesar		1621	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=27	127.0.0.1	cesar		1622	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=28	127.0.0.1	cesar		1623	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=29	127.0.0.1	cesar		1624	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=30	127.0.0.1	cesar		1625	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=22	127.0.0.1	cesar		1626	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=24	127.0.0.1	cesar		1627	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=25	127.0.0.1	cesar		1628	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=26	127.0.0.1	cesar		1629	22:24:52
2016-06-28	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_futbol (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (5,7017, GAL/HUN, 2016-06-28, HUNGRIA, HUNGRIA, 3, 0x3, FINALIZADO)	127.0.0.1	cesar		1630	22:26:45
2016-06-28	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_futbol (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (6,7018, ING/IRL, 2016-06-28, INGLATERRA, INGLATERRA, 1, 1x0, FINALIZADO)	127.0.0.1	cesar		1631	22:26:57
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=73	127.0.0.1	cesar		1632	22:27:03
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=65	127.0.0.1	cesar		1633	22:27:03
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=66	127.0.0.1	cesar		1634	22:27:03
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=68	127.0.0.1	cesar		1635	22:27:03
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=69	127.0.0.1	cesar		1636	22:27:03
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=71	127.0.0.1	cesar		1637	22:27:03
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=10	127.0.0.1	cesar		1638	22:27:03
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=64	127.0.0.1	cesar		1639	22:27:03
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=22	127.0.0.1	cesar		1640	22:27:03
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=24	127.0.0.1	cesar		1641	22:27:03
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=25	127.0.0.1	cesar		1642	22:27:03
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=26	127.0.0.1	cesar		1643	22:27:03
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=73	127.0.0.1	cesar		1644	22:28:22
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=65	127.0.0.1	cesar		1645	22:28:22
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=66	127.0.0.1	cesar		1646	22:28:22
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=68	127.0.0.1	cesar		1647	22:28:22
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=69	127.0.0.1	cesar		1648	22:28:22
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=71	127.0.0.1	cesar		1649	22:28:22
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=10	127.0.0.1	cesar		1650	22:28:22
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=64	127.0.0.1	cesar		1651	22:28:22
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=22	127.0.0.1	cesar		1652	22:28:22
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=24	127.0.0.1	cesar		1653	22:28:22
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=25	127.0.0.1	cesar		1654	22:28:22
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=26	127.0.0.1	cesar		1655	22:28:22
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE resultado_futbol SET ganador=EMPATE, runline=EMPATE, total_goles=2,  marcador=1x1, estatus=FINALIZADO WHERE id=6	127.0.0.1	cesar		1656	22:28:53
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=65	127.0.0.1	cesar		1657	22:28:56
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=66	127.0.0.1	cesar		1658	22:28:56
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=68	127.0.0.1	cesar		1659	22:28:56
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=69	127.0.0.1	cesar		1660	22:28:56
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=71	127.0.0.1	cesar		1661	22:28:56
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=10	127.0.0.1	cesar		1662	22:28:56
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=64	127.0.0.1	cesar		1663	22:28:56
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=22	127.0.0.1	cesar		1664	22:28:56
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=24	127.0.0.1	cesar		1665	22:28:56
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=25	127.0.0.1	cesar		1666	22:28:56
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=26	127.0.0.1	cesar		1667	22:28:56
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=70	127.0.0.1	cesar		1668	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=4	127.0.0.1	cesar		1669	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=72	127.0.0.1	cesar		1670	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=3	127.0.0.1	cesar		1671	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=5	127.0.0.1	cesar		1672	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=2	127.0.0.1	cesar		1673	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=6	127.0.0.1	cesar		1674	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=7	127.0.0.1	cesar		1675	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=8	127.0.0.1	cesar		1676	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=31	127.0.0.1	cesar		1677	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=32	127.0.0.1	cesar		1678	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=33	127.0.0.1	cesar		1679	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=34	127.0.0.1	cesar		1680	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=35	127.0.0.1	cesar		1681	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=36	127.0.0.1	cesar		1682	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=73	127.0.0.1	cesar		1683	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=37	127.0.0.1	cesar		1684	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=38	127.0.0.1	cesar		1685	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=39	127.0.0.1	cesar		1686	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=40	127.0.0.1	cesar		1687	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=60	127.0.0.1	cesar		1688	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=61	127.0.0.1	cesar		1689	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=62	127.0.0.1	cesar		1690	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=63	127.0.0.1	cesar		1691	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=67	127.0.0.1	cesar		1692	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=1	127.0.0.1	cesar		1693	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=11	127.0.0.1	cesar		1694	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=12	127.0.0.1	cesar		1695	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=13	127.0.0.1	cesar		1696	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=51	127.0.0.1	cesar		1697	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=52	127.0.0.1	cesar		1698	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=53	127.0.0.1	cesar		1699	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=54	127.0.0.1	cesar		1700	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=55	127.0.0.1	cesar		1701	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=56	127.0.0.1	cesar		1702	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=57	127.0.0.1	cesar		1703	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=58	127.0.0.1	cesar		1704	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=59	127.0.0.1	cesar		1705	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=41	127.0.0.1	cesar		1706	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=65	127.0.0.1	cesar		1707	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=66	127.0.0.1	cesar		1708	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=42	127.0.0.1	cesar		1709	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=43	127.0.0.1	cesar		1710	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=44	127.0.0.1	cesar		1711	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=45	127.0.0.1	cesar		1712	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=46	127.0.0.1	cesar		1713	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=47	127.0.0.1	cesar		1714	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=48	127.0.0.1	cesar		1715	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=49	127.0.0.1	cesar		1716	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=9	127.0.0.1	cesar		1717	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=68	127.0.0.1	cesar		1718	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=69	127.0.0.1	cesar		1719	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=71	127.0.0.1	cesar		1720	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=10	127.0.0.1	cesar		1721	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=64	127.0.0.1	cesar		1722	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=50	127.0.0.1	cesar		1723	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=16	127.0.0.1	cesar		1724	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=17	127.0.0.1	cesar		1725	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=18	127.0.0.1	cesar		1726	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=19	127.0.0.1	cesar		1727	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=20	127.0.0.1	cesar		1728	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=21	127.0.0.1	cesar		1729	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=23	127.0.0.1	cesar		1730	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=27	127.0.0.1	cesar		1731	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=28	127.0.0.1	cesar		1732	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=29	127.0.0.1	cesar		1733	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=30	127.0.0.1	cesar		1734	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=22	127.0.0.1	cesar		1735	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=24	127.0.0.1	cesar		1736	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=25	127.0.0.1	cesar		1737	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=26	127.0.0.1	cesar		1738	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=14	127.0.0.1	cesar		1739	22:29:34
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=15	127.0.0.1	cesar		1740	22:29:34
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=74	127.0.0.1	cesar		1814	22:25:23
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE resultado_futbol SET ganador=AUSTRIA, runline=AUSTRIA, total_goles=6,  marcador=4x2, estatus=FINALIZADO WHERE id=4	127.0.0.1	cesar		1741	22:30:17
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=73	127.0.0.1	cesar		1742	22:30:20
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=65	127.0.0.1	cesar		1743	22:30:20
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=66	127.0.0.1	cesar		1744	22:30:20
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=68	127.0.0.1	cesar		1745	22:30:20
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=69	127.0.0.1	cesar		1746	22:30:20
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=71	127.0.0.1	cesar		1747	22:30:20
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=10	127.0.0.1	cesar		1748	22:30:20
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=64	127.0.0.1	cesar		1749	22:30:20
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=22	127.0.0.1	cesar		1750	22:30:20
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=24	127.0.0.1	cesar		1751	22:30:20
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=25	127.0.0.1	cesar		1752	22:30:20
2016-06-28	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=26	127.0.0.1	cesar		1753	22:30:20
2016-06-29	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-29, 20:46:51, 127.0.0.1)	127.0.0.1	cesar		1754	20:46:51
2016-06-29	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-29, 20:52:13, 127.0.0.1)	127.0.0.1	cesar		1755	20:52:13
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=65	127.0.0.1	cesar		1756	20:53:42
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=66	127.0.0.1	cesar		1757	20:53:42
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=68	127.0.0.1	cesar		1758	20:53:42
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=69	127.0.0.1	cesar		1759	20:53:42
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=71	127.0.0.1	cesar		1760	20:53:42
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=10	127.0.0.1	cesar		1761	20:53:42
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=64	127.0.0.1	cesar		1762	20:53:42
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=22	127.0.0.1	cesar		1763	20:53:42
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=24	127.0.0.1	cesar		1764	20:53:42
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=25	127.0.0.1	cesar		1765	20:53:42
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=26	127.0.0.1	cesar		1766	20:53:42
2016-06-29	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (6,6, TEX/OAK, 2016-06-29, 0, 0, 0, 0x0, 0, 0, 0, 0x0, 0, 0, 0, SUSPENDIDO)	127.0.0.1	cesar		1767	21:39:26
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=ANULADA WHERE id=65	127.0.0.1	cesar		1768	21:43:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=ANULADA WHERE id=65	127.0.0.1	cesar		1769	21:43:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=ANULADA WHERE id=66	127.0.0.1	cesar		1770	21:43:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=ANULADA WHERE id=10	127.0.0.1	cesar		1771	21:43:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_apuesta=65	127.0.0.1	cesar		1772	21:45:58
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_apuesta=65	127.0.0.1	cesar		1773	21:45:58
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_apuesta=10	127.0.0.1	cesar		1774	21:45:58
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_apuesta=66	127.0.0.1	cesar		1775	21:45:58
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=6	127.0.0.1	cesar		1776	21:51:57
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=6	127.0.0.1	cesar		1777	21:51:57
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=6	127.0.0.1	cesar		1778	21:51:57
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=6	127.0.0.1	cesar		1779	21:51:57
2016-06-29	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (7,10, TOR/PHI, 2016-06-29, TORONTO, TORONTO, TORONTO, 8x0, 8, TORONTO, TORONTO, 4x0, 4, SI, TORONTO, FINALIZADO)	127.0.0.1	cesar		1780	21:58:39
2016-06-29	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (74, 2016-06-29, 22:00:21, 50, 237.65, PENDIENTE, 36570434, PARLEY, 1, cesar)	127.0.0.1	cesar		1781	22:00:21
2016-06-29	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (74, 1, 10, ganador1, TORONTO, -150, GANAR, PENDIENTE)	127.0.0.1	cesar		1782	22:00:21
2016-06-29	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (74, 1, 10, altabaja1, TOR/PHI, -120, AB/ALTA(8,0), PENDIENTE)	127.0.0.1	cesar		1783	22:00:21
2016-06-29	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (74, 1, 10, p_anotar1, TORONTO, -180, P/ANOT, PENDIENTE)	127.0.0.1	cesar		1784	22:00:21
2016-06-29	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (75, 2016-06-29, 22:00:31, 50, 386.53, PENDIENTE, 48001708, PARLEY, 1, cesar)	127.0.0.1	cesar		1785	22:00:31
2016-06-29	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (75, 1, 10, ganador2, PHILLIES, 130, GANAR, PENDIENTE)	127.0.0.1	cesar		1786	22:00:31
2016-06-29	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (75, 1, 10, altabaja2, TOR/PHI, -120, AB/BAJA(8,0), PENDIENTE)	127.0.0.1	cesar		1787	22:00:31
2016-06-29	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (75, 1, 9, ab_mediojuego1, DET/KAN, -120, ABM/ALTA(4,0), PENDIENTE)	127.0.0.1	cesar		1788	22:00:31
2016-06-29	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (76, 2016-06-29, 22:00:41, 50, 237.65, PENDIENTE, 59432983, PARLEY, 1, cesar)	127.0.0.1	cesar		1789	22:00:41
2016-06-29	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (76, 1, 10, g_mediojuego1, TORONTO, -150, GMITAD, PENDIENTE)	127.0.0.1	cesar		1790	22:00:41
2016-06-29	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (76, 1, 10, ab_mediojuego2, TOR/PHI, -120, ABM/BAJA(4,0), PENDIENTE)	127.0.0.1	cesar		1791	22:00:41
2016-06-29	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (76, 1, 10, p_anotar1, TORONTO, -180, P/ANOT, PENDIENTE)	127.0.0.1	cesar		1792	22:00:41
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		1793	22:01:03
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		1794	22:01:03
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10  AND campo_logro IN (ab_mediojuego1, ab_mediojuego2, altabajam1, altabajam2) 	127.0.0.1	cesar		1797	22:09:00
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10  AND campo_logro IN (ab_mediojuego1, ab_mediojuego2, altabajam1, altabajam2) 	127.0.0.1	cesar		1798	22:18:07
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_deporte= AND id_logro=  AND campo_logro IN (ab_mediojuego1, ab_mediojuego2, altabajam1, altabajam2) 	127.0.0.1	cesar		1799	22:20:25
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_deporte= AND id_logro=  AND campo_logro IN (ab_mediojuego1, ab_mediojuego2, altabajam1, altabajam2) 	127.0.0.1	cesar		1800	22:21:40
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_deporte=1 AND id_logro=10  AND campo_logro IN (ab_mediojuego1, ab_mediojuego2, altabajam1, altabajam2) 	127.0.0.1	cesar		1801	22:22:48
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_deporte=1 AND id_logro=10  AND campo_logro IN (altabaja1, altabaja2) 	127.0.0.1	cesar		1802	22:23:16
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PENDIENTE WHERE id_deporte=1 AND id_logro=10  AND campo_logro IN (altabaja1, altabaja2) 	127.0.0.1	cesar		1803	22:23:16
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE resultado_beisbol SET ganador=TORONTO, runline=TORONTO, srunline=TORONTO, p_inning=SI, g_mediojuego=TORONTO, runlinem=TORONTO, p_anotar=TORONTO, marcador=8x0, marcadorm=4x0, total_carreras=8, total_carreras_5to=4, estatus=SUSPENDIDO WHERE id=7	127.0.0.1	cesar		1804	22:23:40
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		1805	22:23:48
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		1806	22:23:48
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		1807	22:23:48
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		1808	22:23:48
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		1809	22:23:48
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		1810	22:23:48
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		1811	22:23:48
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		1812	22:23:48
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		1813	22:23:48
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10  AND campo_logro IN (altabaja1, altabaja2) 	127.0.0.1	cesar		1795	22:08:06
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10  AND campo_logro IN (altabaja1, altabaja2) 	127.0.0.1	cesar		1796	22:08:06
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=75	127.0.0.1	cesar		1815	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=76	127.0.0.1	cesar		1816	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=34	127.0.0.1	cesar		1817	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=35	127.0.0.1	cesar		1818	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=36	127.0.0.1	cesar		1819	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=37	127.0.0.1	cesar		1820	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=38	127.0.0.1	cesar		1821	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=39	127.0.0.1	cesar		1822	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=40	127.0.0.1	cesar		1823	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=60	127.0.0.1	cesar		1824	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=61	127.0.0.1	cesar		1825	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=62	127.0.0.1	cesar		1826	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=63	127.0.0.1	cesar		1827	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=67	127.0.0.1	cesar		1828	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=1	127.0.0.1	cesar		1829	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=11	127.0.0.1	cesar		1830	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=12	127.0.0.1	cesar		1831	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=13	127.0.0.1	cesar		1832	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=73	127.0.0.1	cesar		1833	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=70	127.0.0.1	cesar		1834	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=4	127.0.0.1	cesar		1835	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=72	127.0.0.1	cesar		1836	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=3	127.0.0.1	cesar		1837	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=5	127.0.0.1	cesar		1838	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=2	127.0.0.1	cesar		1839	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=6	127.0.0.1	cesar		1840	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=7	127.0.0.1	cesar		1841	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=8	127.0.0.1	cesar		1842	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=31	127.0.0.1	cesar		1843	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=32	127.0.0.1	cesar		1844	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=33	127.0.0.1	cesar		1845	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=65	127.0.0.1	cesar		1846	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=10	127.0.0.1	cesar		1847	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=66	127.0.0.1	cesar		1848	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=51	127.0.0.1	cesar		1849	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=52	127.0.0.1	cesar		1850	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=53	127.0.0.1	cesar		1851	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=54	127.0.0.1	cesar		1852	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=55	127.0.0.1	cesar		1853	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=56	127.0.0.1	cesar		1854	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=57	127.0.0.1	cesar		1855	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=58	127.0.0.1	cesar		1856	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=59	127.0.0.1	cesar		1857	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=41	127.0.0.1	cesar		1858	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=42	127.0.0.1	cesar		1859	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=43	127.0.0.1	cesar		1860	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=44	127.0.0.1	cesar		1861	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=45	127.0.0.1	cesar		1862	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=46	127.0.0.1	cesar		1863	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=47	127.0.0.1	cesar		1864	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=48	127.0.0.1	cesar		1865	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=49	127.0.0.1	cesar		1866	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=9	127.0.0.1	cesar		1867	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=50	127.0.0.1	cesar		1868	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=68	127.0.0.1	cesar		1869	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=69	127.0.0.1	cesar		1870	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=71	127.0.0.1	cesar		1871	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=64	127.0.0.1	cesar		1872	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=22	127.0.0.1	cesar		1873	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=24	127.0.0.1	cesar		1874	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=25	127.0.0.1	cesar		1875	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=26	127.0.0.1	cesar		1876	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=16	127.0.0.1	cesar		1877	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=17	127.0.0.1	cesar		1878	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=18	127.0.0.1	cesar		1879	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=19	127.0.0.1	cesar		1880	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=20	127.0.0.1	cesar		1881	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=21	127.0.0.1	cesar		1882	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=23	127.0.0.1	cesar		1883	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=27	127.0.0.1	cesar		1884	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=28	127.0.0.1	cesar		1885	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=29	127.0.0.1	cesar		1886	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=30	127.0.0.1	cesar		1887	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=14	127.0.0.1	cesar		1888	22:25:23
2016-06-29	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=15	127.0.0.1	cesar		1889	22:25:23
2016-06-30	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-06-30, 22:06:18, 127.0.0.1)	127.0.0.1	cesar		1890	22:06:19
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=75	127.0.0.1	cesar		1891	22:09:46
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=65	127.0.0.1	cesar		1892	22:09:46
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=10	127.0.0.1	cesar		1893	22:09:46
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=66	127.0.0.1	cesar		1894	22:09:46
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=68	127.0.0.1	cesar		1895	22:09:46
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=69	127.0.0.1	cesar		1896	22:09:46
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=71	127.0.0.1	cesar		1897	22:09:46
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=64	127.0.0.1	cesar		1898	22:09:46
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=22	127.0.0.1	cesar		1899	22:09:46
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=24	127.0.0.1	cesar		1900	22:09:46
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=25	127.0.0.1	cesar		1901	22:09:46
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=26	127.0.0.1	cesar		1902	22:09:46
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=75	127.0.0.1	cesar		1903	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=74	127.0.0.1	cesar		1904	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=76	127.0.0.1	cesar		1905	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=34	127.0.0.1	cesar		1906	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=35	127.0.0.1	cesar		1907	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=36	127.0.0.1	cesar		1908	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=37	127.0.0.1	cesar		1909	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=38	127.0.0.1	cesar		1910	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=39	127.0.0.1	cesar		1911	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=40	127.0.0.1	cesar		1912	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=60	127.0.0.1	cesar		1913	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=61	127.0.0.1	cesar		1914	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=62	127.0.0.1	cesar		1915	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=63	127.0.0.1	cesar		1916	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=67	127.0.0.1	cesar		1917	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=1	127.0.0.1	cesar		1918	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=11	127.0.0.1	cesar		1919	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=12	127.0.0.1	cesar		1920	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=13	127.0.0.1	cesar		1921	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=73	127.0.0.1	cesar		1922	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=70	127.0.0.1	cesar		1923	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=4	127.0.0.1	cesar		1924	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=72	127.0.0.1	cesar		1925	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=3	127.0.0.1	cesar		1926	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=5	127.0.0.1	cesar		1927	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=2	127.0.0.1	cesar		1928	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=6	127.0.0.1	cesar		1929	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=7	127.0.0.1	cesar		1930	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=8	127.0.0.1	cesar		1931	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=31	127.0.0.1	cesar		1932	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=32	127.0.0.1	cesar		1933	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=33	127.0.0.1	cesar		1934	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=51	127.0.0.1	cesar		1935	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=52	127.0.0.1	cesar		1936	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=65	127.0.0.1	cesar		1937	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=10	127.0.0.1	cesar		1938	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=66	127.0.0.1	cesar		1939	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=68	127.0.0.1	cesar		1940	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=69	127.0.0.1	cesar		1941	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=71	127.0.0.1	cesar		1942	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=64	127.0.0.1	cesar		1943	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=53	127.0.0.1	cesar		1944	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=54	127.0.0.1	cesar		1945	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=55	127.0.0.1	cesar		1946	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=56	127.0.0.1	cesar		1947	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=57	127.0.0.1	cesar		1948	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=58	127.0.0.1	cesar		1949	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=59	127.0.0.1	cesar		1950	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=41	127.0.0.1	cesar		1951	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=42	127.0.0.1	cesar		1952	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=43	127.0.0.1	cesar		1953	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=44	127.0.0.1	cesar		1954	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=45	127.0.0.1	cesar		1955	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=46	127.0.0.1	cesar		1956	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=47	127.0.0.1	cesar		1957	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=48	127.0.0.1	cesar		1958	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=49	127.0.0.1	cesar		1959	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=9	127.0.0.1	cesar		1960	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=50	127.0.0.1	cesar		1961	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=22	127.0.0.1	cesar		1962	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=24	127.0.0.1	cesar		1963	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=25	127.0.0.1	cesar		1964	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=26	127.0.0.1	cesar		1965	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=16	127.0.0.1	cesar		1966	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=17	127.0.0.1	cesar		1967	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=18	127.0.0.1	cesar		1968	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=19	127.0.0.1	cesar		1969	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=20	127.0.0.1	cesar		1970	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=21	127.0.0.1	cesar		1971	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=23	127.0.0.1	cesar		1972	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=27	127.0.0.1	cesar		1973	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=28	127.0.0.1	cesar		1974	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=29	127.0.0.1	cesar		1975	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=30	127.0.0.1	cesar		1976	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=14	127.0.0.1	cesar		1977	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=15	127.0.0.1	cesar		1978	22:14:27
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		1979	22:17:20
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		1980	22:17:20
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		1981	22:17:20
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		1982	22:17:20
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		1983	22:17:20
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		1984	22:17:20
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		1985	22:17:20
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		1986	22:17:20
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		1987	22:17:20
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=75	127.0.0.1	cesar		1988	22:17:43
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=ANULADA WHERE id=74	127.0.0.1	cesar		1989	22:17:43
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=ANULADA WHERE id=76	127.0.0.1	cesar		1990	22:17:43
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=65	127.0.0.1	cesar		1991	22:17:43
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=10	127.0.0.1	cesar		1992	22:17:43
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=66	127.0.0.1	cesar		1993	22:17:43
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=68	127.0.0.1	cesar		1994	22:17:43
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=69	127.0.0.1	cesar		1995	22:17:43
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=71	127.0.0.1	cesar		1996	22:17:43
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=64	127.0.0.1	cesar		1997	22:17:43
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=22	127.0.0.1	cesar		1998	22:17:43
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=24	127.0.0.1	cesar		1999	22:17:43
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=25	127.0.0.1	cesar		2000	22:17:43
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=26	127.0.0.1	cesar		2001	22:17:43
2016-06-30	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (8,9, DET/KAN, 2016-06-29, DETROIT, DETROIT, DETROIT, 8x0, 8, DETROIT, DETROIT, 5x0, 5, SI, DETROIT, FINALIZADO)	127.0.0.1	cesar		2002	22:19:43
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=75	127.0.0.1	cesar		2003	22:19:48
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=65	127.0.0.1	cesar		2004	22:19:48
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=10	127.0.0.1	cesar		2005	22:19:48
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=66	127.0.0.1	cesar		2006	22:19:48
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=68	127.0.0.1	cesar		2007	22:19:48
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=69	127.0.0.1	cesar		2008	22:19:48
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=71	127.0.0.1	cesar		2009	22:19:48
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=64	127.0.0.1	cesar		2010	22:19:48
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=22	127.0.0.1	cesar		2011	22:19:48
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=24	127.0.0.1	cesar		2012	22:19:48
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=25	127.0.0.1	cesar		2013	22:19:48
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=26	127.0.0.1	cesar		2014	22:19:48
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PAGADA WHERE id=75 AND id_seguridad=48001708	127.0.0.1	cesar		2015	22:40:55
2016-06-30	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=PAGADA WHERE id_apuesta=75	127.0.0.1	cesar		2016	22:40:55
2016-07-01	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-07-01, 22:18:09, 127.0.0.1)	127.0.0.1	cesar		2017	22:18:09
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=38	127.0.0.1	cesar		2018	22:20:27
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=39	127.0.0.1	cesar		2019	22:20:27
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=40	127.0.0.1	cesar		2020	22:20:27
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=60	127.0.0.1	cesar		2021	22:20:27
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=61	127.0.0.1	cesar		2022	22:20:27
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=62	127.0.0.1	cesar		2023	22:20:27
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=63	127.0.0.1	cesar		2024	22:20:27
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=67	127.0.0.1	cesar		2025	22:20:27
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=74	127.0.0.1	cesar		2026	22:20:27
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=76	127.0.0.1	cesar		2027	22:20:27
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=75	127.0.0.1	cesar		2028	22:20:27
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=1	127.0.0.1	cesar		2029	22:20:27
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=11	127.0.0.1	cesar		2030	22:20:27
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=12	127.0.0.1	cesar		2031	22:20:27
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=13	127.0.0.1	cesar		2032	22:20:27
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=73	127.0.0.1	cesar		2033	22:20:27
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=70	127.0.0.1	cesar		2034	22:20:27
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=4	127.0.0.1	cesar		2035	22:20:27
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=72	127.0.0.1	cesar		2036	22:20:27
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=3	127.0.0.1	cesar		2037	22:20:27
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=5	127.0.0.1	cesar		2038	22:20:27
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=2	127.0.0.1	cesar		2039	22:20:27
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=6	127.0.0.1	cesar		2040	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=7	127.0.0.1	cesar		2041	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=8	127.0.0.1	cesar		2042	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=31	127.0.0.1	cesar		2043	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=32	127.0.0.1	cesar		2044	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=33	127.0.0.1	cesar		2045	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=34	127.0.0.1	cesar		2046	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=35	127.0.0.1	cesar		2047	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=36	127.0.0.1	cesar		2048	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=37	127.0.0.1	cesar		2049	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=54	127.0.0.1	cesar		2050	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=55	127.0.0.1	cesar		2051	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=56	127.0.0.1	cesar		2052	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=57	127.0.0.1	cesar		2053	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=58	127.0.0.1	cesar		2054	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=59	127.0.0.1	cesar		2055	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=41	127.0.0.1	cesar		2056	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=42	127.0.0.1	cesar		2057	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=43	127.0.0.1	cesar		2058	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=44	127.0.0.1	cesar		2059	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=45	127.0.0.1	cesar		2060	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=46	127.0.0.1	cesar		2061	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=47	127.0.0.1	cesar		2062	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=48	127.0.0.1	cesar		2063	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=49	127.0.0.1	cesar		2064	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=9	127.0.0.1	cesar		2065	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=50	127.0.0.1	cesar		2066	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=65	127.0.0.1	cesar		2067	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=10	127.0.0.1	cesar		2068	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=66	127.0.0.1	cesar		2069	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=68	127.0.0.1	cesar		2070	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=69	127.0.0.1	cesar		2071	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=71	127.0.0.1	cesar		2072	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=64	127.0.0.1	cesar		2073	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=51	127.0.0.1	cesar		2074	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=52	127.0.0.1	cesar		2075	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=53	127.0.0.1	cesar		2076	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=22	127.0.0.1	cesar		2077	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=24	127.0.0.1	cesar		2078	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=25	127.0.0.1	cesar		2079	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=26	127.0.0.1	cesar		2080	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=16	127.0.0.1	cesar		2081	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=17	127.0.0.1	cesar		2082	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=18	127.0.0.1	cesar		2083	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=19	127.0.0.1	cesar		2084	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=20	127.0.0.1	cesar		2085	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=21	127.0.0.1	cesar		2086	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=23	127.0.0.1	cesar		2087	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=27	127.0.0.1	cesar		2088	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=28	127.0.0.1	cesar		2089	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=29	127.0.0.1	cesar		2090	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=30	127.0.0.1	cesar		2091	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=14	127.0.0.1	cesar		2092	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=15	127.0.0.1	cesar		2093	22:20:28
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		2094	22:21:45
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		2095	22:21:45
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		2096	22:21:45
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		2097	22:21:45
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		2098	22:21:45
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		2099	22:21:45
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		2100	22:21:45
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		2101	22:21:45
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_deporte=1 AND id_logro=10	127.0.0.1	cesar		2102	22:21:45
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=ANULADA WHERE id=74	127.0.0.1	cesar		2103	22:22:04
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=ANULADA WHERE id=76	127.0.0.1	cesar		2104	22:22:04
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=75	127.0.0.1	cesar		2105	22:22:04
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=65	127.0.0.1	cesar		2106	22:22:04
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=10	127.0.0.1	cesar		2107	22:22:04
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=66	127.0.0.1	cesar		2108	22:22:04
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=68	127.0.0.1	cesar		2109	22:22:04
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=69	127.0.0.1	cesar		2110	22:22:04
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=71	127.0.0.1	cesar		2111	22:22:04
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=64	127.0.0.1	cesar		2112	22:22:04
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=22	127.0.0.1	cesar		2113	22:22:04
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=24	127.0.0.1	cesar		2114	22:22:04
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=25	127.0.0.1	cesar		2115	22:22:04
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=26	127.0.0.1	cesar		2116	22:22:04
2016-07-01	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (77, 2016-07-01, 22:22:54, 50, 776.73, PENDIENTE, 17643737, PARLEY, 1, cesar)	127.0.0.1	cesar		2117	22:22:54
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=44	127.0.0.1	cesar		2194	22:58:30
2016-07-01	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (77, 1, 1, runline1, CINCINNATI, -225, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		2118	22:22:54
2016-07-01	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (77, 1, 2, srunline1, PIRATES, -205, SRLINE(+2,5), PENDIENTE)	127.0.0.1	cesar		2119	22:22:54
2016-07-01	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (77, 1, 3, ganador1, MILWAUKEE, 130, GANAR, PENDIENTE)	127.0.0.1	cesar		2120	22:22:54
2016-07-01	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (77, 1, 3, altabaja2, MIL/DOD, -120, AB/BAJA(7,5), PENDIENTE)	127.0.0.1	cesar		2121	22:22:54
2016-07-01	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (77, 1, 4, runlinem2, PADRES, -140, RLMITAD(+0,5), PENDIENTE)	127.0.0.1	cesar		2122	22:22:54
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=ANULADA WHERE id=77 AND id_seguridad=17643737	127.0.0.1	cesar		2123	22:23:13
2016-07-01	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_apuesta=77	127.0.0.1	cesar		2124	22:23:13
2016-07-01	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (78, 2016-07-01, 22:30:47, 50, 1667.70, PENDIENTE, 90343017, PARLEY, 1, cesar)	127.0.0.1	cesar		2125	22:30:47
2016-07-01	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (78, 1, 9, runline1, DETROIT, 140, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		2126	22:30:47
2016-07-01	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (78, 1, 7, srunline1, BALTIMORE, -185, SRLINE(+2,5), PENDIENTE)	127.0.0.1	cesar		2127	22:30:47
2016-07-01	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (78, 1, 8, altabaja1, YAN/MIN, -120, AB/ALTA(8,5), PENDIENTE)	127.0.0.1	cesar		2128	22:30:47
2016-07-01	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (78, 1, 5, runlinem1, SEATTLE, -210, RLMITAD(+0,5), PENDIENTE)	127.0.0.1	cesar		2129	22:30:47
2016-07-01	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (78, 1, 4, p_inning1, NAT/PAD, 100, P/INNG(SI), PENDIENTE)	127.0.0.1	cesar		2130	22:30:47
2016-07-01	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (78, 1, 6, p_anotar1, TEXAS, -150, P/ANOT, PENDIENTE)	127.0.0.1	cesar		2131	22:30:47
2016-07-02	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-07-02, 08:31:26, 127.0.0.1)	127.0.0.1	cesar		2132	08:31:27
2016-07-02	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-07-02, 17:11:53, 127.0.0.1)	127.0.0.1	cesar		2133	17:11:53
2016-07-02	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (1,1, CIN/ATL, 2016-07-02, ATLANTA, ATLANTA, CINCINNATI, 5x7, 12, ATLANTA, ATLANTA, 5x6, 11, SI, CINCINNATI, FINALIZADO)	127.0.0.1	cesar		2134	17:39:40
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE resultado_beisbol SET ganador=ATLANTA, runline=ATLANTA, srunline=CINCINNATI, p_inning=SI, g_mediojuego=ATLANTA, runlinem=ATLANTA, p_anotar=ATLANTA, marcador=5x7, marcadorm=5x6, total_carreras=12, total_carreras_5to=11, estatus=FINALIZADO WHERE id=1	127.0.0.1	cesar		2135	17:40:47
2016-07-03	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-07-03, 01:30:26, 127.0.0.1)	127.0.0.1	cesar		2136	01:30:26
2016-07-02	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_basquetbol (id, id_logro, encuentro, fecha, ganador, runline, total_puntos, marcador, ganadorm, runlinem, total_puntosm, marcadorm, estatus) VALUES (1,2, GSW/CLE, 2016-07-02, GSWARRIORS, GSWARRIORS, 210, 110x100, GSWARRIORS, EMPATE, 108, 55x53, FINALIZADO)	127.0.0.1	cesar		2137	22:00:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_basquetbol (id, id_logro, encuentro, fecha, ganador, runline, total_puntos, marcador, ganadorm, runlinem, total_puntosm, marcadorm, estatus) VALUES (2,1, CHI/MIA, 2016-07-02, 0, 0, 0, 0x0, EMPATE, CHICAGO, 108, 54x54, FINALIZADO)	127.0.0.1	cesar		2138	22:02:03
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE resultado_basquetbol SET ganador=CHICAGO, runline=CHICAGO, total_puntos=204,  marcador=104x100, ganadorm=EMPATE, runlinem=CHICAGO, total_puntosm=108,  marcadorm=54x54, estatus=FINALIZADO WHERE id=2	127.0.0.1	cesar		2139	22:02:32
2016-07-02	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_futbol (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (7,11009, CHI/MEX, 2016-07-02, MEXICO, MEXICO, 7, 0x7, FINALIZADO)	127.0.0.1	cesar		2140	22:19:08
2016-07-02	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_futbol_americano (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (1,3, KAN/CAR, 2016-07-02, CAROLINA, EMPATE, 42, 20x22, FINALIZADO)	127.0.0.1	cesar		2141	22:27:23
2016-07-02	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_formula1 (id, id_logro, encuentro, fecha, ganador, tiempo, estatus) VALUES (1,1, GP INGLATERRA, 2016-07-02, SCHUMACHER, 0, FINALIZADO)	127.0.0.1	cesar		2142	22:42:51
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE resultado_formula1 SET ganador=SCHUMACHER, tiempo=06, estatus=FINALIZADO WHERE id=1	127.0.0.1	cesar		2143	22:43:05
2016-07-02	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_tennis (id, id_logro, encuentro, fecha, ganador, marcador, estatus) VALUES (1,4, FED/NIS, 2016-07-02, FEDERER, 6-0 6-0 6-0, FINALIZADO)	127.0.0.1	cesar		2144	22:46:01
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE resultado_tennis SET ganador=FEDERER, marcador=6-1 6-2 6-3, estatus=FINALIZADO WHERE id=1	127.0.0.1	cesar		2145	22:46:22
2016-07-02	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (79, 2016-07-02, 22:47:18, 50, 327.17, PENDIENTE, 53393249, PARLEY, 1, cesar)	127.0.0.1	cesar		2146	22:47:18
2016-07-02	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (79, 1, 1, ganador1, CINCINNATI, -110, GANAR, PENDIENTE)	127.0.0.1	cesar		2147	22:47:18
2016-07-02	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (79, 1, 1, altabaja2, CIN/ATL, -120, AB/BAJA(8,0), PENDIENTE)	127.0.0.1	cesar		2148	22:47:18
2016-07-02	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (79, 1, 1, p_anotar2, ATLANTA, -115, P/ANOT, PENDIENTE)	127.0.0.1	cesar		2149	22:47:18
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=38	127.0.0.1	cesar		2150	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=39	127.0.0.1	cesar		2151	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=40	127.0.0.1	cesar		2152	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=60	127.0.0.1	cesar		2153	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=61	127.0.0.1	cesar		2154	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=62	127.0.0.1	cesar		2155	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=63	127.0.0.1	cesar		2156	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=67	127.0.0.1	cesar		2157	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=1	127.0.0.1	cesar		2158	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=11	127.0.0.1	cesar		2159	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=74	127.0.0.1	cesar		2160	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=76	127.0.0.1	cesar		2161	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=12	127.0.0.1	cesar		2162	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=13	127.0.0.1	cesar		2163	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=73	127.0.0.1	cesar		2164	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=70	127.0.0.1	cesar		2165	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=4	127.0.0.1	cesar		2166	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=72	127.0.0.1	cesar		2167	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=3	127.0.0.1	cesar		2168	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=5	127.0.0.1	cesar		2169	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=2	127.0.0.1	cesar		2170	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=6	127.0.0.1	cesar		2171	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=7	127.0.0.1	cesar		2172	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=8	127.0.0.1	cesar		2173	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=31	127.0.0.1	cesar		2174	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=32	127.0.0.1	cesar		2175	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=33	127.0.0.1	cesar		2176	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=34	127.0.0.1	cesar		2177	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=35	127.0.0.1	cesar		2178	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=75	127.0.0.1	cesar		2179	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=77	127.0.0.1	cesar		2180	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=78	127.0.0.1	cesar		2181	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=36	127.0.0.1	cesar		2182	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=37	127.0.0.1	cesar		2183	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=79	127.0.0.1	cesar		2184	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=54	127.0.0.1	cesar		2185	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=55	127.0.0.1	cesar		2186	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=56	127.0.0.1	cesar		2187	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=57	127.0.0.1	cesar		2188	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=58	127.0.0.1	cesar		2189	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=59	127.0.0.1	cesar		2190	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=41	127.0.0.1	cesar		2191	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=42	127.0.0.1	cesar		2192	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=43	127.0.0.1	cesar		2193	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=45	127.0.0.1	cesar		2195	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=46	127.0.0.1	cesar		2196	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=47	127.0.0.1	cesar		2197	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=48	127.0.0.1	cesar		2198	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=49	127.0.0.1	cesar		2199	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=9	127.0.0.1	cesar		2200	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=50	127.0.0.1	cesar		2201	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=51	127.0.0.1	cesar		2202	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=52	127.0.0.1	cesar		2203	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=53	127.0.0.1	cesar		2204	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=65	127.0.0.1	cesar		2205	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=10	127.0.0.1	cesar		2206	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=66	127.0.0.1	cesar		2207	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=68	127.0.0.1	cesar		2208	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=69	127.0.0.1	cesar		2209	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=71	127.0.0.1	cesar		2210	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=64	127.0.0.1	cesar		2211	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=16	127.0.0.1	cesar		2212	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=17	127.0.0.1	cesar		2213	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=18	127.0.0.1	cesar		2214	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=19	127.0.0.1	cesar		2215	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=22	127.0.0.1	cesar		2216	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=24	127.0.0.1	cesar		2217	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=25	127.0.0.1	cesar		2218	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=26	127.0.0.1	cesar		2219	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=20	127.0.0.1	cesar		2220	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=21	127.0.0.1	cesar		2221	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=23	127.0.0.1	cesar		2222	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=27	127.0.0.1	cesar		2223	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=28	127.0.0.1	cesar		2224	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=29	127.0.0.1	cesar		2225	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=30	127.0.0.1	cesar		2226	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=14	127.0.0.1	cesar		2227	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=15	127.0.0.1	cesar		2228	22:58:30
2016-07-02	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (80, 2016-07-02, 23:05:00, 50, 311.01, PENDIENTE, 25394592, PARLEY, 1, cesar)	127.0.0.1	cesar		2229	23:05:00
2016-07-02	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (80, 1, 1, runlinem1, CINCINNATI, -225, RLMITAD(+0,5), PENDIENTE)	127.0.0.1	cesar		2230	23:05:00
2016-07-02	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (80, 1, 2, runline2, METS, 165, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		2231	23:05:00
2016-07-02	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (80, 1, 3, ganador2, DODGERS, -160, GANAR, PENDIENTE)	127.0.0.1	cesar		2232	23:05:00
2016-07-03	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-07-03, 07:04:59, 127.0.0.1)	127.0.0.1	cesar		2233	07:05:00
2016-07-03	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-07-03, 10:01:40, 127.0.0.1)	127.0.0.1	cesar		2234	10:01:40
2016-07-03	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (81, 2016-07-03, 10:27:31, 50, 826.42, PENDIENTE, 91606445, PARLEY, 1, cesar)	127.0.0.1	cesar		2235	10:27:31
2016-07-03	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (81, 1, 3, altabaja1, MIL/DOD, -120, AB/ALTA(7,5), PENDIENTE)	127.0.0.1	cesar		2236	10:27:31
2016-07-03	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (81, 1, 5, runline1, SEATTLE, -210, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		2237	10:27:31
2016-07-03	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (81, 1, 6, altabaja2, TEX/OAK, -120, AB/BAJA(8,5), PENDIENTE)	127.0.0.1	cesar		2238	10:27:31
2016-07-03	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (81, 1, 6, ganador2, OAKLAND, 105, GANAR, PENDIENTE)	127.0.0.1	cesar		2239	10:27:31
2016-07-03	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (81, 1, 4, ganador1, NATIONALS, -160, GANAR, PENDIENTE)	127.0.0.1	cesar		2240	10:27:31
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-07-05, 19:08:47, 127.0.0.1)	127.0.0.1	cesar		2241	19:08:47
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (1,2, PIR/MET, 2016-07-05, METS, PIRATES, PIRATES, 4x5, 9, PIRATES, PIRATES, 2x1, 3, SI, PIRATES, FINALIZADO)	127.0.0.1	cesar		2242	19:13:36
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (2,8, YAN/MIN, 2016-07-05, YANKEES, YANKEES, MINNESOTA, 7x5, 12, YANKEES, YANKEES, 4x2, 6, SI, YANKEES, FINALIZADO)	127.0.0.1	cesar		2243	19:14:25
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_basquetbol (id, id_logro, encuentro, fecha, ganador, runline, total_puntos, marcador, ganadorm, runlinem, total_puntosm, marcadorm, estatus) VALUES (1,1, CHI/MIA, 2016-07-05, CHICAGO, CHICAGO, 200, 102x98, MIAMI, MIAMI, 114, 54x60, FINALIZADO)	127.0.0.1	cesar		2244	19:34:48
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_basquetbol (id, id_logro, encuentro, fecha, ganador, runline, total_puntos, marcador, ganadorm, runlinem, total_puntosm, marcadorm, estatus) VALUES (2,2, GSW/CLE, 2016-07-05, GSWARRIORS, GSWARRIORS, 235, 123x112, GSWARRIORS, GSWARRIORS, 107, 58x49, FINALIZADO)	127.0.0.1	cesar		2245	19:35:17
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_futbol (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (1,7013, ALB/ALE, 2016-07-05, ALEMANIA, ALEMANIA, 7, 2x5, FINALIZADO)	127.0.0.1	cesar		2246	19:57:59
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_futbol (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (2,7016, ESP/FRA, 2016-07-05, FRANCIA, EMPATE, 3, 1x2, FINALIZADO)	127.0.0.1	cesar		2247	19:58:20
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_futbol (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (3,11008, VEN/ARG, 2016-07-05, ARGENTINA, ARGENTINA, 5, 1x4, FINALIZADO)	127.0.0.1	cesar		2248	19:58:31
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_futbol (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (4,11009, CHI/MEX, 2016-07-05, CHILE, CHILE, 7, 7x0, FINALIZADO)	127.0.0.1	cesar		2249	19:58:41
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_futbol_americano (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (1,1, PAT/DEN, 2016-07-05, PATRIOTS, PATRIOTS, 55, 32x23, FINALIZADO)	127.0.0.1	cesar		2250	20:01:46
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_futbol_americano (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (2,2, SF4/SEA, 2016-07-05, SF49ERS, SF49ERS, 65, 42x23, FINALIZADO)	127.0.0.1	cesar		2251	20:02:00
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_futbol_americano (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (3,3, KAN/CAR, 2016-07-05, CAROLINA, EMPATE, 48, 23x25, FINALIZADO)	127.0.0.1	cesar		2252	20:02:17
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_hockey (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (1,1, ANA/LAN, 2016-07-05, LANGELES, ANAHEIM, 7, 3x4, FINALIZADO)	127.0.0.1	cesar		2253	20:06:40
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_hockey (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (2,3, PIT/NYR, 2016-07-05, NYRANGERS, NYRANGERS, 8, 3x5, FINALIZADO)	127.0.0.1	cesar		2254	20:06:50
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_hockey (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES (3,4, BOS/MON, 2016-07-05, MONTREAL, MONTREAL, 8, 2x6, FINALIZADO)	127.0.0.1	cesar		2255	20:07:00
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_tennis (id, id_logro, encuentro, fecha, ganador, marcador, estatus) VALUES (1,4, FED/NIS, 2016-07-05, FEDERER, 6-0 6-0 6-0, FINALIZADO)	127.0.0.1	cesar		2256	20:09:18
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_tennis (id, id_logro, encuentro, fecha, ganador, marcador, estatus) VALUES (2,3, MUR/DJO, 2016-07-05, DJOKOVIC, 1-6 4-6 4-6, FINALIZADO)	127.0.0.1	cesar		2257	20:09:34
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_boxeo (id, id_logro, encuentro, fecha, ganador, marcador, estatus) VALUES (1,3, BRA/PAC, 2016-07-05, PACQUIAO, 12 43 35 55 54, FINALIZADO)	127.0.0.1	cesar		2258	20:12:09
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_boxeo (id, id_logro, encuentro, fecha, ganador, marcador, estatus) VALUES (2,1, GAR/MAT, 2016-07-05, GARCIA, 43 34 34 36 46, FINALIZADO)	127.0.0.1	cesar		2259	20:12:31
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_formula1 (id, id_logro, encuentro, fecha, ganador, tiempo, estatus) VALUES (1,1, GP INGLATERRA, 2016-07-05, SCHUMACHER, 02:21:00, FINALIZADO)	127.0.0.1	cesar		2260	20:14:50
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (144, CIN/CHC, CINCINNATI, CHCUBS, B. Finnegan, J. Lackey, 2, 2016-07-05, 14:20:00, 190, -250, 110, -160, 1.5, 110, -160, 2.5, -120, -120, 9, -120, -120, 190, -250, 110, -160, 0.5, -120, -120, 5, 130, -180, ACTIVO, 1)	127.0.0.1	cesar		2261	20:35:09
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (3, 1, 147, runline2, METS, 140, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		2296	20:48:22
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (3, 1, 158, ganador2, DODGERS, -160, GANAR, PENDIENTE)	127.0.0.1	cesar		2297	20:48:22
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (145, ATL/PHI, ATLANTA, PHILLIES, M. Foltynewicz, Z. Eflin, 2, 2016-07-05, 19:05:00, 120, -145, -185, 145, 1.5, -185, 145, 2.5, -120, -120, 8.5, -105, -145, 120, -145, -185, 145, 0.5, -120, -120, 4.5, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2262	20:35:09
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (146, MIL/NAT, MILWAUKEE, NATIONALS, Z. Davies, G. Gonzalez, 2, 2016-07-05, 19:05:00, 145, -180, -150, 110, 1.5, -150, 110, 2.5, -105, -125, 8.5, -105, -145, 145, -180, -150, 110, 0.5, -105, -125, 4.5, 100, -150, ACTIVO, 1)	127.0.0.1	cesar		2263	20:35:09
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (147, MIA/MET, MIAMI, METS, W. Chen, S. Matz, 2, 2016-07-05, 19:10:00, 125, -150, -180, 140, 1.5, -180, 140, 2.5, -120, -120, 8.5, -105, -145, 125, -150, -180, 140, 0.5, -120, -120, 4.5, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2264	20:35:09
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (148, PIR/CAR, PIRATES, CARDINALS, J. Taillon, M. Leake, 2, 2016-07-05, 20:05:00, 130, -160, -175, 125, 1.5, -175, 125, 2.5, -125, -115, 8.5, -125, -125, 130, -160, -175, 125, 0.5, -120, -120, 4.5, -130, -120, ACTIVO, 1)	127.0.0.1	cesar		2265	20:35:09
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (149, PAD/ARI, PADRES, ARIZONA, C. Friedrich, Z. Godley, 2, 2016-07-05, 21:40:00, 130, -150, -180, 140, 1.5, -180, 140, 2.5, -110, -125, 9.5, -120, -130, 130, -150, -180, 140, 0.5, -110, -125, 5, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2266	20:35:09
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (150, COL/GIA, COLORADO, GIANTS, Chatwood, M. Bumgarner, 2, 2016-07-05, 22:15:00, 200, -250, 120, -160, 1.5, 120, -160, 2.5, -125, -105, 6.5, 140, -220, 200, -250, 120, -160, 0.5, -125, -105, 3.5, 130, -180, ACTIVO, 1)	127.0.0.1	cesar		2267	20:35:09
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (151, KAN/TOR, KANSAS, TORONTO, C. Young, R. Dickey, 2, 2016-07-05, 19:05:00, 155, -185, -145, 105, 1.5, -145, 105, 2.5, -105, -125, 9.5, -120, -130, 155, -185, -145, 105, 0.5, -105, -125, 5, 100, -150, ACTIVO, 1)	127.0.0.1	cesar		2268	20:35:09
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (152, DET/CLE, DETROIT, CLEVELAND, A. Sanchez, C. Carrasco, 2, 2016-07-05, 19:10:00, 170, -210, -125, -125, 1.5, -125, -125, 2.5, -120, -120, 9, -130, -120, 160, -220, -125, -125, 0.5, -115, -125, 5, -120, -130, ACTIVO, 1)	127.0.0.1	cesar		2269	20:35:09
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (153, ANG/TAM, ANGELS, TAMPA, T. Lincecum, J. Odorizzi, 2, 2016-07-05, 19:10:00, 135, -160, -170, 130, 1.5, -170, 130, 2.5, -125, -110, 8.5, -105, -145, 135, -160, -170, 130, 0.5, -125, -110, 4.5, -110, -140, ACTIVO, 1)	127.0.0.1	cesar		2270	20:35:09
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (154, TEX/BOS, TEXAS, BOSTON, A. Griffin, D. Price, 2, 2016-07-05, 19:10:00, 160, -190, -140, 100, 1.5, -140, 100, 2.5, -125, -105, 9, -115, -135, 160, -190, -140, 100, 0.5, -125, -105, 5, 100, -150, ACTIVO, 1)	127.0.0.1	cesar		2271	20:35:09
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (155, SEA/HOU, SEATTLE, HOUSTON, T. Walker, D. Keuchel, 2, 2016-07-05, 20:10:00, 130, -155, -175, 135, 1.5, -175, 135, 2.5, -105, -125, 8, 100, -150, 130, -155, -175, 135, 0.5, -105, -125, 4, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2272	20:35:09
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (156, OAK/MIN, OAKLAND, MINNESOTA, S. Manaea, T. Milone, 1, 2016-07-05, 20:10:00, -130, 105, 130, -170, 1.5, 130, -170, 2.5, -105, -125, 9.5, -120, -130, -130, 105, 130, -170, 0.5, -105, -125, 5, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2273	20:35:09
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (157, YAN/CHW, YANKEES, CHWSOX, M. Tanaka, C. Rodon, 1, 2016-07-05, 20:10:00, -140, 110, 120, -160, 1.5, 120, -160, 2.5, -105, -125, 8.5, -105, -145, -140, 110, 120, -160, 0.5, -105, -125, 4.5, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2274	20:35:09
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (158, BAL/DOD, BALTIMORE, DODGERS, C. Tillman, K. Maeda, 2, 2016-07-05, 22:10:00, 135, -160, -170, 130, 1.5, -170, 130, 2.5, -120, -120, 7.5, 105, -165, 135, -160, -170, 130, 0.5, -120, -120, 4, -110, -140, ACTIVO, 1)	127.0.0.1	cesar		2275	20:35:09
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (1, 2016-07-05, 20:43:29, 100, 4647.47, PENDIENTE, 93732299, PARLEY, 1, cesar)	127.0.0.1	cesar		2276	20:43:29
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (1, 1, 146, runline2, NATIONALS, 110, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		2277	20:43:29
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (1, 1, 147, runline1, MIAMI, -180, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		2278	20:43:29
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (1, 1, 153, runline1, ANGELS, -170, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		2279	20:43:29
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (1, 1, 158, ganador1, BALTIMORE, 135, GANAR, PENDIENTE)	127.0.0.1	cesar		2280	20:43:29
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (1, 1, 155, altabaja1, SEA/HOU, -105, AB/ALTA(8,0), PENDIENTE)	127.0.0.1	cesar		2281	20:43:29
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (1, 1, 154, altabaja2, TEX/BOS, -105, AB/BAJA(9,0), PENDIENTE)	127.0.0.1	cesar		2282	20:43:29
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (2, 2016-07-05, 20:45:35, 100, 2881.91, PENDIENTE, 21766357, PARLEY, 1, cesar)	127.0.0.1	cesar		2283	20:45:35
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (2, 1, 146, runline2, NATIONALS, 110, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		2284	20:45:35
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (2, 1, 148, altabaja1, PIR/CAR, -125, AB/ALTA(8,5), PENDIENTE)	127.0.0.1	cesar		2285	20:45:35
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (2, 1, 155, ganador2, HOUSTON, -155, GANAR, PENDIENTE)	127.0.0.1	cesar		2286	20:45:35
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (2, 1, 147, runline1, MIAMI, -180, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		2287	20:45:35
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (2, 1, 158, ganador2, DODGERS, -160, GANAR, PENDIENTE)	127.0.0.1	cesar		2288	20:45:35
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (2, 1, 145, altabaja1, ATL/PHI, -120, AB/ALTA(8,5), PENDIENTE)	127.0.0.1	cesar		2289	20:45:35
2016-07-05	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=ANULADA WHERE id=2 AND id_seguridad=21766357	127.0.0.1	cesar		2290	20:45:53
2016-07-05	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta_detalle SET estatus=ANULADA WHERE id_apuesta=2	127.0.0.1	cesar		2291	20:45:53
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (3, 2016-07-05, 20:48:22, 100, 4446.38, PENDIENTE, 50668640, PARLEY, 1, cesar)	127.0.0.1	cesar		2292	20:48:22
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (3, 1, 146, runline2, NATIONALS, 110, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		2293	20:48:22
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (3, 1, 148, altabaja1, PIR/CAR, -125, AB/ALTA(8,5), PENDIENTE)	127.0.0.1	cesar		2294	20:48:22
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (3, 1, 155, ganador2, HOUSTON, -155, GANAR, PENDIENTE)	127.0.0.1	cesar		2295	20:48:22
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (3, 1, 145, altabaja1, ATL/PHI, -120, AB/ALTA(8,5), PENDIENTE)	127.0.0.1	cesar		2298	20:48:22
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (4, 2016-07-05, 20:49:32, 100, 5850.00, PENDIENTE, 40687561, PARLEY, 1, cesar)	127.0.0.1	cesar		2299	20:49:32
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (4, 1, 144, runline2, CHCUBS, -160, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		2300	20:49:32
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (4, 1, 146, ganador2, NATIONALS, -180, GANAR, PENDIENTE)	127.0.0.1	cesar		2301	20:49:32
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (4, 1, 152, ganador1, DETROIT, 170, GANAR, PENDIENTE)	127.0.0.1	cesar		2302	20:49:32
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (4, 1, 147, ganador2, METS, -150, GANAR, PENDIENTE)	127.0.0.1	cesar		2303	20:49:32
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (4, 1, 157, ganador1, YANKEES, -140, GANAR, PENDIENTE)	127.0.0.1	cesar		2304	20:49:32
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (4, 1, 150, ganador1, COLORADO, 200, GANAR, PENDIENTE)	127.0.0.1	cesar		2305	20:49:32
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (5, 2016-07-05, 20:52:45, 300, 3806.35, PENDIENTE, 63311157, PARLEY, 1, cesar)	127.0.0.1	cesar		2306	20:52:45
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (5, 1, 151, ganador2, TORONTO, -185, GANAR, PENDIENTE)	127.0.0.1	cesar		2307	20:52:46
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (5, 1, 154, ganador1, TEXAS, 160, GANAR, PENDIENTE)	127.0.0.1	cesar		2308	20:52:46
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (5, 1, 152, ganador2, CLEVELAND, -220, GANAR, PENDIENTE)	127.0.0.1	cesar		2309	20:52:46
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (5, 1, 146, ganador2, NATIONALS, -180, GANAR, PENDIENTE)	127.0.0.1	cesar		2310	20:52:46
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (5, 1, 150, ganador2, GIANTS, -250, GANAR, PENDIENTE)	127.0.0.1	cesar		2311	20:52:46
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (6, 2016-07-05, 20:53:46, 100, 4870.80, PENDIENTE, 97041931, PARLEY, 1, cesar)	127.0.0.1	cesar		2312	20:53:46
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (6, 1, 151, runline2, TORONTO, 105, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		2313	20:53:46
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (6, 1, 154, runline2, BOSTON, 100, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		2314	20:53:46
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (6, 1, 157, runline1, YANKEES, 120, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		2315	20:53:46
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (6, 1, 148, runline2, CARDINALS, 125, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		2316	20:53:46
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (6, 1, 147, runline2, METS, 140, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		2317	20:53:46
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (1,144, CIN/CHC, 2016-07-05, CINCINNATI, CINCINNATI, CINCINNATI, 9x5, 14, CINCINNATI, CINCINNATI, 6x5, 11, SI, CINCINNATI, FINALIZADO)	127.0.0.1	cesar		2318	21:01:14
2016-07-05	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=1	127.0.0.1	cesar		2319	21:04:51
2016-07-05	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=3	127.0.0.1	cesar		2320	21:04:51
2016-07-05	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=4	127.0.0.1	cesar		2321	21:04:51
2016-07-05	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=5	127.0.0.1	cesar		2322	21:04:51
2016-07-05	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=6	127.0.0.1	cesar		2323	21:04:51
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-07-05, 22:13:48, 127.0.0.1)	127.0.0.1	cesar		2324	22:13:48
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (2,147, MIA/MET, 2016-07-05, MIAMI, MIAMI, MIAMI, 5x2, 7, METS, METS, 0x1, 1, NO, METS, FINALIZADO)	127.0.0.1	cesar		2325	22:14:33
2016-07-07	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=7	127.0.0.1	cesar		2392	22:12:43
2016-07-07	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=8	127.0.0.1	cesar		2393	22:12:43
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (3,151, KAN/TOR, 2016-07-05, TORONTO, TORONTO, TORONTO, 3x8, 11, TORONTO, TORONTO, 2x7, 9, SI, TORONTO, FINALIZADO)	127.0.0.1	cesar		2326	22:15:15
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (4,145, ATL/PHI, 2016-07-05, PHILLIES, PHILLIES, PHILLIES, 1x5, 6, PHILLIES, PHILLIES, 0x3, 3, SI, PHILLIES, FINALIZADO)	127.0.0.1	cesar		2327	22:15:53
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (5,146, MIL/NAT, 2016-07-05, MILWAUKEE, MILWAUKEE, MILWAUKEE, 5x2, 7, EMPATE, EMPATE, 1x1, 2, NO, NATIONALS, FINALIZADO)	127.0.0.1	cesar		2328	22:16:44
2016-07-05	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=1	127.0.0.1	cesar		2329	22:17:54
2016-07-05	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=3	127.0.0.1	cesar		2330	22:17:54
2016-07-05	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=4	127.0.0.1	cesar		2331	22:17:54
2016-07-05	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=5	127.0.0.1	cesar		2332	22:17:54
2016-07-05	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=6	127.0.0.1	cesar		2333	22:17:54
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (6,152, DET/CLE, 2016-07-05, CLEVELAND, CLEVELAND, CLEVELAND, 1x12, 13, CLEVELAND, CLEVELAND, 0x4, 4, NO, CLEVELAND, FINALIZADO)	127.0.0.1	cesar		2334	22:30:21
2016-07-05	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=1	127.0.0.1	cesar		2335	22:30:28
2016-07-05	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=3	127.0.0.1	cesar		2336	22:30:28
2016-07-05	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=4	127.0.0.1	cesar		2337	22:30:28
2016-07-05	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=5	127.0.0.1	cesar		2338	22:30:28
2016-07-05	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=6	127.0.0.1	cesar		2339	22:30:28
2016-07-05	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (7,153, ANG/TAM, 2016-07-05, ANGELS, ANGELS, ANGELS, 13x5, 18, TAMPA, TAMPA, 4x5, 9, SI, TAMPA, FINALIZADO)	127.0.0.1	cesar		2340	22:34:40
2016-07-06	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-07-06, 06:04:05, 127.0.0.1)	127.0.0.1	cesar		2341	06:04:06
2016-07-06	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (8,148, PIR/CAR, 2016-07-05, PIRATES, PIRATES, PIRATES, 5x2, 7, EMPATE, EMPATE, 2x2, 4, NO, CARDINALS, FINALIZADO)	127.0.0.1	cesar		2342	06:04:47
2016-07-06	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (9,149, PAD/ARI, 2016-07-05, ARIZONA, ARIZONA, PADRES, 5x7, 12, ARIZONA, ARIZONA, 4x5, 9, NO, PADRES, FINALIZADO)	127.0.0.1	cesar		2343	06:05:35
2016-07-06	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (10,150, COL/GIA, 2016-07-05, COLORADO, COLORADO, COLORADO, 7x3, 10, GIANTS, GIANTS, 0x1, 1, SI, GIANTS, FINALIZADO)	127.0.0.1	cesar		2344	06:06:23
2016-07-06	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (11,154, TEX/BOS, 2016-07-05, TEXAS, TEXAS, TEXAS, 7x2, 9, EMPATE, EMPATE, 2x2, 4, SI, TEXAS, FINALIZADO)	127.0.0.1	cesar		2345	06:07:06
2016-07-06	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (12,155, SEA/HOU, 2016-07-05, HOUSTON, HOUSTON, HOUSTON, 2x5, 7, HOUSTON, HOUSTON, 2x5, 7, NO, SEATTLE, FINALIZADO)	127.0.0.1	cesar		2346	06:07:47
2016-07-06	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=1	127.0.0.1	cesar		2347	06:07:53
2016-07-06	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=3	127.0.0.1	cesar		2348	06:07:53
2016-07-06	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=4	127.0.0.1	cesar		2349	06:07:53
2016-07-06	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=5	127.0.0.1	cesar		2350	06:07:53
2016-07-06	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=6	127.0.0.1	cesar		2351	06:07:53
2016-07-06	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (13,156, OAK/MIN, 2016-07-05, MINNESOTA, MINNESOTA, MINNESOTA, 4x11, 15, MINNESOTA, MINNESOTA, 1x3, 4, NO, OAKLAND, FINALIZADO)	127.0.0.1	cesar		2352	06:09:35
2016-07-06	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (14,157, YAN/CHW, 2016-07-05, YANKEES, YANKEES, YANKEES, 9x0, 9, YANKEES, YANKEES, 6x0, 6, NO, YANKEES, FINALIZADO)	127.0.0.1	cesar		2353	06:10:03
2016-07-07	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=9	127.0.0.1	cesar		2394	22:12:43
2016-07-07	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=10	127.0.0.1	cesar		2395	22:12:43
2016-07-06	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (15,158, BAL/DOD, 2016-07-05, BALTIMORE, BALTIMORE, BALTIMORE, 4x1, 5, BALTIMORE, BALTIMORE, 4x1, 5, SI, DODGERS, FINALIZADO)	127.0.0.1	cesar		2354	06:10:41
2016-07-06	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=1	127.0.0.1	cesar		2355	06:10:48
2016-07-06	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=3	127.0.0.1	cesar		2356	06:10:48
2016-07-06	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=4	127.0.0.1	cesar		2357	06:10:48
2016-07-06	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=6	127.0.0.1	cesar		2358	06:10:48
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-07-08, 01:52:58, 127.0.0.1)	127.0.0.1	cesar		2359	01:53:00
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (174, PIR/CAR, PIRATES, CARDINALS, T. Glasnow, A. Wainwright, 2, 2016-07-07, 13:45:00, 130, -175, -165, 105, 1.5, -165, 105, 2.5, -120, -120, 8, 100, -150, 130, -175, -165, 105, 0.5, -120, -120, 4, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2360	01:53:40
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (175, NAT/MET, NATIONALS, METS, L. Giolito, B. Colon, 2, 2016-07-07, 19:10:00, -105, -135, -225, 155, 1.5, -225, 155, 2.5, -130, -110, 7.5, 105, -165, -105, -135, -225, 155, 0.5, -130, -110, 4, -140, -110, ACTIVO, 1)	127.0.0.1	cesar		2361	01:53:40
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (176, PHI/COL, PHILLIES, COLORADO, A. Morgan, C. Bettis, 2, 2016-07-07, 20:40:00, 140, -200, -150, 100, 1.5, -150, 100, 2.5, -120, -120, 12.5, -175, 115, 140, -200, -150, 100, 0.5, -120, -120, 7, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2362	01:53:40
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (177, PAD/DOD, PADRES, DODGERS, D. Pomeranz, H. Ryu, 2, 2016-07-07, 22:10:00, 115, -160, -180, 120, 1.5, -180, 120, 2.5, -125, -115, 7, 115, -175, 115, -160, -180, 120, 0.5, -125, -115, 3.5, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2363	01:53:40
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (178, ANG/TAM, ANGELS, TAMPA, H. Santiago, B. Snell, 2, 2016-07-07, 12:10:00, -105, -135, -225, 145, 1.5, -225, 145, 2.5, -115, -125, 9.5, -120, -130, -105, -135, -225, 145, 0.5, -115, -125, 5, -145, -105, ACTIVO, 1)	127.0.0.1	cesar		2364	01:53:40
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (179, DET/TOR, DETROIT, TORONTO, J. Verlander, D. Hutchison, 2, 2016-07-07, 19:05:00, 100, -130, -220, 150, 1.5, -220, 150, 2.5, -125, -115, 9.5, -120, -130, 100, -130, -220, 150, 0.5, -125, -115, 5, -145, -105, ACTIVO, 1)	127.0.0.1	cesar		2365	01:53:40
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (180, YAN/CLE, YANKEES, CLEVELAND, I. Nova, T. Bauer, 2, 2016-07-07, 19:10:00, 135, -190, -160, 115, 1.5, -160, 115, 2.5, -125, -115, 8.5, -105, -145, 135, -190, -160, 115, 0.5, -125, -115, 4.5, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2366	01:53:40
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (181, MIN/TEX, MINNESOTA, TEXAS, T. Duffey, C. Gonzalez, 2, 2016-07-07, 20:05:00, 105, -140, -200, 150, 1.5, -200, 150, 2.5, -120, -120, 11, -135, -115, 105, -140, -200, 150, 0.5, -120, -120, 6, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2367	01:53:40
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (182, OAK/HOU, OAKLAND, HOUSTON, R. Hill, D. Fister, 2, 2016-07-07, 20:10:00, 105, -150, -200, 150, 1.5, -200, 150, 2.5, -125, -115, 8, 100, -150, 105, -150, -200, 150, 0.5, -125, -115, 4, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2368	01:53:40
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (183, SEA/KAN, SEATTLE, KANSAS, J. Paxton, D. Duffy, 2, 2016-07-07, 20:15:00, 110, -150, -205, 145, 1.5, -205, 145, 2.5, -125, -115, 8.5, -105, -145, 110, -150, -205, 145, 0.5, -125, -115, 4.5, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2369	01:53:40
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (184, ATL/CHC, ATLANTA, CHCUBS, L. Harrell, J. Hammel, 2, 2016-07-07, 20:05:00, 200, -300, 120, -180, 1.5, 120, -180, 2.5, -120, -120, 9, -120, -120, 200, -300, 120, -180, 0.5, -120, -120, 5.5, 115, -175, ACTIVO, 1)	127.0.0.1	cesar		2370	01:53:40
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (7, 2016-07-07, 21:55:44, 1000, 4000.00, PENDIENTE, 81611633, PARLEY, 1, cesar)	127.0.0.1	cesar		2371	21:55:44
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (7, 1, 176, ganador2, COLORADO, -200, GANAR, PENDIENTE)	127.0.0.1	cesar		2372	21:55:44
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (7, 1, 179, ganador1, DETROIT, 100, GANAR, PENDIENTE)	127.0.0.1	cesar		2373	21:55:44
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (7, 1, 184, ganador2, CHCUBS, -300, GANAR, PENDIENTE)	127.0.0.1	cesar		2374	21:55:44
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (16,174, PIR/CAR, 2016-07-07, CARDINALS, CARDINALS, CARDINALS, 1x5, 6, CARDINALS, CARDINALS, 1x2, 3, NO, CARDINALS, FINALIZADO)	127.0.0.1	cesar		2375	22:09:39
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (17,178, ANG/TAM, 2016-07-07, ANGELS, ANGELS, ANGELS, 5x1, 6, EMPATE, EMPATE, 0x0, 0, NO, ANGELS, FINALIZADO)	127.0.0.1	cesar		2376	22:10:08
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (8, 2016-07-07, 22:11:53, 50, 660.61, PENDIENTE, 55302124, PARLEY, 1, cesar)	127.0.0.1	cesar		2377	22:11:53
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (8, 1, 174, ganador1, PIRATES, 130, GANAR, PENDIENTE)	127.0.0.1	cesar		2378	22:11:53
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (8, 1, 178, ganador2, TAMPA, -135, GANAR, PENDIENTE)	127.0.0.1	cesar		2379	22:11:53
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (8, 1, 174, altabaja2, PIR/CAR, -120, AB/BAJA(8,0), PENDIENTE)	127.0.0.1	cesar		2380	22:11:53
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (8, 1, 178, altabaja2, ANG/TAM, -125, AB/BAJA(9,5), PENDIENTE)	127.0.0.1	cesar		2381	22:11:53
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (9, 2016-07-07, 22:12:05, 50, 506.22, PENDIENTE, 87019653, PARLEY, 1, cesar)	127.0.0.1	cesar		2382	22:12:05
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (9, 1, 174, ganador2, CARDINALS, -175, GANAR, PENDIENTE)	127.0.0.1	cesar		2383	22:12:05
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (9, 1, 178, ganador1, ANGELS, -105, GANAR, PENDIENTE)	127.0.0.1	cesar		2384	22:12:05
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (9, 1, 178, altabaja2, ANG/TAM, -125, AB/BAJA(9,5), PENDIENTE)	127.0.0.1	cesar		2385	22:12:05
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (9, 1, 174, altabaja2, PIR/CAR, -120, AB/BAJA(8,0), PENDIENTE)	127.0.0.1	cesar		2386	22:12:05
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (10, 2016-07-07, 22:12:23, 50, 452.34, PENDIENTE, 89595947, PARLEY, 1, cesar)	127.0.0.1	cesar		2387	22:12:23
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (10, 1, 174, ganador2, CARDINALS, -175, GANAR, PENDIENTE)	127.0.0.1	cesar		2388	22:12:23
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (10, 1, 178, ganador1, ANGELS, -105, GANAR, PENDIENTE)	127.0.0.1	cesar		2389	22:12:23
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (10, 1, 174, p_inning2, PIR/CAR, -150, P/INNG(NO), PENDIENTE)	127.0.0.1	cesar		2390	22:12:23
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (10, 1, 178, p_inning2, ANG/TAM, -130, P/INNG(NO), PENDIENTE)	127.0.0.1	cesar		2391	22:12:23
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (11, 2016-07-07, 22:13:47, 50, 1783.38, PENDIENTE, 41618652, PARLEY, 1, cesar)	127.0.0.1	cesar		2396	22:13:47
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (11, 1, 174, runline2, CARDINALS, 105, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		2397	22:13:47
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (11, 1, 178, runline1, ANGELS, -225, RLINE(+1,5), PENDIENTE)	127.0.0.1	cesar		2398	22:13:47
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (11, 1, 174, altabaja2, PIR/CAR, -120, AB/BAJA(8,0), PENDIENTE)	127.0.0.1	cesar		2399	22:13:47
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (11, 1, 178, altabaja2, ANG/TAM, -125, AB/BAJA(9,5), PENDIENTE)	127.0.0.1	cesar		2400	22:13:47
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (11, 1, 178, p_anotar2, TAMPA, -105, P/ANOT, PENDIENTE)	127.0.0.1	cesar		2401	22:13:47
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (11, 1, 174, p_anotar2, CARDINALS, -115, P/ANOT, PENDIENTE)	127.0.0.1	cesar		2402	22:13:47
2016-07-07	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=7	127.0.0.1	cesar		2403	22:13:53
2016-07-07	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=11	127.0.0.1	cesar		2404	22:13:53
2016-07-07	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (18,180, YAN/CLE, 2016-07-07, YANKEES, YANKEES, YANKEES, 5x4, 9, EMPATE, EMPATE, 2x2, 4, NO, CLEVELAND, FINALIZADO)	127.0.0.1	cesar		2405	22:18:03
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-07-08, 06:13:09, 127.0.0.1)	127.0.0.1	cesar		2406	06:13:09
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (19,175, NAT/MET, 2016-07-07, METS, METS, NATIONALS, 7x9, 16, METS, METS, 6x7, 13, SI, NATIONALS, FINALIZADO)	127.0.0.1	cesar		2407	06:14:38
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (20,176, PHI/COL, 2016-07-07, COLORADO, COLORADO, COLORADO, 2x11, 13, COLORADO, COLORADO, 2x5, 7, SI, COLORADO, FINALIZADO)	127.0.0.1	cesar		2408	06:15:17
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (21,177, PAD/DOD, 2016-07-07, PADRES, PADRES, PADRES, 6x0, 6, PADRES, PADRES, 6x0, 6, SI, PADRES, FINALIZADO)	127.0.0.1	cesar		2409	06:15:46
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (22,179, DET/TOR, 2016-07-07, TORONTO, DETROIT, DETROIT, 4x5, 9, DETROIT, DETROIT, 3x2, 5, SI, TORONTO, FINALIZADO)	127.0.0.1	cesar		2410	06:16:40
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (23,181, MIN/TEX, 2016-07-07, MINNESOTA, MINNESOTA, MINNESOTA, 10x1, 11, MINNESOTA, MINNESOTA, 4x0, 4, SI, MINNESOTA, FINALIZADO)	127.0.0.1	cesar		2411	06:17:10
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (24,182, OAK/HOU, 2016-07-07, OAKLAND, OAKLAND, OAKLAND, 3x1, 4, OAKLAND, OAKLAND, 2x1, 3, SI, HOUSTON, FINALIZADO)	127.0.0.1	cesar		2412	06:17:41
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (25,183, SEA/KAN, 2016-07-07, KANSAS, SEATTLE, SEATTLE, 3x4, 7, SEATTLE, SEATTLE, 2x0, 2, NO, SEATTLE, FINALIZADO)	127.0.0.1	cesar		2413	06:18:10
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (26,184, ATL/CHC, 2016-07-07, ATLANTA, ATLANTA, ATLANTA, 4x3, 7, ATLANTA, ATLANTA, 2x0, 2, SI, ATLANTA, FINALIZADO)	127.0.0.1	cesar		2414	06:18:45
2016-07-08	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=7	127.0.0.1	cesar		2415	06:18:52
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-07-08, 22:20:01, 127.0.0.1)	127.0.0.1	cesar		2416	22:20:01
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (185, CHC/PIR, CHCUBS, PIRATES, J. Arrieta, F. Liriano, 1, 2016-07-08, 23:05:00, -185, 140, -125, -115, 1.5, -125, -115, 2.5, -125, -105, 7.5, -125, -115, 0.5, 105, -165, -185, 140, -125, -105, 4, -150, 100, ACTIVO, 1)	127.0.0.1	cesar		2417	22:29:59
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (14, 1, 193, altabaja2, DET/TOR, -115, AB/BAJA(10,0), PENDIENTE)	127.0.0.1	cesar		2451	22:33:06
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (186, CIN/MIA, CINCINNATI, MIAMI, D. Straily, J. Fernandez, 2, 2016-07-08, 23:05:00, 230, -340, 150, -190, 1.5, 150, -190, 2.5, -120, -110, 7, 150, -190, 0.5, 115, -175, 230, -340, -120, -110, 3.5, 130, -180, ACTIVO, 1)	127.0.0.1	cesar		2418	22:29:59
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (187, NAT/MET, NATIONALS, METS, S. Strasburg, N. Syndergaard, 1, 2016-07-08, 23:05:00, -125, -115, 145, -185, 1.5, 145, -185, 2.5, -120, -110, 6.5, 145, -185, 0.5, 140, -220, -125, -115, -120, -110, 3.5, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2419	22:29:59
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (188, PHI/COL, PHILLIES, COLORADO, V. Velasquez, J. Gray, 2, 2016-07-08, 23:05:00, 110, -155, -190, 150, 1.5, -190, 150, 2.5, -130, -105, 11, -190, 150, 0.5, -135, -115, 110, -155, -130, -105, 6, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2420	22:29:59
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (189, CAR/MIL, CARDINALS, MILWAUKEE, M. Wacha, J. Nelson, 1, 2016-07-08, 23:05:00, -160, 120, 115, -155, 1.5, 115, -155, 2.5, -125, -105, 8.5, 115, -155, 0.5, -105, -145, -160, 120, -125, -105, 4.5, -160, 110, ACTIVO, 1)	127.0.0.1	cesar		2421	22:29:59
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (190, PAD/DOD, PADRES, DODGERS, A. Cashner, S. Kazmir, 2, 2016-07-08, 23:05:00, 145, -210, -150, 110, 1.5, -150, 110, 2.5, -110, -120, 8, -150, 110, 0.5, 100, -150, 145, -210, -110, -120, 4, 100, -150, ACTIVO, 1)	127.0.0.1	cesar		2422	22:29:59
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (191, ARI/GIA, ARIZONA, GIANTS, P. Corbin, J. Samardzija, 2, 2016-07-08, 23:05:00, 130, -180, -175, 135, 1.5, -175, 135, 2.5, -125, -105, 7.5, -175, 135, 0.5, 105, -165, 130, -180, -125, -105, 4, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2423	22:29:59
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (192, ANG/BAL, ANGELS, BALTIMORE, M. Shoemaker, U. Jimenez, 2, 2016-07-08, 23:05:00, 105, -135, -205, 155, 1.5, -205, 155, 2.5, -125, -110, 10, -205, 155, 0.5, -140, -110, 105, -135, -130, -115, 5.5, -140, -110, ACTIVO, 1)	127.0.0.1	cesar		2424	22:29:59
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (193, DET/TOR, DETROIT, TORONTO, M. Pelfrey, J. Happ, 2, 2016-07-08, 23:05:00, 145, -210, -150, 110, 1.5, -150, 110, 2.5, -125, -115, 10, -150, 110, 0.5, -125, -125, 145, -210, -125, -115, 5.5, -115, -135, ACTIVO, 1)	127.0.0.1	cesar		2425	22:29:59
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (194, TAM/BOS, TAMPA, BOSTON, C. Archer, S. OSullivan, 2, 2016-07-08, 23:05:00, -120, -130, -210, 170, 1.5, -210, 170, 2.5, -120, -120, 10, -210, 170, 0.5, -125, -125, -120, -130, -120, -120, 5.5, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2426	22:29:59
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (195, YAN/CLE, YANKEES, CLEVELAND, C. Green, C. Kluber, 2, 2016-07-08, 23:05:00, 145, -205, -145, 105, 1.5, -145, 105, 2.5, -125, -105, 8, -145, 105, 0.5, 100, -150, 145, -205, -125, -105, 4, -115, -135, ACTIVO, 1)	127.0.0.1	cesar		2427	22:29:59
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (196, MIN/TEX, MINNESOTA, TEXAS, K. Gibson, C. Hamels, 2, 2016-07-08, 23:05:00, 170, -230, 110, -150, 1.5, 110, -150, 2.5, -105, -125, 9.5, 110, -150, 0.5, -120, -130, 170, -230, -105, -125, 5, 120, -170, ACTIVO, 1)	127.0.0.1	cesar		2428	22:29:59
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (197, OAK/HOU, OAKLAND, HOUSTON, D. Mengden, C. McHugh, 2, 2016-07-08, 23:05:00, 135, -180, -175, 135, 1.5, -175, 135, 2.5, -125, -105, 8, -175, 135, 0.5, 100, -150, 135, -180, -125, -105, 4, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2429	22:29:59
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (198, SEA/KAN, SEATTLE, KANSAS, H. Iwakuma, Y. Ventura, 2, 2016-07-08, 23:05:00, -120, -130, -205, 165, 1.5, -205, 165, 2.5, -120, -120, 8.5, -205, 165, 0.5, -105, -145, -120, -130, -120, -120, 4.5, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2430	22:29:59
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (199, ATL/CHW, ATLANTA, CHWSOX, M. Wisler, C. Sale, 2, 2016-07-08, 23:05:00, 220, -350, 150, -220, 1.5, 150, -220, 2.5, -120, -120, 8, 150, -220, 0.5, 100, -150, 220, -350, -120, -120, 4, 120, -180, ACTIVO, 1)	127.0.0.1	cesar		2431	22:29:59
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (12, 2016-07-08, 22:31:01, 80, 2893.98, PENDIENTE, 35823364, PARLEY, 1, cesar)	127.0.0.1	cesar		2432	22:31:01
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (12, 1, 185, ganador1, CHCUBS, -185, GANAR, PENDIENTE)	127.0.0.1	cesar		2433	22:31:01
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (12, 1, 186, altabaja2, CIN/MIA, -110, AB/BAJA(7,0), PENDIENTE)	127.0.0.1	cesar		2434	22:31:01
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (12, 1, 187, ganador1, NATIONALS, -125, GANAR, PENDIENTE)	127.0.0.1	cesar		2435	22:31:01
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (12, 1, 190, runline2, DODGERS, 110, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		2436	22:31:01
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (12, 1, 196, runline2, TEXAS, -150, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		2437	22:31:01
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (12, 1, 195, altabaja2, YAN/CLE, -105, AB/BAJA(8,0), PENDIENTE)	127.0.0.1	cesar		2438	22:31:01
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (13, 2016-07-08, 22:31:49, 80, 1226.78, PENDIENTE, 72693481, PARLEY, 1, cesar)	127.0.0.1	cesar		2439	22:31:49
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (13, 1, 199, runline2, CHWSOX, -220, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		2440	22:31:49
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (13, 1, 196, runline2, TEXAS, -150, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		2441	22:31:49
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (13, 1, 195, ganador2, CLEVELAND, -205, GANAR, PENDIENTE)	127.0.0.1	cesar		2442	22:31:49
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (13, 1, 190, ganador2, DODGERS, -210, GANAR, PENDIENTE)	127.0.0.1	cesar		2443	22:31:49
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (13, 1, 187, ganador2, METS, -115, GANAR, PENDIENTE)	127.0.0.1	cesar		2444	22:31:49
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (13, 1, 185, ganador1, CHCUBS, -185, GANAR, PENDIENTE)	127.0.0.1	cesar		2445	22:31:49
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (14, 2016-07-08, 22:33:06, 80, 3417.05, PENDIENTE, 88714294, PARLEY, 1, cesar)	127.0.0.1	cesar		2446	22:33:06
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (14, 1, 196, runline2, TEXAS, -150, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		2447	22:33:06
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (14, 1, 185, ganador1, CHCUBS, -185, GANAR, PENDIENTE)	127.0.0.1	cesar		2448	22:33:06
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (14, 1, 187, ganador1, NATIONALS, -125, GANAR, PENDIENTE)	127.0.0.1	cesar		2449	22:33:06
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (14, 1, 192, ganador2, BALTIMORE, -135, GANAR, PENDIENTE)	127.0.0.1	cesar		2450	22:33:06
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (14, 1, 199, runline2, CHWSOX, -220, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		2452	22:33:06
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (14, 1, 195, altabaja2, YAN/CLE, -105, AB/BAJA(8,0), PENDIENTE)	127.0.0.1	cesar		2453	22:33:06
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (15, 2016-07-08, 22:34:16, 1000, 6616.36, PENDIENTE, 78733215, PARLEY, 1, cesar)	127.0.0.1	cesar		2454	22:34:16
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (15, 1, 186, ganador2, MIAMI, -340, GANAR, PENDIENTE)	127.0.0.1	cesar		2455	22:34:16
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (15, 1, 195, ganador2, CLEVELAND, -205, GANAR, PENDIENTE)	127.0.0.1	cesar		2456	22:34:16
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (15, 1, 195, altabaja1, YAN/CLE, -125, AB/ALTA(8,0), PENDIENTE)	127.0.0.1	cesar		2457	22:34:16
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (15, 1, 186, altabaja2, CIN/MIA, -110, AB/BAJA(7,0), PENDIENTE)	127.0.0.1	cesar		2458	22:34:16
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (185, CHC/PIR, CHCUBS, PIRATES, J. Arrieta, F. Liriano, 1, 2016-07-08, 23:05:00, -185, 140, -125, -115, 1.5, -125, -115, 2.5, -125, -105, 7.5, -125, -115, 0.5, 105, -165, -185, 140, -125, -105, 4, -150, 100, ACTIVO, 1)	127.0.0.1	cesar		2459	22:37:25
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (186, CIN/MIA, CINCINNATI, MIAMI, D. Straily, J. Fernandez, 2, 2016-07-08, 23:05:00, 230, -340, 150, -190, 1.5, 150, -190, 2.5, -120, -110, 7, 150, -190, 0.5, 115, -175, 230, -340, -120, -110, 3.5, 130, -180, ACTIVO, 1)	127.0.0.1	cesar		2460	22:37:25
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (187, NAT/MET, NATIONALS, METS, S. Strasburg, N. Syndergaard, 1, 2016-07-08, 23:05:00, -125, -115, 145, -185, 1.5, 145, -185, 2.5, -120, -110, 6.5, 145, -185, 0.5, 140, -220, -125, -115, -120, -110, 3.5, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2461	22:37:25
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (188, PHI/COL, PHILLIES, COLORADO, V. Velasquez, J. Gray, 2, 2016-07-08, 23:05:00, 110, -155, -190, 150, 1.5, -190, 150, 2.5, -130, -105, 11, -190, 150, 0.5, -135, -115, 110, -155, -130, -105, 6, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2462	22:37:25
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (189, CAR/MIL, CARDINALS, MILWAUKEE, M. Wacha, J. Nelson, 1, 2016-07-08, 23:05:00, -160, 120, 115, -155, 1.5, 115, -155, 2.5, -125, -105, 8.5, 115, -155, 0.5, -105, -145, -160, 120, -125, -105, 4.5, -160, 110, ACTIVO, 1)	127.0.0.1	cesar		2463	22:37:25
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (190, PAD/DOD, PADRES, DODGERS, A. Cashner, S. Kazmir, 2, 2016-07-08, 23:05:00, 145, -210, -150, 110, 1.5, -150, 110, 2.5, -110, -120, 8, -150, 110, 0.5, 100, -150, 145, -210, -110, -120, 4, 100, -150, ACTIVO, 1)	127.0.0.1	cesar		2464	22:37:25
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (191, ARI/GIA, ARIZONA, GIANTS, P. Corbin, J. Samardzija, 2, 2016-07-08, 23:05:00, 130, -180, -175, 135, 1.5, -175, 135, 2.5, -125, -105, 7.5, -175, 135, 0.5, 105, -165, 130, -180, -125, -105, 4, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2465	22:37:25
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (192, ANG/BAL, ANGELS, BALTIMORE, M. Shoemaker, U. Jimenez, 2, 2016-07-08, 23:05:00, 105, -135, -205, 155, 1.5, -205, 155, 2.5, -125, -110, 10, -205, 155, 0.5, -140, -110, 105, -135, -130, -115, 5.5, -140, -110, ACTIVO, 1)	127.0.0.1	cesar		2466	22:37:26
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (193, DET/TOR, DETROIT, TORONTO, M. Pelfrey, J. Happ, 2, 2016-07-08, 23:05:00, 145, -210, -150, 110, 1.5, -150, 110, 2.5, -125, -115, 10, -150, 110, 0.5, -125, -125, 145, -210, -125, -115, 5.5, -115, -135, ACTIVO, 1)	127.0.0.1	cesar		2467	22:37:26
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (194, TAM/BOS, TAMPA, BOSTON, C. Archer, S. OSullivan, 2, 2016-07-08, 23:05:00, -120, -130, -210, 170, 1.5, -210, 170, 2.5, -120, -120, 10, -210, 170, 0.5, -125, -125, -120, -130, -120, -120, 5.5, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2468	22:37:26
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (195, YAN/CLE, YANKEES, CLEVELAND, C. Green, C. Kluber, 2, 2016-07-08, 23:05:00, 145, -205, -145, 105, 1.5, -145, 105, 2.5, -125, -105, 8, -145, 105, 0.5, 100, -150, 145, -205, -125, -105, 4, -115, -135, ACTIVO, 1)	127.0.0.1	cesar		2469	22:37:26
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (196, MIN/TEX, MINNESOTA, TEXAS, K. Gibson, C. Hamels, 2, 2016-07-08, 23:05:00, 170, -230, 110, -150, 1.5, 110, -150, 2.5, -105, -125, 9.5, 110, -150, 0.5, -120, -130, 170, -230, -105, -125, 5, 120, -170, ACTIVO, 1)	127.0.0.1	cesar		2470	22:37:26
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (197, OAK/HOU, OAKLAND, HOUSTON, D. Mengden, C. McHugh, 2, 2016-07-08, 23:05:00, 135, -180, -175, 135, 1.5, -175, 135, 2.5, -125, -105, 8, -175, 135, 0.5, 100, -150, 135, -180, -125, -105, 4, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2471	22:37:26
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (198, SEA/KAN, SEATTLE, KANSAS, H. Iwakuma, Y. Ventura, 2, 2016-07-08, 23:05:00, -120, -130, -205, 165, 1.5, -205, 165, 2.5, -120, -120, 8.5, -205, 165, 0.5, -105, -145, -120, -130, -120, -120, 4.5, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2472	22:37:26
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (199, ATL/CHW, ATLANTA, CHWSOX, M. Wisler, C. Sale, 2, 2016-07-08, 23:05:00, 220, -350, 150, -220, 1.5, 150, -220, 2.5, -120, -120, 8, 150, -220, 0.5, 100, -150, 220, -350, -120, -120, 4, 120, -180, ACTIVO, 1)	127.0.0.1	cesar		2473	22:37:26
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (185, CHC/PIR, CHCUBS, PIRATES, J. Arrieta, F. Liriano, 1, 2016-07-08, 23:05:00, -185, 140, -125, -115, 1.5, -125, -115, 2.5, -125, -105, 7.5, 105, -165, -185, 140, -125, -115, 0.5, -125, -105, 4, -150, 100, ACTIVO, 1)	127.0.0.1	cesar		2474	22:38:00
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (186, CIN/MIA, CINCINNATI, MIAMI, D. Straily, J. Fernandez, 2, 2016-07-08, 23:05:00, 230, -340, 150, -190, 1.5, 150, -190, 2.5, -120, -110, 7, 115, -175, 230, -340, 150, -190, 0.5, -120, -110, 3.5, 130, -180, ACTIVO, 1)	127.0.0.1	cesar		2475	22:38:00
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (187, NAT/MET, NATIONALS, METS, S. Strasburg, N. Syndergaard, 1, 2016-07-08, 23:05:00, -125, -115, 145, -185, 1.5, 145, -185, 2.5, -120, -110, 6.5, 140, -220, -125, -115, 145, -185, 0.5, -120, -110, 3.5, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2476	22:38:00
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (188, PHI/COL, PHILLIES, COLORADO, V. Velasquez, J. Gray, 2, 2016-07-08, 23:05:00, 110, -155, -190, 150, 1.5, -190, 150, 2.5, -130, -105, 11, -135, -115, 110, -155, -190, 150, 0.5, -130, -105, 6, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2477	22:38:00
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (189, CAR/MIL, CARDINALS, MILWAUKEE, M. Wacha, J. Nelson, 1, 2016-07-08, 23:05:00, -160, 120, 115, -155, 1.5, 115, -155, 2.5, -125, -105, 8.5, -105, -145, -160, 120, 115, -155, 0.5, -125, -105, 4.5, -160, 110, ACTIVO, 1)	127.0.0.1	cesar		2478	22:38:00
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (190, PAD/DOD, PADRES, DODGERS, A. Cashner, S. Kazmir, 2, 2016-07-08, 23:05:00, 145, -210, -150, 110, 1.5, -150, 110, 2.5, -110, -120, 8, 100, -150, 145, -210, -150, 110, 0.5, -110, -120, 4, 100, -150, ACTIVO, 1)	127.0.0.1	cesar		2479	22:38:00
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (191, ARI/GIA, ARIZONA, GIANTS, P. Corbin, J. Samardzija, 2, 2016-07-08, 23:05:00, 130, -180, -175, 135, 1.5, -175, 135, 2.5, -125, -105, 7.5, 105, -165, 130, -180, -175, 135, 0.5, -125, -105, 4, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2480	22:38:00
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (192, ANG/BAL, ANGELS, BALTIMORE, M. Shoemaker, U. Jimenez, 2, 2016-07-08, 23:05:00, 105, -135, -205, 155, 1.5, -205, 155, 2.5, -125, -110, 10, -140, -110, 105, -135, -205, 155, 0.5, -130, -115, 5.5, -140, -110, ACTIVO, 1)	127.0.0.1	cesar		2481	22:38:00
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (193, DET/TOR, DETROIT, TORONTO, M. Pelfrey, J. Happ, 2, 2016-07-08, 23:05:00, 145, -210, -150, 110, 1.5, -150, 110, 2.5, -125, -115, 10, -125, -125, 145, -210, -150, 110, 0.5, -125, -115, 5.5, -115, -135, ACTIVO, 1)	127.0.0.1	cesar		2482	22:38:00
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (194, TAM/BOS, TAMPA, BOSTON, C. Archer, S. OSullivan, 2, 2016-07-08, 23:05:00, -120, -130, -210, 170, 1.5, -210, 170, 2.5, -120, -120, 10, -125, -125, -120, -130, -210, 170, 0.5, -120, -120, 5.5, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2483	22:38:00
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (195, YAN/CLE, YANKEES, CLEVELAND, C. Green, C. Kluber, 2, 2016-07-08, 23:05:00, 145, -205, -145, 105, 1.5, -145, 105, 2.5, -125, -105, 8, 100, -150, 145, -205, -145, 105, 0.5, -125, -105, 4, -115, -135, ACTIVO, 1)	127.0.0.1	cesar		2484	22:38:00
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (196, MIN/TEX, MINNESOTA, TEXAS, K. Gibson, C. Hamels, 2, 2016-07-08, 23:05:00, 170, -230, 110, -150, 1.5, 110, -150, 2.5, -105, -125, 9.5, -120, -130, 170, -230, 110, -150, 0.5, -105, -125, 5, 120, -170, ACTIVO, 1)	127.0.0.1	cesar		2485	22:38:00
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (197, OAK/HOU, OAKLAND, HOUSTON, D. Mengden, C. McHugh, 2, 2016-07-08, 23:05:00, 135, -180, -175, 135, 1.5, -175, 135, 2.5, -125, -105, 8, 100, -150, 135, -180, -175, 135, 0.5, -125, -105, 4, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2486	22:38:00
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (198, SEA/KAN, SEATTLE, KANSAS, H. Iwakuma, Y. Ventura, 2, 2016-07-08, 23:05:00, -120, -130, -205, 165, 1.5, -205, 165, 2.5, -120, -120, 8.5, -105, -145, -120, -130, -205, 165, 0.5, -120, -120, 4.5, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2487	22:38:00
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (199, ATL/CHW, ATLANTA, CHWSOX, M. Wisler, C. Sale, 2, 2016-07-08, 23:05:00, 220, -350, 150, -220, 1.5, 150, -220, 2.5, -120, -120, 8, 100, -150, 220, -350, 150, -220, 0.5, -120, -120, 4, 120, -180, ACTIVO, 1)	127.0.0.1	cesar		2488	22:38:00
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (16, 2016-07-08, 22:39:16, 500, 13012.90, PENDIENTE, 61671447, PARLEY, 1, cesar)	127.0.0.1	cesar		2489	22:39:16
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (16, 1, 187, g_mediojuego1, NATIONALS, -125, GMITAD, PENDIENTE)	127.0.0.1	cesar		2490	22:39:16
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (16, 1, 185, g_mediojuego2, PIRATES, 140, GMITAD, PENDIENTE)	127.0.0.1	cesar		2491	22:39:16
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (16, 1, 192, g_mediojuego1, ANGELS, 105, GMITAD, PENDIENTE)	127.0.0.1	cesar		2492	22:39:16
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (16, 1, 192, p_anotar1, ANGELS, -140, P/ANOT, PENDIENTE)	127.0.0.1	cesar		2493	22:39:16
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (16, 1, 192, p_inning1, ANG/BAL, -140, P/INNG(SI), PENDIENTE)	127.0.0.1	cesar		2494	22:39:16
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (17, 2016-07-08, 22:39:41, 50, 231.27, PENDIENTE, 90249633, PARLEY, 1, cesar)	127.0.0.1	cesar		2495	22:39:41
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (17, 1, 193, g_mediojuego2, TORONTO, -210, GMITAD, PENDIENTE)	127.0.0.1	cesar		2496	22:39:41
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (17, 1, 193, p_inning1, DET/TOR, -125, P/INNG(SI), PENDIENTE)	127.0.0.1	cesar		2497	22:39:41
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (17, 1, 193, p_anotar2, TORONTO, -135, P/ANOT, PENDIENTE)	127.0.0.1	cesar		2498	22:39:41
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (18, 2016-07-08, 22:40:05, 50, 573.64, PENDIENTE, 63684692, PARLEY, 1, cesar)	127.0.0.1	cesar		2499	22:40:05
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (18, 1, 190, ab_mediojuego2, PAD/DOD, -120, ABM/BAJA(4,0), PENDIENTE)	127.0.0.1	cesar		2500	22:40:05
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (18, 1, 190, runlinem2, DODGERS, 110, RLMITAD(-0,5), PENDIENTE)	127.0.0.1	cesar		2501	22:40:05
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (18, 1, 189, p_inning1, CAR/MIL, -105, P/INNG(SI), PENDIENTE)	127.0.0.1	cesar		2502	22:40:05
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (18, 1, 188, runlinem1, PHILLIES, -190, RLMITAD(+0,5), PENDIENTE)	127.0.0.1	cesar		2503	22:40:05
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (19, 2016-07-08, 22:40:28, 50, 341.71, PENDIENTE, 71976623, PARLEY, 1, cesar)	127.0.0.1	cesar		2504	22:40:28
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (19, 1, 193, runlinem2, TORONTO, 110, RLMITAD(-0,5), PENDIENTE)	127.0.0.1	cesar		2505	22:40:28
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (19, 1, 193, ab_mediojuego2, DET/TOR, -115, ABM/BAJA(5,5), PENDIENTE)	127.0.0.1	cesar		2506	22:40:28
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (19, 1, 193, p_anotar2, TORONTO, -135, P/ANOT, PENDIENTE)	127.0.0.1	cesar		2507	22:40:28
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (20, 2016-07-08, 22:41:23, 500, 5376.10, PENDIENTE, 44848632, PARLEY, 1, cesar)	127.0.0.1	cesar		2508	22:41:23
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (20, 1, 195, srunline2, CLEVELAND, 105, SRLINE(-2,5), PENDIENTE)	127.0.0.1	cesar		2509	22:41:23
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (20, 1, 186, runline2, MIAMI, -190, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		2510	22:41:23
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (20, 1, 186, altabaja2, CIN/MIA, -110, AB/BAJA(7,0), PENDIENTE)	127.0.0.1	cesar		2511	22:41:23
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (20, 1, 195, altabaja1, YAN/CLE, -125, AB/ALTA(8,0), PENDIENTE)	127.0.0.1	cesar		2512	22:41:23
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (21, 2016-07-08, 22:41:50, 50, 320.25, PENDIENTE, 93713073, PARLEY, 1, cesar)	127.0.0.1	cesar		2513	22:41:50
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (21, 1, 195, srunline2, CLEVELAND, 105, SRLINE(-2,5), PENDIENTE)	127.0.0.1	cesar		2514	22:41:50
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (21, 1, 193, srunline2, TORONTO, 110, SRLINE(-2,5), PENDIENTE)	127.0.0.1	cesar		2515	22:41:50
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (21, 1, 192, srunline1, ANGELS, -205, SRLINE(+2,5), PENDIENTE)	127.0.0.1	cesar		2516	22:41:50
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (27,186, CIN/MIA, 2016-07-08, MIAMI, MIAMI, CINCINNATI, 1x3, 4, MIAMI, MIAMI, 1x2, 3, SI, MIAMI, FINALIZADO)	127.0.0.1	cesar		2517	22:50:49
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (28,195, YAN/CLE, 2016-07-08, CLEVELAND, CLEVELAND, CLEVELAND, 2x10, 12, CLEVELAND, CLEVELAND, 0x6, 6, SI, CLEVELAND, FINALIZADO)	127.0.0.1	cesar		2518	22:51:20
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (29,194, TAM/BOS, 2016-07-08, BOSTON, TAMPA, TAMPA, 5x6, 11, EMPATE, EMPATE, 4x4, 8, SI, BOSTON, FINALIZADO)	127.0.0.1	cesar		2519	22:52:04
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (30,193, DET/TOR, 2016-07-08, TORONTO, TORONTO, TORONTO, 0x6, 6, TORONTO, TORONTO, 0x1, 1, NO, TORONTO, FINALIZADO)	127.0.0.1	cesar		2520	22:52:46
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (31,192, ANG/BAL, 2016-07-08, ANGELS, ANGELS, ANGELS, 9x5, 14, ANGELS, ANGELS, 8x2, 10, SI, ANGELS, FINALIZADO)	127.0.0.1	cesar		2521	22:53:35
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (32,185, CHC/PIR, 2016-07-08, PIRATES, PIRATES, PIRATES, 4x8, 12, PIRATES, PIRATES, 1x3, 4, NO, PIRATES, FINALIZADO)	127.0.0.1	cesar		2522	22:54:08
2016-07-08	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=12	127.0.0.1	cesar		2523	23:03:33
2016-07-08	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=13	127.0.0.1	cesar		2524	23:03:33
2016-07-08	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=14	127.0.0.1	cesar		2525	23:03:33
2016-07-08	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=15	127.0.0.1	cesar		2526	23:03:33
2016-07-08	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=16	127.0.0.1	cesar		2527	23:03:33
2016-07-08	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=17	127.0.0.1	cesar		2528	23:03:33
2016-07-08	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=18	127.0.0.1	cesar		2529	23:03:33
2016-07-08	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=19	127.0.0.1	cesar		2530	23:03:33
2016-07-08	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=20	127.0.0.1	cesar		2531	23:03:33
2016-07-08	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=21	127.0.0.1	cesar		2532	23:03:33
2016-07-08	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (33,198, SEA/KAN, 2016-07-08, SEATTLE, SEATTLE, SEATTLE, 3x2, 5, EMPATE, EMPATE, 1x1, 2, NO, KANSAS, FINALIZADO)	127.0.0.1	cesar		2533	23:07:27
2016-07-08	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=12	127.0.0.1	cesar		2534	23:07:33
2016-07-08	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=13	127.0.0.1	cesar		2535	23:07:33
2016-07-08	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=14	127.0.0.1	cesar		2536	23:07:33
2016-07-08	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=16	127.0.0.1	cesar		2537	23:07:33
2016-07-08	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=18	127.0.0.1	cesar		2538	23:07:33
2016-07-09	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-07-09, 07:25:06, 127.0.0.1)	127.0.0.1	cesar		2539	07:25:06
2016-07-09	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (34,187, NAT/MET, 2016-07-08, NATIONALS, NATIONALS, METS, 3x1, 4, NATIONALS, NATIONALS, 3x1, 4, NO, NATIONALS, FINALIZADO)	127.0.0.1	cesar		2540	07:26:36
2016-07-09	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (35,188, PHI/COL, 2016-07-08, PHILLIES, PHILLIES, PHILLIES, 5x3, 8, COLORADO, COLORADO, 0x1, 1, NO, COLORADO, FINALIZADO)	127.0.0.1	cesar		2541	07:27:09
2016-07-09	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (36,189, CAR/MIL, 2016-07-08, MILWAUKEE, MILWAUKEE, MILWAUKEE, 3x4, 7, CARDINALS, CARDINALS, 2x1, 3, NO, MILWAUKEE, FINALIZADO)	127.0.0.1	cesar		2542	07:27:43
2016-07-09	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (37,190, PAD/DOD, 2016-07-08, DODGERS, DODGERS, DODGERS, 6x10, 16, DODGERS, DODGERS, 6x9, 15, SI, PADRES, FINALIZADO)	127.0.0.1	cesar		2543	07:28:40
2016-07-09	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (38,191, ARI/GIA, 2016-07-08, GIANTS, GIANTS, GIANTS, 2x6, 8, GIANTS, GIANTS, 2x4, 6, SI, ARIZONA, FINALIZADO)	127.0.0.1	cesar		2544	07:29:05
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (23, 2016-07-10, 07:47:15, 100, 2488.81, PENDIENTE, 98769531, PARLEY, 1, cesar)	127.0.0.1	cesar		2578	07:47:15
2016-07-09	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (39,196, MIN/TEX, 2016-07-08, TEXAS, MINNESOTA, MINNESOTA, 5x6, 11, MINNESOTA, MINNESOTA, 5x4, 9, SI, TEXAS, FINALIZADO)	127.0.0.1	cesar		2545	07:30:22
2016-07-09	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=12	127.0.0.1	cesar		2546	07:30:30
2016-07-09	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=13	127.0.0.1	cesar		2547	07:30:30
2016-07-09	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PENDIENTE WHERE id=14	127.0.0.1	cesar		2548	07:30:30
2016-07-09	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=GANADORA WHERE id=16	127.0.0.1	cesar		2549	07:30:30
2016-07-09	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=18	127.0.0.1	cesar		2550	07:30:30
2016-07-09	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (40,197, OAK/HOU, 2016-07-08, HOUSTON, OAKLAND, OAKLAND, 9x10, 19, HOUSTON, HOUSTON, 3x6, 9, NO, OAKLAND, FINALIZADO)	127.0.0.1	cesar		2551	07:32:00
2016-07-09	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (41,199, ATL/CHW, 2016-07-08, ATLANTA, ATLANTA, ATLANTA, 11x8, 19, ATLANTA, ATLANTA, 8x6, 14, SI, ATLANTA, FINALIZADO)	127.0.0.1	cesar		2552	07:32:38
2016-07-09	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=13	127.0.0.1	cesar		2553	07:32:42
2016-07-09	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=14	127.0.0.1	cesar		2554	07:32:42
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-07-10, 07:43:31, 127.0.0.1)	127.0.0.1	cesar		2555	07:43:31
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (200, CAR/MIL, CARDINALS, MILWAUKEE, C. Martinez, C. Anderson, 1, 2016-07-10, 14:10:00, -180, 140, -120, -120, 1.5, -120, -120, 2.5, -105, -125, 9, -115, -135, -180, 140, -120, -120, 0.5, -105, -125, 5, -200, 150, ACTIVO, 1)	127.0.0.1	cesar		2556	07:43:44
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (201, ARI/GIA, ARIZONA, GIANTS, R. Ray, J. Peavy, 2, 2016-07-10, 16:05:00, 125, -165, -180, 140, 1.5, -180, 140, 2.5, -105, -125, 7.5, 105, -165, 125, -165, -180, 140, 0.5, -105, -125, 4, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2557	07:43:44
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (202, CIN/MIA, CINCINNATI, MIAMI, J. Lamb, A. Conley, 2, 2016-07-10, 16:10:00, 165, -230, -110, -130, 1.5, -110, -130, 2.5, -125, -105, 9, -115, -135, 165, -230, -110, -130, 0.5, -125, -105, 5, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2558	07:43:44
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (203, CHC/PIR, CHCUBS, PIRATES, J. Lester, C. Kuhl, 1, 2016-07-10, 19:15:00, -190, 140, -120, -120, 1.5, -120, -120, 2.5, -125, -105, 8, 100, -150, -190, 140, -120, -120, 0.5, -125, -105, 4, -200, 150, ACTIVO, 1)	127.0.0.1	cesar		2559	07:43:44
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (204, NAT/MET, NATIONALS, METS, M. Scherzer, L. Verrett, 1, 2016-07-10, 19:15:00, -210, 155, -135, -105, 1.5, -135, -105, 2.5, -120, -120, 7.5, 105, -165, -210, 155, -135, -105, 0.5, -120, -120, 4, -200, 150, ACTIVO, 1)	127.0.0.1	cesar		2560	07:43:44
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (205, PAD/DOD, PADRES, DODGERS, L. Perdomo, B. McCarthy, 2, 2016-07-10, 19:15:00, 180, -260, 110, -150, 1.5, 110, -150, 2.5, -105, -125, 8, 100, -150, 180, -260, 110, -150, 0.5, -105, -125, 4, 100, -150, ACTIVO, 1)	127.0.0.1	cesar		2561	07:43:44
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (206, PHI/COL, PHILLIES, COLORADO, J. Eickhoff, T. Anderson, 2, 2016-07-10, 20:40:00, 135, -180, -175, 135, 1.5, -175, 135, 2.5, -125, -105, 11.5, -145, -105, 135, -180, -175, 135, 0.5, -125, -105, 6, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2562	07:43:44
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (23, 1, 200, ganador1, CARDINALS, -180, GANAR, PENDIENTE)	127.0.0.1	cesar		2579	07:47:15
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (207, DET/TOR, DETROIT, TORONTO, M. Boyd, A. Sanchez, 2, 2016-07-10, 13:05:00, 170, -250, -115, -135, 1.5, -115, -135, 2.5, -130, -110, 10.5, -135, -115, 170, -250, -115, -135, 0.5, -130, -110, 6, -110, -140, ACTIVO, 1)	127.0.0.1	cesar		2563	07:43:44
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (208, ANG/BAL, ANGELS, BALTIMORE, N. Tropeano, Y. Gallardo, 2, 2016-07-10, 16:05:00, 110, -160, -190, 150, 1.5, -190, 150, 2.5, -110, -125, 10, -125, -125, 110, -160, -190, 150, 0.5, -110, -125, 5.5, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2564	07:43:44
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (209, TAM/BOS, TAMPA, BOSTON, M. Moore, R. Porcello, 2, 2016-07-10, 16:05:00, 140, -190, -150, 110, 1.5, -150, 110, 2.5, -120, -120, 10, -125, -125, 140, -190, -150, 110, 0.5, -120, -120, 5.5, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2565	07:43:44
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (210, YAN/CLE, YANKEES, CLEVELAND, C. Sabathia, D. Salazar, 2, 2016-07-10, 16:10:00, 140, -200, -165, 125, 1.5, -165, 125, 2.5, -125, -110, 8, 100, -150, 140, -200, -165, 125, 0.5, -125, -110, 4, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2566	07:43:44
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (211, OAK/HOU, OAKLAND, HOUSTON, K. Graveman, L. McCullers, 2, 2016-07-10, 16:10:00, 165, -240, -110, -130, 1.5, -110, -130, 2.5, -125, -110, 8.5, -105, -145, 165, -240, -110, -130, 0.5, -125, -110, 4.5, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2567	07:43:44
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (212, SEA/KAN, SEATTLE, KANSAS, W. Miley, E. Velazquez, 2, 2016-07-10, 16:15:00, 110, -145, -190, 150, 1.5, -190, 150, 2.5, -105, -125, 8.5, -105, -145, 110, -145, -190, 150, 0.5, -105, -125, 4.5, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2568	07:43:44
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (213, MIN/TEX, MINNESOTA, TEXAS, R. Nolasco, N. Martinez, 2, 2016-07-10, 21:05:00, -105, -125, -210, 170, 1.5, -210, 170, 2.5, -125, -110, 11.5, -145, -105, -105, -125, -210, 170, 0.5, -125, -110, 6, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2569	07:43:44
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO logro_beisbol(id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_anotar1, p_anotar2, estatus, id_liga) VALUES (214, ATL/CHW, ATLANTA, CHWSOX, J. Tehern, J. Quintana, 2, 2016-07-10, 14:10:00, 140, -190, -150, 110, 1.5, -150, 110, 2.5, -110, -125, 7.5, 105, -165, 140, -190, -150, 110, 0.5, -110, -125, 4, -135, -115, ACTIVO, 1)	127.0.0.1	cesar		2570	07:43:44
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (22, 2016-07-10, 07:46:06, 100, 3905.67, PENDIENTE, 73893737, PARLEY, 1, cesar)	127.0.0.1	cesar		2571	07:46:06
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (22, 1, 200, ganador1, CARDINALS, -180, GANAR, PENDIENTE)	127.0.0.1	cesar		2572	07:46:07
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (22, 1, 210, altabaja1, YAN/CLE, -125, AB/ALTA(8,0), PENDIENTE)	127.0.0.1	cesar		2573	07:46:07
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (22, 1, 209, ganador2, BOSTON, -190, GANAR, PENDIENTE)	127.0.0.1	cesar		2574	07:46:07
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (22, 1, 208, runline2, BALTIMORE, 150, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		2575	07:46:07
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (22, 1, 214, runline2, CHWSOX, 110, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		2576	07:46:07
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (22, 1, 204, runline1, NATIONALS, -135, RLINE(-1,5), PENDIENTE)	127.0.0.1	cesar		2577	07:46:07
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (23, 1, 210, ganador2, CLEVELAND, -200, GANAR, PENDIENTE)	127.0.0.1	cesar		2580	07:47:15
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (23, 1, 205, altabaja1, PAD/DOD, -105, AB/ALTA(8,0), PENDIENTE)	127.0.0.1	cesar		2581	07:47:15
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (23, 1, 203, ganador1, CHCUBS, -190, GANAR, PENDIENTE)	127.0.0.1	cesar		2582	07:47:15
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (23, 1, 204, altabaja1, NAT/MET, -120, AB/ALTA(7,5), PENDIENTE)	127.0.0.1	cesar		2583	07:47:15
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (23, 1, 212, altabaja1, SEA/KAN, -105, AB/ALTA(8,5), PENDIENTE)	127.0.0.1	cesar		2584	07:47:15
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (42,207, DET/TOR, 2016-07-10, DETROIT, DETROIT, DETROIT, 3x2, 5, DETROIT, DETROIT, 2x1, 3, NO, DETROIT, FINALIZADO)	127.0.0.1	cesar		2590	07:58:58
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES (24, 2016-07-10, 07:48:07, 350, 4584.55, PENDIENTE, 86212158, PARLEY, 1, cesar)	127.0.0.1	cesar		2585	07:48:07
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (24, 1, 208, altabaja1, ANG/BAL, -110, AB/ALTA(10,0), PENDIENTE)	127.0.0.1	cesar		2586	07:48:07
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (24, 1, 201, altabaja1, ARI/GIA, -105, AB/ALTA(7,5), PENDIENTE)	127.0.0.1	cesar		2587	07:48:07
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (24, 1, 212, altabaja1, SEA/KAN, -105, AB/ALTA(8,5), PENDIENTE)	127.0.0.1	cesar		2588	07:48:07
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES (24, 1, 210, altabaja1, YAN/CLE, -125, AB/ALTA(8,0), PENDIENTE)	127.0.0.1	cesar		2589	07:48:07
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES (cesar, 2016-07-10, 08:05:03, 127.0.0.1)	127.0.0.1	cesar		2591	08:05:04
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (42,207, DET/TOR, 2016-07-09, DETROIT, DETROIT, DETROIT, 3x2, 5, DETROIT, DETROIT, 2x1, 3, NO, DETROIT, FINALIZADO)	127.0.0.1	cesar		2592	08:05:55
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (43,214, ATL/CHW, 2016-07-09, CHWSOX, ATLANTA, ATLANTA, 4x5, 9, CHWSOX, CHWSOX, 3x5, 8, SI, ATLANTA, FINALIZADO)	127.0.0.1	cesar		2593	08:06:44
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (44,200, CAR/MIL, 2016-07-09, CARDINALS, CARDINALS, CARDINALS, 8x1, 9, CARDINALS, CARDINALS, 2x1, 3, NO, CARDINALS, FINALIZADO)	127.0.0.1	cesar		2594	08:07:21
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (45,208, ANG/BAL, 2016-07-09, BALTIMORE, ANGELS, ANGELS, 2x3, 5, BALTIMORE, BALTIMORE, 0x1, 1, NO, BALTIMORE, FINALIZADO)	127.0.0.1	cesar		2595	08:07:51
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (46,209, TAM/BOS, 2016-07-09, BOSTON, BOSTON, BOSTON, 1x4, 5, BOSTON, BOSTON, 1x2, 3, SI, TAMPA, FINALIZADO)	127.0.0.1	cesar		2596	08:08:37
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (47,201, ARI/GIA, 2016-07-09, GIANTS, GIANTS, ARIZONA, 2x4, 6, GIANTS, GIANTS, 2x3, 5, NO, GIANTS, FINALIZADO)	127.0.0.1	cesar		2597	08:09:18
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (48,210, YAN/CLE, 2016-07-09, YANKEES, YANKEES, YANKEES, 7x6, 13, CLEVELAND, CLEVELAND, 3x4, 7, SI, CLEVELAND, FINALIZADO)	127.0.0.1	cesar		2598	08:10:24
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (49,211, OAK/HOU, 2016-07-09, OAKLAND, OAKLAND, OAKLAND, 3x2, 5, OAKLAND, OAKLAND, 3x0, 3, NO, OAKLAND, FINALIZADO)	127.0.0.1	cesar		2599	08:11:01
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (50,202, CIN/MIA, 2016-07-09, MIAMI, MIAMI, CINCINNATI, 2x4, 6, MIAMI, MIAMI, 2x3, 5, SI, MIAMI, FINALIZADO)	127.0.0.1	cesar		2600	08:11:34
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (51,212, SEA/KAN, 2016-07-09, KANSAS, KANSAS, SEATTLE, 3x5, 8, EMPATE, EMPATE, 3x3, 6, NO, KANSAS, FINALIZADO)	127.0.0.1	cesar		2601	08:12:10
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (52,205, PAD/DOD, 2016-07-09, DODGERS, PADRES, PADRES, 3x4, 7, DODGERS, DODGERS, 3x4, 7, SI, PADRES, FINALIZADO)	127.0.0.1	cesar		2602	08:12:55
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (53,204, NAT/MET, 2016-07-09, NATIONALS, NATIONALS, NATIONALS, 6x1, 7, NATIONALS, NATIONALS, 4x1, 5, SI, METS, FINALIZADO)	127.0.0.1	cesar		2603	08:13:33
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (54,203, CHC/PIR, 2016-07-09, PIRATES, PIRATES, PIRATES, 6x12, 18, PIRATES, PIRATES, 5x7, 12, SI, CHCUBS, FINALIZADO)	127.0.0.1	cesar		2604	08:15:12
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (55,206, PHI/COL, 2016-07-09, COLORADO, COLORADO, COLORADO, 3x8, 11, EMPATE, EMPATE, 2x2, 4, NO, PHILLIES, FINALIZADO)	127.0.0.1	cesar		2605	08:15:48
2016-07-10	AUDITORIA	ALTER	STATEMENT	INSERT	TABLA	INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES (56,213, MIN/TEX, 2016-07-09, MINNESOTA, MINNESOTA, MINNESOTA, 8x6, 14, MINNESOTA, MINNESOTA, 6x3, 9, NO, MINNESOTA, FINALIZADO)	127.0.0.1	cesar		2606	08:16:27
2016-07-10	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=22	127.0.0.1	cesar		2607	08:16:32
2016-07-10	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=23	127.0.0.1	cesar		2608	08:16:32
2016-07-10	AUDITORIA	ALTER	STATEMENT	UPDATE	TABLA	UPDATE apuesta SET estatus=PERDEDORA WHERE id=24	127.0.0.1	cesar		2609	08:16:32
\.


--
-- TOC entry 1992 (class 0 OID 85653)
-- Dependencies: 1579
-- Data for Name: inicio_sesion; Type: TABLE DATA; Schema: auditoria; Owner: admin
--

COPY inicio_sesion (id, usuario, fecha, hora, ip) FROM stdin;
1	cesar	2016-06-16	10:16:08	127.0.0.1
2	cesar	2016-06-16	15:45:26	127.0.0.1
3	cesar	2016-06-16	20:08:48	127.0.0.1
4	cesar	2016-06-17	17:16:32	127.0.0.1
5	cesar	2016-06-18	16:49:36	127.0.0.1
6	cesar	2016-06-20	21:11:35	127.0.0.1
7	cesar	2016-06-20	21:14:15	127.0.0.1
8	cesar	2016-06-20	21:22:29	127.0.0.1
9	cesar	2016-06-20	21:26:40	127.0.0.1
10	cesar	2016-06-20	21:59:01	127.0.0.1
11	cesar	2016-06-20	22:10:34	127.0.0.1
12	cesar	2016-06-20	22:10:53	127.0.0.1
13	cesar	2016-06-21	20:56:42	127.0.0.1
14	cesar	2016-06-21	21:02:44	127.0.0.1
15	cesar	2016-06-22	20:20:05	127.0.0.1
16	cesar	2016-06-22	22:37:03	127.0.0.1
17	cesar	2016-06-22	22:48:45	127.0.0.1
18	cesar	2016-06-22	22:48:57	127.0.0.1
19	cesar	2016-06-22	22:53:03	127.0.0.1
20	cesar	2016-06-22	22:53:42	127.0.0.1
21	cesar	2016-06-22	23:07:29	127.0.0.1
22	cesar	2016-06-22	23:09:20	127.0.0.1
23	cesar	2016-06-25	21:27:32	127.0.0.1
24	cesar	2016-06-25	21:29:15	127.0.0.1
25	cesar	2016-06-26	09:27:52	127.0.0.1
26	cesar	2016-06-26	21:35:42	127.0.0.1
27	cesar	2016-06-27	19:57:50	127.0.0.1
28	cesar	2016-06-27	22:47:51	127.0.0.1
29	cesar	2016-06-28	20:21:19	127.0.0.1
30	cesar	2016-06-29	20:46:51	127.0.0.1
31	cesar	2016-06-29	20:52:13	127.0.0.1
32	cesar	2016-06-30	22:06:18	127.0.0.1
33	cesar	2016-07-01	22:18:09	127.0.0.1
34	cesar	2016-07-02	08:31:26	127.0.0.1
35	cesar	2016-07-02	17:11:53	127.0.0.1
36	cesar	2016-07-03	01:30:26	127.0.0.1
37	cesar	2016-07-03	07:04:59	127.0.0.1
38	cesar	2016-07-03	10:01:40	127.0.0.1
39	cesar	2016-07-05	19:08:47	127.0.0.1
40	cesar	2016-07-05	22:13:48	127.0.0.1
41	cesar	2016-07-06	06:04:05	127.0.0.1
42	cesar	2016-07-08	01:52:58	127.0.0.1
43	cesar	2016-07-08	06:13:09	127.0.0.1
44	cesar	2016-07-08	22:20:01	127.0.0.1
45	cesar	2016-07-09	07:25:06	127.0.0.1
46	cesar	2016-07-10	07:43:31	127.0.0.1
47	cesar	2016-07-10	08:05:03	127.0.0.1
\.


SET search_path = public, pg_catalog;

--
-- TOC entry 1993 (class 0 OID 85658)
-- Dependencies: 1581
-- Data for Name: agencia; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY agencia (id, nombre, ci_rif, direccion, telefono, correo, id_estado, ciudad, disponible, id_banquero, premio_max, porcentaje_venta, porcentaje_utilidad, estatus, porcentaje_derecho, monto_max, monto_derecho, id_grupo, monto_min) FROM stdin;
1	BetCES	15743511	SIN REGISTRO	04148070580	cesar3r2@gmail.com	19	CUMANÁ	900000	15743511	50000	10	5	ACTIVA	2	1000	500	0	50
2	INV. JD00	12345678	SIN REGISTRO	04123123123	cesar3r2@gmail.com	19	CUMANÁ	50000	15743511	5000	15	10	ACTIVA	12	1000	500	1	10
\.


--
-- TOC entry 1994 (class 0 OID 85667)
-- Dependencies: 1582
-- Data for Name: apuesta; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) FROM stdin;
2	2016-07-05	20:45:35	100	2881.9099999999999	ANULADA	21766357	PARLEY	1	cesar
14	2016-07-08	22:33:06	80	3417.0500000000002	PERDEDORA	88714294	PARLEY	1	cesar
22	2016-07-09	07:46:06	100	3905.6700000000001	PERDEDORA	73893737	PARLEY	1	cesar
23	2016-07-09	07:47:15	100	2488.8099999999999	PERDEDORA	98769531	PARLEY	1	cesar
24	2016-07-09	07:48:07	350	4584.5500000000002	PERDEDORA	86212158	PARLEY	1	cesar
5	2016-07-05	20:52:45	300	3806.3499999999999	PERDEDORA	63311157	PARLEY	1	cesar
1	2016-07-05	20:43:29	100	4647.4700000000003	PERDEDORA	93732299	PARLEY	1	cesar
3	2016-07-05	20:48:22	100	4446.3800000000001	PERDEDORA	50668640	PARLEY	1	cesar
4	2016-07-05	20:49:32	100	5850	PERDEDORA	40687561	PARLEY	1	cesar
6	2016-07-05	20:53:46	100	4870.8000000000002	PERDEDORA	97041931	PARLEY	1	cesar
8	2016-07-07	22:11:53	50	660.61000000000001	PERDEDORA	55302124	PARLEY	1	cesar
9	2016-07-07	22:12:05	50	506.22000000000003	GANADORA	87019653	PARLEY	1	cesar
10	2016-07-07	22:12:23	50	452.33999999999997	GANADORA	89595947	PARLEY	1	cesar
11	2016-07-07	22:13:47	50	1783.3800000000001	PERDEDORA	41618652	PARLEY	1	cesar
7	2016-07-07	21:55:44	1000	4000	PERDEDORA	81611633	PARLEY	1	cesar
15	2016-07-08	22:34:16	1000	6616.3599999999997	GANADORA	78733215	PARLEY	1	cesar
17	2016-07-08	22:39:41	50	231.27000000000001	PERDEDORA	90249633	PARLEY	1	cesar
19	2016-07-08	22:40:28	50	341.70999999999998	GANADORA	71976623	PARLEY	1	cesar
20	2016-07-08	22:41:23	500	5376.1000000000004	GANADORA	44848632	PARLEY	1	cesar
21	2016-07-08	22:41:50	50	320.25	GANADORA	93713073	PARLEY	1	cesar
12	2016-07-08	22:31:01	80	2893.98	PERDEDORA	35823364	PARLEY	1	cesar
16	2016-07-08	22:39:16	500	13012.9	GANADORA	61671447	PARLEY	1	cesar
18	2016-07-08	22:40:05	50	573.63999999999999	PERDEDORA	63684692	PARLEY	1	cesar
13	2016-07-08	22:31:49	80	1226.78	PERDEDORA	72693481	PARLEY	1	cesar
\.


--
-- TOC entry 1995 (class 0 OID 85670)
-- Dependencies: 1583
-- Data for Name: apuesta_detalle; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY apuesta_detalle (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) FROM stdin;
46	10	1	174	ganador2	CARDINALS	-175	GANAR	GANADORA
47	10	1	178	ganador1	ANGELS	-105	GANAR	GANADORA
19	4	1	144	runline2	CHCUBS	-160	RLINE(-1,5)	PERDEDORA
25	5	1	151	ganador2	TORONTO	-185	GANAR	GANADORA
20	4	1	146	ganador2	NATIONALS	-180	GANAR	PERDEDORA
22	4	1	147	ganador2	METS	-150	GANAR	PERDEDORA
28	5	1	146	ganador2	NATIONALS	-180	GANAR	PERDEDORA
2	1	1	147	runline1	MIAMI	-180	RLINE(+1,5)	GANADORA
10	2	1	147	runline1	MIAMI	-180	RLINE(+1,5)	GANADORA
30	6	1	151	runline2	TORONTO	105	RLINE(-1,5)	GANADORA
1	1	1	146	runline2	NATIONALS	110	RLINE(-1,5)	PERDEDORA
7	2	1	146	runline2	NATIONALS	110	RLINE(-1,5)	PERDEDORA
13	3	1	146	runline2	NATIONALS	110	RLINE(-1,5)	PERDEDORA
16	3	1	147	runline2	METS	140	RLINE(-1,5)	PERDEDORA
34	6	1	147	runline2	METS	140	RLINE(-1,5)	PERDEDORA
12	2	1	145	altabaja1	ATL/PHI	-120	AB/ALTA(8,5)	PERDEDORA
18	3	1	145	altabaja1	ATL/PHI	-120	AB/ALTA(8,5)	PERDEDORA
27	5	1	152	ganador2	CLEVELAND	-220	GANAR	GANADORA
21	4	1	152	ganador1	DETROIT	170	GANAR	PERDEDORA
9	2	1	155	ganador2	HOUSTON	-155	GANAR	GANADORA
15	3	1	155	ganador2	HOUSTON	-155	GANAR	GANADORA
24	4	1	150	ganador1	COLORADO	200	GANAR	GANADORA
26	5	1	154	ganador1	TEXAS	160	GANAR	GANADORA
29	5	1	150	ganador2	GIANTS	-250	GANAR	PERDEDORA
3	1	1	153	runline1	ANGELS	-170	RLINE(+1,5)	GANADORA
31	6	1	154	runline2	BOSTON	100	RLINE(-1,5)	PERDEDORA
33	6	1	148	runline2	CARDINALS	125	RLINE(-1,5)	PERDEDORA
5	1	1	155	altabaja1	SEA/HOU	-105	AB/ALTA(8,0)	PERDEDORA
8	2	1	148	altabaja1	PIR/CAR	-125	AB/ALTA(8,5)	PERDEDORA
14	3	1	148	altabaja1	PIR/CAR	-125	AB/ALTA(8,5)	PERDEDORA
6	1	1	154	altabaja2	TEX/BOS	-105	AB/BAJA(9,0)	ANULADA
4	1	1	158	ganador1	BALTIMORE	135	GANAR	GANADORA
23	4	1	157	ganador1	YANKEES	-140	GANAR	GANADORA
11	2	1	158	ganador2	DODGERS	-160	GANAR	PERDEDORA
17	3	1	158	ganador2	DODGERS	-160	GANAR	PERDEDORA
32	6	1	157	runline1	YANKEES	120	RLINE(-1,5)	GANADORA
42	9	1	174	ganador2	CARDINALS	-175	GANAR	GANADORA
43	9	1	178	ganador1	ANGELS	-105	GANAR	GANADORA
38	8	1	174	ganador1	PIRATES	130	GANAR	PERDEDORA
39	8	1	178	ganador2	TAMPA	-135	GANAR	PERDEDORA
48	10	1	174	p_inning2	PIR/CAR	-150	P/INNG(NO)	GANADORA
49	10	1	178	p_inning2	ANG/TAM	-130	P/INNG(NO)	GANADORA
50	11	1	174	runline2	CARDINALS	105	RLINE(-1,5)	GANADORA
51	11	1	178	runline1	ANGELS	-225	RLINE(+1,5)	GANADORA
40	8	1	174	altabaja2	PIR/CAR	-120	AB/BAJA(8,0)	GANADORA
41	8	1	178	altabaja2	ANG/TAM	-125	AB/BAJA(9,5)	GANADORA
44	9	1	178	altabaja2	ANG/TAM	-125	AB/BAJA(9,5)	GANADORA
45	9	1	174	altabaja2	PIR/CAR	-120	AB/BAJA(8,0)	GANADORA
52	11	1	174	altabaja2	PIR/CAR	-120	AB/BAJA(8,0)	GANADORA
53	11	1	178	altabaja2	ANG/TAM	-125	AB/BAJA(9,5)	GANADORA
55	11	1	174	p_anotar2	CARDINALS	-115	P/ANOT	GANADORA
54	11	1	178	p_anotar2	TAMPA	-105	P/ANOT	PERDEDORA
35	7	1	176	ganador2	COLORADO	-200	GANAR	GANADORA
36	7	1	179	ganador1	DETROIT	100	GANAR	PERDEDORA
37	7	1	184	ganador2	CHCUBS	-300	GANAR	PERDEDORA
65	13	1	190	ganador2	DODGERS	-210	GANAR	GANADORA
58	12	1	187	ganador1	NATIONALS	-125	GANAR	GANADORA
70	14	1	187	ganador1	NATIONALS	-125	GANAR	GANADORA
66	13	1	187	ganador2	METS	-115	GANAR	PERDEDORA
59	12	1	190	runline2	DODGERS	110	RLINE(-1,5)	GANADORA
63	13	1	196	runline2	TEXAS	-150	RLINE(-1,5)	PERDEDORA
60	12	1	196	runline2	TEXAS	-150	RLINE(-1,5)	PERDEDORA
68	14	1	196	runline2	TEXAS	-150	RLINE(-1,5)	PERDEDORA
79	16	1	187	g_mediojuego1	NATIONALS	-125	GMITAD	GANADORA
88	18	1	190	runlinem2	DODGERS	110	RLMITAD(-0,5)	GANADORA
87	18	1	190	ab_mediojuego2	PAD/DOD	-120	ABM/BAJA(4,0)	PERDEDORA
89	18	1	189	p_inning1	CAR/MIL	-105	P/INNG(SI)	PERDEDORA
62	13	1	199	runline2	CHWSOX	-220	RLINE(-1,5)	PERDEDORA
73	14	1	199	runline2	CHWSOX	-220	RLINE(-1,5)	PERDEDORA
64	13	1	195	ganador2	CLEVELAND	-205	GANAR	GANADORA
75	15	1	186	ganador2	MIAMI	-340	GANAR	GANADORA
76	15	1	195	ganador2	CLEVELAND	-205	GANAR	GANADORA
56	12	1	185	ganador1	CHCUBS	-185	GANAR	PERDEDORA
67	13	1	185	ganador1	CHCUBS	-185	GANAR	PERDEDORA
69	14	1	185	ganador1	CHCUBS	-185	GANAR	PERDEDORA
71	14	1	192	ganador2	BALTIMORE	-135	GANAR	PERDEDORA
95	20	1	186	runline2	MIAMI	-190	RLINE(-1,5)	GANADORA
94	20	1	195	srunline2	CLEVELAND	105	SRLINE(-2,5)	GANADORA
98	21	1	195	srunline2	CLEVELAND	105	SRLINE(-2,5)	GANADORA
99	21	1	193	srunline2	TORONTO	110	SRLINE(-2,5)	GANADORA
100	21	1	192	srunline1	ANGELS	-205	SRLINE(+2,5)	GANADORA
77	15	1	195	altabaja1	YAN/CLE	-125	AB/ALTA(8,0)	GANADORA
97	20	1	195	altabaja1	YAN/CLE	-125	AB/ALTA(8,0)	GANADORA
61	12	1	195	altabaja2	YAN/CLE	-105	AB/BAJA(8,0)	PERDEDORA
74	14	1	195	altabaja2	YAN/CLE	-105	AB/BAJA(8,0)	PERDEDORA
57	12	1	186	altabaja2	CIN/MIA	-110	AB/BAJA(7,0)	GANADORA
72	14	1	193	altabaja2	DET/TOR	-115	AB/BAJA(10,0)	GANADORA
78	15	1	186	altabaja2	CIN/MIA	-110	AB/BAJA(7,0)	GANADORA
96	20	1	186	altabaja2	CIN/MIA	-110	AB/BAJA(7,0)	GANADORA
80	16	1	185	g_mediojuego2	PIRATES	140	GMITAD	GANADORA
81	16	1	192	g_mediojuego1	ANGELS	105	GMITAD	GANADORA
84	17	1	193	g_mediojuego2	TORONTO	-210	GMITAD	GANADORA
91	19	1	193	runlinem2	TORONTO	110	RLMITAD(-0,5)	GANADORA
92	19	1	193	ab_mediojuego2	DET/TOR	-115	ABM/BAJA(5,5)	GANADORA
83	16	1	192	p_inning1	ANG/BAL	-140	P/INNG(SI)	GANADORA
85	17	1	193	p_inning1	DET/TOR	-125	P/INNG(SI)	PERDEDORA
82	16	1	192	p_anotar1	ANGELS	-140	P/ANOT	GANADORA
86	17	1	193	p_anotar2	TORONTO	-135	P/ANOT	GANADORA
93	19	1	193	p_anotar2	TORONTO	-135	P/ANOT	GANADORA
90	18	1	188	runlinem1	PHILLIES	-190	RLMITAD(+0,5)	PERDEDORA
101	22	1	200	ganador1	CARDINALS	-180	GANAR	GANADORA
103	22	1	209	ganador2	BOSTON	-190	GANAR	GANADORA
107	23	1	200	ganador1	CARDINALS	-180	GANAR	GANADORA
108	23	1	210	ganador2	CLEVELAND	-200	GANAR	PERDEDORA
110	23	1	203	ganador1	CHCUBS	-190	GANAR	PERDEDORA
106	22	1	204	runline1	NATIONALS	-135	RLINE(-1,5)	GANADORA
104	22	1	208	runline2	BALTIMORE	150	RLINE(-1,5)	PERDEDORA
105	22	1	214	runline2	CHWSOX	110	RLINE(-1,5)	PERDEDORA
102	22	1	210	altabaja1	YAN/CLE	-125	AB/ALTA(8,0)	GANADORA
116	24	1	210	altabaja1	YAN/CLE	-125	AB/ALTA(8,0)	GANADORA
109	23	1	205	altabaja1	PAD/DOD	-105	AB/ALTA(8,0)	PERDEDORA
111	23	1	204	altabaja1	NAT/MET	-120	AB/ALTA(7,5)	PERDEDORA
112	23	1	212	altabaja1	SEA/KAN	-105	AB/ALTA(8,5)	PERDEDORA
113	24	1	208	altabaja1	ANG/BAL	-110	AB/ALTA(10,0)	PERDEDORA
114	24	1	201	altabaja1	ARI/GIA	-105	AB/ALTA(7,5)	PERDEDORA
115	24	1	212	altabaja1	SEA/KAN	-105	AB/ALTA(8,5)	PERDEDORA
\.


--
-- TOC entry 1998 (class 0 OID 85708)
-- Dependencies: 1587
-- Data for Name: banquero; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY banquero (cedula, nombre, direccion, telefono, correo) FROM stdin;
15743511	CESAR RAMOS	SIN DIRECCION	04148070580	cesar3r2@gmail.com
12333444	BANQUERO	SIN REGISTRO	04148070580	cesar3r2@gmail.com
\.


--
-- TOC entry 1999 (class 0 OID 85714)
-- Dependencies: 1588
-- Data for Name: deporte; Type: TABLE DATA; Schema: public; Owner: admin
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
-- TOC entry 2000 (class 0 OID 85717)
-- Dependencies: 1589
-- Data for Name: empresa; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY empresa (rif, nombre, nombre_comercial, direccion, telefono) FROM stdin;
V-15743511-2	BetCES Parley	BetCES Parley	CUMANÁ, ESTADO SUCRE	04148070580
\.


--
-- TOC entry 2001 (class 0 OID 85723)
-- Dependencies: 1590
-- Data for Name: estado; Type: TABLE DATA; Schema: public; Owner: admin
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
-- TOC entry 2002 (class 0 OID 85726)
-- Dependencies: 1591
-- Data for Name: grupo; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY grupo (id, id_banquero, nombre) FROM stdin;
0	15743511	GENERAL
2	15743511	GRUPO 2
1	15743511	GRUPO 1
\.


--
-- TOC entry 2003 (class 0 OID 85729)
-- Dependencies: 1592
-- Data for Name: jugada_anulada; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) FROM stdin;
\.


--
-- TOC entry 2004 (class 0 OID 85732)
-- Dependencies: 1593
-- Data for Name: liga; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY liga (id, id_deporte, nombre, pais, estatus) FROM stdin;
4	2	NBA	EEUU	ACTIVA
1	1	MLB	EEUU	ACTIVA
20	7	WBO	EEUU	ACTIVA
21	8	CAMPEONATO F1 2016	MUNDIAL	ACTIVA
24	3	EUROCOPA 2016	EUROPA	ACTIVA
23	3	COPA AMÉRICA	AMÉRICA	ACTIVA
13	4	NFL	EEUU	ACTIVA
14	5	NHL	EEUU	ACTIVA
33	6	M1000 MIAMI	EEUU	ACTIVA
6	2	LBP	VENEZUELA	INACTIVA
5	2	NCAA	EEUU	INACTIVA
3	1	SERIE DEL CARIBE	AMÉRICA LATINA	INACTIVA
2	1	LVBP	VENEZUELA	INACTIVA
9	3	PREMIER LEAGUE	INGLATERRA	INACTIVA
8	3	CALCIO	ITALIA	INACTIVA
7	3	LFP	ESPAÑA	INACTIVA
22	3	COPA LIBERTADORES	MUNDIAL	INACTIVA
11	3	CHAMPIONS LEAGUE	EUROPA	INACTIVA
12	3	EUROPA LEAGUE	EUROPA	INACTIVA
10	3	BUNDESLIGA	ALEMANIA	INACTIVA
15	3	EUROCOPA	EUROPA	INACTIVA
18	6	WIMBLEDON	INGLATERRA	INACTIVA
16	6	AUSTRALIA OPEN	AUSTRALIA	INACTIVA
19	6	US OPEN	EEUU	INACTIVA
17	6	ROLAND GARROS	FRANCIA	INACTIVA
\.


--
-- TOC entry 2020 (class 0 OID 93835)
-- Dependencies: 1609
-- Data for Name: logro_basquetbol; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY logro_basquetbol (id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, ganadorm1, ganadorm2, runlinem1, runlinem2, v_runline_m, altabajam1, altabajam2, v_altabaja_m, estatus, id_liga) FROM stdin;
\.


--
-- TOC entry 2019 (class 0 OID 85921)
-- Dependencies: 1608
-- Data for Name: logro_beisbol; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY logro_beisbol (id, encuentro, equipo1, equipo2, lanzador1, lanzador2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, srunline1, srunline2, v_srunline, altabaja1, altabaja2, v_altabaja, g_mediojuego1, g_mediojuego2, runline_m1, runline_m2, v_runline_m, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, p_inning1, p_inning2, p_anotar1, p_anotar2, estatus, id_liga) FROM stdin;
144	CIN/CHC	CINCINNATI	CHCUBS	B. Finnegan	J. Lackey	2	2016-07-05	23:00:00	190	-250	110	-160	1.5	110	-160	2.5	-120	-120	9	190	-250	110	-160	0.5	-120	-120	5	-120	-120	130	-180	ACTIVO	1
145	ATL/PHI	ATLANTA	PHILLIES	M. Foltynewicz	Z. Eflin	2	2016-07-05	23:00:00	120	-145	-185	145	1.5	-185	145	2.5	-120	-120	8.5	120	-145	-185	145	0.5	-120	-120	4.5	-105	-145	-135	-115	ACTIVO	1
146	MIL/NAT	MILWAUKEE	NATIONALS	Z. Davies	G. Gonzalez	2	2016-07-05	23:00:00	145	-180	-150	110	1.5	-150	110	2.5	-105	-125	8.5	145	-180	-150	110	0.5	-105	-125	4.5	-105	-145	100	-150	ACTIVO	1
147	MIA/MET	MIAMI	METS	W. Chen	S. Matz	2	2016-07-05	23:00:00	125	-150	-180	140	1.5	-180	140	2.5	-120	-120	8.5	125	-150	-180	140	0.5	-120	-120	4.5	-105	-145	-135	-115	ACTIVO	1
148	PIR/CAR	PIRATES	CARDINALS	J. Taillon	M. Leake	2	2016-07-05	23:00:00	130	-160	-175	125	1.5	-175	125	2.5	-125	-115	8.5	130	-160	-175	125	0.5	-120	-120	4.5	-125	-125	-130	-120	ACTIVO	1
149	PAD/ARI	PADRES	ARIZONA	C. Friedrich	Z. Godley	2	2016-07-05	23:00:00	130	-150	-180	140	1.5	-180	140	2.5	-110	-125	9.5	130	-150	-180	140	0.5	-110	-125	5	-120	-130	-135	-115	ACTIVO	1
150	COL/GIA	COLORADO	GIANTS	Chatwood	M. Bumgarner	2	2016-07-05	23:00:00	200	-250	120	-160	1.5	120	-160	2.5	-125	-105	6.5	200	-250	120	-160	0.5	-125	-105	3.5	140	-220	130	-180	ACTIVO	1
151	KAN/TOR	KANSAS	TORONTO	C. Young	R. Dickey	2	2016-07-05	23:00:00	155	-185	-145	105	1.5	-145	105	2.5	-105	-125	9.5	155	-185	-145	105	0.5	-105	-125	5	-120	-130	100	-150	ACTIVO	1
153	ANG/TAM	ANGELS	TAMPA	T. Lincecum	J. Odorizzi	2	2016-07-05	23:00:00	135	-160	-170	130	1.5	-170	130	2.5	-125	-110	8.5	135	-160	-170	130	0.5	-125	-110	4.5	-105	-145	-110	-140	ACTIVO	1
154	TEX/BOS	TEXAS	BOSTON	A. Griffin	D. Price	2	2016-07-05	23:00:00	160	-190	-140	100	1.5	-140	100	2.5	-125	-105	9	160	-190	-140	100	0.5	-125	-105	5	-115	-135	100	-150	ACTIVO	1
155	SEA/HOU	SEATTLE	HOUSTON	T. Walker	D. Keuchel	2	2016-07-05	23:00:00	130	-155	-175	135	1.5	-175	135	2.5	-105	-125	8	130	-155	-175	135	0.5	-105	-125	4	100	-150	-135	-115	ACTIVO	1
156	OAK/MIN	OAKLAND	MINNESOTA	S. Manaea	T. Milone	1	2016-07-05	23:00:00	-130	105	130	-170	1.5	130	-170	2.5	-105	-125	9.5	-130	105	130	-170	0.5	-105	-125	5	-120	-130	-135	-115	ACTIVO	1
157	YAN/CHW	YANKEES	CHWSOX	M. Tanaka	C. Rodon	1	2016-07-05	23:00:00	-140	110	120	-160	1.5	120	-160	2.5	-105	-125	8.5	-140	110	120	-160	0.5	-105	-125	4.5	-105	-145	-135	-115	ACTIVO	1
158	BAL/DOD	BALTIMORE	DODGERS	C. Tillman	K. Maeda	2	2016-07-05	23:00:00	135	-160	-170	130	1.5	-170	130	2.5	-120	-120	7.5	135	-160	-170	130	0.5	-120	-120	4	105	-165	-110	-140	ACTIVO	1
152	DET/CLE	DETROIT	CLEVELAND	A. Sanchez	C. Carrasco	2	2016-07-05	23:00:00	170	-220	-125	-125	1.5	-125	-125	2.5	-120	-120	9	160	-220	-125	-125	0.5	-115	-125	5	-130	-120	-120	-130	ACTIVO	1
174	PIR/CAR	PIRATES	CARDINALS	T. Glasnow	A. Wainwright	2	2016-07-07	23:00:00	130	-175	-165	105	1.5	-165	105	2.5	-120	-120	8	130	-175	-165	105	0.5	-120	-120	4	100	-150	-135	-115	ACTIVO	1
175	NAT/MET	NATIONALS	METS	L. Giolito	B. Colon	2	2016-07-07	23:00:00	-105	-135	-225	155	1.5	-225	155	2.5	-130	-110	7.5	-105	-135	-225	155	0.5	-130	-110	4	105	-165	-140	-110	ACTIVO	1
176	PHI/COL	PHILLIES	COLORADO	A. Morgan	C. Bettis	2	2016-07-07	23:00:00	140	-200	-150	100	1.5	-150	100	2.5	-120	-120	12.5	140	-200	-150	100	0.5	-120	-120	7	-175	115	-135	-115	ACTIVO	1
177	PAD/DOD	PADRES	DODGERS	D. Pomeranz	H. Ryu	2	2016-07-07	23:00:00	115	-160	-180	120	1.5	-180	120	2.5	-125	-115	7	115	-160	-180	120	0.5	-125	-115	3.5	115	-175	-135	-115	ACTIVO	1
178	ANG/TAM	ANGELS	TAMPA	H. Santiago	B. Snell	2	2016-07-07	23:00:00	-105	-135	-225	145	1.5	-225	145	2.5	-115	-125	9.5	-105	-135	-225	145	0.5	-115	-125	5	-120	-130	-145	-105	ACTIVO	1
179	DET/TOR	DETROIT	TORONTO	J. Verlander	D. Hutchison	2	2016-07-07	23:00:00	100	-130	-220	150	1.5	-220	150	2.5	-125	-115	9.5	100	-130	-220	150	0.5	-125	-115	5	-120	-130	-145	-105	ACTIVO	1
180	YAN/CLE	YANKEES	CLEVELAND	I. Nova	T. Bauer	2	2016-07-07	23:00:00	135	-190	-160	115	1.5	-160	115	2.5	-125	-115	8.5	135	-190	-160	115	0.5	-125	-115	4.5	-105	-145	-135	-115	ACTIVO	1
181	MIN/TEX	MINNESOTA	TEXAS	T. Duffey	C. Gonzalez	2	2016-07-07	23:00:00	105	-140	-200	150	1.5	-200	150	2.5	-120	-120	11	105	-140	-200	150	0.5	-120	-120	6	-135	-115	-135	-115	ACTIVO	1
182	OAK/HOU	OAKLAND	HOUSTON	R. Hill	D. Fister	2	2016-07-07	23:00:00	105	-150	-200	150	1.5	-200	150	2.5	-125	-115	8	105	-150	-200	150	0.5	-125	-115	4	100	-150	-135	-115	ACTIVO	1
183	SEA/KAN	SEATTLE	KANSAS	J. Paxton	D. Duffy	2	2016-07-07	23:00:00	110	-150	-205	145	1.5	-205	145	2.5	-125	-115	8.5	110	-150	-205	145	0.5	-125	-115	4.5	-105	-145	-135	-115	ACTIVO	1
184	ATL/CHC	ATLANTA	CHCUBS	L. Harrell	J. Hammel	2	2016-07-07	23:00:00	200	-300	120	-180	1.5	120	-180	2.5	-120	-120	9	200	-300	120	-180	0.5	-120	-120	5.5	-120	-120	115	-175	ACTIVO	1
185	CHC/PIR	CHCUBS	PIRATES	J. Arrieta	F. Liriano	1	2016-07-08	23:05:00	-185	140	-125	-115	1.5	-125	-115	2.5	-125	-105	7.5	-185	140	-125	-115	0.5	-125	-105	4	105	-165	-150	100	ACTIVO	1
186	CIN/MIA	CINCINNATI	MIAMI	D. Straily	J. Fernandez	2	2016-07-08	23:05:00	230	-340	150	-190	1.5	150	-190	2.5	-120	-110	7	230	-340	150	-190	0.5	-120	-110	3.5	115	-175	130	-180	ACTIVO	1
187	NAT/MET	NATIONALS	METS	S. Strasburg	N. Syndergaard	1	2016-07-08	23:05:00	-125	-115	145	-185	1.5	145	-185	2.5	-120	-110	6.5	-125	-115	145	-185	0.5	-120	-110	3.5	140	-220	-135	-115	ACTIVO	1
188	PHI/COL	PHILLIES	COLORADO	V. Velasquez	J. Gray	2	2016-07-08	23:05:00	110	-155	-190	150	1.5	-190	150	2.5	-130	-105	11	110	-155	-190	150	0.5	-130	-105	6	-135	-115	-135	-115	ACTIVO	1
189	CAR/MIL	CARDINALS	MILWAUKEE	M. Wacha	J. Nelson	1	2016-07-08	23:05:00	-160	120	115	-155	1.5	115	-155	2.5	-125	-105	8.5	-160	120	115	-155	0.5	-125	-105	4.5	-105	-145	-160	110	ACTIVO	1
190	PAD/DOD	PADRES	DODGERS	A. Cashner	S. Kazmir	2	2016-07-08	23:05:00	145	-210	-150	110	1.5	-150	110	2.5	-110	-120	8	145	-210	-150	110	0.5	-110	-120	4	100	-150	100	-150	ACTIVO	1
191	ARI/GIA	ARIZONA	GIANTS	P. Corbin	J. Samardzija	2	2016-07-08	23:05:00	130	-180	-175	135	1.5	-175	135	2.5	-125	-105	7.5	130	-180	-175	135	0.5	-125	-105	4	105	-165	-135	-115	ACTIVO	1
192	ANG/BAL	ANGELS	BALTIMORE	M. Shoemaker	U. Jimenez	2	2016-07-08	23:05:00	105	-135	-205	155	1.5	-205	155	2.5	-125	-110	10	105	-135	-205	155	0.5	-130	-115	5.5	-140	-110	-140	-110	ACTIVO	1
193	DET/TOR	DETROIT	TORONTO	M. Pelfrey	J. Happ	2	2016-07-08	23:05:00	145	-210	-150	110	1.5	-150	110	2.5	-125	-115	10	145	-210	-150	110	0.5	-125	-115	5.5	-125	-125	-115	-135	ACTIVO	1
194	TAM/BOS	TAMPA	BOSTON	C. Archer	S. OSullivan	2	2016-07-08	23:05:00	-120	-130	-210	170	1.5	-210	170	2.5	-120	-120	10	-120	-130	-210	170	0.5	-120	-120	5.5	-125	-125	-135	-115	ACTIVO	1
195	YAN/CLE	YANKEES	CLEVELAND	C. Green	C. Kluber	2	2016-07-08	23:05:00	145	-205	-145	105	1.5	-145	105	2.5	-125	-105	8	145	-205	-145	105	0.5	-125	-105	4	100	-150	-115	-135	ACTIVO	1
196	MIN/TEX	MINNESOTA	TEXAS	K. Gibson	C. Hamels	2	2016-07-08	23:05:00	170	-230	110	-150	1.5	110	-150	2.5	-105	-125	9.5	170	-230	110	-150	0.5	-105	-125	5	-120	-130	120	-170	ACTIVO	1
197	OAK/HOU	OAKLAND	HOUSTON	D. Mengden	C. McHugh	2	2016-07-08	23:05:00	135	-180	-175	135	1.5	-175	135	2.5	-125	-105	8	135	-180	-175	135	0.5	-125	-105	4	100	-150	-135	-115	ACTIVO	1
198	SEA/KAN	SEATTLE	KANSAS	H. Iwakuma	Y. Ventura	2	2016-07-08	23:05:00	-120	-130	-205	165	1.5	-205	165	2.5	-120	-120	8.5	-120	-130	-205	165	0.5	-120	-120	4.5	-105	-145	-135	-115	ACTIVO	1
199	ATL/CHW	ATLANTA	CHWSOX	M. Wisler	C. Sale	2	2016-07-08	23:05:00	220	-350	150	-220	1.5	150	-220	2.5	-120	-120	8	220	-350	150	-220	0.5	-120	-120	4	100	-150	120	-180	ACTIVO	1
200	CAR/MIL	CARDINALS	MILWAUKEE	C. Martinez	C. Anderson	1	2016-07-09	14:10:00	-180	140	-120	-120	1.5	-120	-120	2.5	-105	-125	9	-180	140	-120	-120	0.5	-105	-125	5	-115	-135	-200	150	ACTIVO	1
201	ARI/GIA	ARIZONA	GIANTS	R. Ray	J. Peavy	2	2016-07-09	16:05:00	125	-165	-180	140	1.5	-180	140	2.5	-105	-125	7.5	125	-165	-180	140	0.5	-105	-125	4	105	-165	-135	-115	ACTIVO	1
202	CIN/MIA	CINCINNATI	MIAMI	J. Lamb	A. Conley	2	2016-07-09	16:10:00	165	-230	-110	-130	1.5	-110	-130	2.5	-125	-105	9	165	-230	-110	-130	0.5	-125	-105	5	-115	-135	-135	-115	ACTIVO	1
203	CHC/PIR	CHCUBS	PIRATES	J. Lester	C. Kuhl	1	2016-07-09	19:15:00	-190	140	-120	-120	1.5	-120	-120	2.5	-125	-105	8	-190	140	-120	-120	0.5	-125	-105	4	100	-150	-200	150	ACTIVO	1
204	NAT/MET	NATIONALS	METS	M. Scherzer	L. Verrett	1	2016-07-09	19:15:00	-210	155	-135	-105	1.5	-135	-105	2.5	-120	-120	7.5	-210	155	-135	-105	0.5	-120	-120	4	105	-165	-200	150	ACTIVO	1
205	PAD/DOD	PADRES	DODGERS	L. Perdomo	B. McCarthy	2	2016-07-09	19:15:00	180	-260	110	-150	1.5	110	-150	2.5	-105	-125	8	180	-260	110	-150	0.5	-105	-125	4	100	-150	100	-150	ACTIVO	1
206	PHI/COL	PHILLIES	COLORADO	J. Eickhoff	T. Anderson	2	2016-07-09	20:40:00	135	-180	-175	135	1.5	-175	135	2.5	-125	-105	11.5	135	-180	-175	135	0.5	-125	-105	6	-145	-105	-135	-115	ACTIVO	1
207	DET/TOR	DETROIT	TORONTO	M. Boyd	A. Sanchez	2	2016-07-09	13:05:00	170	-250	-115	-135	1.5	-115	-135	2.5	-130	-110	10.5	170	-250	-115	-135	0.5	-130	-110	6	-135	-115	-110	-140	ACTIVO	1
208	ANG/BAL	ANGELS	BALTIMORE	N. Tropeano	Y. Gallardo	2	2016-07-09	16:05:00	110	-160	-190	150	1.5	-190	150	2.5	-110	-125	10	110	-160	-190	150	0.5	-110	-125	5.5	-125	-125	-135	-115	ACTIVO	1
209	TAM/BOS	TAMPA	BOSTON	M. Moore	R. Porcello	2	2016-07-09	16:05:00	140	-190	-150	110	1.5	-150	110	2.5	-120	-120	10	140	-190	-150	110	0.5	-120	-120	5.5	-125	-125	-135	-115	ACTIVO	1
210	YAN/CLE	YANKEES	CLEVELAND	C. Sabathia	D. Salazar	2	2016-07-09	16:10:00	140	-200	-165	125	1.5	-165	125	2.5	-125	-110	8	140	-200	-165	125	0.5	-125	-110	4	100	-150	-135	-115	ACTIVO	1
211	OAK/HOU	OAKLAND	HOUSTON	K. Graveman	L. McCullers	2	2016-07-09	16:10:00	165	-240	-110	-130	1.5	-110	-130	2.5	-125	-110	8.5	165	-240	-110	-130	0.5	-125	-110	4.5	-105	-145	-135	-115	ACTIVO	1
212	SEA/KAN	SEATTLE	KANSAS	W. Miley	E. Velazquez	2	2016-07-09	16:15:00	110	-145	-190	150	1.5	-190	150	2.5	-105	-125	8.5	110	-145	-190	150	0.5	-105	-125	4.5	-105	-145	-135	-115	ACTIVO	1
213	MIN/TEX	MINNESOTA	TEXAS	R. Nolasco	N. Martinez	2	2016-07-09	21:05:00	-105	-125	-210	170	1.5	-210	170	2.5	-125	-110	11.5	-105	-125	-210	170	0.5	-125	-110	6	-145	-105	-135	-115	ACTIVO	1
214	ATL/CHW	ATLANTA	CHWSOX	J. Tehern	J. Quintana	2	2016-07-09	14:10:00	140	-190	-150	110	1.5	-150	110	2.5	-110	-125	7.5	140	-190	-150	110	0.5	-110	-125	4	105	-165	-135	-115	ACTIVO	1
\.


--
-- TOC entry 2005 (class 0 OID 85735)
-- Dependencies: 1594
-- Data for Name: logro_boxeo; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY logro_boxeo (id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, estatus, id_liga) FROM stdin;
\.


--
-- TOC entry 2006 (class 0 OID 85738)
-- Dependencies: 1595
-- Data for Name: logro_formula1; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY logro_formula1 (id, encuentro, equipo1, ganador1, equipo2, ganador2, equipo3, ganador3, equipo4, ganador4, equipo5, ganador5, equipo6, ganador6, equipo7, ganador7, equipo8, ganador8, equipo9, ganador9, equipo10, ganador10, equipo11, ganador11, equipo12, ganador12, equipo13, ganador13, equipo14, ganador14, equipo15, ganador15, equipo16, ganador16, equipo17, ganador17, equipo18, ganador18, equipo19, ganador19, equipo20, ganador20, equipo21, ganador21, equipo22, ganador22, equipo23, ganador23, equipo24, ganador24, favorito, fecha, hora, estatus, id_liga) FROM stdin;
\.


--
-- TOC entry 1996 (class 0 OID 85697)
-- Dependencies: 1585
-- Data for Name: logro_futbol; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY logro_futbol (id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, empate, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, estatus, id_liga) FROM stdin;
\.


--
-- TOC entry 2007 (class 0 OID 85744)
-- Dependencies: 1596
-- Data for Name: logro_futbol_americano; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY logro_futbol_americano (id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, estatus, id_liga) FROM stdin;
\.


--
-- TOC entry 2008 (class 0 OID 85747)
-- Dependencies: 1597
-- Data for Name: logro_hockey; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY logro_hockey (id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, estatus, id_liga) FROM stdin;
\.


--
-- TOC entry 2009 (class 0 OID 85750)
-- Dependencies: 1598
-- Data for Name: logro_tennis; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY logro_tennis (id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, estatus, id_liga) FROM stdin;
\.


--
-- TOC entry 2010 (class 0 OID 85753)
-- Dependencies: 1599
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY menu (id, superior, descripcion, enlace, nivel, icono) FROM stdin;
301	3	Béisbol	sistema/apuestas/beisbol.php	0	\N
303	3	Fútbol	sistema/apuestas/futbol.php	0	\N
503	5	Movimientos de Agencias	sistema/reportes/movimientos_agencias.php	0	\N
501	5	Apuestas Registradas	sistema/reportes/apuestas.php	0	\N
201	2	Cargar Logros	sistema/procesos/cargar_logros.php	0	\N
202	2	Cargar Resultados	sistema/procesos/cargar_resultados.php	0	\N
504	5	Porcentajes de Ventas	sistema/reportes/porcentajes_ventas.php	0	\N
505	5	Porcentajes de Utilidades	sistema/reportes/porcentajes_utilidades.php	0	\N
901	9	Empresa	sistema/admon/empresa_list.php	0	\N
208	2	Anular Jugadas	sistema/procesos/anular_jugadas.php	0	\N
302	3	Básquetbol	sistema/apuestas/basquetbol.php	0	\N
207	2	Actualizar Premio	sistema/procesos/actualizar_premio.php	0	\N
909	9	Cambiar Contraseña	sistema/admon/cambiar_clave.php	0	\N
2	0	procesos	sistema/procesos/procesos.php	0	fa-cogs
401	4	Ver Ticket	sistema/consultas/ticket.php	0	\N
506	5	Movimientos por Grupos	sistema/reportes/movimientos_grupos.php	0	\N
908	9	Notificaciones	sistema/admon/notificaciones_admin.php	0	\N
1	0	inicio	inicio.php	0	fa-home
402	4	Apuestas Detalladas	sistema/consultas/apuestas_detalladas.php	0	\N
304	3	Fútbol Americano	sistema/apuestas/futbol_americano.php	0	\N
3	0	apuestas	sistema/apuestas/apuestas.php	0	fa-money
502	5	Movimientos de Caja	sistema/reportes/movimientos_caja.php	0	\N
404	4	Resultados Diarios	sistema/consultas/resultados_diarios.php	0	\N
403	4	Logros Diarios	sistema/consultas/logros_diarios.php	0	\N
9	0	admin	sistema/admon/administracion.php	0	fa-user-secret
204	2	Anular Ticket	sistema/procesos/anular_ticket.php	0	\N
205	2	Reimprimir Ticket	sistema/procesos/reimprimir_ticket.php	0	\N
206	2	Pagar Premio	sistema/procesos/pagar_premio.php	0	\N
203	2	Calculadora Parley	sistema/procesos/calculadora.php	0	\N
5	0	reportes	sistema/reportes/reportes.php	0	fa-bar-chart
4	0	consultas	sistema/consultas/consultas.php	0	fa-search
903	9	Agencias	sistema/admon/agencias_list.php	0	\N
902	9	Banqueros	sistema/admon/banqueros_list.php	0	\N
904	9	Usuarios	sistema/admon/usuarios_list.php	0	\N
905	9	Perfiles	sistema/admon/perfiles_list.php	0	\N
906	9	Mi Agencia	sistema/admon/mi_agencia.php	0	\N
907	9	Ligas Activas	sistema/admon/ligas_activas.php	0	\N
305	3	Hockey	sistema/apuestas/hockey.php	0	\N
306	3	Tennis	sistema/apuestas/tennis.php	0	\N
307	3	Boxeo	sistema/apuestas/boxeo.php	0	\N
308	3	Fórmula 1	sistema/apuestas/formula1.php	0	\N
209	2	Procesar Apuestas	sistema/procesos/procesar_apuestas.php	0	\N
\.


--
-- TOC entry 2011 (class 0 OID 85756)
-- Dependencies: 1600
-- Data for Name: notificacion; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY notificacion (id, descripcion, estatus) FROM stdin;
1		INACTIVA
2	Los logros del día actual han sido cargados completamente	ACTIVA
3		INACTIVA
4	\N	ACTIVA
5	\N	ACTIVA
\.


--
-- TOC entry 2012 (class 0 OID 85762)
-- Dependencies: 1601
-- Data for Name: perfil; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY perfil (id, nombre, acceso_menu) FROM stdin;
2	Banquero	0,1,2,4,5,9,203,402,403,404,501,502,503,504,505,903,904,909
3	Agencia	1,2,4,5,9,203,204,205,206,401,402,403,404,501,502,906,909
4	Taquilla	1,2,3,4,9,203,204,205,206,301,302,303,304,305,306,307,308,401,402,403,404,909
5	Transcriptor	1,2,4,9,201,202,203,403,404,908,909
1	Administrador	0,1,2,3,4,5,9,201,202,203,204,205,206,207,208,209,301,302,303,304,305,306,307,308,401,402,403,404,501,502,503,504,505,506,901,902,903,904,905,906,907,908,909
\.


--
-- TOC entry 2021 (class 0 OID 93841)
-- Dependencies: 1610
-- Data for Name: resultado_basquetbol; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY resultado_basquetbol (id, id_logro, encuentro, fecha, ganador, runline, total_puntos, marcador, ganadorm, runlinem, total_puntosm, marcadorm, estatus) FROM stdin;
\.


--
-- TOC entry 2022 (class 0 OID 93870)
-- Dependencies: 1611
-- Data for Name: resultado_beisbol; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) FROM stdin;
1	144	CIN/CHC	2016-07-05	CINCINNATI	CINCINNATI	CINCINNATI	9x5	14	CINCINNATI	CINCINNATI	6x5	11	SI	CINCINNATI	FINALIZADO
2	147	MIA/MET	2016-07-05	MIAMI	MIAMI	MIAMI	5x2	7	METS	METS	0x1	1	NO	METS	FINALIZADO
3	151	KAN/TOR	2016-07-05	TORONTO	TORONTO	TORONTO	3x8	11	TORONTO	TORONTO	2x7	9	SI	TORONTO	FINALIZADO
4	145	ATL/PHI	2016-07-05	PHILLIES	PHILLIES	PHILLIES	1x5	6	PHILLIES	PHILLIES	0x3	3	SI	PHILLIES	FINALIZADO
5	146	MIL/NAT	2016-07-05	MILWAUKEE	MILWAUKEE	MILWAUKEE	5x2	7	EMPATE	EMPATE	1x1	2	NO	NATIONALS	FINALIZADO
6	152	DET/CLE	2016-07-05	CLEVELAND	CLEVELAND	CLEVELAND	1x12	13	CLEVELAND	CLEVELAND	0x4	4	NO	CLEVELAND	FINALIZADO
7	153	ANG/TAM	2016-07-05	ANGELS	ANGELS	ANGELS	13x5	18	TAMPA	TAMPA	4x5	9	SI	TAMPA	FINALIZADO
8	148	PIR/CAR	2016-07-05	PIRATES	PIRATES	PIRATES	5x2	7	EMPATE	EMPATE	2x2	4	NO	CARDINALS	FINALIZADO
9	149	PAD/ARI	2016-07-05	ARIZONA	ARIZONA	PADRES	5x7	12	ARIZONA	ARIZONA	4x5	9	NO	PADRES	FINALIZADO
10	150	COL/GIA	2016-07-05	COLORADO	COLORADO	COLORADO	7x3	10	GIANTS	GIANTS	0x1	1	SI	GIANTS	FINALIZADO
11	154	TEX/BOS	2016-07-05	TEXAS	TEXAS	TEXAS	7x2	9	EMPATE	EMPATE	2x2	4	SI	TEXAS	FINALIZADO
12	155	SEA/HOU	2016-07-05	HOUSTON	HOUSTON	HOUSTON	2x5	7	HOUSTON	HOUSTON	2x5	7	NO	SEATTLE	FINALIZADO
13	156	OAK/MIN	2016-07-05	MINNESOTA	MINNESOTA	MINNESOTA	4x11	15	MINNESOTA	MINNESOTA	1x3	4	NO	OAKLAND	FINALIZADO
14	157	YAN/CHW	2016-07-05	YANKEES	YANKEES	YANKEES	9x0	9	YANKEES	YANKEES	6x0	6	NO	YANKEES	FINALIZADO
15	158	BAL/DOD	2016-07-05	BALTIMORE	BALTIMORE	BALTIMORE	4x1	5	BALTIMORE	BALTIMORE	4x1	5	SI	DODGERS	FINALIZADO
16	174	PIR/CAR	2016-07-07	CARDINALS	CARDINALS	CARDINALS	1x5	6	CARDINALS	CARDINALS	1x2	3	NO	CARDINALS	FINALIZADO
17	178	ANG/TAM	2016-07-07	ANGELS	ANGELS	ANGELS	5x1	6	EMPATE	EMPATE	0x0	0	NO	ANGELS	FINALIZADO
18	180	YAN/CLE	2016-07-07	YANKEES	YANKEES	YANKEES	5x4	9	EMPATE	EMPATE	2x2	4	NO	CLEVELAND	FINALIZADO
19	175	NAT/MET	2016-07-07	METS	METS	NATIONALS	7x9	16	METS	METS	6x7	13	SI	NATIONALS	FINALIZADO
20	176	PHI/COL	2016-07-07	COLORADO	COLORADO	COLORADO	2x11	13	COLORADO	COLORADO	2x5	7	SI	COLORADO	FINALIZADO
21	177	PAD/DOD	2016-07-07	PADRES	PADRES	PADRES	6x0	6	PADRES	PADRES	6x0	6	SI	PADRES	FINALIZADO
22	179	DET/TOR	2016-07-07	TORONTO	DETROIT	DETROIT	4x5	9	DETROIT	DETROIT	3x2	5	SI	TORONTO	FINALIZADO
23	181	MIN/TEX	2016-07-07	MINNESOTA	MINNESOTA	MINNESOTA	10x1	11	MINNESOTA	MINNESOTA	4x0	4	SI	MINNESOTA	FINALIZADO
24	182	OAK/HOU	2016-07-07	OAKLAND	OAKLAND	OAKLAND	3x1	4	OAKLAND	OAKLAND	2x1	3	SI	HOUSTON	FINALIZADO
25	183	SEA/KAN	2016-07-07	KANSAS	SEATTLE	SEATTLE	3x4	7	SEATTLE	SEATTLE	2x0	2	NO	SEATTLE	FINALIZADO
26	184	ATL/CHC	2016-07-07	ATLANTA	ATLANTA	ATLANTA	4x3	7	ATLANTA	ATLANTA	2x0	2	SI	ATLANTA	FINALIZADO
27	186	CIN/MIA	2016-07-08	MIAMI	MIAMI	CINCINNATI	1x3	4	MIAMI	MIAMI	1x2	3	SI	MIAMI	FINALIZADO
28	195	YAN/CLE	2016-07-08	CLEVELAND	CLEVELAND	CLEVELAND	2x10	12	CLEVELAND	CLEVELAND	0x6	6	SI	CLEVELAND	FINALIZADO
29	194	TAM/BOS	2016-07-08	BOSTON	TAMPA	TAMPA	5x6	11	EMPATE	EMPATE	4x4	8	SI	BOSTON	FINALIZADO
30	193	DET/TOR	2016-07-08	TORONTO	TORONTO	TORONTO	0x6	6	TORONTO	TORONTO	0x1	1	NO	TORONTO	FINALIZADO
31	192	ANG/BAL	2016-07-08	ANGELS	ANGELS	ANGELS	9x5	14	ANGELS	ANGELS	8x2	10	SI	ANGELS	FINALIZADO
32	185	CHC/PIR	2016-07-08	PIRATES	PIRATES	PIRATES	4x8	12	PIRATES	PIRATES	1x3	4	NO	PIRATES	FINALIZADO
33	198	SEA/KAN	2016-07-08	SEATTLE	SEATTLE	SEATTLE	3x2	5	EMPATE	EMPATE	1x1	2	NO	KANSAS	FINALIZADO
34	187	NAT/MET	2016-07-08	NATIONALS	NATIONALS	METS	3x1	4	NATIONALS	NATIONALS	3x1	4	NO	NATIONALS	FINALIZADO
35	188	PHI/COL	2016-07-08	PHILLIES	PHILLIES	PHILLIES	5x3	8	COLORADO	COLORADO	0x1	1	NO	COLORADO	FINALIZADO
36	189	CAR/MIL	2016-07-08	MILWAUKEE	MILWAUKEE	MILWAUKEE	3x4	7	CARDINALS	CARDINALS	2x1	3	NO	MILWAUKEE	FINALIZADO
37	190	PAD/DOD	2016-07-08	DODGERS	DODGERS	DODGERS	6x10	16	DODGERS	DODGERS	6x9	15	SI	PADRES	FINALIZADO
38	191	ARI/GIA	2016-07-08	GIANTS	GIANTS	GIANTS	2x6	8	GIANTS	GIANTS	2x4	6	SI	ARIZONA	FINALIZADO
39	196	MIN/TEX	2016-07-08	TEXAS	MINNESOTA	MINNESOTA	5x6	11	MINNESOTA	MINNESOTA	5x4	9	SI	TEXAS	FINALIZADO
40	197	OAK/HOU	2016-07-08	HOUSTON	OAKLAND	OAKLAND	9x10	19	HOUSTON	HOUSTON	3x6	9	NO	OAKLAND	FINALIZADO
41	199	ATL/CHW	2016-07-08	ATLANTA	ATLANTA	ATLANTA	11x8	19	ATLANTA	ATLANTA	8x6	14	SI	ATLANTA	FINALIZADO
42	207	DET/TOR	2016-07-09	DETROIT	DETROIT	DETROIT	3x2	5	DETROIT	DETROIT	2x1	3	NO	DETROIT	FINALIZADO
43	214	ATL/CHW	2016-07-09	CHWSOX	ATLANTA	ATLANTA	4x5	9	CHWSOX	CHWSOX	3x5	8	SI	ATLANTA	FINALIZADO
44	200	CAR/MIL	2016-07-09	CARDINALS	CARDINALS	CARDINALS	8x1	9	CARDINALS	CARDINALS	2x1	3	NO	CARDINALS	FINALIZADO
45	208	ANG/BAL	2016-07-09	BALTIMORE	ANGELS	ANGELS	2x3	5	BALTIMORE	BALTIMORE	0x1	1	NO	BALTIMORE	FINALIZADO
46	209	TAM/BOS	2016-07-09	BOSTON	BOSTON	BOSTON	1x4	5	BOSTON	BOSTON	1x2	3	SI	TAMPA	FINALIZADO
47	201	ARI/GIA	2016-07-09	GIANTS	GIANTS	ARIZONA	2x4	6	GIANTS	GIANTS	2x3	5	NO	GIANTS	FINALIZADO
48	210	YAN/CLE	2016-07-09	YANKEES	YANKEES	YANKEES	7x6	13	CLEVELAND	CLEVELAND	3x4	7	SI	CLEVELAND	FINALIZADO
49	211	OAK/HOU	2016-07-09	OAKLAND	OAKLAND	OAKLAND	3x2	5	OAKLAND	OAKLAND	3x0	3	NO	OAKLAND	FINALIZADO
50	202	CIN/MIA	2016-07-09	MIAMI	MIAMI	CINCINNATI	2x4	6	MIAMI	MIAMI	2x3	5	SI	MIAMI	FINALIZADO
51	212	SEA/KAN	2016-07-09	KANSAS	KANSAS	SEATTLE	3x5	8	EMPATE	EMPATE	3x3	6	NO	KANSAS	FINALIZADO
52	205	PAD/DOD	2016-07-09	DODGERS	PADRES	PADRES	3x4	7	DODGERS	DODGERS	3x4	7	SI	PADRES	FINALIZADO
53	204	NAT/MET	2016-07-09	NATIONALS	NATIONALS	NATIONALS	6x1	7	NATIONALS	NATIONALS	4x1	5	SI	METS	FINALIZADO
54	203	CHC/PIR	2016-07-09	PIRATES	PIRATES	PIRATES	6x12	18	PIRATES	PIRATES	5x7	12	SI	CHCUBS	FINALIZADO
55	206	PHI/COL	2016-07-09	COLORADO	COLORADO	COLORADO	3x8	11	EMPATE	EMPATE	2x2	4	NO	PHILLIES	FINALIZADO
56	213	MIN/TEX	2016-07-09	MINNESOTA	MINNESOTA	MINNESOTA	8x6	14	MINNESOTA	MINNESOTA	6x3	9	NO	MINNESOTA	FINALIZADO
\.


--
-- TOC entry 2013 (class 0 OID 85768)
-- Dependencies: 1602
-- Data for Name: resultado_boxeo; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY resultado_boxeo (id, id_logro, encuentro, fecha, ganador, marcador, estatus) FROM stdin;
\.


--
-- TOC entry 2014 (class 0 OID 85775)
-- Dependencies: 1603
-- Data for Name: resultado_formula1; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY resultado_formula1 (id, id_logro, encuentro, fecha, ganador, tiempo, estatus) FROM stdin;
\.


--
-- TOC entry 1997 (class 0 OID 85700)
-- Dependencies: 1586
-- Data for Name: resultado_futbol; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY resultado_futbol (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) FROM stdin;
\.


--
-- TOC entry 2015 (class 0 OID 85778)
-- Dependencies: 1604
-- Data for Name: resultado_futbol_americano; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY resultado_futbol_americano (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) FROM stdin;
\.


--
-- TOC entry 2016 (class 0 OID 85781)
-- Dependencies: 1605
-- Data for Name: resultado_hockey; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY resultado_hockey (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) FROM stdin;
\.


--
-- TOC entry 2017 (class 0 OID 85784)
-- Dependencies: 1606
-- Data for Name: resultado_tennis; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY resultado_tennis (id, id_logro, encuentro, fecha, ganador, marcador, estatus) FROM stdin;
\.


--
-- TOC entry 2018 (class 0 OID 85787)
-- Dependencies: 1607
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY usuario (usuario, clave, nombre, descripcion, tipo, estatus, id_agencia, cookie, nro_pcs) FROM stdin;
cesar	MTIz	César III Ramos Reyes	\N	1	1	1	\N	0
15743511	MTIz	CESAR BANQUERO	Ninguna	2	1	1		0
\.


SET search_path = auditoria, pg_catalog;

--
-- TOC entry 1899 (class 2606 OID 85798)
-- Dependencies: 1577 1577
-- Name: codigo; Type: CONSTRAINT; Schema: auditoria; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY auditoria
    ADD CONSTRAINT codigo PRIMARY KEY (codigo);


--
-- TOC entry 1901 (class 2606 OID 85800)
-- Dependencies: 1579 1579
-- Name: incio_sesion_pkey; Type: CONSTRAINT; Schema: auditoria; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY inicio_sesion
    ADD CONSTRAINT incio_sesion_pkey PRIMARY KEY (id);


SET search_path = public, pg_catalog;

--
-- TOC entry 1903 (class 2606 OID 85802)
-- Dependencies: 1581 1581
-- Name: agencia_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY agencia
    ADD CONSTRAINT agencia_pkey PRIMARY KEY (id);


--
-- TOC entry 1910 (class 2606 OID 85804)
-- Dependencies: 1583 1583 1583
-- Name: apuesta_detalle_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY apuesta_detalle
    ADD CONSTRAINT apuesta_detalle_pkey PRIMARY KEY (id, id_apuesta);


--
-- TOC entry 1906 (class 2606 OID 85806)
-- Dependencies: 1582 1582
-- Name: apuesta_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY apuesta
    ADD CONSTRAINT apuesta_pkey PRIMARY KEY (id);


--
-- TOC entry 1918 (class 2606 OID 85808)
-- Dependencies: 1587 1587
-- Name: banquero_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY banquero
    ADD CONSTRAINT banquero_pkey PRIMARY KEY (cedula);


--
-- TOC entry 1920 (class 2606 OID 85810)
-- Dependencies: 1588 1588
-- Name: deporte_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY deporte
    ADD CONSTRAINT deporte_pkey PRIMARY KEY (id);


--
-- TOC entry 1922 (class 2606 OID 85812)
-- Dependencies: 1589 1589
-- Name: empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY empresa
    ADD CONSTRAINT empresa_pkey PRIMARY KEY (rif);


--
-- TOC entry 1924 (class 2606 OID 85814)
-- Dependencies: 1590 1590
-- Name: estado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estado
    ADD CONSTRAINT estado_pkey PRIMARY KEY (codigo);


--
-- TOC entry 1927 (class 2606 OID 85816)
-- Dependencies: 1591 1591 1591
-- Name: grupo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY grupo
    ADD CONSTRAINT grupo_pkey PRIMARY KEY (id, id_banquero);


--
-- TOC entry 1929 (class 2606 OID 85818)
-- Dependencies: 1592 1592 1592
-- Name: jugada_anulada_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY jugada_anulada
    ADD CONSTRAINT jugada_anulada_pkey PRIMARY KEY (id, id_apuesta);


--
-- TOC entry 1975 (class 2606 OID 93839)
-- Dependencies: 1609 1609
-- Name: l_basquetbol_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY logro_basquetbol
    ADD CONSTRAINT l_basquetbol_pkey PRIMARY KEY (id);


--
-- TOC entry 1973 (class 2606 OID 85925)
-- Dependencies: 1608 1608
-- Name: l_beisbol_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY logro_beisbol
    ADD CONSTRAINT l_beisbol_pkey PRIMARY KEY (id);


--
-- TOC entry 1934 (class 2606 OID 85824)
-- Dependencies: 1594 1594
-- Name: l_boxeo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY logro_boxeo
    ADD CONSTRAINT l_boxeo_pkey PRIMARY KEY (id);


--
-- TOC entry 1936 (class 2606 OID 85826)
-- Dependencies: 1595 1595
-- Name: l_f1_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY logro_formula1
    ADD CONSTRAINT l_f1_pkey PRIMARY KEY (id);


--
-- TOC entry 1938 (class 2606 OID 85828)
-- Dependencies: 1596 1596
-- Name: l_futbol_amer_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY logro_futbol_americano
    ADD CONSTRAINT l_futbol_amer_pkey PRIMARY KEY (id);


--
-- TOC entry 1912 (class 2606 OID 85830)
-- Dependencies: 1585 1585
-- Name: l_futbol_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY logro_futbol
    ADD CONSTRAINT l_futbol_pkey PRIMARY KEY (id);


--
-- TOC entry 1940 (class 2606 OID 85832)
-- Dependencies: 1597 1597
-- Name: l_hockey_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY logro_hockey
    ADD CONSTRAINT l_hockey_pkey PRIMARY KEY (id);


--
-- TOC entry 1942 (class 2606 OID 85834)
-- Dependencies: 1598 1598
-- Name: l_tennis_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY logro_tennis
    ADD CONSTRAINT l_tennis_pkey PRIMARY KEY (id);


--
-- TOC entry 1932 (class 2606 OID 85836)
-- Dependencies: 1593 1593
-- Name: liga_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY liga
    ADD CONSTRAINT liga_pkey PRIMARY KEY (id);


--
-- TOC entry 1944 (class 2606 OID 85838)
-- Dependencies: 1599 1599
-- Name: menu_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT menu_pkey PRIMARY KEY (id);


--
-- TOC entry 1946 (class 2606 OID 85840)
-- Dependencies: 1600 1600
-- Name: notificacion_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY notificacion
    ADD CONSTRAINT notificacion_pkey PRIMARY KEY (id);


--
-- TOC entry 1948 (class 2606 OID 85842)
-- Dependencies: 1601 1601
-- Name: perfil_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY perfil
    ADD CONSTRAINT perfil_pkey PRIMARY KEY (id);


--
-- TOC entry 1977 (class 2606 OID 93847)
-- Dependencies: 1610 1610
-- Name: resultado_basquetbol_id_logro_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY resultado_basquetbol
    ADD CONSTRAINT resultado_basquetbol_id_logro_key UNIQUE (id_logro);


--
-- TOC entry 1979 (class 2606 OID 93845)
-- Dependencies: 1610 1610
-- Name: resultado_basquetbol_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY resultado_basquetbol
    ADD CONSTRAINT resultado_basquetbol_pkey PRIMARY KEY (id);


--
-- TOC entry 1982 (class 2606 OID 93879)
-- Dependencies: 1611 1611
-- Name: resultado_beisbol_id_logro_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY resultado_beisbol
    ADD CONSTRAINT resultado_beisbol_id_logro_key UNIQUE (id_logro);


--
-- TOC entry 1984 (class 2606 OID 93877)
-- Dependencies: 1611 1611
-- Name: resultado_beisbol_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY resultado_beisbol
    ADD CONSTRAINT resultado_beisbol_pkey PRIMARY KEY (id);


--
-- TOC entry 1950 (class 2606 OID 85852)
-- Dependencies: 1602 1602
-- Name: resultado_boxeo_id_logro_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY resultado_boxeo
    ADD CONSTRAINT resultado_boxeo_id_logro_key UNIQUE (id_logro);


--
-- TOC entry 1952 (class 2606 OID 85854)
-- Dependencies: 1602 1602
-- Name: resultado_boxeo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY resultado_boxeo
    ADD CONSTRAINT resultado_boxeo_pkey PRIMARY KEY (id);


--
-- TOC entry 1954 (class 2606 OID 85856)
-- Dependencies: 1603 1603
-- Name: resultado_f1_id_logro_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY resultado_formula1
    ADD CONSTRAINT resultado_f1_id_logro_key UNIQUE (id_logro);


--
-- TOC entry 1956 (class 2606 OID 85858)
-- Dependencies: 1603 1603
-- Name: resultado_f1_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY resultado_formula1
    ADD CONSTRAINT resultado_f1_pkey PRIMARY KEY (id);


--
-- TOC entry 1958 (class 2606 OID 85860)
-- Dependencies: 1604 1604
-- Name: resultado_futbol_amer_id_logro_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY resultado_futbol_americano
    ADD CONSTRAINT resultado_futbol_amer_id_logro_key UNIQUE (id_logro);


--
-- TOC entry 1960 (class 2606 OID 85862)
-- Dependencies: 1604 1604
-- Name: resultado_futbol_amer_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY resultado_futbol_americano
    ADD CONSTRAINT resultado_futbol_amer_pkey PRIMARY KEY (id);


--
-- TOC entry 1914 (class 2606 OID 85864)
-- Dependencies: 1586 1586
-- Name: resultado_futbol_id_logro_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY resultado_futbol
    ADD CONSTRAINT resultado_futbol_id_logro_key UNIQUE (id_logro);


--
-- TOC entry 1916 (class 2606 OID 85866)
-- Dependencies: 1586 1586
-- Name: resultado_futbol_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY resultado_futbol
    ADD CONSTRAINT resultado_futbol_pkey PRIMARY KEY (id);


--
-- TOC entry 1962 (class 2606 OID 85868)
-- Dependencies: 1605 1605
-- Name: resultado_hockey_id_logro_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY resultado_hockey
    ADD CONSTRAINT resultado_hockey_id_logro_key UNIQUE (id_logro);


--
-- TOC entry 1964 (class 2606 OID 85870)
-- Dependencies: 1605 1605
-- Name: resultado_hockey_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY resultado_hockey
    ADD CONSTRAINT resultado_hockey_pkey PRIMARY KEY (id);


--
-- TOC entry 1966 (class 2606 OID 85872)
-- Dependencies: 1606 1606
-- Name: resultado_tennis_id_logro_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY resultado_tennis
    ADD CONSTRAINT resultado_tennis_id_logro_key UNIQUE (id_logro);


--
-- TOC entry 1968 (class 2606 OID 85874)
-- Dependencies: 1606 1606
-- Name: resultado_tennis_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY resultado_tennis
    ADD CONSTRAINT resultado_tennis_pkey PRIMARY KEY (id);


--
-- TOC entry 1971 (class 2606 OID 85876)
-- Dependencies: 1607 1607
-- Name: usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (usuario);


--
-- TOC entry 1907 (class 1259 OID 85877)
-- Dependencies: 1582
-- Name: fki_apu_age; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX fki_apu_age ON apuesta USING btree (id_agencia);


--
-- TOC entry 1904 (class 1259 OID 85878)
-- Dependencies: 1581
-- Name: fki_banquero; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX fki_banquero ON agencia USING btree (id_banquero);


--
-- TOC entry 1925 (class 1259 OID 85879)
-- Dependencies: 1591
-- Name: fki_banquero1; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX fki_banquero1 ON grupo USING btree (id_banquero);


--
-- TOC entry 1930 (class 1259 OID 85880)
-- Dependencies: 1593
-- Name: fki_liga_dep; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX fki_liga_dep ON liga USING btree (id_deporte);


--
-- TOC entry 1980 (class 1259 OID 93880)
-- Dependencies: 1611
-- Name: fki_logro_res; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX fki_logro_res ON resultado_beisbol USING btree (id_logro);


--
-- TOC entry 1908 (class 1259 OID 85882)
-- Dependencies: 1582
-- Name: fki_usr; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX fki_usr ON apuesta USING btree (usuario);


--
-- TOC entry 1969 (class 1259 OID 85883)
-- Dependencies: 1607
-- Name: fki_usu_age; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX fki_usu_age ON usuario USING btree (id_agencia);


--
-- TOC entry 1990 (class 2606 OID 85884)
-- Dependencies: 1902 1607 1581
-- Name: age; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT age FOREIGN KEY (id_agencia) REFERENCES agencia(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 1986 (class 2606 OID 85889)
-- Dependencies: 1582 1583 1905
-- Name: apuesta_detalle_id_apuesta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY apuesta_detalle
    ADD CONSTRAINT apuesta_detalle_id_apuesta_fkey FOREIGN KEY (id_apuesta) REFERENCES apuesta(id);


--
-- TOC entry 1985 (class 2606 OID 85894)
-- Dependencies: 1581 1587 1917
-- Name: banquero; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY agencia
    ADD CONSTRAINT banquero FOREIGN KEY (id_banquero) REFERENCES banquero(cedula) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 1987 (class 2606 OID 85899)
-- Dependencies: 1917 1591 1587
-- Name: banquero1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY grupo
    ADD CONSTRAINT banquero1 FOREIGN KEY (id_banquero) REFERENCES banquero(cedula) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 1988 (class 2606 OID 85904)
-- Dependencies: 1592 1905 1582
-- Name: jugada_anulada_id_apuesta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY jugada_anulada
    ADD CONSTRAINT jugada_anulada_id_apuesta_fkey FOREIGN KEY (id_apuesta) REFERENCES apuesta(id);


--
-- TOC entry 1989 (class 2606 OID 85909)
-- Dependencies: 1588 1593 1919
-- Name: liga_dep; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY liga
    ADD CONSTRAINT liga_dep FOREIGN KEY (id_deporte) REFERENCES deporte(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2026 (class 0 OID 0)
-- Dependencies: 6
-- Name: auditoria; Type: ACL; Schema: -; Owner: admin
--

REVOKE ALL ON SCHEMA auditoria FROM PUBLIC;
REVOKE ALL ON SCHEMA auditoria FROM admin;
GRANT ALL ON SCHEMA auditoria TO admin;
GRANT ALL ON SCHEMA auditoria TO wwwcrapp;
GRANT ALL ON SCHEMA auditoria TO PUBLIC;


--
-- TOC entry 2028 (class 0 OID 0)
-- Dependencies: 7
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO wwwcrapp;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 2033 (class 0 OID 0)
-- Dependencies: 1581
-- Name: agencia; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE agencia FROM PUBLIC;
REVOKE ALL ON TABLE agencia FROM admin;
GRANT ALL ON TABLE agencia TO admin;
GRANT ALL ON TABLE agencia TO wwwcrapp;
GRANT ALL ON TABLE agencia TO PUBLIC;


--
-- TOC entry 2034 (class 0 OID 0)
-- Dependencies: 1582
-- Name: apuesta; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE apuesta FROM PUBLIC;
REVOKE ALL ON TABLE apuesta FROM admin;
GRANT ALL ON TABLE apuesta TO admin;
GRANT ALL ON TABLE apuesta TO wwwcrapp;
GRANT ALL ON TABLE apuesta TO PUBLIC;


--
-- TOC entry 2035 (class 0 OID 0)
-- Dependencies: 1583
-- Name: apuesta_detalle; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE apuesta_detalle FROM PUBLIC;
REVOKE ALL ON TABLE apuesta_detalle FROM admin;
GRANT ALL ON TABLE apuesta_detalle TO admin;
GRANT ALL ON TABLE apuesta_detalle TO wwwcrapp;
GRANT ALL ON TABLE apuesta_detalle TO PUBLIC;


--
-- TOC entry 2036 (class 0 OID 0)
-- Dependencies: 1608
-- Name: logro_beisbol; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE logro_beisbol FROM PUBLIC;
REVOKE ALL ON TABLE logro_beisbol FROM admin;
GRANT ALL ON TABLE logro_beisbol TO admin;
GRANT ALL ON TABLE logro_beisbol TO wwwcrapp;
GRANT ALL ON TABLE logro_beisbol TO PUBLIC;


--
-- TOC entry 2037 (class 0 OID 0)
-- Dependencies: 1611
-- Name: resultado_beisbol; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE resultado_beisbol FROM PUBLIC;
REVOKE ALL ON TABLE resultado_beisbol FROM admin;
GRANT ALL ON TABLE resultado_beisbol TO admin;
GRANT ALL ON TABLE resultado_beisbol TO wwwcrapp;
GRANT ALL ON TABLE resultado_beisbol TO PUBLIC;


--
-- TOC entry 2040 (class 0 OID 0)
-- Dependencies: 1587
-- Name: banquero; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE banquero FROM PUBLIC;
REVOKE ALL ON TABLE banquero FROM admin;
GRANT ALL ON TABLE banquero TO admin;
GRANT ALL ON TABLE banquero TO wwwcrapp;
GRANT ALL ON TABLE banquero TO PUBLIC;


--
-- TOC entry 2041 (class 0 OID 0)
-- Dependencies: 1588
-- Name: deporte; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE deporte FROM PUBLIC;
REVOKE ALL ON TABLE deporte FROM admin;
GRANT ALL ON TABLE deporte TO admin;
GRANT ALL ON TABLE deporte TO wwwcrapp;
GRANT ALL ON TABLE deporte TO PUBLIC;


--
-- TOC entry 2042 (class 0 OID 0)
-- Dependencies: 1589
-- Name: empresa; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE empresa FROM PUBLIC;
REVOKE ALL ON TABLE empresa FROM admin;
GRANT ALL ON TABLE empresa TO admin;
GRANT ALL ON TABLE empresa TO wwwcrapp;
GRANT ALL ON TABLE empresa TO PUBLIC;


--
-- TOC entry 2043 (class 0 OID 0)
-- Dependencies: 1590
-- Name: estado; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE estado FROM PUBLIC;
REVOKE ALL ON TABLE estado FROM admin;
GRANT ALL ON TABLE estado TO admin;
GRANT ALL ON TABLE estado TO wwwcrapp;
GRANT ALL ON TABLE estado TO PUBLIC;


--
-- TOC entry 2044 (class 0 OID 0)
-- Dependencies: 1591
-- Name: grupo; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE grupo FROM PUBLIC;
REVOKE ALL ON TABLE grupo FROM admin;
GRANT ALL ON TABLE grupo TO admin;
GRANT ALL ON TABLE grupo TO wwwcrapp;
GRANT ALL ON TABLE grupo TO PUBLIC;


--
-- TOC entry 2045 (class 0 OID 0)
-- Dependencies: 1592
-- Name: jugada_anulada; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE jugada_anulada FROM PUBLIC;
REVOKE ALL ON TABLE jugada_anulada FROM admin;
GRANT ALL ON TABLE jugada_anulada TO admin;
GRANT ALL ON TABLE jugada_anulada TO wwwcrapp;
GRANT ALL ON TABLE jugada_anulada TO PUBLIC;


--
-- TOC entry 2046 (class 0 OID 0)
-- Dependencies: 1593
-- Name: liga; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE liga FROM PUBLIC;
REVOKE ALL ON TABLE liga FROM admin;
GRANT ALL ON TABLE liga TO admin;
GRANT ALL ON TABLE liga TO wwwcrapp;
GRANT ALL ON TABLE liga TO PUBLIC;


--
-- TOC entry 2047 (class 0 OID 0)
-- Dependencies: 1609
-- Name: logro_basquetbol; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE logro_basquetbol FROM PUBLIC;
REVOKE ALL ON TABLE logro_basquetbol FROM admin;
GRANT ALL ON TABLE logro_basquetbol TO admin;
GRANT ALL ON TABLE logro_basquetbol TO wwwcrapp;
GRANT ALL ON TABLE logro_basquetbol TO PUBLIC;


--
-- TOC entry 2048 (class 0 OID 0)
-- Dependencies: 1594
-- Name: logro_boxeo; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE logro_boxeo FROM PUBLIC;
REVOKE ALL ON TABLE logro_boxeo FROM admin;
GRANT ALL ON TABLE logro_boxeo TO admin;
GRANT ALL ON TABLE logro_boxeo TO wwwcrapp;
GRANT ALL ON TABLE logro_boxeo TO PUBLIC;


--
-- TOC entry 2049 (class 0 OID 0)
-- Dependencies: 1595
-- Name: logro_formula1; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE logro_formula1 FROM PUBLIC;
REVOKE ALL ON TABLE logro_formula1 FROM admin;
GRANT ALL ON TABLE logro_formula1 TO admin;
GRANT ALL ON TABLE logro_formula1 TO wwwcrapp;
GRANT ALL ON TABLE logro_formula1 TO PUBLIC;


--
-- TOC entry 2050 (class 0 OID 0)
-- Dependencies: 1585
-- Name: logro_futbol; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE logro_futbol FROM PUBLIC;
REVOKE ALL ON TABLE logro_futbol FROM admin;
GRANT ALL ON TABLE logro_futbol TO admin;
GRANT ALL ON TABLE logro_futbol TO wwwcrapp;
GRANT ALL ON TABLE logro_futbol TO PUBLIC;


--
-- TOC entry 2051 (class 0 OID 0)
-- Dependencies: 1596
-- Name: logro_futbol_americano; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE logro_futbol_americano FROM PUBLIC;
REVOKE ALL ON TABLE logro_futbol_americano FROM admin;
GRANT ALL ON TABLE logro_futbol_americano TO admin;
GRANT ALL ON TABLE logro_futbol_americano TO wwwcrapp;
GRANT ALL ON TABLE logro_futbol_americano TO PUBLIC;


--
-- TOC entry 2052 (class 0 OID 0)
-- Dependencies: 1597
-- Name: logro_hockey; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE logro_hockey FROM PUBLIC;
REVOKE ALL ON TABLE logro_hockey FROM admin;
GRANT ALL ON TABLE logro_hockey TO admin;
GRANT ALL ON TABLE logro_hockey TO wwwcrapp;
GRANT ALL ON TABLE logro_hockey TO PUBLIC;


--
-- TOC entry 2053 (class 0 OID 0)
-- Dependencies: 1598
-- Name: logro_tennis; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE logro_tennis FROM PUBLIC;
REVOKE ALL ON TABLE logro_tennis FROM admin;
GRANT ALL ON TABLE logro_tennis TO admin;
GRANT ALL ON TABLE logro_tennis TO wwwcrapp;
GRANT ALL ON TABLE logro_tennis TO PUBLIC;


--
-- TOC entry 2054 (class 0 OID 0)
-- Dependencies: 1599
-- Name: menu; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE menu FROM PUBLIC;
REVOKE ALL ON TABLE menu FROM admin;
GRANT ALL ON TABLE menu TO admin;
GRANT ALL ON TABLE menu TO wwwcrapp;
GRANT ALL ON TABLE menu TO PUBLIC;


--
-- TOC entry 2055 (class 0 OID 0)
-- Dependencies: 1600
-- Name: notificacion; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE notificacion FROM PUBLIC;
REVOKE ALL ON TABLE notificacion FROM admin;
GRANT ALL ON TABLE notificacion TO admin;
GRANT ALL ON TABLE notificacion TO wwwcrapp;
GRANT ALL ON TABLE notificacion TO PUBLIC;


--
-- TOC entry 2056 (class 0 OID 0)
-- Dependencies: 1601
-- Name: perfil; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE perfil FROM PUBLIC;
REVOKE ALL ON TABLE perfil FROM admin;
GRANT ALL ON TABLE perfil TO admin;
GRANT ALL ON TABLE perfil TO wwwcrapp;
GRANT ALL ON TABLE perfil TO PUBLIC;


--
-- TOC entry 2057 (class 0 OID 0)
-- Dependencies: 1610
-- Name: resultado_basquetbol; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE resultado_basquetbol FROM PUBLIC;
REVOKE ALL ON TABLE resultado_basquetbol FROM admin;
GRANT ALL ON TABLE resultado_basquetbol TO admin;
GRANT ALL ON TABLE resultado_basquetbol TO wwwcrapp;
GRANT ALL ON TABLE resultado_basquetbol TO PUBLIC;


--
-- TOC entry 2058 (class 0 OID 0)
-- Dependencies: 1602
-- Name: resultado_boxeo; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE resultado_boxeo FROM PUBLIC;
REVOKE ALL ON TABLE resultado_boxeo FROM admin;
GRANT ALL ON TABLE resultado_boxeo TO admin;
GRANT ALL ON TABLE resultado_boxeo TO wwwcrapp;
GRANT ALL ON TABLE resultado_boxeo TO PUBLIC;


--
-- TOC entry 2059 (class 0 OID 0)
-- Dependencies: 1603
-- Name: resultado_formula1; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE resultado_formula1 FROM PUBLIC;
REVOKE ALL ON TABLE resultado_formula1 FROM admin;
GRANT ALL ON TABLE resultado_formula1 TO admin;
GRANT ALL ON TABLE resultado_formula1 TO wwwcrapp;
GRANT ALL ON TABLE resultado_formula1 TO PUBLIC;


--
-- TOC entry 2060 (class 0 OID 0)
-- Dependencies: 1586
-- Name: resultado_futbol; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE resultado_futbol FROM PUBLIC;
REVOKE ALL ON TABLE resultado_futbol FROM admin;
GRANT ALL ON TABLE resultado_futbol TO admin;
GRANT ALL ON TABLE resultado_futbol TO wwwcrapp;
GRANT ALL ON TABLE resultado_futbol TO PUBLIC;


--
-- TOC entry 2061 (class 0 OID 0)
-- Dependencies: 1604
-- Name: resultado_futbol_americano; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE resultado_futbol_americano FROM PUBLIC;
REVOKE ALL ON TABLE resultado_futbol_americano FROM admin;
GRANT ALL ON TABLE resultado_futbol_americano TO admin;
GRANT ALL ON TABLE resultado_futbol_americano TO wwwcrapp;
GRANT ALL ON TABLE resultado_futbol_americano TO PUBLIC;


--
-- TOC entry 2062 (class 0 OID 0)
-- Dependencies: 1605
-- Name: resultado_hockey; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE resultado_hockey FROM PUBLIC;
REVOKE ALL ON TABLE resultado_hockey FROM admin;
GRANT ALL ON TABLE resultado_hockey TO admin;
GRANT ALL ON TABLE resultado_hockey TO wwwcrapp;
GRANT ALL ON TABLE resultado_hockey TO PUBLIC;


--
-- TOC entry 2063 (class 0 OID 0)
-- Dependencies: 1606
-- Name: resultado_tennis; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE resultado_tennis FROM PUBLIC;
REVOKE ALL ON TABLE resultado_tennis FROM admin;
GRANT ALL ON TABLE resultado_tennis TO admin;
GRANT ALL ON TABLE resultado_tennis TO wwwcrapp;
GRANT ALL ON TABLE resultado_tennis TO PUBLIC;


--
-- TOC entry 2064 (class 0 OID 0)
-- Dependencies: 1607
-- Name: usuario; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE usuario FROM PUBLIC;
REVOKE ALL ON TABLE usuario FROM admin;
GRANT ALL ON TABLE usuario TO admin;
GRANT ALL ON TABLE usuario TO wwwcrapp;
GRANT ALL ON TABLE usuario TO PUBLIC;


-- Completed on 2016-07-10 12:49:01

--
-- PostgreSQL database dump complete
--

