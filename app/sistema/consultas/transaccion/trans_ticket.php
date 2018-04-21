<?php
	session_start();
	ob_start();
	include_once("../../../include/php/JSON.php");
	include_once('../../../conexionConf.php');
	include ("../../../clases/class.apuesta.php");
	include ("../../../clases/class.jugada_anulada.php");
		
	$objeto = new apuesta();
	$operacion = $_POST['accion'];
	
	switch($operacion) {
		case 'mostrarInfoTicket':
			$datos_form['ID_TICKET'] = $_POST['nro_ticket'];
			$datos_form['ID_SEGURIDAD'] = $_POST['nro_seguridad'];
			$datos_form['ID_AGENCIA'] = $_SESSION['AGENCIA'];
			$datos_form['PERFIL_USR'] = $_SESSION["PERFIL_USUARIO"];
			$fila = $objeto->buscar_ticket($datos_form);
		break;
		
		case 'buscarAnuladas':
			$objAnu = new jugada_anulada();
			$ticket = $_POST['nro_ticket'];
			$fila = $objAnu->buscar_anuladas($ticket);
		break;
		
		default:
		break;
	}
	$json = new Services_JSON();
	$resp = $json->encode($fila);
	echo $resp;
?>