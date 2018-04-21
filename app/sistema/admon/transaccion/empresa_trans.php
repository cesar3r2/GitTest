<?php
	include_once("../../../include/php/JSON.php");
	include_once('../../../conexionConf.php');
	include "../../../clases/class.empresa.php";
		
	$objEmpresa = new empresa();
	$operacion = $_POST['accion'];
	
	switch($operacion) {
		case 'registrarEmpresa':
			$datos_form['RIF'] = $_POST['rif'];
			$datos_form['NOMBRE'] = $_POST['nombre'];
			$datos_form['NOMBRE_COMERCIAL'] = $_POST['nombre_comercial'];
			$datos_form['DIRECCION'] = $_POST['direccion'];
			$datos_form['TELEFONO'] = $_POST['telefono'];
			$datos_form['ID_ESTADO'] = $_POST['estado'];
			$datos_form['CIUDAD'] = $_POST['ciudad'];

			$empresa = $objEmpresa->modificar($datos_form);
		break;
		
		case 'mostrarInformacionEmpresa':
			sleep(1);
			$datos_form['RIF'] = $_POST['rif'];
			$empresa = $objEmpresa->buscar_empresa($datos_form);
		break;
		
		default:
		break;
	}
	$json = new Services_JSON();
	$resp = $json->encode($empresa);
	echo $resp;
?>