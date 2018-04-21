<?php
class logro_basquetbol {
	private $nombre;
	private $clave;
	private $tipo;
	
	var $_perfil1;
	
	function logro_basquetbol() {
		include("configDb.php");
	}
	
	public function logros_apuestas($fecha, $hora, $id_liga, $estatus) {
		$consulta = "SELECT * FROM logro_basquetbol WHERE fecha='".$fecha."' AND hora>='".$hora."' AND id_liga='".$id_liga."' AND estatus='".$estatus."' ORDER BY id";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function logros_diarios($fecha, $estatus) {
		$consulta = "SELECT id, encuentro FROM logro_basquetbol WHERE fecha='".$fecha."' AND estatus='".$estatus."' AND id NOT IN (SELECT id_logro FROM resultado_basquetbol) ORDER BY id";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function ver_equipos_logro($id_logro) {
		$consulta = "SELECT equipo1, equipo2, favorito, v_runline, v_altabaja, v_runline_m, v_altabaja_m FROM logro_basquetbol WHERE id='".$id_logro."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function consultas_logros_diarios($fecha) {
		$consulta = "SELECT * FROM logro_basquetbol WHERE fecha='".$fecha."' ORDER BY id";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function datos_logro($id_logro) {
		$consulta = "SELECT * FROM logro_basquetbol WHERE id='".$id_logro."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function datos_encuentro_anular($id_logro) {
		$consulta = "SELECT a.id, a.encuentro, a.v_runline, a.v_altabaja, a.v_runline_m, a.v_altabaja_m, a.estatus AS estatus_logro, b.id_logro, b.runline, b.total_puntos, b.ganadorm, b.runlinem, b.total_puntosm, b.estatus AS estatus_resultado FROM logro_basquetbol a, resultado_basquetbol b WHERE a.id='".$id_logro."' AND a.id=b.id_logro AND b.id_logro='".$id_logro."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function subir_logro_archivo($datos)
	{
		$consulta = "INSERT INTO logro_basquetbol(id, encuentro, equipo1, equipo2, favorito, fecha, hora, ganador1, ganador2, runline1, runline2, v_runline, altabaja1, altabaja2, v_altabaja, ganadorm1, ganadorm2, runlinem1, runlinem2, v_runline_m, altabajam1, altabajam2, v_altabaja_m, estatus, id_liga) VALUES ('".$datos['ID']."', '".$datos['ENCUENTRO']."', '".$datos['EQUIPO1']."', '".$datos['EQUIPO2']."', '".$datos['FAVORITO']."', '".$datos['FECHA']."', '".$datos['HORA']."', '".$datos['GANADOR1']."', '".$datos['GANADOR2']."', '".$datos['RUNLINE1']."', '".$datos['RUNLINE2']."', '".$datos['VRUNLINE']."', '".$datos['ALTABAJA1']."', '".$datos['ALTABAJA2']."', '".$datos['VALTABAJA']."', '".$datos['GANADORM1']."', '".$datos['GANADORM2']."', '".$datos['RUNLINEM1']."', '".$datos['RUNLINEM2']."', '".$datos['VRUNLINEM']."', '".$datos['ALTABAJAM1']."', '".$datos['ALTABAJAM2']."', '".$datos['VALTABAJAM']."', '".$datos['ESTATUS']."', '".$datos['ID_LIGA']."')";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}
	
	// MODULO DE CONSULTAS
	public function consultas_logros_diarios_ligas($fecha) {
		$consulta = "SELECT distinct(a.id_liga), b.nombre FROM logro_basquetbol a, liga b WHERE a.fecha='".$fecha."' AND a.id_liga=b.id ORDER BY b.nombre";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function consultas_logros_diarios_encuentros($id_liga, $fecha) {
		$consulta = "SELECT * FROM logro_basquetbol WHERE id_liga='".$id_liga."' AND fecha='".$fecha."' AND estatus='ACTIVO' ORDER BY id";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	// MODULO DE CARGAR RESULTADOS
	public function logros_diarios_resultados($fecha, $estatus)
	{
		$consulta = "SELECT a.id as codigo, a.encuentro, b.nombre FROM logro_basquetbol a, liga b WHERE a.id_liga=b.id AND a.fecha='".$fecha."' AND a.estatus='".$estatus."' AND a.id NOT IN (SELECT id_logro FROM resultado_basquetbol) ORDER BY codigo";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	// MODULO ANULAR JUGADAS
	public function consultas_logros_diarios_anular($fecha) {
		$consulta = "SELECT a.id, a.encuentro, b.nombre FROM logro_basquetbol a, liga b WHERE a.id_liga=b.id AND a.fecha='".$fecha."' ORDER BY a.id";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	// MODULO DE PROCESAR APUESTAS
	public function logros_sin_resultados() {
		$consulta = "SELECT * FROM logro_basquetbol WHERE id NOT IN (SELECT id_logro FROM resultado_basquetbol) ORDER BY id";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function apuesta_detalle_sin_resultados($id_logro) {
		$consulta = "SELECT count(*) as apu_pendientes FROM apuesta_detalle WHERE id_logro='".$id_logro."' AND id_deporte='2'";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
}
?>