<?php
class perfil {
	private $id;
	private $nombre;
	private $acceso;
	
	var $_perfil1;
	
	function perfil() {
		include("configDb.php");
	}
	
	public function lista() {
		$consulta = "SELECT * FROM perfil ORDER BY id";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	public function lista_banquero() {
		$consulta = "SELECT * FROM perfil WHERE id IN ('3', '4') ORDER BY id";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	public function lista_pag($reg_pag, $pag_act) {
		$consulta = "SELECT id, nombre FROM perfil ORDER BY id LIMIT '".$reg_pag."' OFFSET '".$pag_act."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	public function buscar_perfil($id) {
		$consulta = "SELECT * FROM perfil WHERE id='".$id."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function agregar($datos) {
		$consulta = "INSERT INTO perfil (id, nombre, acceso_menu) VALUES ('".$datos['ID']."', '".$datos['NOMBRE']."', '".$datos['ACCESO']."')";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}
	
	public function modificar($datos){
		$consulta = "UPDATE perfil SET nombre='".$datos['NOMBRE']."', acceso_menu='".$datos['ACCESO']."' WHERE id='".$datos['ID']."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}
	
	public function eliminar($codigos) {
		$codigo = explode(',', $codigos);
		foreach($codigo as $id) {
			$consulta = "DELETE FROM perfil WHERE id IN('".$id."')";
			$resultado = $this->_perfil1->Execute($consulta);
		}
		$this->_perfil1->Close();
		return $resultado;
	}
	
	public function busquedaPerfiles($buscar) {
		$consulta = "SELECT * FROM perfil";
		$indices = array('id', 'nombre');
		
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