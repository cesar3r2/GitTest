<?php
	session_start();
	ob_start();
	include "conexionConf.php";
	include "include/php/common.php";
	include "clases/class.agencia.php";
	include "clases/class.apuesta.php";
	include "clases/class.notificacion.php";
	
	$id_agencia = $_SESSION['AGENCIA'];
	$perfil = $_SESSION["PERFIL_USUARIO"];
	$obj = new agencia();
	$fila = $obj->datos_agencia($id_agencia);
	
	$ayer = date("d/m/Y", strtotime("$hoy -1 day"));
	
	$objApuGan = new apuesta();
	$fApuGan = $objApuGan->buscar_apuestas_por_estatus($id_agencia, $ayer, 'GANADORA');
	
	$objApuPag = new apuesta();
	$fApuPag = $objApuPag->buscar_apuestas_por_estatus($id_agencia, $ayer, 'PAGADA');
	
	$objNot = new notificacion();
	$fNot = $objNot->listado_notificaciones();
	
?>
<?php
	if (($perfil == '1') || ($perfil == '2') || ($perfil == '3') || ($perfil == '4') || ($perfil == '5')) {
		$sw = 0;
		for ($i=0; $i<count($fNot); $i++) {
			if ($fNot[$i]['descripcion'] != '' && $fNot[$i]['estatus'] == 'ACTIVA')
				$sw = 1;
		}
		if ($sw == 1) {
		?>
		<table width="100%" align="center" cellpadding="1" cellspacing="1" border="0">
			<tr><td align="center" style="color: #2B58A5; font-size:11px"><strong>MENSAJES DEL ADMINISTRADOR</strong></td></tr>
            <tr><td align="center"></td></tr>
			<tr>
				<td align="left">
					<ul style="font-size:11px; margin:0px; padding:0px 5px 5px 10px; line-height:15px; list-style-image: url('imagenes/img12.gif');">
						<?php 
						for ($i=0; $i<count($fNot); $i++) {
							if ($fNot[$i]['descripcion'] != '' && $fNot[$i]['estatus'] == 'ACTIVA') { ?>
							<li><?php echo $fNot[$i]['descripcion'].'.'; ?></li>
						<?php
							}
						} ?>
					</ul>
				</td>
			</tr>
		</table>
		<?php
		} 
	}
	
	if ((($perfil == '1') || ($perfil == '2') || ($perfil == '5')) && ($sw == 0)) { ?>
		<table width="100%" align="center" cellpadding="1" cellspacing="1" border="0">
			<tr><td align="center" style="color: #2B58A5"><strong>Sin mensajes a mostrar</strong></td></tr>
		</table>
	<?php
	}
	?>
<?php
	if (($perfil == '3') || ($perfil == '4')) { ?>
    <table width="100%" align="center" cellpadding="1" cellspacing="1" border="0">
        <tr><td align="center" style="color: #2B58A5"><strong>TICKETS PREMIADOS</strong> (<?php echo fecha($ayer); ?>)</td></tr>
        <tr><td align="center"></td></tr>
        <tr>
            <td align="center"><strong style="color:#F00"><?php echo count($fApuGan);?></strong> Ticket(s) Ganador(es)</td>
        </tr>
        <tr>
            <td align="center"><strong style="color:#090"><?php echo count($fApuPag);?></strong> Ticket(s) Pagado(s)</td>
        </tr>
        <tr><td align="center"></td></tr>
    </table>
<?php
	}
?>
<br><br>