<?php
function fecha_letras() {
	$dia_nro = date('d');
	$dia_letra = date('D');
	$mes_nro = date('m');
	$anyo_nro = date('Y');
	
	switch ($dia_letra) {
		case 'Mon': $dia = 'Lunes'; break;
		case 'Tue': $dia = 'Martes'; break;
		case 'Wed': $dia = 'Miércoles'; break;
		case 'Thu': $dia = 'Jueves'; break;
		case 'Fri': $dia = 'Viernes'; break;
		case 'Sat': $dia = 'Sábado'; break;
		case 'Sun': $dia = 'Domingo'; break;
		default: break;
	}
	
	switch ($mes_nro) {
		case '01': $mes = 'Enero'; break;
		case '02': $mes = 'Febrero'; break;
		case '03': $mes = 'Marzo'; break;
		case '04': $mes = 'Abril'; break;
		case '05': $mes = 'Mayo'; break;
		case '06': $mes = 'Junio'; break;
		case '07': $mes = 'Julio'; break;
		case '08': $mes = 'Agosto'; break;
		case '09': $mes = 'Septiembre'; break;
		case '10': $mes = 'Octubre'; break;
		case '11': $mes = 'Noviembre'; break;
		case '12': $mes = 'Diciembre'; break;
		default: break;
	}
	echo $dia.', '.$dia_nro.' de '.$mes.' de '.$anyo_nro;
}

function fecha($value) { // fecha de YYYY/MM/DD a DD/MM/YYYY
 if ( ! empty($value) ) return substr($value,8,2) ."/". substr($value,5,2) ."/". substr($value,0,4);
}

function fecha_sql($value) { // fecha de DD/MM/YYYY a YYYYY-MM-DD
 return substr($value,6,4) ."-". substr($value,3,2) ."-". substr($value,0,2);
}

function mes_letras($mes_nro) {
	switch ($mes_nro) {
		case '01': $mes = 'Enero'; break;
		case '02': $mes = 'Febrero'; break;
		case '03': $mes = 'Marzo'; break;
		case '04': $mes = 'Abril'; break;
		case '05': $mes = 'Mayo'; break;
		case '06': $mes = 'Junio'; break;
		case '07': $mes = 'Julio'; break;
		case '08': $mes = 'Agosto'; break;
		case '09': $mes = 'Septiembre'; break;
		case '10': $mes = 'Octubre'; break;
		case '11': $mes = 'Noviembre'; break;
		case '12': $mes = 'Diciembre'; break;
		default: break;
	}
	return $mes;
}

function buscar_patron() {
	$patron = '!360p@rl3y!';
	return $patron;
}
?>