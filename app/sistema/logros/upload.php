<?php
	include "../../conexionConf.php";
	include "../../include/php/JSON.php";
	include "../../clases/class.logro_beisbol.php";
	include "../../clases/class.logro_basquetbol.php";
	include "../../clases/class.logro_futbol.php";
	include "../../clases/class.logro_futbol_americano.php";
	include "../../clases/class.logro_hockey.php";
	include "../../clases/class.logro_tennis.php";
	include "../../clases/class.logro_boxeo.php";
	include "../../clases/class.logro_formula1.php";
	
	$accion = $_GET['accion'];

	switch ($accion)
	{
		case 'beisbol':
			$tmp_name = $_FILES["archivo"]["tmp_name"];
		    $fp = fopen($tmp_name, "rb");
			$archivo = fread($fp, filesize($tmp_name));
			fclose($fp);
			
			$lineas = explode("\n", $archivo);
			for($i=0; $i<count($lineas)-1; $i++) {
				$dato = explode("\t", $lineas[$i]);
				$datoLogro['ID'] = trim($dato[0]);
				$datoLogro['ENCUENTRO'] = trim($dato[1]);
				$datoLogro['EQUIPO1'] = trim($dato[2]);
				$datoLogro['EQUIPO2'] = trim($dato[3]);
				$datoLogro['LANZADOR1'] = trim($dato[4]);
				$datoLogro['LANZADOR2'] = trim($dato[5]);
				$datoLogro['FAVORITO'] = trim($dato[6]);
				$datoLogro['FECHA'] = trim($dato[7]);
				$datoLogro['HORA'] = trim($dato[8]);
				$datoLogro['GANADOR1'] = trim($dato[9]);
				$datoLogro['GANADOR2'] = trim($dato[10]);
				$datoLogro['RUNLINE1'] = trim($dato[11]);
				$datoLogro['RUNLINE2'] = trim($dato[12]);
				$datoLogro['VRUNLINE'] = trim($dato[13]);
				$datoLogro['SRUNLINE1'] = trim($dato[14]);
				$datoLogro['SRUNLINE2'] = trim($dato[15]);
				$datoLogro['VSRUNLINE'] = trim($dato[16]);
				$datoLogro['ALTABAJA1'] = trim($dato[17]);
				$datoLogro['ALTABAJA2'] = trim($dato[18]);
				$datoLogro['VALTABAJA'] = trim($dato[19]);
				$datoLogro['PINNING1'] = trim($dato[20]);
				$datoLogro['PINNING2'] = trim($dato[21]);
				$datoLogro['GMITAD1'] = trim($dato[22]);
				$datoLogro['GMITAD2'] = trim($dato[23]);
				$datoLogro['RUNLINEM1'] = trim($dato[24]);
				$datoLogro['RUNLINEM2'] = trim($dato[25]);
				$datoLogro['VRUNLINEM'] = trim($dato[26]);
				$datoLogro['ABMITAD1'] = trim($dato[27]);
				$datoLogro['ABMITAD2'] = trim($dato[28]);
				$datoLogro['VABMITAD'] = trim($dato[29]);
				$datoLogro['PANOTAR1'] = trim($dato[30]);
				$datoLogro['PANOTAR2'] = trim($dato[31]);
				$datoLogro['ESTATUS'] = trim($dato[32]);
				$datoLogro['ID_LIGA'] = trim($dato[33]);
				
				$logro = new logro_beisbol();
				$fila = $logro->subir_logro_archivo($datoLogro);
			}
		break;
		
		case 'basquetbol':
			$tmp_name = $_FILES["archivo"]["tmp_name"];
		    $fp = fopen($tmp_name, "rb");
			$archivo = fread($fp, filesize($tmp_name));
			fclose($fp);
			
			$lineas = explode("\n", $archivo);
			for($i=0; $i<count($lineas)-1; $i++) {
				$dato = explode("\t", $lineas[$i]);
				$datoLogro['ID'] = trim($dato[0]);
				$datoLogro['ENCUENTRO'] = trim($dato[1]);
				$datoLogro['EQUIPO1'] = trim($dato[2]);
				$datoLogro['EQUIPO2'] = trim($dato[3]);
				$datoLogro['FAVORITO'] = trim($dato[4]);
				$datoLogro['FECHA'] = trim($dato[5]);
				$datoLogro['HORA'] = trim($dato[6]);
				$datoLogro['GANADOR1'] = trim($dato[7]);
				$datoLogro['GANADOR2'] = trim($dato[8]);
				$datoLogro['RUNLINE1'] = trim($dato[9]);
				$datoLogro['RUNLINE2'] = trim($dato[10]);
				$datoLogro['VRUNLINE'] = trim($dato[11]);
				$datoLogro['ALTABAJA1'] = trim($dato[12]);
				$datoLogro['ALTABAJA2'] = trim($dato[13]);
				$datoLogro['VALTABAJA'] = trim($dato[14]);
				$datoLogro['GANADORM1'] = trim($dato[15]);
				$datoLogro['GANADORM2'] = trim($dato[16]);
				$datoLogro['RUNLINEM1'] = trim($dato[17]);
				$datoLogro['RUNLINEM2'] = trim($dato[18]);
				$datoLogro['VRUNLINEM'] = trim($dato[19]);
				$datoLogro['ALTABAJAM1'] = trim($dato[20]);
				$datoLogro['ALTABAJAM2'] = trim($dato[21]);
				$datoLogro['VALTABAJAM'] = trim($dato[22]);
				$datoLogro['ESTATUS'] = trim($dato[23]);
				$datoLogro['ID_LIGA'] = trim($dato[24]);
				
				$logro = new logro_basquetbol();
				$fila = $logro->subir_logro_archivo($datoLogro);
			}
		break;
		
		case 'futbol':
			$tmp_name = $_FILES["archivo"]["tmp_name"];
		    $fp = fopen($tmp_name, "rb");
			$archivo = fread($fp, filesize($tmp_name));
			fclose($fp);
			
			$lineas = explode("\n", $archivo);
			for($i=0; $i<count($lineas)-1; $i++) {
				$dato = explode("\t", $lineas[$i]);
				$datoLogro['ID'] = trim($dato[0]);
				$datoLogro['ENCUENTRO'] = trim($dato[1]);
				$datoLogro['EQUIPO1'] = trim($dato[2]);
				$datoLogro['EQUIPO2'] = trim($dato[3]);
				$datoLogro['FAVORITO'] = trim($dato[4]);
				$datoLogro['FECHA'] = trim($dato[5]);
				$datoLogro['HORA'] = trim($dato[6]);
				$datoLogro['GANADOR1'] = trim($dato[7]);
				$datoLogro['GANADOR2'] = trim($dato[8]);
				$datoLogro['EMPATE'] = trim($dato[9]);
				$datoLogro['RUNLINE1'] = trim($dato[10]);
				$datoLogro['RUNLINE2'] = trim($dato[11]);
				$datoLogro['VRUNLINE'] = trim($dato[12]);
				$datoLogro['ALTABAJA1'] = trim($dato[13]);
				$datoLogro['ALTABAJA2'] = trim($dato[14]);
				$datoLogro['VALTABAJA'] = trim($dato[15]);
				$datoLogro['ESTATUS'] = trim($dato[16]);
				$datoLogro['ID_LIGA'] = trim($dato[17]);
				
				$logro = new logro_futbol();
				$fila = $logro->subir_logro_archivo($datoLogro);
			}
		break;
		
		case 'futbol_americano':
			$tmp_name = $_FILES["archivo"]["tmp_name"];
		    $fp = fopen($tmp_name, "rb");
			$archivo = fread($fp, filesize($tmp_name));
			fclose($fp);
			
			$lineas = explode("\n", $archivo);
			for($i=0; $i<count($lineas)-1; $i++) {
				$dato = explode("\t", $lineas[$i]);
				$datoLogro['ID'] = trim($dato[0]);
				$datoLogro['ENCUENTRO'] = trim($dato[1]);
				$datoLogro['EQUIPO1'] = trim($dato[2]);
				$datoLogro['EQUIPO2'] = trim($dato[3]);
				$datoLogro['FAVORITO'] = trim($dato[4]);
				$datoLogro['FECHA'] = trim($dato[5]);
				$datoLogro['HORA'] = trim($dato[6]);
				$datoLogro['GANADOR1'] = trim($dato[7]);
				$datoLogro['GANADOR2'] = trim($dato[8]);
				$datoLogro['RUNLINE1'] = trim($dato[9]);
				$datoLogro['RUNLINE2'] = trim($dato[10]);
				$datoLogro['VRUNLINE'] = trim($dato[11]);
				$datoLogro['ALTABAJA1'] = trim($dato[12]);
				$datoLogro['ALTABAJA2'] = trim($dato[13]);
				$datoLogro['VALTABAJA'] = trim($dato[14]);
				$datoLogro['ESTATUS'] = trim($dato[15]);
				$datoLogro['ID_LIGA'] = trim($dato[16]);
				
				$logro = new logro_futbol_americano();
				$fila = $logro->subir_logro_archivo($datoLogro);
			}
		break;
		
		case 'hockey':
			$tmp_name = $_FILES["archivo"]["tmp_name"];
		    $fp = fopen($tmp_name, "rb");
			$archivo = fread($fp, filesize($tmp_name));
			fclose($fp);
			
			$lineas = explode("\n", $archivo);
			for($i=0; $i<count($lineas)-1; $i++) {
				$dato = explode("\t", $lineas[$i]);
				$datoLogro['ID'] = trim($dato[0]);
				$datoLogro['ENCUENTRO'] = trim($dato[1]);
				$datoLogro['EQUIPO1'] = trim($dato[2]);
				$datoLogro['EQUIPO2'] = trim($dato[3]);
				$datoLogro['FAVORITO'] = trim($dato[4]);
				$datoLogro['FECHA'] = trim($dato[5]);
				$datoLogro['HORA'] = trim($dato[6]);
				$datoLogro['GANADOR1'] = trim($dato[7]);
				$datoLogro['GANADOR2'] = trim($dato[8]);
				$datoLogro['RUNLINE1'] = trim($dato[9]);
				$datoLogro['RUNLINE2'] = trim($dato[10]);
				$datoLogro['VRUNLINE'] = trim($dato[11]);
				$datoLogro['ALTABAJA1'] = trim($dato[12]);
				$datoLogro['ALTABAJA2'] = trim($dato[13]);
				$datoLogro['VALTABAJA'] = trim($dato[14]);
				$datoLogro['ESTATUS'] = trim($dato[15]);
				$datoLogro['ID_LIGA'] = trim($dato[16]);
				
				$logro = new logro_hockey();
				$fila = $logro->subir_logro_archivo($datoLogro);
			}
		break;
		
		case 'tennis':
			$tmp_name = $_FILES["archivo"]["tmp_name"];
		    $fp = fopen($tmp_name, "rb");
			$archivo = fread($fp, filesize($tmp_name));
			fclose($fp);
			
			$lineas = explode("\n", $archivo);
			for($i=0; $i<count($lineas)-1; $i++) {
				$dato = explode("\t", $lineas[$i]);
				$datoLogro['ID'] = trim($dato[0]);
				$datoLogro['ENCUENTRO'] = trim($dato[1]);
				$datoLogro['EQUIPO1'] = trim($dato[2]);
				$datoLogro['EQUIPO2'] = trim($dato[3]);
				$datoLogro['FAVORITO'] = trim($dato[4]);
				$datoLogro['FECHA'] = trim($dato[5]);
				$datoLogro['HORA'] = trim($dato[6]);
				$datoLogro['GANADOR1'] = trim($dato[7]);
				$datoLogro['GANADOR2'] = trim($dato[8]);
				$datoLogro['ESTATUS'] = trim($dato[9]);
				$datoLogro['ID_LIGA'] = trim($dato[10]);
				$logro = new logro_tennis();
				$fila = $logro->subir_logro_archivo($datoLogro);
			}
		break;
		
		case 'boxeo':
			$tmp_name = $_FILES["archivo"]["tmp_name"];
		    $fp = fopen($tmp_name, "rb");
			$archivo = fread($fp, filesize($tmp_name));
			fclose($fp);
			
			$lineas = explode("\n", $archivo);
			for($i=0; $i<count($lineas)-1; $i++) {
				$dato = explode("\t", $lineas[$i]);
				$datoLogro['ID'] = trim($dato[0]);
				$datoLogro['ENCUENTRO'] = trim($dato[1]);
				$datoLogro['EQUIPO1'] = trim($dato[2]);
				$datoLogro['EQUIPO2'] = trim($dato[3]);
				$datoLogro['FAVORITO'] = trim($dato[4]);
				$datoLogro['FECHA'] = trim($dato[5]);
				$datoLogro['HORA'] = trim($dato[6]);
				$datoLogro['GANADOR1'] = trim($dato[7]);
				$datoLogro['GANADOR2'] = trim($dato[8]);
				$datoLogro['ESTATUS'] = trim($dato[9]);
				$datoLogro['ID_LIGA'] = trim($dato[10]);
				$logro = new logro_boxeo();
				$fila = $logro->subir_logro_archivo($datoLogro);
			}
		break;
		
		case 'formula1':
			$tmp_name = $_FILES["archivo"]["tmp_name"];
		    $fp = fopen($tmp_name, "rb");
			$archivo = fread($fp, filesize($tmp_name));
			fclose($fp);
			
			$lineas = explode("\n", $archivo);
			for($i=0; $i<count($lineas)-1; $i++) {
				$dato = explode("\t", $lineas[$i]);
				$datoLogro['ID'] = trim($dato[0]);
				$datoLogro['ENCUENTRO'] = trim($dato[1]);
				$datoLogro['EQUIPO1'] = trim($dato[2]);
				$datoLogro['GANADOR1'] = trim($dato[3]);
				$datoLogro['EQUIPO2'] = trim($dato[4]);
				$datoLogro['GANADOR2'] = trim($dato[5]);
				$datoLogro['EQUIPO3'] = trim($dato[6]);
				$datoLogro['GANADOR3'] = trim($dato[7]);
				$datoLogro['EQUIPO4'] = trim($dato[8]);
				$datoLogro['GANADOR4'] = trim($dato[9]);
				$datoLogro['EQUIPO5'] = trim($dato[10]);
				$datoLogro['GANADOR5'] = trim($dato[11]);
				$datoLogro['EQUIPO6'] = trim($dato[12]);
				$datoLogro['GANADOR6'] = trim($dato[13]);
				$datoLogro['EQUIPO7'] = trim($dato[14]);
				$datoLogro['GANADOR7'] = trim($dato[15]);
				$datoLogro['EQUIPO8'] = trim($dato[16]);
				$datoLogro['GANADOR8'] = trim($dato[17]);
				$datoLogro['EQUIPO9'] = trim($dato[18]);
				$datoLogro['GANADOR9'] = trim($dato[19]);
				$datoLogro['EQUIPO10'] = trim($dato[20]);
				$datoLogro['GANADOR10'] = trim($dato[21]);
				$datoLogro['EQUIPO11'] = trim($dato[22]);
				$datoLogro['GANADOR11'] = trim($dato[23]);
				$datoLogro['EQUIPO12'] = trim($dato[24]);
				$datoLogro['GANADOR12'] = trim($dato[25]);
				$datoLogro['EQUIPO13'] = trim($dato[26]);
				$datoLogro['GANADOR13'] = trim($dato[27]);
				$datoLogro['EQUIPO14'] = trim($dato[28]);
				$datoLogro['GANADOR14'] = trim($dato[29]);
				$datoLogro['EQUIPO15'] = trim($dato[30]);
				$datoLogro['GANADOR15'] = trim($dato[31]);
				$datoLogro['EQUIPO16'] = trim($dato[32]);
				$datoLogro['GANADOR16'] = trim($dato[33]);
				$datoLogro['EQUIPO17'] = trim($dato[34]);
				$datoLogro['GANADOR17'] = trim($dato[35]);
				$datoLogro['EQUIPO18'] = trim($dato[36]);
				$datoLogro['GANADOR18'] = trim($dato[37]);
				$datoLogro['EQUIPO19'] = trim($dato[38]);
				$datoLogro['GANADOR19'] = trim($dato[39]);
				$datoLogro['EQUIPO20'] = trim($dato[40]);
				$datoLogro['GANADOR20'] = trim($dato[41]);
				$datoLogro['EQUIPO21'] = trim($dato[42]);
				$datoLogro['GANADOR21'] = trim($dato[43]);
				$datoLogro['EQUIPO22'] = trim($dato[44]);
				$datoLogro['GANADOR22'] = trim($dato[45]);
				$datoLogro['EQUIPO23'] = trim($dato[46]);
				$datoLogro['GANADOR23'] = trim($dato[47]);
				$datoLogro['EQUIPO24'] = trim($dato[48]);
				$datoLogro['GANADOR24'] = trim($dato[49]);
				$datoLogro['FAVORITO'] = trim($dato[50]);
				$datoLogro['FECHA'] = trim($dato[51]);
				$datoLogro['HORA'] = trim($dato[52]);
				$datoLogro['ESTATUS'] = trim($dato[53]);
				$datoLogro['ID_LIGA'] = trim($dato[54]);
				
				$logro = new logro_formula1();
				$fila = $logro->subir_logro_archivo($datoLogro);
			}
		break;
	
		default:
		break;
	}
	$json = new Services_JSON();
	$resp = $json->encode($fila);
	
	if (($resp == 'false') || ($resp == 'null'))
		echo "<SCRIPT language=\"JavaScript\" type=\"text/javascript\">
		alert(\"ERROR: NO SE PUDO PROCESAR EL ARCHIVO DE LOGROS\")
		location.href=\"logros_$accion.php\"</SCRIPT>";
	else
		echo "<SCRIPT language=\"JavaScript\" type=\"text/javascript\">
		alert(\"ARCHIVO DE LOGROS CARGADO CORRECTAMENTE\")
		location.href=\"logros_$accion.php\"</SCRIPT>";
?>