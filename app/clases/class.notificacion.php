<?php
class notificacion {
	private $nombre;
	private $clave;
	private $tipo;
	
	var $_perfil1;
	
	function notificacion() {
		include("configDb.php");
	}
	
	public function listado_notificaciones() {
		$consulta = "SELECT * FROM notificacion ORDER BY id";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function datos_notificacion($id) {
		$consulta = "SELECT * FROM notificacion WHERE id='".$id."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function modificar_notificacion($datos) {
		$consulta = "UPDATE notificacion SET descripcion='".$datos['DESCRIPCION']."', estatus='".$datos['ESTATUS']."' WHERE id='".$datos['ID']."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}
}
?>