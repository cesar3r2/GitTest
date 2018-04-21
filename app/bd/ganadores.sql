--UPDATE apuesta_detalle set estatus='PENDIENTE';
-- BEISBOL
-- GANADOR
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo!=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');*/

-- RUNLINE
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runline1', 'runline2') and a.equipo=c.runline and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runline1', 'runline2') and a.equipo!=c.runline and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');*/

-- SUPER RUNLINE
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('srunline1', 'srunline2') and a.equipo=c.srunline and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('srunline1', 'srunline2') and a.equipo!=c.srunline and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');*/

-- ALTA
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja1' and c.total_carreras>b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja2' and c.total_carreras>b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');*/

-- BAJA
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja2' and c.total_carreras<b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja1' and c.total_carreras<b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');*/

-- ALTABAJA ANULADA
/*update apuesta_detalle set estatus='ANULADA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('altabaja1', 'altabaja2') and c.total_carreras=b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');*/

--GANAR MITAD
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('g_mediojuego1', 'g_mediojuego2') and a.equipo=c.g_mediojuego and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('g_mediojuego1', 'g_mediojuego2') and a.equipo!=c.g_mediojuego and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');*/

-- RUNLINE MITAD
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runlinem1', 'runlinem2') and a.equipo=c.runlinem and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runlinem1', 'runlinem2') and a.equipo!=c.runlinem and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');*/

-- ALTA MITAD
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='ab_mediojuego1' and c.total_carreras_5to>b.v_ab_mediojuego and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='ab_mediojuego2' and c.total_carreras_5to>b.v_ab_mediojuego and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');*/

-- BAJA MITAD
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='ab_mediojuego2' and c.total_carreras_5to<b.v_ab_mediojuego and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='ab_mediojuego1' and c.total_carreras_5to<b.v_ab_mediojuego and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');*/

-- ALTABAJA MITAD ANULADA
/*update apuesta_detalle set estatus='ANULADA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ab_mediojuego1', 'ab_mediojuego2') and c.total_carreras_5to=b.v_ab_mediojuego and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');*/

-- PRIMER INNING SI
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='p_inning1' and c.p_inning='SI' and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='p_inning2' and c.p_inning='SI' and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');*/

-- PRIMER INNING NO
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='p_inning2' and c.p_inning='NO' and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='p_inning1' and c.p_inning='NO' and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');*/

-- ANOTAR PRIMERO
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('p_anotar1', 'p_anotar2') and a.equipo=c.p_anotar and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_beisbol b, resultado_beisbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('p_anotar1', 'p_anotar2') and a.equipo!=c.p_anotar and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='1');*/

-- BASQUETBOL
--UPDATE apuesta_detalle set estatus='PENDIENTE';
-- GANADOR
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo!=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');*/

-- RUNLINE
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runline1', 'runline2') and a.equipo=c.runline and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runline1', 'runline2') and a.equipo!=c.runline and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');*/

-- ALTA
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja1' and c.total_puntos>b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja2' and c.total_puntos>b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');*/

-- BAJA
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja2' and c.total_puntos<b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja1' and c.total_puntos<b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');*/

-- ALTABAJA ANULADA
/*update apuesta_detalle set estatus='ANULADA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('altabaja1', 'altabaja2') and c.total_puntos=b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');*/

-- GANADOR MITAD
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganadorm1', 'ganadorm2') and a.equipo=c.ganadorm and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganadorm1', 'ganadorm2') and a.equipo!=c.ganadorm and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');*/

-- RUNLINE MITAD
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runlinem1', 'runlinem2') and a.equipo=c.runlinem and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runlinem1', 'runlinem2') and a.equipo!=c.runlinem and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');*/

-- ALTA MITAD
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabajam1' and c.total_puntosm>b.v_altabaja_m and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabajam2' and c.total_puntosm>b.v_altabaja_m and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');*/

-- BAJA MITAD
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabajam2' and c.total_puntosm<b.v_altabaja_m and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabajam1' and c.total_puntosm<b.v_altabaja_m and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');*/

-- ALTABAJA MITAD ANULADA
/*update apuesta_detalle set estatus='ANULADA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_basquetbol b, resultado_basquetbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('altabajam1', 'altabajam2') and c.total_puntosm=b.v_altabaja_m and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='2');*/

UPDATE apuesta_detalle set estatus='PENDIENTE';
SELECT * FROM procesar_apuestas();

-- FUTBOL
-- GANADOR
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol b, resultado_futbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='3');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol b, resultado_futbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo!=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='3');*/

-- EMPATE
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol b, resultado_futbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='empate' and c.ganador='EMPATE' and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='3');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol b, resultado_futbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='empate' and c.ganador!='EMPATE' and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='3');*/

-- RUNLINE
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol b, resultado_futbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runline1', 'runline2') and a.equipo=c.runline and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='3');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol b, resultado_futbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runline1', 'runline2') and a.equipo!=c.runline and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='3');*/

-- ALTA
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol b, resultado_futbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja1' and c.total_goles>b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='3');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol b, resultado_futbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja2' and c.total_goles>b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='3');*/

-- BAJA
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol b, resultado_futbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja2' and c.total_goles<b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='3');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol b, resultado_futbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja1' and c.total_goles<b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='3');*/

-- ALTABAJA ANULADA
/*update apuesta_detalle set estatus='ANULADA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol b, resultado_futbol c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('altabaja1', 'altabaja2') and c.total_goles=b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='3');*/

-- FUTBOL AMERICANO
-- GANADOR
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol_americano b, resultado_futbol_americano c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='4');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol_americano b, resultado_futbol_americano c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo!=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='4');*/

-- RUNLINE
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol_americano b, resultado_futbol_americano c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runline1', 'runline2') and a.equipo=c.runline and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='4');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol_americano b, resultado_futbol_americano c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runline1', 'runline2') and a.equipo!=c.runline and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='4');*/

-- ALTA
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol_americano b, resultado_futbol_americano c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja1' and c.total_goles>b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='4');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol_americano b, resultado_futbol_americano c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja2' and c.total_goles>b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='4');*/

-- BAJA
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol_americano b, resultado_futbol_americano c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja2' and c.total_goles<b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='4');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol_americano b, resultado_futbol_americano c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja1' and c.total_goles<b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='4');*/

-- ALTABAJA ANULADA
/*update apuesta_detalle set estatus='ANULADA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_futbol_americano b, resultado_futbol_americano c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('altabaja1', 'altabaja2') and c.total_goles=b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='4');*/

-- HOCKEY
-- GANADOR
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_hockey b, resultado_hockey c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='5');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_hockey b, resultado_hockey c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo!=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='5');*/

-- RUNLINE
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_hockey b, resultado_hockey c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runline1', 'runline2') and a.equipo=c.runline and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='5');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_hockey b, resultado_hockey c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('runline1', 'runline2') and a.equipo!=c.runline and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='5');*/

-- ALTA
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_hockey b, resultado_hockey c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja1' and c.total_goles>b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='5');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_hockey b, resultado_hockey c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja2' and c.total_goles>b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='5');*/

-- BAJA
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_hockey b, resultado_hockey c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja2' and c.total_goles<b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='5');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_hockey b, resultado_hockey c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro='altabaja1' and c.total_goles<b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='5');*/

-- ALTABAJA ANULADA
/*update apuesta_detalle set estatus='ANULADA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_hockey b, resultado_hockey c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('altabaja1', 'altabaja2') and c.total_goles=b.v_altabaja and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='5');*/

-- TENNIS
-- GANADOR
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_tennis b, resultado_tennis c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='6');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_tennis b, resultado_tennis c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo!=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='6');*/

-- BOXEO
-- GANADOR
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_boxeo b, resultado_boxeo c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='7');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_boxeo b, resultado_boxeo c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2') and a.equipo!=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='7');*/

-- FÓRMULA 1
-- GANADOR
/*update apuesta_detalle set estatus='GANADORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_formula1 b, resultado_formula1 c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2', 'ganador3', 'ganador4', 'ganador5', 'ganador6', 'ganador7', 'ganador8', 'ganador9', 'ganador10', 'ganador11', 'ganador12', 'ganador13', 'ganador14', 'ganador15', 'ganador16', 'ganador17', 'ganador18', 'ganador19', 'ganador20', 'ganador21', 'ganador22', 'ganador23', 'ganador24') and a.equipo=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='8');

update apuesta_detalle set estatus='PERDEDORA' where (id_deporte, id_logro, campo_logro) in
(select a.id_deporte, c.id_logro, a.campo_logro from apuesta_detalle a, logro_formula1 b, resultado_formula1 c
where a.id_logro=b.id and b.id=c.id_logro and a.campo_logro in ('ganador1', 'ganador2', 'ganador3', 'ganador4', 'ganador5', 'ganador6', 'ganador7', 'ganador8', 'ganador9', 'ganador10', 'ganador11', 'ganador12', 'ganador13', 'ganador14', 'ganador15', 'ganador16', 'ganador17', 'ganador18', 'ganador19', 'ganador20', 'ganador21', 'ganador22', 'ganador23', 'ganador24') and a.equipo!=c.ganador and a.estatus='PENDIENTE' and c.estatus='FINALIZADO' and a.id_deporte='8');*/
