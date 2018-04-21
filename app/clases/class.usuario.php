<?php
class usuario {
	private $nombre;
	private $clave;
	private $tipo;
	
	var $_perfil1;
	
	function usuario() {
		include("configDb.php");
	}
	
	public function lista() {
		$consulta = "SELECT * FROM usuario ORDER BY usuario";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	public function lista_banquero($usuario) {
		$consulta = "SELECT * FROM usuario a, agencia b WHERE b.id_banquero='".$usuario."' AND b.id=a.id_agencia ORDER BY a.usuario";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	public function lista_pag($reg_pag, $pag_act) {
		$consulta = "SELECT usuario, nombre, tipo, estatus FROM usuario ORDER BY usuario LIMIT '".$reg_pag."' OFFSET '".$pag_act."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	public function lista_pag_banquero($usuario, $reg_pag, $pag_act) {
		$consulta = "SELECT a.usuario, a.nombre, a.tipo, a.estatus FROM usuario a, agencia b WHERE  b.id_banquero='".$usuario."' AND b.id=a.id_agencia ORDER BY a.usuario LIMIT '".$reg_pag."' OFFSET '".$pag_act."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	public function buscar_usuario($usuario) {
		$usuario = strtolower($usuario);
		$consulta = "SELECT * FROM usuario WHERE usuario='".$usuario."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function agregar($datos) {
		$consulta = "INSERT INTO usuario (usuario, clave, nombre, descripcion, tipo, estatus, id_agencia, cookie, nro_pcs) VALUES ('".$datos['USUARIO']."', '".base64_encode($datos['CLAVE'])."', '".$datos['NOMBRE']."', 'Ninguna', '".$datos['TIPO']."', '1', '".$datos['ID_AGENCIA']."', '".$datos['COOKIE']."', '".$datos['PCS']."')";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}
	
	public function modificar($datos) {
		$consulta = "UPDATE usuario SET clave='".base64_encode($datos['CLAVE'])."', nombre='".$datos['NOMBRE']."', tipo='".$datos['TIPO']."', id_agencia='".$datos['ID_AGENCIA']."', nro_pcs='".$datos['PCS']."' WHERE usuario='".$datos['USUARIO']."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}

	public function modificar_sin_clave($datos) {
		$consulta = "UPDATE usuario SET nombre='".$datos['NOMBRE']."', tipo='".$datos['TIPO']."', id_agencia='".$datos['ID_AGENCIA']."', nro_pcs='".$datos['PCS']."' WHERE usuario='".$datos['USUARIO']."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}
	
	public function cambiar_clave($usuario, $clave) {
		$consulta = "UPDATE usuario SET clave='".base64_encode($clave)."' WHERE usuario='".$usuario."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}
	
	public function eliminar($codigos) {
		$codigo = explode(',', $codigos);
		foreach($codigo as $id) {
			$consulta = "DELETE FROM usuario WHERE usuario IN('".$id."')";
			$resultado = $this->_perfil1->Execute($consulta);
		}
		$this->_perfil1->Close();
		return $resultado;
	}
	
	public function validar_usuario($nombre, $clave) {
		$usuario = strtolower($nombre);
		$consulta = "SELECT * FROM usuario WHERE usuario='".$usuario."' AND clave='".base64_encode($clave)."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function validar_usuario_cookie($nombre, $clave, $cookie) {
		$usuario = strtolower($nombre);
		$consulta = "SELECT * FROM usuario WHERE usuario='".$usuario."' AND clave='".base64_encode($clave)."' AND (cookie='-1' OR cookie LIKE ('%".$cookie."%'))";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function validar_agencia_tipo($agencia, $tipo) {
		$consulta = "SELECT * FROM usuario WHERE id_agencia='".$agencia."' AND tipo='".$tipo."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function busquedaUsuarios($buscar) {
		$consulta = "SELECT * FROM usuario";
		$indices = array('usuario', 'nombre');
		
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
	
	public function busquedaUsuarios_banquero($usuario, $buscar) {
		$consulta = "SELECT a.usuario, a.nombre, a.id_agencia, b.id FROM usuario a, agencia b";
		$indices = array('a.usuario', 'a.nombre');
		
		if($buscar != "") {
			$temp_condicion = $indices[0]." LIKE '%".$buscar."%'";
			for($i=1; $i<count($indices); $i++) {
				$temp_condicion.=" OR ".$indices[$i]." LIKE '%".$buscar."%'";
			}
			$consulta.=" WHERE b.id_banquero='".$usuario."' AND b.id=a.id_agencia AND (".$temp_condicion.")";
		}
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function actualizar_cookie($usuario, $valor) {
		$consulta = "UPDATE usuario SET cookie='".$valor."' WHERE usuario='".$usuario."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}
}
?>