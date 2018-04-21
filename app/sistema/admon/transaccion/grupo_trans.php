<?php
	include_once("../../../include/php/JSON.php");
	include_once('../../../conexionConf.php');
	include "../../../clases/class.grupo.php";
		
	$objGrupo = new grupo();
	$operacion = $_POST['accion'];
	
	switch($operacion) {
		case 'cargarGrupos':
			$id_banquero = $_POST['id_banquero'];
			$grupo = $objGrupo->buscar_grupos($id_banquero);
			$nFilas = count($fObj);
		break;
		
		default:
		break;
	}
	$json = new Services_JSON();
	$resp = $json->encode($grupo);
	echo $resp;
?>