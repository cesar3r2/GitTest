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
		case 'mostrarInfoPremio':
			$datos_form['ID_TICKET'] = $_POST['nro_ticket'];
			$datos_form['ID_SEGURIDAD'] = $_POST['nro_seguridad'];
			$datos_form['ID_AGENCIA'] = $_SESSION['AGENCIA'];
			$fila = $objeto->buscar_ticket($datos_form);
		break;
		
		case 'pagarTicket':
			$datos_form['ID_TICKET'] = $_POST['nro_ticket'];
			$datos_form['ID_SEGURIDAD'] = $_POST['nro_seguridad'];
			$datos_form['ESTATUS'] = 'PAGADA';
			$fila = $objeto->pagar_ticket($datos_form);
			
			$objApuDet = new apuesta();
			$fApuDet = $objApuDet->anular_ticket_detalles($datos_form);
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