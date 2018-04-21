<?php
	include_once("../../../include/php/JSON.php");
	include_once('../../../conexionConf.php');
	include "../../../clases/class.perfil.php";
		
	$objeto = new perfil();
	$operacion = $_POST['accion'];
	
	switch($operacion) {
		case 'registrarPerfil':
			$datos_form['ID'] = $_POST['codigo'];
			$datos_form['NOMBRE'] = $_POST['nombre'];
			$datos_form['ACCESO'] = $_POST['acceso'];
			$opcion = $_POST['modificarPerfil'];
			
			if($opcion == 1) {
				$fila = $objeto->modificar($datos_form);
			} else {
				$fila = $objeto->agregar($datos_form);
			}
		break;

		case 'mostrarInformacionPerfil':
			sleep(1);
			$codigo = $_POST['codigo'];
			$fila = $objeto->buscar_perfil($codigo);
		break;
			
		case 'eliminarPerfil':
			$perfiles = $_POST['perfiles'];
			$fila = $objeto->eliminar($perfiles);
		break;
				
		case 'mostrarLista':
			$usuario = $objUsr->lista();
			$nFilas = count($fObj);
		break;
		
		default:
		break;
	}
	$json = new Services_JSON();
	$resp = $json->encode($fila);
	echo $resp;
?>