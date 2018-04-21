<?php
class resultado_hockey {
	private $nombre;
	private $clave;
	private $tipo;
	
	var $_perfil1;
	
	function resultado_hockey() {
		include("configDb.php");
	}
	
	public function proximo_codigo()
	{
		$consulta = "SELECT MAX(id) AS ultimo FROM resultado_hockey";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function guardar_resultado($datos) {
		$consulta = "INSERT INTO resultado_hockey (id, id_logro, encuentro, fecha, ganador, runline, total_goles, marcador, estatus) VALUES ('".$datos['ID']."','".$datos['ID_LOGRO']."', '".$datos['ENCUENTRO']."', '".$datos['FECHA']."', '".$datos['GANADOR']."', '".$datos['RUNLINE']."', '".$datos['GOLES']."', '".$datos['MARCADOR']."', '".$datos['ESTATUS']."')";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}
	
	public function modificar_resultado($datos) {
		$consulta = "UPDATE resultado_hockey SET ganador='".$datos['GANADOR']."', runline='".$datos['RUNLINE']."', total_goles='".$datos['GOLES']."',  marcador='".$datos['MARCADOR']."', estatus='".$datos['ESTATUS']."' WHERE id='".$datos['ID_LOGRO']."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}
	
	public function datos_resultado($id_logro)
	{
		$consulta = "SELECT *, a.estatus AS estado_res FROM resultado_hockey a, logro_hockey b WHERE a.id='".$id_logro."' AND a.id_logro=b.id";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function buscar_resultado($id)
	{
		$consulta = "SELECT * FROM resultado_hockey WHERE id='".$id."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}

	public function resultados_diarios($fecha)
	{
		$consulta = "SELECT * FROM resultado_hockey WHERE fecha='".$fecha."' ORDER BY id";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function buscar_resultado_logro($id_logro)
	{
		$consulta = "SELECT * FROM resultado_hockey WHERE id_logro='".$id_logro."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	// MODULO DE CONSULTAS
	public function consultas_resultados_diarios_encuentros($id_liga, $fecha) {
		$consulta = "SELECT b.* FROM logro_hockey a, resultado_hockey b WHERE a.id_liga='".$id_liga."' AND b.fecha='".$fecha."' AND a.id=b.id_logro";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	// MODULO DE CARGAR RESULTADOS
	public function cargar_resultados_diarios($fecha)
	{
		$consulta = "SELECT a.id as codigo, a.encuentro, c.nombre FROM resultado_hockey a, logro_hockey b, liga c WHERE a.fecha='".$fecha."' AND a.id_logro=b.id AND b.id_liga=c.id ORDER BY codigo";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
}
?>