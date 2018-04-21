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
	
	$objA = new apuesta();
	if ($id_agencia != 'TODAS') {
		$fApu = $objA->apuestas_diarias_reportes($fDesde, $fHasta, $tipo, $id_agencia);
	} else {
		$fApu = $objA->apuestas_diarias_reportes2($fDesde, $fHasta, $tipo);
	}
	
	if ($id_agencia != 'TODAS') {
		$objAg = new agencia();
		$fAg = $objAg->datos_agencia($id_agencia);
		$agencia = strtoupper($fAg[0]['nombre']);
		$rif = $fAg[0]['ci_rif'];
	} else {
		$agencia = 'TODAS';
		$rif = '000000000';
	}
?>
<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD width="50%" align="right">
			<?php barra_opciones3("", "imprimir('impresion')", "cambiar_contenido('sistema/reportes/apuestas.php', 'sub_contenido')");?>
		</TD>
	</TR>
</TABLE>
<BR>
<DIV id="impresion">
<?php echo $encabezado = encabezado_reporte($agencia, $rif);?>
<BR>
<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD class="txtR10" colspan="2" align="center"><strong>Apuestas Registradas (Estatus: <?php echo $tipo; ?>)</strong></TD>
	</TR>
	<TR>
		<TD class="txtR9" align="center"><strong>Desde el </strong> <?php echo fecha($fDesde); ?> <strong>Hasta el </strong> <?php echo fecha($fHasta); ?></TD>
	</TR>
    <TR><TD height="10"></TD></TR>
</TABLE>
<BR>
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="0">
	<TR class="txtR9">
		<TD id="fRepT" width="15%" align="left"><strong>Nro. Ticket</strong></TD>
		<TD id="fRepT" width="20%" align="left"><strong>Nro. Seguridad</strong></TD>
        <TD id="fRepT" width="18%" align="left"><strong>Fecha</strong></TD>
        <TD id="fRepT" width="12%" align="left"><strong>Hora</strong></TD>
		<TD id="fRepT" width="15%" align="right"><strong>Monto (BsF)</strong></TD>
        <TD id="fRepT" width="20%" align="right"><strong>Premio (BsF)</strong></TD>
	</TR>
	<?php
	for($i=0; $i<count($fApu); $i++) { ?>
	<TR class="txtR9">
		<TD id="fRep" align="left"><?php echo $fApu[$i]['id']; ?></TD>
        <TD id="fRep" align="left"><?php echo $fApu[$i]['id_seguridad']; ?></TD>
        <TD id="fRep" align="left"><?php echo fecha($fApu[$i]['fecha']); ?></TD>
		<TD id="fRep" align="left"><?php echo $fApu[$i]['hora']; ?></TD>
		<TD id="fRep" align="right"><?php echo number_format($fApu[$i]['monto'], 2, ',', '.'); $montoTot += $fApu[$i]['monto']; ?></TD>
		<TD id="fRep" align="right"><?php echo number_format($fApu[$i]['premio'], 2, ',', '.'); $montoPre += $fApu[$i]['premio']; ?></TD>
	</TR>			
<?php } ?>
	<TR class="txtR9">
    	<TD id="fRep" align="left"><strong>(<?php echo count($fApu);?> Reg.)</strong></TD>
    	<TD id="fRep" align="right" colspan="3"><strong>Totales (BsF)</strong></TD>
        <TD id="fRep" align="right"><strong><?php echo number_format($montoTot, 2, ',', '.'); ?></strong></TD>
        <TD id="fRep" align="right"><strong><?php echo number_format($montoPre, 2, ',', '.'); ?></strong></TD>
    </TR>
	<TR><TD colspan="6" height="15"></TD></TR>
</TABLE>
</DIV>