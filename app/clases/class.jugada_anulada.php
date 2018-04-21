<?php
class jugada_anulada {
	
	var $_perfil1;
	
	function jugada_anulada() {
		include("configDb.php");
	}
	
	public function insertar_anuladas($id, $id_apuesta, $id_deporte, $id_logro, $campo_logro, $equipo, $nro_logro, $des_logro, $estatus)
	{
		$consulta = "INSERT INTO jugada_anulada (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES ('".$id."', '".$id_apuesta."', '".$id_deporte."', '".$id_logro."', '".$campo_logro."', '".$equipo."', '".$nro_logro."', '".$des_logro."', '".$estatus."')";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}
	
	public function jugadas_a_revertir($datos) {
		if ($datos['APUESTAS'] == 'JC')
			$consulta = "SELECT b.* FROM apuesta a, jugada_anulada b WHERE a.fecha='".$datos['FECHA']."' AND a.estatus='".$datos['ESTATUS']."' AND b.id_deporte='".$datos['DEPORTE']."' AND b.id_logro='".$datos['ENCUENTRO']."' AND a.id=b.id_apuesta";
		else
			$consulta = "SELECT b.* FROM apuesta a, jugada_anulada b WHERE a.fecha='".$datos['FECHA']."' AND a.estatus='".$datos['ESTATUS']."' AND b.id_deporte='".$datos['DEPORTE']."' AND b.id_logro='".$datos['ENCUENTRO']."' AND b.campo_logro IN ('".$datos['APUESTAS']."') AND a.id=b.id_apuesta";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function revertir_jugada($id, $id_apuesta) {
		$consulta = "DELETE FROM jugada_anulada WHERE id='".$id."' AND id_apuesta='". $id_apuesta."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function buscar_anuladas($ticket) {
		$consulta = "SELECT * FROM jugada_anulada b WHERE id_apuesta='".$ticket."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
}
?>	