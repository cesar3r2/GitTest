<?php
class deporte {
	private $nombre;
	private $clave;
	private $tipo;
	
	var $_perfil1;
	
	function deporte() {
		include("configDb.php");
	}
	
	public function vista() {
		$consulta = "SELECT * FROM deporte ORDER BY id";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
}
?>