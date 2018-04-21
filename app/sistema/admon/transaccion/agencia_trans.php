<?php
	include_once("../../../include/php/JSON.php");
	include_once('../../../conexionConf.php');
	include "../../../clases/class.agencia.php";
		
	$objAgencia = new agencia();
	$operacion = $_POST['accion'];
	
	switch($operacion) {
		case 'registrarAgencia':
			$datos_form['ID_AGENCIA'] = $_POST['id'];
			$datos_form['RIF'] = $_POST['rif'];
			$datos_form['NOMBRE'] = $_POST['nombre'];
			$datos_form['DIRECCION'] = $_POST['direccion'];
			$datos_form['TELEFONO'] = $_POST['telefono'];
			$datos_form['EMAIL'] = $_POST['email'];
			$datos_form['ID_ESTADO'] = $_POST['estado'];
			$datos_form['CIUDAD'] = $_POST['ciudad'];
			$datos_form['DISPONIBLE'] = $_POST['saldo'];
			$datos_form['PREMIO_MAX'] = $_POST['premio_max'];
			$datos_form['MONTO_MIN'] = $_POST['monto_min'];
			$datos_form['MONTO_MAX'] = $_POST['monto_max'];
			$datos_form['MONTO_DERECHO'] = $_POST['monto_derecho'];
			$datos_form['POR_VENTA'] = $_POST['por_venta'];
			$datos_form['POR_DERECHO'] = $_POST['por_derecho'];
			$datos_form['POR_UTILIDAD'] = $_POST['por_utilidad'];
			$datos_form['BANQUERO'] = $_POST['banquero'];
			$datos_form['GRUPO'] = $_POST['grupo'];
			$datos_form['ESTATUS'] = $_POST['estatus'];
			
			$opcion = $_POST['modificarAgencia'];
			
			if($opcion == 1) {
				$agencia = $objAgencia->modificar($datos_form);
			} else {
				$agencia = $objAgencia->agregar($datos_form);
			}
		break;
		
		case 'registrarMiAgencia':
			$datos_form['ID_AGENCIA'] = $_POST['id'];
			$datos_form['NOMBRE'] = $_POST['nombre'];
			$datos_form['DIRECCION'] = $_POST['direccion'];
			$datos_form['TELEFONO'] = $_POST['telefono'];
			$datos_form['EMAIL'] = $_POST['email'];
			$datos_form['MONTO_MIN'] = $_POST['monto_min'];
			$datos_form['MONTO_MAX'] = $_POST['monto_max'];
			$datos_form['MONTO_DERECHO'] = $_POST['monto_derecho'];
			$datos_form['PREMIO_MAX'] = $_POST['premio_max'];
			$datos_form['DISPONIBLE'] = $_POST['saldo'];
			
			$agencia = $objAgencia->modificar_mi_agencia($datos_form);
		break;
		
		case 'mostrarInformacionAgencia':
			sleep(1);
			$codigo = $_POST['codigo'];
			$agencia = $objAgencia->buscar_agencia($codigo);
		break;
		
		case 'eliminarAgencia':
			$codigos = $_POST['codigos'];
			$agencia = $objAgencia->eliminar($codigos);
		break;
		
		case 'mostrarLista':
			$agencia = $objAgencia->lista();
			$nFilas = count($fObj);
		break;
		
		default:
		break;
	}
	$json = new Services_JSON();
	$resp = $json->encode($agencia);
	echo $resp;
?>