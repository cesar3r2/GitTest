<?php
class empresa {
	private $nombre;
	private $clave;
	private $tipo;
	
	var $_perfil1;
	
	function empresa() {
		include("configDb.php");
	}
	
	public function lista() {
		$consulta = "SELECT * FROM empresa ORDER BY nombre";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function modificar($datos){
		$consulta = "UPDATE empresa SET nombre='".$datos['NOMBRE']."', nombre_comercial='".$datos['NOMBRE_COMERCIAL']."', direccion='".$datos['DIRECCION']."', telefono='".$datos['TELEFONO']."' WHERE rif='".$datos['RIF']."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}
	
	public function buscar_empresa($datos) {
		$consulta = "SELECT * FROM empresa WHERE rif='".$datos['RIF']."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
}
?>