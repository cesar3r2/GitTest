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
			$datos_form['ID_SEGURIDAD'] = $_POST['nro_seguridad'];
			$datos_form['ID_AGENCIA'] = $_SESSION['AGENCIA'];
			$fila = $objeto->buscar_datos_ticket($datos_form['ID_TICKET'], $datos_form['ID_SEGURIDAD'], $datos_form['ID_AGENCIA']);
		break;

		default:
		break;
	}
	$json = new Services_JSON();
	$resp = $json->encode($fila);
	echo $resp;
?>