<?php
class grupo {
	private $codigo;
	private $nombre;
	
	var $_perfil1;
	
	function grupo() {
		include("configDb.php");
	}
	
	public function lista() {
		$consulta = "SELECT * FROM grupo ORDER BY id, id_banquero";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}

	public function buscar_grupos($id_banquero) {
		$consulta = "SELECT * FROM grupo WHERE id_banquero='".$id_banquero."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function datos_grupo($id_grupo, $id_banquero) {
		$consulta = "SELECT * FROM grupo WHERE id='".$id_grupo."' AND id_banquero='".$id_banquero."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
}
?>