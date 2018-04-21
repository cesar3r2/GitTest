<?php
	session_start();
	ob_start();
	include_once("../../../include/php/JSON.php");
	include_once('../../../conexionConf.php');
	include ("../../../clases/class.apuesta.php");
		
	$objeto = new apuesta();
	$operacion = $_POST['accion'];
	
	switch($operacion) {
		case 'buscarInfoTicket':
			$datos_form['ID_TICKET'] = $_POST['nro_ticket'];
			$fila = $objeto->ver_apuesta($datos_form['ID_TICKET']);
		break;
		
		case 'actualizarPremio':
			$datos_form['ID_TICKET'] = $_POST['nro_ticket'];
			$datos_form['PREMIO'] = $_POST['premio_nuevo'];
			$fila = $objeto->actualizar_premio($datos_form['ID_TICKET'], $datos_form['PREMIO']);
		break;

		default:
		break;
	}
	$json = new Services_JSON();
	$resp = $json->encode($fila);
	echo $resp;
?>