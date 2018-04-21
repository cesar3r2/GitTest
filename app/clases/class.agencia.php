<?php
class agencia {
	private $codigo;
	private $nombre;
	
	var $_perfil1;
	
	function agencia() {
		include("configDb.php");
	}
	
	public function lista() {
		$consulta = "SELECT * FROM agencia ORDER BY nombre";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function lista_banquero($usuario) {
		$consulta = "SELECT * FROM agencia WHERE id_banquero='".$usuario."' ORDER BY nombre";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function lista_agencia($usuario) {
		$consulta = "SELECT a.id, a.nombre FROM agencia a, usuario b WHERE a.id=b.id_agencia AND b.usuario='".$usuario."' ORDER BY nombre";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function lista_pag($reg_pag, $pag_act) {
		$consulta = "SELECT id, nombre, telefono, premio_max, disponible, estatus FROM agencia ORDER BY nombre LIMIT '".$reg_pag."' OFFSET '".$pag_act."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function lista_pag_banquero($usuario, $reg_pag, $pag_act) {
		$consulta = "SELECT id, nombre, telefono, premio_max, disponible, estatus FROM agencia WHERE id_banquero='".$usuario."' ORDER BY nombre LIMIT '".$reg_pag."' OFFSET '".$pag_act."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}

	public function buscar_agencia($codigo) {
		$consulta = "SELECT * FROM agencia WHERE id='".$codigo."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function datos_agencia($codigo) {
		$consulta = "SELECT * FROM agencia WHERE id='".$codigo."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function agregar($datos) {
		$consulta = "INSERT INTO agencia (id, nombre, ci_rif, direccion, telefono, correo, id_estado, ciudad, disponible, premio_max, porcentaje_venta, porcentaje_utilidad, id_banquero, estatus, porcentaje_derecho, monto_max, monto_derecho, id_grupo, monto_min) VALUES ('".$datos['ID_AGENCIA']."', '".$datos['NOMBRE']."', '".$datos['RIF']."', '".$datos['DIRECCION']."', '".$datos['TELEFONO']."', '".$datos['EMAIL']."', '".$datos['ID_ESTADO']."', '".$datos['CIUDAD']."', '".$datos['DISPONIBLE']."', '".$datos['PREMIO_MAX']."', '".$datos['POR_VENTA']."', '".$datos['POR_UTILIDAD']."', '".$datos['BANQUERO']."', '".$datos['ESTATUS']."', '".$datos['POR_DERECHO']."', '".$datos['MONTO_MAX']."', '".$datos['MONTO_DERECHO']."', '".$datos['GRUPO']."', '".$datos['MONTO_MIN']."')";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}
	
	public function proximo_codigo()
	{
		$consulta = "SELECT MAX(id) AS ultimo FROM agencia";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function modificar($datos){
		$consulta = "UPDATE agencia SET nombre='".$datos['NOMBRE']."', ci_rif='".$datos['RIF']."', direccion='".$datos['DIRECCION']."', telefono='".$datos['TELEFONO']."', correo='".$datos['EMAIL']."', id_estado='".$datos['ID_ESTADO']."', ciudad='".$datos['CIUDAD']."', disponible='".$datos['DISPONIBLE']."', premio_max='".$datos['PREMIO_MAX']."', porcentaje_venta='".$datos['POR_VENTA']."', porcentaje_utilidad='".$datos['POR_UTILIDAD']."', id_banquero='".$datos['BANQUERO']."', estatus='".$datos['ESTATUS']."', porcentaje_derecho='".$datos['POR_DERECHO']."', monto_max='".$datos['MONTO_MAX']."', monto_derecho='".$datos['MONTO_DERECHO']."', id_grupo='".$datos['GRUPO']."', monto_min='".$datos['MONTO_MIN']."' WHERE id='".$datos['ID_AGENCIA']."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}

	public function modificar_mi_agencia($datos){
		$consulta = "UPDATE agencia SET nombre='".$datos['NOMBRE']."', direccion='".$datos['DIRECCION']."', telefono='".$datos['TELEFONO']."', correo='".$datos['EMAIL']."', disponible='".$datos['DISPONIBLE']."', monto_max='".$datos['MONTO_MAX']."', premio_max='".$datos['PREMIO_MAX']."', monto_derecho='".$datos['MONTO_DERECHO']."', monto_min='".$datos['MONTO_MIN']."' WHERE id='".$datos['ID_AGENCIA']."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}
	
	public function eliminar($codigos) {
		$codigo = explode(',', $codigos);
		foreach($codigo as $id) {
			$consulta = "DELETE FROM agencia WHERE id IN('".$id."')";
			$resultado = $this->_perfil1->Execute($consulta);
		}
		$this->_perfil1->Close();
		return $resultado;
	}
	
	public function busquedaAgencias($buscar) {
		$consulta = "SELECT * FROM agencia";
		$indices = array('nombre', 'telefono', 'estatus');
		
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
	
	public function busquedaAgencias_banqueros($usuario, $buscar) {
		$consulta = "SELECT * FROM agencia";
		$indices = array('nombre', 'telefono', 'estatus');
		
		if($buscar != "") {
			$temp_condicion = $indices[0]." LIKE '%".$buscar."%'";
			for($i=1; $i<count($indices); $i++) {
				$temp_condicion.=" OR ".$indices[$i]." LIKE '%".$buscar."%'";
			}
			$consulta.=" WHERE id_banquero='".$usuario."' AND (".$temp_condicion.")";
		}
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	// MODULOS DE CONSULTAS Y REPORTES
	public function consultas_lista() {
		$consulta = "SELECT * FROM agencia WHERE estatus='ACTIVA' ORDER BY nombre";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function consultas_lista_banquero($usuario) {
		$consulta = "SELECT * FROM agencia WHERE  estatus='ACTIVA' AND id_banquero='".$usuario."' ORDER BY nombre";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function consultas_lista_agencia($usuario) {
		$consulta = "SELECT a.id, a.nombre FROM agencia a, usuario b WHERE a.estatus='ACTIVA' AND a.id=b.id_agencia AND b.usuario='".$usuario."' ORDER BY nombre";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function consultas_lista_banquero_grupo($banquero, $grupo) {
		$consulta = "SELECT * FROM agencia WHERE estatus='ACTIVA' AND id_banquero='".$banquero."' AND id_grupo='".$grupo."' ORDER BY nombre";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
}
?>