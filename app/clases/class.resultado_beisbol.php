<?php
class resultado_beisbol {
	private $nombre;
	private $clave;
	private $tipo;
	
	var $_perfil1;
	
	function resultado_beisbol() {
		include("configDb.php");
	}
	
	public function buscar_resultado_ganador($id_apuesta, $id_logro, $fecha, $equipo) {
		$consulta = "SELECT * FROM apuesta a, apuesta_detalle b, resultado_beisbol c WHERE a.id='".$id_apuesta."' AND a.fecha='".$fecha."' AND c.fecha='".$fecha."' AND b.id_logro='".$id_logro."' AND b.campo_logro in ('ganador1', 'ganador2') AND c.ganador='".$equipo."' AND b.equipo=c.ganador AND b.id_logro=c.id_logro AND a.id=b.id_apuesta ORDER BY b.id_apuesta";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function buscar_resultado_runline($id_apuesta, $id_logro, $fecha, $equipo) {
		$consulta = "SELECT * FROM apuesta a, apuesta_detalle b, resultado_beisbol c WHERE a.id='".$id_apuesta."' AND a.fecha='".$fecha."' AND c.fecha='".$fecha."' AND b.id_logro='".$id_logro."' AND b.campo_logro in ('runline1', 'runline2') AND c.runline='".$equipo."' AND b.equipo=c.ganador AND b.id_logro=c.id_logro AND a.id=b.id_apuesta ORDER BY b.id_apuesta";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function buscar_resultado_altabaja($id_apuesta, $id_logro, $fecha, $tipo_apuesta) {
		if ($tipo_apuesta == 'altabaja1') {
			$consulta = "SELECT * FROM apuesta a, apuesta_detalle b, resultado_beisbol c, logro_beisbol d WHERE a.id='".$id_apuesta."' AND a.fecha='".$fecha."' AND c.fecha='".$fecha."' AND b.id_logro='".$id_logro."' AND d.altabaja1=b.nro_logro AND b.campo_logro='altabaja1' AND c.total_carreras>d.v_altabaja AND b.equipo=c.encuentro AND b.id_logro=c.id_logro AND a.id=b.id_apuesta AND b.id_logro=d.id ORDER BY b.id_apuesta";
		} elseif ($tipo_apuesta == 'altabaja2') {
			$consulta = "SELECT * FROM apuesta a, apuesta_detalle b, resultado_beisbol c, logro_beisbol d WHERE a.id='".$id_apuesta."' AND a.fecha='".$fecha."' AND c.fecha='".$fecha."' AND b.id_logro='".$id_logro."' AND d.altabaja2=b.nro_logro AND b.campo_logro='altabaja2' AND c.total_carreras<d.v_altabaja AND b.equipo=c.encuentro AND b.id_logro=c.id_logro AND a.id=b.id_apuesta AND b.id_logro=d.id ORDER BY b.id_apuesta";
		}
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function proximo_codigo()
	{
		$consulta = "SELECT MAX(id) AS ultimo FROM resultado_beisbol";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function guardar_resultado($datos) {
		$consulta = "INSERT INTO resultado_beisbol (id, id_logro, encuentro, fecha, ganador, runline, srunline, marcador, total_carreras, g_mediojuego, runlinem, marcadorm, total_carreras_5to, p_inning, p_anotar, estatus) VALUES ('".$datos['ID']."','".$datos['ID_LOGRO']."', '".$datos['ENCUENTRO']."', '".$datos['FECHA']."', '".$datos['GANADOR']."', '".$datos['RUNLINE']."', '".$datos['SRUNLINE']."', '".$datos['MARCADOR']."', '".$datos['CARRERAS']."', '".$datos['GANADOR_MITAD']."', '".$datos['RUNLINEM']."', '".$datos['MARCADORM']."', '".$datos['CARRERAS_MITAD']."', '".$datos['INNING1']."', '".$datos['ANOTAR1']."', '".$datos['ESTATUS']."')";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}
	
	public function modificar_resultado($datos) {
		$consulta = "UPDATE resultado_beisbol SET ganador='".$datos['GANADOR']."', runline='".$datos['RUNLINE']."', srunline='".$datos['SRUNLINE']."', p_inning='".$datos['INNING1']."', g_mediojuego='".$datos['GANADOR_MITAD']."', runlinem='".$datos['RUNLINEM']."', p_anotar='".$datos['ANOTAR1']."', marcador='".$datos['MARCADOR']."', marcadorm='".$datos['MARCADORM']."', total_carreras='".$datos['CARRERAS']."', total_carreras_5to='".$datos['CARRERAS_MITAD']."', estatus='".$datos['ESTATUS']."' WHERE id='".$datos['ID_LOGRO']."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}
	
	public function datos_resultado($id_logro)
	{
		$consulta = "SELECT *, a.estatus AS estado_res FROM resultado_beisbol a, logro_beisbol b WHERE a.id='".$id_logro."' AND a.id_logro=b.id";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function buscar_resultado($id)
	{
		$consulta = "SELECT * FROM resultado_beisbol WHERE id='".$id."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}

	public function resultados_diarios($fecha)
	{
		$consulta = "SELECT * FROM resultado_beisbol WHERE fecha='".$fecha."' ORDER BY id";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function buscar_resultado_logro($id_logro)
	{
		$consulta = "SELECT * FROM resultado_beisbol WHERE id_logro='".$id_logro."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	// MODULO DE CONSULTAS
	public function consultas_resultados_diarios_encuentros($id_liga, $fecha) {
		$consulta = "SELECT b.* FROM logro_beisbol a, resultado_beisbol b WHERE a.id_liga='".$id_liga."' AND b.fecha='".$fecha."' AND a.id=b.id_logro";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	// MODULO DE CARGAR RESULTADOS
	public function cargar_resultados_diarios($fecha)
	{
		$consulta = "SELECT a.id as codigo, a.encuentro, c.nombre FROM resultado_beisbol a, logro_beisbol b, liga c WHERE a.fecha='".$fecha."' AND a.id_logro=b.id AND b.id_liga=c.id ORDER BY codigo";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	// FUNCIONES PARA PROCESAR TICKETS GANADORES
	public function consulta_apuestas_beisbol($id_apu) {
		$consulta = "SELECT * FROM apuesta_beisbol WHERE id_apu='".$id_apu."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
}
?>