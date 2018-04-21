<?php
class logro_formula1 {
	private $nombre;
	private $clave;
	private $tipo;
	
	var $_perfil1;
	
	function logro_formula1() {
		include("configDb.php");
	}
	
	public function logros_apuestas($fecha, $hora, $id_liga, $estatus) {
		$consulta = "SELECT * FROM logro_formula1 WHERE fecha='".$fecha."' AND hora>='".$hora."' AND id_liga='".$id_liga."' AND estatus='".$estatus."' ORDER BY id";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function logros_diarios($fecha, $estatus) {
		$consulta = "SELECT id, encuentro FROM logro_formula1 WHERE fecha='".$fecha."' AND estatus='".$estatus."' AND id NOT IN (SELECT id_logro FROM resultado_formula1) ORDER BY id";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function ver_equipos_logro($id_logro) {
		$consulta = "SELECT * FROM logro_formula1 WHERE id='".$id_logro."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function consultas_logros_diarios($fecha) {
		$consulta = "SELECT * FROM logro_formula1 WHERE fecha='".$fecha."' ORDER BY id";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function datos_logro($id_logro) {
		$consulta = "SELECT * FROM logro_formula1 WHERE id='".$id_logro."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function datos_encuentro_anular($id_logro) {
		$consulta = "SELECT a.id, a.encuentro, a.estatus AS estatus_logro, b.id_logro, b.estatus AS estatus_resultado FROM logro_formula1 a, resultado_formula1 b WHERE a.id='".$id_logro."' AND a.id=b.id_logro AND b.id_logro='".$id_logro."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function subir_logro_archivo($datos)
	{
		$consulta = "INSERT INTO logro_formula1(id, encuentro, equipo1, ganador1, equipo2, ganador2, equipo3, ganador3, equipo4, ganador4, equipo5, ganador5, equipo6, ganador6, equipo7, ganador7, equipo8, ganador8, equipo9, ganador9, equipo10, ganador10, equipo11, ganador11, equipo12, ganador12, equipo13, ganador13, equipo14, ganador14, equipo15, ganador15, equipo16, ganador16, equipo17, ganador17, equipo18, ganador18, equipo19, ganador19, equipo20, ganador20, equipo21, ganador21, equipo22, ganador22, equipo23, ganador23, equipo24, ganador24, favorito, fecha, hora, estatus, id_liga) VALUES ('".$datos['ID']."', '".$datos['ENCUENTRO']."', '".$datos['EQUIPO1']."', '".$datos['GANADOR1']."', '".$datos['EQUIPO2']."', '".$datos['GANADOR2']."', '".$datos['EQUIPO3']."', '".$datos['GANADOR3']."', '".$datos['EQUIPO4']."', '".$datos['GANADOR4']."', '".$datos['EQUIPO5']."', '".$datos['GANADOR5']."', '".$datos['EQUIPO6']."', '".$datos['GANADOR6']."', '".$datos['EQUIPO7']."', '".$datos['GANADOR7']."', '".$datos['EQUIPO8']."', '".$datos['GANADOR8']."', '".$datos['EQUIPO9']."', '".$datos['GANADOR9']."', '".$datos['EQUIPO10']."', '".$datos['GANADOR10']."', '".$datos['EQUIPO11']."', '".$datos['GANADOR11']."', '".$datos['EQUIPO12']."', '".$datos['GANADOR12']."', '".$datos['EQUIPO13']."', '".$datos['GANADOR13']."', '".$datos['EQUIPO14']."', '".$datos['GANADOR14']."', '".$datos['EQUIPO15']."', '".$datos['GANADOR15']."', '".$datos['EQUIPO16']."', '".$datos['GANADOR16']."', '".$datos['EQUIPO17']."', '".$datos['GANADOR17']."', '".$datos['EQUIPO18']."', '".$datos['GANADOR18']."', '".$datos['EQUIPO19']."', '".$datos['GANADOR19']."', '".$datos['EQUIPO20']."', '".$datos['GANADOR20']."', '".$datos['EQUIPO21']."', '".$datos['GANADOR21']."', '".$datos['EQUIPO22']."', '".$datos['GANADOR22']."', '".$datos['EQUIPO23']."', '".$datos['GANADOR23']."', '".$datos['EQUIPO24']."', '".$datos['GANADOR24']."', '".$datos['FAVORITO']."', '".$datos['FECHA']."', '".$datos['HORA']."', '".$datos['ESTATUS']."', '".$datos['ID_LIGA']."')";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}
	
	// MODULO DE CONSULTAS
	public function consultas_logros_diarios_ligas($fecha) {
		$consulta = "SELECT distinct(a.id_liga), b.nombre FROM logro_formula1 a, liga b WHERE a.fecha='".$fecha."' AND a.id_liga=b.id ORDER BY b.nombre";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function consultas_logros_diarios_encuentros($id_liga, $fecha) {
		$consulta = "SELECT * FROM logro_formula1 WHERE id_liga='".$id_liga."' AND fecha='".$fecha."' AND estatus='ACTIVO' ORDER BY id";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	// MODULO DE CARGAR RESULTADOS
	public function logros_diarios_resultados($fecha, $estatus)
	{
		$consulta = "SELECT a.id as codigo, a.encuentro, b.nombre FROM logro_formula1 a, liga b WHERE a.id_liga=b.id AND a.fecha='".$fecha."' AND a.estatus='".$estatus."' AND a.id NOT IN (SELECT id_logro FROM resultado_formula1) ORDER BY codigo";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	// MODULO ANULAR JUGADAS
	public function consultas_logros_diarios_anular($fecha) {
		$consulta = "SELECT a.id, a.encuentro, b.nombre FROM logro_formula1 a, liga b WHERE a.id_liga=b.id AND a.fecha='".$fecha."' ORDER BY a.id";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	// MODULO DE PROCESAR APUESTAS
	public function logros_sin_resultados() {
		$consulta = "SELECT * FROM logro_formula1 WHERE id NOT IN (SELECT id_logro FROM resultado_formula1) ORDER BY id";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function apuesta_detalle_sin_resultados($id_logro) {
		$consulta = "SELECT count(*) as apu_pendientes FROM apuesta_detalle WHERE id_logro='".$id_logro."' AND id_deporte='8'";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
}
?>