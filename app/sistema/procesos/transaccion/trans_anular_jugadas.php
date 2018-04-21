<?php
	session_start();
	ob_start();
	include_once('../../../conexionConf.php');
	include_once("../../../include/php/JSON.php");
	include_once('../../../include/php/common.php');
	include ("../../../clases/class.apuesta.php");
	include ("../../../clases/class.jugada_anulada.php");
	include ("../../../clases/class.logro_beisbol.php");
	include ("../../../clases/class.logro_basquetbol.php");
	include ("../../../clases/class.logro_futbol.php");
	include ("../../../clases/class.logro_futbol_americano.php");
	include ("../../../clases/class.logro_hockey.php");
	include ("../../../clases/class.logro_tennis.php");
	include ("../../../clases/class.logro_boxeo.php");
	include ("../../../clases/class.logro_formula1.php");

	$operacion = $_POST['accion'];

	switch($operacion) {
		case 'buscarEncuentros':
			$deporte = $_POST['deporte'];
			$fecha = fecha_sql($_POST['fecha']);
			
			switch($deporte) {
				case '1':
					$objeto = new logro_beisbol();
					$fila = $objeto->consultas_logros_diarios_anular($fecha);
				break;
				
				case '2':
					$objeto = new logro_basquetbol();
					$fila = $objeto->consultas_logros_diarios_anular($fecha);
				break;
				
				case '3':
					$objeto = new logro_futbol();
					$fila = $objeto->consultas_logros_diarios_anular($fecha);
				break;
				
				case '4':
					$objeto = new logro_futbol_americano();
					$fila = $objeto->consultas_logros_diarios_anular($fecha);
				break;
					
				case '5':
					$objeto = new logro_hockey();
					$fila = $objeto->consultas_logros_diarios_anular($fecha);
				break;
					
				case '6':
					$objeto = new logro_tennis();
					$fila = $objeto->consultas_logros_diarios_anular($fecha);
				break;
					
				case '7':
					$objeto = new logro_boxeo();
					$fila = $objeto->consultas_logros_diarios_anular($fecha);
				break;
				
				case '8':
					$objeto = new logro_formula1();
					$fila = $objeto->consultas_logros_diarios_anular($fecha);
				break;
			}
		break;
		
		case 'anularJugada':
			$datos_form['DEPORTE'] = $_POST['deporte'];
			$datos_form['FECHA'] = fecha_sql($_POST['fecha']);
			$datos_form['ENCUENTRO'] = $_POST['encuentro'];
			$datos_form['ESTATUS'] = 'PENDIENTE';
			$jugada = $_POST['jugada'];
			$modificar = $_POST['modificar'];
			
			if ($jugada == 'JC')
				$datos_form['APUESTAS'] = 'JC';
			else if ($jugada == 'GM')
				$datos_form['APUESTAS'] = "g_mediojuego1', 'g_mediojuego2', 'ganadorm1', 'ganadorm2";
			else if ($jugada == 'RL')
				$datos_form['APUESTAS'] = "runline1', 'runline2";
			else if ($jugada == 'RLM')
				$datos_form['APUESTAS'] = "runlinem1', 'runlinem2";
			else if ($jugada == 'AB')
				$datos_form['APUESTAS'] = "altabaja1', 'altabaja2";
			else if ($jugada == 'ABM')
				$datos_form['APUESTAS'] = "ab_mediojuego1', 'ab_mediojuego2', 'altabajam1', 'altabajam2";
			
			if ($modificar == 0) {
				$objetoAp = new apuesta();
				$filaAp = $objetoAp->apuestas_a_anular($datos_form);
				
				for($i=0; $i<count($filaAp); $i++)
				{	
					$objetoApu = new apuesta();	
					$fila = $objetoApu->actualizar_estatus_apuestas_detalles($jugada, $datos_form['APUESTAS'], $filaAp[$i]['id_deporte'], $filaAp[$i]['id_logro'], 'ANULADA');
				}
			} elseif ($modificar == 1) {
				$objetoApuAnu = new apuesta();
				$fApuAnu = $objetoApuAnu->jugadas_anuladas_revertir($datos_form);
				
				for($i=0; $i<count($fApuAnu); $i++)
				{	
					$objetoApu = new apuesta();	
					$fila = $objetoApu->actualizar_estatus_apuestas_detalles($jugada, $datos_form['APUESTAS'], $fApuAnu[$i]['id_deporte'], $fApuAnu[$i]['id_logro'], 'PENDIENTE');
				}				
			}
		break;
		
		case 'datosEncuentro':
			$deporte = $_POST['deporte'];
			$id_logro = $_POST['encuentro'];
			switch($deporte) {
				case '1':
					$objeto = new logro_beisbol();
					$fila = $objeto->datos_encuentro_anular($id_logro);
				break;
				
				case '2':
					$objeto = new logro_basquetbol();
					$fila = $objeto->datos_encuentro_anular($id_logro);
				break;
				
				case '3':
					$objeto = new logro_futbol();
					$fila = $objeto->datos_encuentro_anular($id_logro);
				break;
				
				case '4':
					$objeto = new logro_futbol_americano();
					$fila = $objeto->datos_encuentro_anular($id_logro);
				break;
				
				case '5':
					$objeto = new logro_hockey();
					$fila = $objeto->datos_encuentro_anular($id_logro);
				break;
				
				case '6':
					$objeto = new logro_tennis();
					$fila = $objeto->datos_encuentro_anular($id_logro);
				break;
					
				case '7':
					$objeto = new logro_boxeo();
					$fila = $objeto->datos_encuentro_anular($id_logro);
				break;
				
				case '8':
					$objeto = new logro_formula1();
					$fila = $objeto->datos_encuentro_anular($id_logro);
				break;
			}
		break;
		
		default:
		break;
	}
	$json = new Services_JSON();
	$resp = $json->encode($fila);
	echo $resp;
?>