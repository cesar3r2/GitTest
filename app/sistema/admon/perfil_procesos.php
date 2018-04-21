<?php
	include "../../conexionConf.php";
	include "../../clases/class.perfil.php";
	
	$accion = $_GET['accion'];
	
	switch ($accion)
	{
		case '1':
			$objeto = new perfil();
			$codigo = $_GET['codigo'];
			$fila = $objeto->buscar_perfil($codigo);
			$registros = count($fila);
			echo $registros;
		break;
		
		default:
		break;
	}
?>