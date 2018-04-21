<?php
	session_start();
	ob_start();

	include_once('../../../conexionConf.php');
	include_once("../../../include/php/JSON.php");
	include ("../../../clases/class.apuesta.php");
	
	$operacion = $_POST['accion'];
	
	switch($operacion) {
		case 'procesarApuestas':
			$procesar = $_POST['procesar'];
			$deporte = $_POST['deporte'];

			$objeto = new apuesta();
			$fila = $objeto->procesar_apuestas_detalles();
			
			$objAp = new apuesta();
			$fApu = $objAp->buscar_apuestas_estatus('PENDIENTE');
			
			for($i=0; $i<count($fApu); $i++) {
				$objApuDet = new apuesta();
				$fApuDet = $objApuDet->ver_apuesta_detalle($fApu[$i]['id']);
				
				$estatusApuDet = '';
				
				for($j=0; $j<count($fApuDet); $j++) {
					$estatusApuDet .= $fApuDet[$j]['estatus'].'||';
				}
				
				$estatus = explode('||', $estatusApuDet);
				$nroApu = count($estatus)-1;
				$apuGana = 0;
				$apuPend = 0;
				
				for($k=0; $k<$nroApu; $k++) {
					if($estatus[$k] == 'GANADORA' || $estatus[$k] == 'ANULADA')
						$apuGana++;
					if($estatus[$k] == 'PENDIENTE')
						$apuPend++;
				}
				
				$apuAnulada = 0;
				$apuPendAnu = 0;
				
				for($n=0; $n<$nroApu; $n++) {
					if($estatus[$n] == 'ANULADA')
						$apuAnulada++;
					if($estatus[$n] == 'PENDIENTE')
						$apuPendAnu++;
				}
				
				$estatusApu = '';
				
				if ($nroApu==$apuGana && $apuPend==0)
					$estatusApu = 'GANADORA';
				else if ($nroApu!=$apuGana && $apuPend==0)
					$estatusApu = 'PERDEDORA';
				else
					$estatusApu = 'PENDIENTE';
				
				if ($nroApu==$apuAnulada && $apuPendAnu==0)
					$estatusApu = 'ANULADA';
				
				$objApuesta = new apuesta();
				$fApuesta = $objApuesta->actualizar_estatus_apuestas($fApu[$i]['id'], $estatusApu);
			}
		break;
		
		default:
		break;
	}
	$json = new Services_JSON();
	$resp = $json->encode($fila);
	echo $resp;
?>