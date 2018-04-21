<?php
	include_once('../../../conexionConf.php');
	include_once("../../../include/php/JSON.php");
	include_once('../../../include/php/common.php');
	include ("../../../clases/class.logro_beisbol.php");
	include ("../../../clases/class.logro_basquetbol.php");
	include ("../../../clases/class.logro_futbol.php");
	include ("../../../clases/class.logro_futbol_americano.php");
	include ("../../../clases/class.logro_hockey.php");
	include ("../../../clases/class.logro_tennis.php");
	include ("../../../clases/class.logro_boxeo.php");
	include ("../../../clases/class.logro_formula1.php");
	include ("../../../clases/class.resultado_beisbol.php");
	include ("../../../clases/class.resultado_basquetbol.php");
	include ("../../../clases/class.resultado_futbol.php");
	include ("../../../clases/class.resultado_futbol_americano.php");
	include ("../../../clases/class.resultado_hockey.php");
	include ("../../../clases/class.resultado_tennis.php");
	include ("../../../clases/class.resultado_boxeo.php");
	include ("../../../clases/class.resultado_formula1.php");
	
	$operacion = $_POST['accion'];
	
	switch($operacion) {
		// BEISBOL
		case 'buscarEncuentros':
			$objeto = new logro_beisbol();
			$objeto1 = new resultado_beisbol();
			$datos_form['FECHA'] = fecha_sql($_POST['fecha']);
			$datos_form['ESTATUS'] = 'ACTIVO';
			$modificar = $_POST['modificar'];
			if ($modificar == 0)
				$fila = $objeto->logros_diarios_resultados($datos_form['FECHA'], $datos_form['ESTATUS']);
			else
				$fila = $objeto1->cargar_resultados_diarios($datos_form['FECHA']);
		break;
		
		case 'mostrarEncuentro':
			$objeto = new logro_beisbol();
			$objeto1 = new resultado_beisbol();
			$datos_form['ID_LOGRO'] = $_POST['id_encuentro'];
			$modificar = $_POST['modificar'];
			if ($modificar == 0)
				$fila = $objeto->ver_equipos_logro($datos_form['ID_LOGRO']);
			else
				$fila = $objeto1->datos_resultado($datos_form['ID_LOGRO']);
		break;
		
		case 'guardarResultado':
			$objRes1 = new resultado_beisbol();
			$fRes1 = $objRes1->proximo_codigo();
			$datos_form['ID'] = ($fRes1[0]['ultimo']+1);
			$datos_form['ID_LOGRO'] = $_POST['id_logro'];
			$datos_form['FECHA'] = fecha_sql($_POST['fecha']);
			$datos_form['ENCUENTRO'] = $_POST['encuentro'];
			$datos_form['ESTATUS'] = $_POST['estatus'];
			$datos_form['GANADOR'] = $_POST['ganador'];
			$datos_form['RUNLINE'] = $_POST['runline'];
			$datos_form['SRUNLINE'] = $_POST['srunline'];
			$datos_form['CARRERAS'] = $_POST['carreras'];
			$datos_form['GANADOR_MITAD'] = $_POST['ganadorMitad'];
			$datos_form['RUNLINEM'] = $_POST['runlinem'];
			$datos_form['CARRERAS_MITAD'] = $_POST['carrerasMitad'];
			$datos_form['ANOTAR1'] = $_POST['anotar1'];
			$datos_form['INNING1'] = $_POST['inning1'];
			$datos_form['MARCADOR'] = $_POST['marcador'];
			$datos_form['MARCADORM'] = $_POST['marcadorm'];
			$modificar = $_POST['modificar'];
			$objRes = new resultado_beisbol();
			if ($modificar == 0)
				$fila = $objRes->guardar_resultado($datos_form);
			else
				$fila = $objRes->modificar_resultado($datos_form);
		break;
		
		// BASQUETBOL
		case 'buscarEncuentrosBasquetbol':
			$objLogro = new logro_basquetbol();
			$objeto1 = new resultado_basquetbol();
			$datos_form['FECHA'] = fecha_sql($_POST['fecha']);
			$datos_form['ESTATUS'] = 'ACTIVO';
			$modificar = $_POST['modificar'];
			if ($modificar == 0)
				$fila = $objLogro->logros_diarios_resultados($datos_form['FECHA'], $datos_form['ESTATUS']);
			else
				$fila = $objeto1->cargar_resultados_diarios($datos_form['FECHA']);
		break;
				
		case 'mostrarEncuentroBasquetbol':
			$objLogro = new logro_basquetbol();
			$objeto1 = new resultado_basquetbol();
			$datos_form['ID_LOGRO'] = $_POST['id_encuentro'];
			$modificar = $_POST['modificar'];
			if ($modificar == 0)
				$fila = $objLogro->ver_equipos_logro($datos_form['ID_LOGRO']);
			else
				$fila = $objeto1->datos_resultado($datos_form['ID_LOGRO']);
		break;
		
		case 'guardarResultadoBasquetbol':
			$objRes1 = new resultado_basquetbol();
			$fRes1 = $objRes1->proximo_codigo();
			$datos_form['ID'] = ($fRes1[0]['ultimo']+1);
			$datos_form['ID_LOGRO'] = $_POST['id_logro'];
			$datos_form['FECHA'] = fecha_sql($_POST['fecha']);
			$datos_form['ENCUENTRO'] = $_POST['encuentro'];
			$datos_form['ESTATUS'] = $_POST['estatus'];
			$datos_form['GANADOR'] = $_POST['ganador'];
			$datos_form['RUNLINE'] = $_POST['runline'];
			$datos_form['PUNTOS'] = $_POST['puntos'];
			$datos_form['MARCADOR'] = $_POST['marcador'];
			$datos_form['GANADORM'] = $_POST['ganadorm'];
			$datos_form['RUNLINEM'] = $_POST['runlinem'];
			$datos_form['PUNTOSM'] = $_POST['puntosm'];
			$datos_form['MARCADORM'] = $_POST['marcadorm'];
			$modificar = $_POST['modificar'];
			$objRes = new resultado_basquetbol();
			if ($modificar == 0)
				$fila = $objRes->guardar_resultado($datos_form);
			else
				$fila = $objRes->modificar_resultado($datos_form);
		break;
		
		// FÚTUBOL
		case 'buscarEncuentrosFutbol':
			$objLogro = new logro_futbol();
			$objeto1 = new resultado_futbol();
			$datos_form['FECHA'] = fecha_sql($_POST['fecha']);
			$datos_form['ESTATUS'] = 'ACTIVO';
			$modificar = $_POST['modificar'];
			if ($modificar == 0)
				$fila = $objLogro->logros_diarios_resultados($datos_form['FECHA'], $datos_form['ESTATUS']);
			else
				$fila = $objeto1->cargar_resultados_diarios($datos_form['FECHA']);
		break;
				
		case 'mostrarEncuentroFutbol':
			$objLogro = new logro_futbol();
			$objeto1 = new resultado_futbol();
			$datos_form['ID_LOGRO'] = $_POST['id_encuentro'];
			$modificar = $_POST['modificar'];
			if ($modificar == 0)
				$fila = $objLogro->ver_equipos_logro($datos_form['ID_LOGRO']);
			else
				$fila = $objeto1->datos_resultado($datos_form['ID_LOGRO']);
		break;
		
		case 'guardarResultadoFutbol':
			$objRes1 = new resultado_futbol();
			$fRes1 = $objRes1->proximo_codigo();
			$datos_form['ID'] = ($fRes1[0]['ultimo']+1);
			$datos_form['ID_LOGRO'] = $_POST['id_logro'];
			$datos_form['FECHA'] = fecha_sql($_POST['fecha']);
			$datos_form['ENCUENTRO'] = $_POST['encuentro'];
			$datos_form['ESTATUS'] = $_POST['estatus'];
			$datos_form['GANADOR'] = $_POST['ganador'];
			$datos_form['RUNLINE'] = $_POST['runline'];
			$datos_form['GOLES'] = $_POST['goles'];
			$datos_form['MARCADOR'] = $_POST['marcador'];
			$modificar = $_POST['modificar'];
			$objRes = new resultado_futbol();
			if ($modificar == 0)
				$fila = $objRes->guardar_resultado($datos_form);
			else
				$fila = $objRes->modificar_resultado($datos_form);
		break;
		
		// FÚTUBOL AMERICANO
		case 'buscarEncuentrosFutbolAmericano':
			$objLogro = new logro_futbol_americano();
			$objeto1 = new resultado_futbol_americano();
			$datos_form['FECHA'] = fecha_sql($_POST['fecha']);
			$datos_form['ESTATUS'] = 'ACTIVO';
			$modificar = $_POST['modificar'];
			if ($modificar == 0)
				$fila = $objLogro->logros_diarios_resultados($datos_form['FECHA'], $datos_form['ESTATUS']);
			else
				$fila = $objeto1->cargar_resultados_diarios($datos_form['FECHA']);
		break;
		
		case 'mostrarEncuentroFutbolAmericano':
			$objLogro = new logro_futbol_americano();
			$objeto1 = new resultado_futbol_americano();
			$datos_form['ID_LOGRO'] = $_POST['id_encuentro'];
			$modificar = $_POST['modificar'];
			if ($modificar == 0)
				$fila = $objLogro->ver_equipos_logro($datos_form['ID_LOGRO']);
			else
				$fila = $objeto1->datos_resultado($datos_form['ID_LOGRO']);
		break;
		
		case 'guardarResultadoFutbolAmericano':
			$objRes1 = new resultado_futbol_americano();
			$fRes1 = $objRes1->proximo_codigo();
			$datos_form['ID'] = ($fRes1[0]['ultimo']+1);
			$datos_form['ID_LOGRO'] = $_POST['id_logro'];
			$datos_form['FECHA'] = fecha_sql($_POST['fecha']);
			$datos_form['ENCUENTRO'] = $_POST['encuentro'];
			$datos_form['ESTATUS'] = $_POST['estatus'];
			$datos_form['GANADOR'] = $_POST['ganador'];
			$datos_form['RUNLINE'] = $_POST['runline'];
			$datos_form['GOLES'] = $_POST['goles'];
			$datos_form['MARCADOR'] = $_POST['marcador'];
			$modificar = $_POST['modificar'];
			$objRes = new resultado_futbol_americano();
			if ($modificar == 0)
				$fila = $objRes->guardar_resultado($datos_form);
			else
				$fila = $objRes->modificar_resultado($datos_form);
		break;
		
		// HOCKEY
		case 'buscarEncuentrosHockey':
			$objLogro = new logro_hockey();
			$objeto1 = new resultado_hockey();
			$datos_form['FECHA'] = fecha_sql($_POST['fecha']);
			$datos_form['ESTATUS'] = 'ACTIVO';
			$modificar = $_POST['modificar'];
			if ($modificar == 0)
				$fila = $objLogro->logros_diarios_resultados($datos_form['FECHA'], $datos_form['ESTATUS']);
			else
				$fila = $objeto1->cargar_resultados_diarios($datos_form['FECHA']);
		break;
		
		case 'mostrarEncuentroHockey':
			$objLogro = new logro_hockey();
			$objeto1 = new resultado_hockey();
			$datos_form['ID_LOGRO'] = $_POST['id_encuentro'];
			$modificar = $_POST['modificar'];
			if ($modificar == 0)
				$fila = $objLogro->ver_equipos_logro($datos_form['ID_LOGRO']);
			else
				$fila = $objeto1->datos_resultado($datos_form['ID_LOGRO']);
		break;
		
		case 'guardarResultadoHockey':
			$objRes1 = new resultado_hockey();
			$fRes1 = $objRes1->proximo_codigo();
			$datos_form['ID'] = ($fRes1[0]['ultimo']+1);
			$datos_form['ID_LOGRO'] = $_POST['id_logro'];
			$datos_form['FECHA'] = fecha_sql($_POST['fecha']);
			$datos_form['ENCUENTRO'] = $_POST['encuentro'];
			$datos_form['ESTATUS'] = $_POST['estatus'];
			$datos_form['GANADOR'] = $_POST['ganador'];
			$datos_form['RUNLINE'] = $_POST['runline'];
			$datos_form['GOLES'] = $_POST['goles'];
			$datos_form['MARCADOR'] = $_POST['marcador'];
			$modificar = $_POST['modificar'];
			$objRes = new resultado_hockey();
			if ($modificar == 0)
				$fila = $objRes->guardar_resultado($datos_form);
			else
				$fila = $objRes->modificar_resultado($datos_form);
		break;
		
		// TENNIS
		case 'buscarEncuentrosTennis':
			$objLogro = new logro_tennis();
			$objeto1 = new resultado_tennis();
			$datos_form['FECHA'] = fecha_sql($_POST['fecha']);
			$datos_form['ESTATUS'] = 'ACTIVO';
			$modificar = $_POST['modificar'];
			if ($modificar == 0)
				$fila = $objLogro->logros_diarios_resultados($datos_form['FECHA'], $datos_form['ESTATUS']);
			else
				$fila = $objeto1->cargar_resultados_diarios($datos_form['FECHA']);
		break;
		
		case 'mostrarEncuentroTennis':
			$objLogro = new logro_tennis();
			$objeto1 = new resultado_tennis();
			$datos_form['ID_LOGRO'] = $_POST['id_encuentro'];
			$modificar = $_POST['modificar'];
			if ($modificar == 0)
				$fila = $objLogro->ver_equipos_logro($datos_form['ID_LOGRO']);
			else
				$fila = $objeto1->datos_resultado($datos_form['ID_LOGRO']);
		break;
		
		case 'guardarResultadoTennis':
			$objRes1 = new resultado_tennis();
			$fRes1 = $objRes1->proximo_codigo();
			$datos_form['ID'] = ($fRes1[0]['ultimo']+1);
			$datos_form['ID_LOGRO'] = $_POST['id_logro'];
			$datos_form['FECHA'] = fecha_sql($_POST['fecha']);
			$datos_form['ENCUENTRO'] = $_POST['encuentro'];
			$datos_form['ESTATUS'] = $_POST['estatus'];
			$datos_form['GANADOR'] = $_POST['ganador'];
			$datos_form['MARCADOR'] = $_POST['marcador'];
			$modificar = $_POST['modificar'];
			$objRes = new resultado_tennis();
			if ($modificar == 0)
				$fila = $objRes->guardar_resultado($datos_form);
			else
				$fila = $objRes->modificar_resultado($datos_form);
		break;
		
		// BOXEO
		case 'buscarEncuentrosBoxeo':
			$objLogro = new logro_boxeo();
			$objeto1 = new resultado_boxeo();
			$datos_form['FECHA'] = fecha_sql($_POST['fecha']);
			$datos_form['ESTATUS'] = 'ACTIVO';
			$modificar = $_POST['modificar'];
			if ($modificar == 0)
				$fila = $objLogro->logros_diarios_resultados($datos_form['FECHA'], $datos_form['ESTATUS']);
			else
				$fila = $objeto1->cargar_resultados_diarios($datos_form['FECHA']);
		break;
		
		case 'mostrarEncuentroBoxeo':
			$objLogro = new logro_boxeo();
			$objeto1 = new resultado_boxeo();
			$datos_form['ID_LOGRO'] = $_POST['id_encuentro'];
			$modificar = $_POST['modificar'];
			if ($modificar == 0)
				$fila = $objLogro->ver_equipos_logro($datos_form['ID_LOGRO']);
			else
				$fila = $objeto1->datos_resultado($datos_form['ID_LOGRO']);
		break;
		
		case 'guardarResultadoBoxeo':
			$objRes1 = new resultado_boxeo();
			$fRes1 = $objRes1->proximo_codigo();
			$datos_form['ID'] = ($fRes1[0]['ultimo']+1);
			$datos_form['ID_LOGRO'] = $_POST['id_logro'];
			$datos_form['FECHA'] = fecha_sql($_POST['fecha']);
			$datos_form['ENCUENTRO'] = $_POST['encuentro'];
			$datos_form['ESTATUS'] = $_POST['estatus'];
			$datos_form['GANADOR'] = $_POST['ganador'];
			$datos_form['MARCADOR'] = $_POST['marcador'];
			$modificar = $_POST['modificar'];
			$objRes = new resultado_boxeo();
			if ($modificar == 0)
				$fila = $objRes->guardar_resultado($datos_form);
			else
				$fila = $objRes->modificar_resultado($datos_form);
		break;
		
		// FORMULA 1
		case 'buscarEncuentrosFormula1':
			$objLogro = new logro_formula1();
			$objeto1 = new resultado_formula1();
			$datos_form['FECHA'] = fecha_sql($_POST['fecha']);
			$datos_form['ESTATUS'] = 'ACTIVO';
			$modificar = $_POST['modificar'];
			if ($modificar == 0)
				$fila = $objLogro->logros_diarios_resultados($datos_form['FECHA'], $datos_form['ESTATUS']);
			else
				$fila = $objeto1->cargar_resultados_diarios($datos_form['FECHA']);
		break;
		
		case 'mostrarEncuentroFormula1':
			$objLogro = new logro_formula1();
			$objeto1 = new resultado_formula1();
			$datos_form['ID_LOGRO'] = $_POST['id_encuentro'];
			$modificar = $_POST['modificar'];
			if ($modificar == 0)
				$fila = $objLogro->ver_equipos_logro($datos_form['ID_LOGRO']);
			else
				$fila = $objeto1->datos_resultado($datos_form['ID_LOGRO']);
		break;
		
		case 'guardarResultadoFormula1':
			$objRes1 = new resultado_formula1();
			$fRes1 = $objRes1->proximo_codigo();
			$datos_form['ID'] = ($fRes1[0]['ultimo']+1);
			$datos_form['ID_LOGRO'] = $_POST['id_logro'];
			$datos_form['FECHA'] = fecha_sql($_POST['fecha']);
			$datos_form['ENCUENTRO'] = $_POST['encuentro'];
			$datos_form['ESTATUS'] = $_POST['estatus'];
			$datos_form['GANADOR'] = $_POST['ganador'];
			$datos_form['MARCADOR'] = $_POST['marcador'];
			$modificar = $_POST['modificar'];
			$objRes = new resultado_formula1();
			if ($modificar == 0)
				$fila = $objRes->guardar_resultado($datos_form);
			else
				$fila = $objRes->modificar_resultado($datos_form);
		break;
	
		default:
		break;
	}
	$json = new Services_JSON();
	$resp = $json->encode($fila);
	echo $resp;
?>