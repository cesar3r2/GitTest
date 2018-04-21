<?php
	include "../../conexionConf.php";
	include "../../clases/class.agencia.php";
	
	$accion = $_GET['accion'];
	
	switch ($accion)
	{
		case '1':
			$objeto = new agencia();
			$codigo = $_GET['codigo'];
			$fila = $objeto->buscar_agencia($codigo);
			$registros = count($fila);
			echo $registros;
		break;
		
		default:
		break;
	}
?>