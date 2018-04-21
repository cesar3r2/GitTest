<?php
	session_start();
	ob_start();
	
	include_once("../../../include/php/JSON.php");
	include_once('../../../conexionConf.php');
	include ("../../../clases/class.apuesta.php");
		
	$objeto = new apuesta();
	$objeto1 = new apuesta();
	$objApuesta = new apuesta();
	$fApuesta = $objApuesta->proximo_codigo();

	$operacion = $_POST['accion'];	

	switch($operacion) {
		case 'registrarApuesta':
			srand(time());
			$datos_form['ID'] = $fApuesta[0]['ultimo'] + 1;
			$datos_form['FECHA'] = date('Y-m-d');
			$datos_form['HORA'] = date('H:i:s');
			$datos_form['TIPO'] = $_POST['tipo'];
			$datos_form['MONTO'] = $_POST['monto'];
			$datos_form['PREMIO'] = $_POST['premio'];
			$datos_form['ID_SEGURIDAD'] = rand(10000000, 99999999);
			$datos_form['ESTATUS'] = 'PENDIENTE';
			$datos_form['ID_AGENCIA'] = $_SESSION['AGENCIA'];
			$datos_form['USUARIO'] = $_SESSION["USUARIO"];
			$cadena = explode('||', $_POST['cadenaLogros']);
			$cadena2 = explode('||', $_POST['detallesLogros']);
			
			$veces = 0;
			$valido = 0;
			for ($i=1; $i<=$cadena2[0]; $i++) {
				$detalle = explode('.', $cadena2[$i]);
				$jugada = $detalle[3].'.'.$detalle[4];
				$veces = substr_count($_POST['detallesLogros'], $jugada);
				if ($veces > 1)
				{
					$valido = 1;
					$fila = false;
				}
				$veces = 0;
			}
			
			if ($valido == 0) {
				$fila1 = $objeto1->registrar($datos_form);
				$fila = $objeto->ver_apuesta($datos_form['ID']);
				
				for ($i=1; $i<=$cadena[0]; $i++) {
					$objeto2 = new apuesta();
					$detalle = explode('.', $cadena2[$i]);
					$fila2 = $objeto2->registrar_detalles($datos_form['ID'], $detalle[0], $detalle[1], $detalle[2], $detalle[3], $cadena[$i], $detalle[4], $datos_form['ESTATUS']);	
				}
			}
		break;
		
		case 'actualizarHora':
			//$hora_sistema = date("H:i:s", strtotime("-20 minutes"));
			$hora_sistema = date("H:i:s", strtotime("+5 minutes"));
			$fila = $hora_sistema;
		break;
		
		default:
		break;
	}
	$json = new Services_JSON();
	$resp = $json->encode($fila);
	echo $resp;
?>