<?php
	include_once('../../../conexionConf.php');
	include ("../../../include/php/common.php");
	include ("../../../clases/class.apuesta.php");
	include ("../../../clases/class.resultado_beisbol.php");
		
	$objeto = new apuesta();
	$operacion = $_GET['accion'];
	
	switch($operacion) {
		case 'procesarGanadoresTodos':
			$apuesta = new apuesta();
			$fila = $apuesta->buscar_apuestas_no_procesadas();
			
			for($i=0; $i<count($fila); $i++) {
				$apuDet = new apuesta();
				$filaDet = $apuDet->ver_apuesta_detalle($fila[$i]['id']);
				$sw = 0;
				
				for($j=0; $j<count($filaDet); $j++) {
					
					if ($filaDet[$j]['id_deporte'] == 1)
					{
						$objBe = new resultado_beisbol();
						$filaBe = $objBe->consulta_apuestas_beisbol($filaDet[$j]['id_apuesta']);

						if (($filaBe[$j]['campo_logro'] == 'ganador1') || ($filaBe[$j]['campo_logro'] == 'ganador2')) {
							if (($filaBe[$j]['equipo'] == $filaBe[$j]['ganador']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaBe[0]['estatus'] == 'FINALIZADO')) {
								$sw++;
							}
						}
						if (($filaDet[$j]['campo_logro'] == 'runline1') || ($filaDet[$j]['campo_logro'] == 'runline2')) {
							if (($filaDet[$j]['equipo'] == $filaBe[0]['runline']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaBe[0]['estatus'] == 'FINALIZADO')) {
								$sw++;
							}
						}
						if (($filaDet[$j]['campo_logro'] == 'altabaja1') || ($filaDet[$j]['campo_logro'] == 'altabaja2')) {
							if (($filaDet[$j]['campo_logro'] == 'altabaja1') && ($filaBe[0]['total_carreras'] > $filaBeLo[0]['v_altabaja']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaBe[0]['estatus'] == 'FINALIZADO')) {
								$sw++;
							} else if(($filaDet[$j]['campo_logro'] == 'altabaja2') && ($filaBe[0]['total_carreras'] < $filaBeLo[0]['v_altabaja']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaBe[0]['estatus'] == 'FINALIZADO')){
								$sw++;
							} else if(($filaBe[0]['total_carreras'] == $filaBeLo[0]['v_altabaja']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaBe[0]['estatus'] == 'FINALIZADO')){
								$sw++;
							}	
						}
						if (($filaDet[$j]['campo_logro'] == 'g_mediojuego1') || ($filaDet[$j]['campo_logro'] == 'g_mediojuego2')) {
							if (($filaDet[$j]['equipo'] == $filaBe[0]['g_mediojuego']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaBe[0]['estatus'] == 'FINALIZADO')) {
								$sw++;
							}
						}
						if (($filaDet[$j]['campo_logro'] == 'ab_mediojuego1') || ($filaDet[$j]['campo_logro'] == 'ab_mediojuego2')) {
							if (($filaDet[$j]['campo_logro'] == 'ab_mediojuego1') && ($filaBe[0]['total_carreras_5to'] > $filaBeLo[0]['v_ab_mediojuego']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaBe[0]['estatus'] == 'FINALIZADO')) {
								$sw++;
							} else if(($filaDet[$j]['campo_logro'] == 'ab_mediojuego2') && ($filaBe[0]['total_carreras_5to'] < $filaBeLo[0]['v_ab_mediojuego']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaBe[0]['estatus'] == 'FINALIZADO')){
								$sw++;
							} else if(($filaBe[0]['total_carreras_5to'] == $filaBeLo[0]['v_ab_mediojuego']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaBe[0]['estatus'] == 'FINALIZADO')){
								$sw++;
							}	
						}
						if (($filaDet[$j]['campo_logro'] == 'p_inning1') || ($filaDet[$j]['campo_logro'] == 'p_inning2')) {
							if (($filaDet[$j]['campo_logro'] == 'p_inning1') && ($filaBe[0]['p_inning'] == 'SI') && ($fila[$i]['estatus'] != 'ANULADA') && ($filaBe[0]['estatus'] == 'FINALIZADO')) {
								$sw++;
							} else if(($filaDet[$j]['campo_logro'] == 'p_inning2') && ($filaBe[0]['p_inning'] == 'NO') && ($fila[$i]['estatus'] != 'ANULADA') && ($filaBe[0]['estatus'] == 'FINALIZADO')){
								$sw++;
							}	
						}
						if (($filaDet[$j]['campo_logro'] == 'p_anotar1') || ($filaDet[$j]['campo_logro'] == 'p_anotar2')) {
							if (($filaDet[$j]['equipo'] == $filaBe[0]['p_anotar']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaBe[0]['estatus'] == 'FINALIZADO')) {
								$sw++;
							}
						}
					}
					// BASQUETBOL
					if ($filaDet[$j]['id_deporte'] == 2)
					{
						$objBa = new resultado_basquetbol();
						$filaBa = $objBa->buscar_resultado_logro($filaDet[$j]['id_logro']);
						
						$objBaLo = new logro_basquetbol();
						$filaBaLo = $objBaLo->datos_logro($filaDet[$j]['id_logro']);
						
						if (($filaDet[$j]['campo_logro'] == 'ganador1') || ($filaDet[$j]['campo_logro'] == 'ganador2')) {
							if (($filaDet[$j]['equipo'] == $filaBa[0]['ganador']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaBa[0]['estatus'] == 'FINALIZADO')) {
								$sw++;
							}
						}
						if (($filaDet[$j]['campo_logro'] == 'runline1') || ($filaDet[$j]['campo_logro'] == 'runline2')) {
							if (($filaDet[$j]['equipo'] == $filaBa[0]['runline']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaBa[0]['estatus'] == 'FINALIZADO')) {
								$sw++;
							}
						}
						if (($filaDet[$j]['campo_logro'] == 'altabaja1') || ($filaDet[$j]['campo_logro'] == 'altabaja2')) {
							if (($filaDet[$j]['campo_logro'] == 'altabaja1') && ($filaBa[0]['total_puntos'] > $filaBaLo[0]['v_altabaja']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaBa[0]['estatus'] == 'FINALIZADO')) {
								$sw++;
							} else if(($filaDet[$j]['campo_logro'] == 'altabaja2') && ($filaBa[0]['total_puntos'] < $filaBaLo[0]['v_altabaja']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaBa[0]['estatus'] == 'FINALIZADO')){
								$sw++;
							}	
						}
					}
					
					// FUTBOL
					if ($filaDet[$j]['id_deporte'] == 3)
					{
						$objFu = new resultado_futbol();
						$filaFu = $objFu->buscar_resultado_logro($filaDet[$j]['id_logro']);
						
						$objFuLo = new logro_futbol();
						$filaFuLo = $objFuLo->datos_logro($filaDet[$j]['id_logro']);
						
						if (($filaDet[$j]['campo_logro'] == 'ganador1') || ($filaDet[$j]['campo_logro'] == 'ganador2')) {
							if (($filaDet[$j]['equipo'] == $filaFu[0]['ganador']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaFu[0]['estatus'] == 'FINALIZADO')) {
								$sw++;
							}
						}
						if ($filaDet[$j]['campo_logro'] == 'empate') {
							if (($filaFu[0]['ganador'] == 'EMPATE') && ($fila[$i]['estatus'] != 'ANULADA') && ($filaFu[0]['estatus'] == 'FINALIZADO')) {
								$sw++;
							}
						}
						if (($filaDet[$j]['campo_logro'] == 'runline1') || ($filaDet[$j]['campo_logro'] == 'runline2')) {
							if (($filaDet[$j]['equipo'] == $filaFu[0]['runline']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaFu[0]['estatus'] == 'FINALIZADO')) {
								$sw++;
							}
						}
						if (($filaDet[$j]['campo_logro'] == 'altabaja1') || ($filaDet[$j]['campo_logro'] == 'altabaja2')) {
							if (($filaDet[$j]['campo_logro'] == 'altabaja1') && ($filaFu[0]['total_goles'] > $filaFuLo[0]['v_altabaja']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaFu[0]['estatus'] == 'FINALIZADO')) {
								$sw++;
							} else if(($filaDet[$j]['campo_logro'] == 'altabaja2') && ($filaFu[0]['total_goles'] < $filaFuLo[0]['v_altabaja']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaFu[0]['estatus'] == 'FINALIZADO')){
								$sw++;
							}	
						}
					}
					
					// FUTBOL AMERICANO
					if ($filaDet[$j]['id_deporte'] == 4)
					{
						$objFuAm = new resultado_futbol_americano();
						$filaFuAm = $objFuAm->buscar_resultado_logro($filaDet[$j]['id_logro']);
						
						$objFuAmLo = new logro_futbol_americano();
						$filaFuAmLo = $objFuAmLo->datos_logro($filaDet[$j]['id_logro']);
						
						if (($filaDet[$j]['campo_logro'] == 'ganador1') || ($filaDet[$j]['campo_logro'] == 'ganador2')) {
							if (($filaDet[$j]['equipo'] == $filaFuAm[0]['ganador']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaFuAm[0]['estatus'] == 'FINALIZADO')) {
								$sw++;
							}
						}
						
						if (($filaDet[$j]['campo_logro'] == 'runline1') || ($filaDet[$j]['campo_logro'] == 'runline2')) {
							if (($filaDet[$j]['equipo'] == $filaFuAm[0]['runline']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaFuAm[0]['estatus'] == 'FINALIZADO')) {
								$sw++;
							}
						}
						if (($filaDet[$j]['campo_logro'] == 'altabaja1') || ($filaDet[$j]['campo_logro'] == 'altabaja2')) {
							if (($filaDet[$j]['campo_logro'] == 'altabaja1') && ($filaFuAm[0]['total_goles'] > $filaFuAmLo[0]['v_altabaja']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaFuAm[0]['estatus'] == 'FINALIZADO')) {
								$sw++;
							} else if(($filaDet[$j]['campo_logro'] == 'altabaja2') && ($filaFuAm[0]['total_goles'] < $filaFuAmLo[0]['v_altabaja']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaFuAm[0]['estatus'] == 'FINALIZADO')){
								$sw++;
							}	
						}
					}
					
					// HOCKEY
					if ($filaDet[$j]['id_deporte'] == 5)
					{
						$objHoc = new resultado_hockey();
						$filaHoc = $objHoc->buscar_resultado_logro($filaDet[$j]['id_logro']);
						
						$objHocLo = new logro_hockey();
						$filaHocLo = $objHocLo->datos_logro($filaDet[$j]['id_logro']);
						
						if (($filaDet[$j]['campo_logro'] == 'ganador1') || ($filaDet[$j]['campo_logro'] == 'ganador2')) {
							if (($filaDet[$j]['equipo'] == $filaHoc[0]['ganador']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaHoc[0]['estatus'] == 'FINALIZADO')) {
								$sw++;
							}
						}
						
						if (($filaDet[$j]['campo_logro'] == 'runline1') || ($filaDet[$j]['campo_logro'] == 'runline2')) {
							if (($filaDet[$j]['equipo'] == $filaHoc[0]['runline']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaHoc[0]['estatus'] == 'FINALIZADO')) {
								$sw++;
							}
						}
						if (($filaDet[$j]['campo_logro'] == 'altabaja1') || ($filaDet[$j]['campo_logro'] == 'altabaja2')) {
							if (($filaDet[$j]['campo_logro'] == 'altabaja1') && ($filaHoc[0]['total_goles'] > $filaHocLo[0]['v_altabaja']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaHoc[0]['estatus'] == 'FINALIZADO')) {
								$sw++;
							} else if(($filaDet[$j]['campo_logro'] == 'altabaja2') && ($filaHoc[0]['total_goles'] < $filaHocLo[0]['v_altabaja']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaHoc[0]['estatus'] == 'FINALIZADO')){
								$sw++;
							}	
						}
					}
					
					// TENNIS
					if ($filaDet[$j]['id_deporte'] == 6)
					{
						$objTen = new resultado_tennis();
						$filaTen = $objTen->buscar_resultado_logro($filaDet[$j]['id_logro']);
						
						$objTenLo = new logro_tennis();
						$filaTenLo = $objTenLo->datos_logro($filaDet[$j]['id_logro']);
						
						if (($filaDet[$j]['campo_logro'] == 'ganador1') || ($filaDet[$j]['campo_logro'] == 'ganador2')) {
							if (($filaDet[$j]['equipo'] == $filaTen[0]['ganador']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaTen[0]['estatus'] == 'FINALIZADO')) {
								$sw++;
							}
						}
					}
					
					// BOXEO
					if ($filaDet[$j]['id_deporte'] == 7)
					{
						$objBox = new resultado_boxeo();
						$filaBox = $objBox->buscar_resultado_logro($filaDet[$j]['id_logro']);
						
						$objBoxLo = new logro_boxeo();
						$filaBoxLo = $objBoxLo->datos_logro($filaDet[$j]['id_logro']);
						
						if (($filaDet[$j]['campo_logro'] == 'ganador1') || ($filaDet[$j]['campo_logro'] == 'ganador2')) {
							if (($filaDet[$j]['equipo'] == $filaBox[0]['ganador']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaBox[0]['estatus'] == 'FINALIZADO')) {
								$sw++;
							}
						}
					}
					
					// FORMULA 1
					if ($filaDet[$j]['id_deporte'] == 8)
					{
						$objF1 = new resultado_formula1();
						$filaF1 = $objF1->buscar_resultado_logro($filaDet[$j]['id_logro']);
						
						$objF1Lo = new logro_formula1();
						$filaF1Lo = $objF1Lo->datos_logro($filaDet[$j]['id_logro']);
						
						if (($filaDet[$j]['campo_logro'] == 'ganador1') || ($filaDet[$j]['campo_logro'] == 'ganador2') || ($filaDet[$j]['campo_logro'] == 'ganador3') || ($filaDet[$j]['campo_logro'] == 'ganador4') || ($filaDet[$j]['campo_logro'] == 'ganador5') || ($filaDet[$j]['campo_logro'] == 'ganador6') || ($filaDet[$j]['campo_logro'] == 'ganador7') || ($filaDet[$j]['campo_logro'] == 'ganador8') || ($filaDet[$j]['campo_logro'] == 'ganador9') || ($filaDet[$j]['campo_logro'] == 'ganador10') || ($filaDet[$j]['campo_logro'] == 'ganador11') || ($filaDet[$j]['campo_logro'] == 'ganador12') || ($filaDet[$j]['campo_logro'] == 'ganador13') || ($filaDet[$j]['campo_logro'] == 'ganador14') || ($filaDet[$j]['campo_logro'] == 'ganador15') || ($filaDet[$j]['campo_logro'] == 'ganador16') || ($filaDet[$j]['campo_logro'] == 'ganador17') || ($filaDet[$j]['campo_logro'] == 'ganador18') || ($filaDet[$j]['campo_logro'] == 'ganador19') || ($filaDet[$j]['campo_logro'] == 'ganador20') || ($filaDet[$j]['campo_logro'] == 'ganador21') || ($filaDet[$j]['campo_logro'] == 'ganador22') || ($filaDet[$j]['campo_logro'] == 'ganador23') || ($filaDet[$j]['campo_logro'] == 'ganador24')) {
							if (($filaDet[$j]['equipo'] == $filaF1[0]['ganador']) && ($fila[$i]['estatus'] != 'ANULADA') && ($filaF1[0]['estatus'] == 'FINALIZADO')) {
								$sw++;
							}
						}
					}
					
					//echo count($filaDet).'=='.$sw.'//'; 
					if (count($filaDet) == $sw) {
						$ticketsGanadores .= $fila[$i]['id'].'||';
						$mApuGanadores .= $fila[$i]['monto'].'||';
						$mPreGanadores .= $fila[$i]['premio'].'||';
					}	
				}
			}
			// ACTUALIZAR ESTATUS A TICKETS PENDIENTES
			$objApu = new apuesta();
			$fApu = $objApu->actualizar_apuestas_procesos($datos_form['FECHA'], 'PENDIENTE');
			
			for($i=0; $i<count($fila); $i++) {
				$objApuDet = new apuesta();
				$fApuDet = $objApuDet->actualizar_apuestas_detalles_procesos($fila[$i]['id'], 'PENDIENTE');
			}
			
			// ACTUALIZAR ESTATUS A TICKETS GANADORES
			$apuGanadora = explode('||', $ticketsGanadores);
			for($h=0; $h<count($apuGanadora)-1; $h++) {
				$objApuGan = new apuesta();
				$fObjApuGan = $objApuGan->actualizar_ticket_ganador($apuGanadora[$h], 'GANADORA');
				
				$objApuGanDet = new apuesta();
				$fApuGanDet = $objApuGanDet->actualizar_ticket_ganador_detalles($apuGanadora[$h], 'GANADORA');
			}
			
			// ACTUALIZAR ESTATUS A TICKETS PERDEDORES
			$objApuPer = new apuesta();
			$fApuPer = $objApuPer->actualizar_apuestas_perdedoras($datos_form['FECHA'], 'PERDEDORA');
			
			for($i=0; $i<count($fila); $i++) {
				$objApuDetPer = new apuesta();
				$fApuDetPer = $objApuDetPer->actualizar_apuestas_detalles_perdedoras($fila[$i]['id'], 'PERDEDORA');
			}
			
			echo $ticketsGanadores.'+'.$mApuGanadores.'+'.$mPreGanadores;
		break;
		default:
		break;
	}
?>