<?php
	session_start();
	ob_start();
	include_once("../../../include/php/JSON.php");
	include_once('../../../conexionConf.php');
	include ("../../../clases/class.apuesta.php");
		
	$objeto = new apuesta();
	$operacion = $_POST['accion'];
	
	switch($operacion) {
		case 'mostrarInfoTicket':
			$datos_form['ID_TICKET'] = $_POST['nro_ticket'];
			$datos_form['ID_SEGURIDAD'] = $_POST['nro_seguridad'];
			$datos_form['ID_AGENCIA'] = $_SESSION['AGENCIA'];
			//$fila = $objeto->buscar_ticket($datos_form);
			$fila = $objeto->buscar_ticket2($datos_form);			
		break;
		
		case 'anularTicket':
			$datos_form['ID_TICKET'] = $_POST['nro_ticket'];
			$datos_form['ID_SEGURIDAD'] = $_POST['nro_seguridad'];
			$datos_form['ESTATUS'] = 'ANULADA';
			$fila = $objeto->anular_ticket($datos_form);
			
			$objApuDet = new apuesta();
			$fApuDet = $objApuDet->anular_ticket_detalles($datos_form);
		break;
		
		default:
		break;
	}
	$json = new Services_JSON();
	$resp = $json->encode($fila);
	echo $resp;
?>