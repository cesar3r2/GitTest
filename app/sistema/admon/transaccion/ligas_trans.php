<?php
	include_once("../../../include/php/JSON.php");
	include_once('../../../conexionConf.php');
	include "../../../clases/class.liga.php";
		
	$operacion = $_POST['accion'];
	
	switch($operacion) {
		case 'activarLigas':
			$activar = $_POST['activar'];
			$desactivar = $_POST['desactivar'];
			
			$ligaAct = explode(',', $activar);
			$ligaDes = explode(',', $desactivar);
			
			for($i=0; $i<count($ligaAct); $i++)	{
				$objeto[$i] = new liga();
				$fila[$i] = $objeto[$i]->cambiar_estatus($ligaAct[$i], 'ACTIVA');
			}
			
			for($i=0; $i<count($ligaDes); $i++)	{
				$objeto[$i] = new liga();
				$fila[$i] = $objeto[$i]->cambiar_estatus($ligaDes[$i], 'INACTIVA');
			}
		break;
				
		default:
		break;
	}
	$json = new Services_JSON();
	$resp = $json->encode($fila);
	echo $resp;
?>