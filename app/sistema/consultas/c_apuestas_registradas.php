<?php
	session_start();
	ob_start();
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../include/php/common.php";
	include "../../clases/class.apuesta.php";
	include "../../clases/class.agencia.php";
	
	$id_agencia = $_GET['agencia'];
	$fDesde = fecha_sql($_GET['desde']);
	$fHasta = fecha_sql($_GET['hasta']);
	$tipo = $_GET['tipo'];
	
	if ($id_agencia != 'TODAS') {
		$objAg = new agencia();
		$fAg = $objAg->datos_agencia($id_agencia);
		$agencia = strtoupper($fAg[0]['nombre']);
	} else {
		$agencia = 'TODAS';
	}
	
	$objApu = new apuesta();
	if ($id_agencia != 'TODAS')
		$fApu = $objApu->apuestas_diarias_reportes($fDesde, $fHasta, $tipo, $id_agencia);
	else
		$fApu = $objApu->apuestas_diarias_consultas($fDesde, $fHasta, $tipo);
		
?>
<?php barra_opciones3("", "imprimir('impresion')", "cambiar_contenido('sistema/consultas/apuestas_registradas.php', 'sub_contenido')"); ?>

<DIV id="impresion">
<TABLE align="left" width="100%" border="0" cellpadding="1" cellspacing="1">
	<THEAD>
    <TR><TD align="center" colspan="8">
    		<FONT style="color : #2B58A5; font-size:16px"><strong>Apuestas Registradas</strong></FONT><BR>
            <FONT style="color : #2B58A5;"><strong>Agencia <?php echo $agencia; ?> (Estatus: <?php echo $tipo; ?>)</strong></FONT><BR>
            <FONT style="color : #2B58A5;">Desde el <?php echo fecha($fDesde); ?> Hasta el <?php echo fecha($fHasta); ?></FONT><BR>
        </TD>
    </TR>
    <TR><TD colspan="8" height="16px"></TD></TR>
	</THEAD>
<?php if (count($fApu) == 0){?>
	<TR bgcolor="#F3F3F3">
		<TD height="22" style="color: #F00;" colspan='8' align="center">No existen apuestas registradas para las opciones seleccionadas</TD>
	</TR>
<?php } else {
		for($i=0; $i<count($fApu); $i++) {
			switch($fApu[$i]['estatus']) {
				case 'PENDIENTE': $colorEstApu = '#333333'; break;
				case 'GANADORA': $colorEstApu = '#006600'; break;
				case 'PERDEDORA': $colorEstApu = '#CC0000'; break;
				case 'PAGADA': $colorEstApu = '#E46F29'; break;
				case 'ANULADA': $colorEstApu = '#036'; break;
			}
	?>
    <TR bgcolor="#328AA4">
    	<TD width="14%" align="center" style="color: #FFFFFF"><strong>Nro. Ticket</strong></TD>
        <TD width="14%" align="center" style="color: #FFFFFF"><strong>Nro. Seg.</strong></TD>
		<TD width="14%" align="center" style="color: #FFFFFF"><strong>Fecha</strong></TD>
        <TD width="12%" align="center" style="color: #FFFFFF"><strong>Hora</strong></TD>
        <TD width="12%" align="center" style="color: #FFFFFF"><strong>Monto</strong></TD>
        <TD width="14%" align="center" style="color: #FFFFFF"><strong>Premio</strong></TD>
        <TD width="20%" align="center" style="color: #FFFFFF"><strong>Estatus</strong></TD>
	</TR>
	<TR bgcolor="#F5F5F5" style="color: #333">
		<TD align="center"><?php echo $fApu[$i]['id']; ?></TD>
        <TD align="center"><?php echo $fApu[$i]['id_seguridad']; ?></TD>
		<TD align="center"><?php echo fecha($fApu[$i]['fecha']); ?></TD>
        <TD align="center"><?php echo $fApu[$i]['hora']; ?></TD>
        <TD align="center"><?php echo number_format($fApu[$i]['monto'], 2, ',', '.'); ?></TD>
        <TD align="center"><?php echo number_format($fApu[$i]['premio'], 2, ',', '.'); ?></TD>
        <TD align="center" style="color: <?php echo $colorEstApu; ?>"><strong><?php echo $fApu[$i]['estatus']; ?></strong></TD>
	</TR>
	<?php }
    } ?>
</TABLE>
</DIV>