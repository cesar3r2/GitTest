<?php
	session_start();
	ob_start();
	include "../../conexionConf.php";
	include "../../clases/class.usuario.php";
	
	$accion = $_GET['accion'];
	
	switch ($accion)
	{
		case '1':
			$objUsr = new usuario();
			$usuario = $_GET['usuario'];
			$fUsr = $objUsr->buscar_usuario($usuario);
			$registros = count($fUsr);
			echo $registros;
		break;
		
		case '3';
			$objUsr = new usuario();
			$agencia = $_GET['agencia'];
			$tipo = $_GET['tipo'];
			$fUsr = $objUsr->validar_agencia_tipo($agencia, $tipo);
			$registros = count($fUsr);
			echo $registros;
		break;
		
		case '4':
			$objUsr = new usuario();
			$usuario = $_GET['usuario'];
			$fUsr = $objUsr->buscar_usuario($usuario);
			$nro_pcs = explode(',', $fUsr[0]['cookie']);
			echo $fUsr[0]['tipo'].'||'.count($nro_pcs);
		break;
		
		default:
		break;
	}
?>