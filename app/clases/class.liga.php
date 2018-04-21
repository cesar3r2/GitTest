<?php
class liga {
	private $codigo;
	private $nombre;
	
	var $_perfil1;
	
	function liga() {
		include("configDb.php");
	}
	
	public function lista() {
		$consulta = "SELECT * FROM liga ORDER BY id";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}

	public function buscar_ligas($id_deporte, $estatus) {
		$consulta = "SELECT * FROM liga WHERE id_deporte='".$id_deporte."' AND estatus='".$estatus."' ORDER BY id";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function todas_ligas() {
		$consulta = "SELECT a.id AS idliga, a.nombre AS nombreliga, b.nombre AS nombredeporte, estatus FROM liga a, deporte b WHERE a.id_deporte=b.id ORDER BY b.nombre";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}

	public function cambiar_estatus($id, $estatus) {
		$consulta = "UPDATE liga set estatus='".$estatus."' WHERE id='".$id."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}
}
?>