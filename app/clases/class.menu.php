<?php
	class menu {
		private $id;
		private $superior;
		private $descripcion;
		private $enlace;
		private $nivel;
		
		var $_perfil1;
		
		function menu() {
			include("configDb.php");
		}
		public function lista() {
			$consulta = "SELECT * FROM menu ORDER BY id";
			$resultado = $this->_perfil1->Execute($consulta);
			$datos = $resultado->GetArray();
			$this->_perfil1->Close();
			return $datos;
		}
		public function vistaMenu($perfil) {
			$consulta = "SELECT * FROM menu WHERE superior='0' AND id='".$perfil."' ORDER BY id";
			$resultado = $this->_perfil1->Execute($consulta);
 			$datos = $resultado->GetArray();
			$this->_perfil1->Close();
			return $datos;
		}
		public function vistaSubmenu($id, $perfil) {
			$con1 = "SELECT * FROM menu WHERE superior='".$id."' AND id='".$perfil."' ORDER BY id";
			$resultado = $this->_perfil1->Execute($con1);
  			$datos = $resultado->GetArray();
			$this->_perfil1->Close();
			return $datos;
		}
	}
?>