<?php
class apuesta {
	
	var $_perfil1;
	
	function apuesta() {
		include("configDb.php");
	}
	
	public function registrar($datos)
	{
		$consulta = "INSERT INTO apuesta (id, fecha, hora, monto, premio, estatus, id_seguridad, tipo, id_agencia, usuario) VALUES ('".$datos['ID']."', '".$datos['FECHA']."', '".$datos['HORA']."', '".$datos['MONTO']."', '".$datos['PREMIO']."', '".$datos['ESTATUS']."', '".$datos['ID_SEGURIDAD']."', '".$datos['TIPO']."', '".$datos['ID_AGENCIA']."', '".$datos['USUARIO']."')";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}
	
	public function registrar_detalles($id_apuesta, $id_deporte, $id_logro, $campo_logro, $equipo, $nro_logro, $des_logro, $estatus)
	{
		$consulta = "INSERT INTO apuesta_detalle (id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES ('".$id_apuesta."', '".$id_deporte."', '".$id_logro."', '".$campo_logro."', '".$equipo."', '".$nro_logro."', '".$des_logro."', '".$estatus."')";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}

	public function proximo_codigo()
	{
		$consulta = "SELECT MAX(id) AS ultimo FROM apuesta";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function ver_apuesta($id)
	{
		$consulta = "SELECT * FROM apuesta WHERE id='".$id."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function ver_apuesta_detalle($id_apuesta)
	{
		$consulta = "SELECT * FROM apuesta_detalle WHERE id_apuesta='".$id_apuesta."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function apuestas_diarias_reportes($fDesde, $fHasta, $tipo, $id_agencia) {
		if ($tipo != 'TODOS')
			$consulta = "SELECT * FROM apuesta WHERE estatus='".$tipo."' AND id_agencia='".$id_agencia."' AND fecha BETWEEN '".$fDesde."' AND '".$fHasta."' ORDER BY id";
		else
			$consulta = "SELECT * FROM apuesta WHERE id_agencia='".$id_agencia."' AND fecha BETWEEN '".$fDesde."' AND '".$fHasta."' ORDER BY id";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function buscar_apuestas_fecha($fDesde, $fHasta, $id_agencia) {
		$consulta = "SELECT * FROM apuesta WHERE id_agencia='".$id_agencia."' AND fecha BETWEEN '".$fDesde."' AND '".$fHasta."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function buscar_ticket($datos)
	{
		if ($datos['PERFIL_USR'] == 1)
			$consulta = "SELECT *, a.estatus estatus_apu, b.estatus estatus_det FROM apuesta a, apuesta_detalle b WHERE a.id='".$datos['ID_TICKET']."' AND a.id_seguridad='".$datos['ID_SEGURIDAD']."' AND a.id=b.id_apuesta";
		else
			$consulta = "SELECT *, a.estatus estatus_ap, b.estatus estatus_det FROM apuesta a, apuesta_detalle b WHERE a.id='".$datos['ID_TICKET']."' AND a.id_seguridad='".$datos['ID_SEGURIDAD']."' AND a.id=b.id_apuesta AND id_agencia='".$datos['ID_AGENCIA']."'";	
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}

	// PERMITIR ANULAR CUALQUIER TICKET
	public function buscar_ticket2($datos)
	{
		$consulta = "SELECT *, a.estatus estatus_ap, b.estatus estatus_det FROM apuesta a, apuesta_detalle b WHERE a.id='".$datos['ID_TICKET']."' AND a.id_seguridad='".$datos['ID_SEGURIDAD']."' AND a.id=b.id_apuesta";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function buscar_datos_ticket($id_apuesta, $id_seguridad, $id_agencia)
	{
		$consulta = "SELECT * FROM apuesta WHERE id='".$id_apuesta."' AND id_seguridad='".$id_seguridad."' AND id_agencia='".$id_agencia."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}

	public function anular_ticket($datos)
	{
		$consulta = "UPDATE apuesta SET estatus='".$datos['ESTATUS']."' WHERE id='".$datos['ID_TICKET']."' AND id_seguridad='".$datos['ID_SEGURIDAD']."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function anular_ticket_detalles($datos)
	{
		$consulta = "UPDATE apuesta_detalle SET estatus='".$datos['ESTATUS']."' WHERE id_apuesta='".$datos['ID_TICKET']."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $datos;
	}

	public function pagar_ticket($datos)
	{
		$consulta = "UPDATE apuesta SET estatus='".$datos['ESTATUS']."' WHERE id='".$datos['ID_TICKET']."' AND id_seguridad='".$datos['ID_SEGURIDAD']."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function pagar_ticket_detalles($datos)
	{
		$consulta = "UPDATE apuesta_detalle SET estatus='".$datos['ESTATUS']."' WHERE id_apuesta='".$datos['ID_TICKET']."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function buscar_apuestas_deportes($datos)
	{
		$consulta = "SELECT a.id AS nro_ticket, b.id, b.id_logro, a.id_seguridad, a.fecha, a.hora, a.monto, a.premio, b.campo_logro, b.equipo, b.nro_logro FROM apuesta a, apuesta_detalle b WHERE a.fecha='".$datos['FECHA']."' AND a.id=b.id_apuesta AND b.id_deporte='".$datos['DEPORTE']."' ORDER BY a.id, b.id";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function apuestas_diaria_deporte($fecha, $deporte) {
		$consulta = "SELECT distinct(a.id), a.monto, a.premio FROM apuesta a, apuesta_detalle b WHERE a.fecha='".$fecha."' AND b.id_deporte='".$deporte."' AND a.id=b.id_apuesta ORDER BY a.id";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function actualizar_ticket_ganador($id_apuesta, $estatus)
	{
		$consulta = "UPDATE apuesta SET estatus='".$estatus."' WHERE id='".$id_apuesta."' AND estatus NOT IN ('PAGADA', 'ANULADA')";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function actualizar_ticket_ganador_detalles($id_apuesta, $estatus)
	{
		$consulta = "UPDATE apuesta_detalle SET estatus='".$estatus."' WHERE id_apuesta='".$id_apuesta."' AND estatus NOT IN ('PAGADA', 'ANULADA')";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $datos;
	}

	
	public function apuesta_beisbol_resultado($datos) {
		$consulta = "SELECT distinct(id) FROM apuesta_beisbol_resultado WHERE fecha='".$datos['FECHA']."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function buscar_apuesta_beisbol_resultado($id) {
		$consulta = "SELECT * FROM apuesta_beisbol_resultado WHERE id='".$id."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function apuesta_basquetbol_resultado($datos) {
		$consulta = "SELECT distinct(id) FROM apuesta_basquetbol_resultado WHERE fecha='".$datos['FECHA']."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function buscar_apuesta_basquetbol_resultado($id) {
		$consulta = "SELECT * FROM apuesta_basquetbol_resultado WHERE id='".$id."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function apuesta_futbol_resultado($datos) {
		$consulta = "SELECT distinct(id) FROM apuesta_futbol_resultado WHERE fecha='".$datos['FECHA']."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function buscar_apuesta_futbol_resultado($id) {
		$consulta = "SELECT * FROM apuesta_futbol_resultado WHERE id='".$id."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function premios_diarios($fecha, $id_agencia)
	{
		$consulta = "SELECT SUM(premio) AS total_premios, SUM(monto) AS total_ventas FROM apuesta WHERE fecha='".$fecha."' AND id_agencia='".$id_agencia."' AND estatus='PENDIENTE'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function actualizar_apuestas_procesos($fecha, $estatus) {
		$consulta = "UPDATE apuesta SET estatus='".$estatus."' WHERE fecha='".$fecha."' AND estatus NOT IN ('PAGADA', 'ANULADA')";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function actualizar_apuestas_detalles_procesos($id_apuesta, $estatus) {
		$consulta = "UPDATE apuesta_detalle SET estatus='".$estatus."' WHERE id_apuesta='".$id_apuesta."' estatus NOT IN ('PAGADA', 'ANULADA')";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function actualizar_apuestas_perdedoras($fecha, $estatus) {
		$consulta = "UPDATE apuesta SET estatus='".$estatus."' WHERE fecha='".$fecha."' AND estatus='PENDIENTE'";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function actualizar_apuestas_detalles_perdedoras($id_apuesta, $estatus) {
		$consulta = "UPDATE apuesta_detalle SET estatus='".$estatus."' WHERE id_apuesta='".$id_apuesta."' AND estatus='PENDIENTE'";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function ver_apuestas_diarias_procesos($fecha) {
		$consulta = "SELECT * FROM apuesta WHERE fecha='".$fecha."' AND estatus NOT IN ('PAGADA', 'ANULADA') ORDER BY id";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function apuestas_a_anular($datos) {
		if ($datos['APUESTAS'] == 'JC')
			$consulta = "SELECT b.* FROM apuesta a, apuesta_detalle b WHERE a.estatus='".$datos['ESTATUS']."' AND b.id_deporte='".$datos['DEPORTE']."' AND b.id_logro='".$datos['ENCUENTRO']."' AND a.id=b.id_apuesta";
		else
			$consulta = "SELECT b.* FROM apuesta a, apuesta_detalle b WHERE a.estatus='".$datos['ESTATUS']."' AND b.id_deporte='".$datos['DEPORTE']."' AND b.id_logro='".$datos['ENCUENTRO']."' AND b.campo_logro IN ('".$datos['APUESTAS']."') AND a.id=b.id_apuesta";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function revertir_jugadas_anuladas($id, $id_apuesta, $id_deporte, $id_logro, $campo_logro, $equipo, $nro_logro, $des_logro, $estatus)
	{
		$consulta = "INSERT INTO apuesta_detalle (id, id_apuesta, id_deporte, id_logro, campo_logro, equipo, nro_logro, descripcion_logro, estatus) VALUES ('".$id."', '".$id_apuesta."', '".$id_deporte."', '".$id_logro."', '".$campo_logro."', '".$equipo."', '".$nro_logro."', '".$des_logro."', '".$estatus."')";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $resultado;
	}
	
	public function eliminar_jugada($id, $id_apuesta) {
		$consulta = "DELETE FROM apuesta_detalle WHERE id='".$id."' AND id_apuesta='". $id_apuesta."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $datos;
	}
	
	// MODULOS DE CONSULTAS Y REPORTES
	public function apuestas_diarias_consultas($fDesde, $fHasta, $tipo) {
		if ($tipo != 'TODOS')
			$consulta = "SELECT * FROM apuesta WHERE estatus='".$tipo."' AND fecha BETWEEN '".$fDesde."' AND '".$fHasta."' ORDER BY id";
		else
			$consulta = "SELECT * FROM apuesta WHERE fecha BETWEEN '".$fDesde."' AND '".$fHasta."' ORDER BY id";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function apuestas_diarias_reportes2($fDesde, $fHasta, $tipo) {
		if ($tipo != 'TODOS')
			$consulta = "SELECT * FROM apuesta WHERE estatus='".$tipo."' AND fecha BETWEEN '".$fDesde."' AND '".$fHasta."' ORDER BY id";
		else
			$consulta = "SELECT * FROM apuesta WHERE fecha BETWEEN '".$fDesde."' AND '".$fHasta."' ORDER BY id";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function actualizar_premio($id, $premio) {
		$consulta = "UPDATE apuesta SET premio='".$premio."' WHERE id='".$id."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $datos;
	}
	
	// MODULO DE NOTIFICACIONES
	
	public function buscar_apuestas_por_estatus($id_agencia, $fecha, $estatus) {
		$consulta = "SELECT * FROM apuesta WHERE id_agencia='".$id_agencia."' AND fecha='".$fecha."' AND estatus='".$estatus."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	// FUNCIONES PARA PROCESAR TICKETS GANADORES
	
	public function buscar_apuestas_no_procesadas() {
		$consulta = "SELECT * FROM apuesta_detalle WHERE estatus NOT IN ('PAGADA', 'ANULADA') ORDER BY id";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	// FUNCIONES PARA PROCESAR APUESTAS
	
	public function procesar_apuestas_detalles() {
		$consulta = "SELECT * FROM procesar_apuestas_detalles()";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function buscar_apuestas_estatus($estatus) {
		$consulta = "SELECT * FROM apuesta WHERE estatus='".$estatus."'";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function actualizar_estatus_apuestas($id, $estatus) {
		$consulta = "UPDATE apuesta SET estatus='".$estatus."' WHERE id='".$id."'";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function actualizar_estatus_apuestas_detalles($jugada, $apuestas, $id_deporte, $id_logro, $estatus) {
		if ($jugada == 'JC')
			$consulta = "UPDATE apuesta_detalle SET estatus='".$estatus."' WHERE id_deporte='".$id_deporte."' AND id_logro='".$id_logro."'";
		else
			$consulta = "UPDATE apuesta_detalle SET estatus='".$estatus."' WHERE id_deporte='".$id_deporte."' AND id_logro='".$id_logro."'  AND campo_logro IN ('".$apuestas."') ";
		$resultado = $this->_perfil1->Execute($consulta);
		$this->_perfil1->Close();
		return $datos;
	}
	
	public function jugadas_anuladas_revertir($datos) {
		if ($datos['APUESTAS'] == 'JC')
			$consulta = "SELECT b.* FROM apuesta a, apuesta_detalle b WHERE b.estatus='ANULADA' AND b.id_deporte='".$datos['DEPORTE']."' AND b.id_logro='".$datos['ENCUENTRO']."' AND a.id=b.id_apuesta";
		else
			$consulta = "SELECT b.* FROM apuesta a, apuesta_detalle b WHERE b.estatus='ANULADA' AND b.id_deporte='".$datos['DEPORTE']."' AND b.id_logro='".$datos['ENCUENTRO']."' AND b.campo_logro IN ('".$datos['APUESTAS']."') AND a.id=b.id_apuesta";
		$resultado = $this->_perfil1->Execute($consulta);
 		$datos = $resultado->GetArray();
		$this->_perfil1->Close();
		return $datos;
	}
}
?>