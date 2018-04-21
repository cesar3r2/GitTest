<?php
class taquilla {
	private $codigo;
	private $nombre;
	
	var $_perfil1;
	
	function taquilla() {
		include("configDb.php");
	}
	
	public function lista() {
		$consulta = "SELECT * FROM taquilla ORDER BY id_agencia";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	public function lista_pag($reg_pag, $pag_act) {
		$consulta = "SELECT id, id_agencia, nombre FROM taquilla ORDER BY id_agencia LIMIT '".$reg_pag."' OFFSET '".$pag_act."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	public function buscar_taquilla($codigo) {
		$consulta = "SELECT * FROM taquilla WHERE id='".$codigo."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	public function datos_taquilla($codigo) {
		$consulta = "SELECT * FROM taquilla WHERE id='".$codigo."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	public function agregar($datos) {
		$consulta = "INSERT INTO taquilla (id, id_agencia, nombre) VALUES ('".$datos['ID']."', '".$datos['ID_AGENCIA']."', '".$datos['NOMBRE']."')";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}
	
	public function proximo_codigo()
	{
		$consulta = "SELECT MAX(id) AS ultimo FROM taquilla";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function modificar($datos){
		$consulta = "UPDATE taquilla SET nombre='".$datos['NOMBRE']."' WHERE id='".$datos['ID']."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}
	
	public function eliminar($codigos) {
		$codigo = explode(',', $codigos);
		foreach($codigo as $id) {
			$consulta = "DELETE FROM taquilla WHERE id IN('".$id."')";
			$resultado = $this->_perfil1->Execute($consulta);
		}
		$this->_perfil1->Close();
		return $resultado;
	}
	
	public function busquedaTaquillas($buscar) {
		$consulta = "SELECT * FROM taquilla";
		$indices = array('nombre');
		
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