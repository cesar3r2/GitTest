<?php
	include_once("../../../include/php/JSON.php");
	include_once('../../../conexionConf.php');
	include "../../../clases/class.notificacion.php";
		
	$objeto = new notificacion();
	$operacion = $_POST['accion'];
	
	switch($operacion) {
		
		case 'guardarNotificacion':
			$datos_form['ID'] = $_POST['id'];
			$datos_form['DESCRIPCION'] = $_POST['descripcion'];
			$datos_form['ESTATUS'] = $_POST['estatus'];
			
			$fila = $objeto->modificar_notificacion($datos_form);
		break;
		
		case 'mostrarInfoNotificacion':
			$codigo = $_POST['id'];
			$fila = $objeto->datos_notificacion($codigo);
		break;
		
		default:
		break;
	}
	$json = new Services_JSON();
	$resp = $json->encode($fila);
	echo $resp;
?>