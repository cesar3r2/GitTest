<?php
class estado {
	private $codigo;
	private $nombre;
	
	var $_perfil1;
	
	function estado() {
		include("configDb.php");
	}
	
	public function lista() {
		$consulta = "SELECT * FROM estado ORDER BY nombre";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
}
?>