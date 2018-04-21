<?php
	include "../../conexionConf.php";
	include "../../clases/class.banquero.php";
	
	$accion = $_GET['accion'];
	
	switch ($accion)
	{
		case '1':
			$objeto = new banquero();
			$codigo = $_GET['codigo'];
			$fila = $objeto->buscar_banquero($codigo);
			$registros = count($fila);
			echo $registros;
		break;
		
		default:
		break;
	}
?>