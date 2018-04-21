<?php
class auditoria {
	private $nombre;
	private $clave;
	private $tipo;
	
	var $_perfil1;
	
	function auditoria() {
		include("configDb.php");
	}
		
	public function registrar_inicio_sesion($datos){
		$consulta = "INSERT INTO auditoria.inicio_sesion (usuario, fecha, hora, ip) VALUES ('".$datos['USUARIO']."', '".$datos['FECHA']."', '".$datos['HORA']."', '".$datos['IP']."')";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}
}
?>