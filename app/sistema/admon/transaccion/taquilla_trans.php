<?php
	include_once("../../../include/php/JSON.php");
	include_once('../../../conexionConf.php');
	include "../../../clases/class.agencia.php";
	include "../../../clases/class.taquilla.php";
		
	$objTaquilla = new taquilla();
	$operacion = $_POST['accion'];
	
	switch($operacion) {
		case 'registrarTaquilla':
			$datos_form['ID'] = $_POST['id'];
			$datos_form['ID_AGENCIA'] = $_POST['agencia'];
			$datos_form['NOMBRE'] = $_POST['nombre'];
			
			$opcion = $_POST['modificarTaquilla'];
			
			if($opcion == 1) {
				$taquilla = $objTaquilla->modificar($datos_form);
			} else {
				$taquilla = $objTaquilla->agregar($datos_form);
			}
		break;
		
		case 'registrarMiAgencia':
			$datos_form['ID_AGENCIA'] = $_POST['id'];
			$datos_form['NOMBRE'] = $_POST['nombre'];
			$datos_form['DIRECCION'] = $_POST['direccion'];
			$datos_form['TELEFONO'] = $_POST['telefono'];
			$datos_form['DISPONIBLE'] = $_POST['saldo'];
			
			$agencia = $objAgencia->modificar_mi_agencia($datos_form);
		break;
		
		case 'mostrarInformacionTaquilla':
			sleep(1);
			$codigo = $_POST['codigo'];
			$taquilla = $objTaquilla->buscar_taquilla($codigo);
		break;
		
		case 'eliminarTaquilla':
			$codigos = $_POST['codigos'];
			$taquilla = $objTaquilla->eliminar($codigos);
		break;
		
		case 'mostrarLista':
			$taquilla = $objTaquilla->lista();
			$nFilas = count($fObj);
		break;
		
		default:
		break;
	}
	$json = new Services_JSON();
	$resp = $json->encode($taquilla);
	echo $resp;
?>