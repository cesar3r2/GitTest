<?php
class banquero {
	private $codigo;
	private $nombre;
	
	var $_perfil1;
	
	function banquero() {
		include("configDb.php");
	}
	
	public function lista() {
		$consulta = "SELECT * FROM banquero ORDER BY nombre";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function lista_banquero($usuario) {
		$consulta = "SELECT * FROM banquero WHERE cedula='".$usuario."' ORDER BY nombre";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function lista_pag($reg_pag, $pag_act) {
		$consulta = "SELECT cedula, nombre, telefono, correo FROM banquero ORDER BY nombre LIMIT '".$reg_pag."' OFFSET '".$pag_act."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function buscar_banquero($codigo) {
		$consulta = "SELECT * FROM banquero WHERE cedula='".$codigo."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function agregar($datos) {
		$consulta = "INSERT INTO banquero (cedula, nombre, direccion, telefono, correo) VALUES ('".$datos['CEDULA']."', '".$datos['NOMBRE']."', '".$datos['DIRECCION']."', '".$datos['TELEFONO']."', '".$datos['CORREO']."')";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}
	
	public function modificar($datos){
		$consulta = "UPDATE banquero SET nombre='".$datos['NOMBRE']."', direccion='".$datos['DIRECCION']."', telefono='".$datos['TELEFONO']."', correo='".$datos['CORREO']."' WHERE cedula='".$datos['CEDULA']."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}
	
	public function eliminar($codigos) {
		$codigo = explode(',', $codigos);
		foreach($codigo as $id) {
			$consulta = "DELETE FROM banquero WHERE cedula IN('".$id."')";
			$resultado = $this->_perfil1->Execute($consulta);
		}
		$this->_perfil1->Close();
		return $resultado;
	}
	
	public function busquedaBanqueros($buscar) {
		$consulta = "SELECT * FROM banquero";
		$indices = array('cedula', 'nombre', 'telefono', 'correo');
		
		if($buscar != "") {
			$temp_condicion = $indices[0]." LIKE '%".$buscar."%'";
			for($i=1; $i<count($indices); $i++) {
				$temp_condicion.=" OR ".$indices[$i]." LIKE '%".$buscar."%'";
			}
			$consulta.=" WHERE ".$temp_condicion;
		}
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
}
?>