<?php
	include_once("../../../include/php/JSON.php");
	include_once('../../../conexionConf.php');
	include "../../../clases/class.banquero.php";
		
	$objBanquero = new banquero();
	$operacion = $_POST['accion'];
	
	switch($operacion) {
		case 'registrarBanquero':
			$datos_form['CEDULA'] = $_POST['cedula'];
			$datos_form['NOMBRE'] = $_POST['nombre'];
			$datos_form['DIRECCION'] = $_POST['direccion'];
			$datos_form['TELEFONO'] = $_POST['telefono'];
			$datos_form['CORREO'] = $_POST['correo'];
			
			$opcion = $_POST['modificarBanquero'];
			
			if($opcion == 1) {
				$banquero = $objBanquero->modificar($datos_form);
			} else {
				$banquero = $objBanquero->agregar($datos_form);
			}
		break;
		
		case 'mostrarInformacionBanquero':
			sleep(1);
			$codigo = $_POST['codigo'];
			$banquero = $objBanquero->buscar_banquero($codigo);
		break;
		
		case 'eliminarBanquero':
			$codigos = $_POST['codigos'];
			$banquero = $objBanquero->eliminar($codigos);
		break;
		
		case 'mostrarLista':
			$banquero = $objBanquero->lista();
			$nFilas = count($fObj);
		break;
		
		default:
		break;
	}
	$json = new Services_JSON();
	$resp = $json->encode($banquero);
	echo $resp;
?>