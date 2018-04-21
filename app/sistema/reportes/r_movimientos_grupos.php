<?php
	session_start();
	ob_start();
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../include/php/common.php";
	include "../../clases/class.apuesta.php";
	include "../../clases/class.agencia.php";
	include "../../clases/class.banquero.php";
	include "../../clases/class.grupo.php";
	
	$id_banquero = $_GET['banquero'];
	$grupo = $_GET['grupo'];
	$fDesde = fecha_sql($_GET['desde']);
	$fHasta = fecha_sql($_GET['hasta']);
	
	$objBan = new banquero();
	$fBan = $objBan->buscar_banquero($id_banquero);
	
	$objAg = new agencia();
	$fAg = $objAg->consultas_lista_banquero_grupo($id_banquero, $grupo);
	
	$objGru = new grupo();
	$fGru = $objGru->datos_grupo($grupo, $id_banquero);
?>
<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD width="50%" align="right">
			<?php barra_opciones3("", "imprimir('impresion')", "cambiar_contenido('sistema/reportes/movimientos_grupos.php', 'sub_contenido')");?>
		</TD>
	</TR>
</TABLE>
<BR>
<DIV id="impresion">
<?php echo $encabezado = encabezado_reporte($fBan[0]['nombre'], $id_banquero);?>
<BR>
<TABLE align="left" width="100%" border="0" cellpadding="1" cellspacing="1">
	<TR>
		<TD class="txtR10" align="center"><strong>Movimientos Registrados por el grupo: <?php echo $fGru[0]['nombre']?></strong></TD>
	</TR>
	<TR>
		<TD class="txtR9" align="center"><strong>Desde el </strong> <?php echo fecha($fDesde); ?> <strong>Hasta el </strong> <?php echo fecha($fHasta); ?></TD>
	</TR>
	<TR><TD height="10"></TD></TR>
</TABLE>
<BR>
<TABLE align="left" width="100%" border="0" cellpadding="4" cellspacing="0">
	<TR class="txtR9">
		<TD id="fRepT" width="25%" align="left"><strong>Nombre Agencia</strong></TD>
        <TD id="fRepT" width="15%" align="right"><strong>Registrados</strong></TD>
        <TD id="fRepT" width="15%" align="right"><strong>Válidos</strong></TD>
        <TD id="fRepT" width="15%" align="right"><strong>Anulados</strong></TD>
        <TD id="fRepT" width="15%" align="right"><strong>Ganadores</strong></TD>
        <TD id="fRepT" width="15%" align="right"><strong>Pagados</strong></TD>
	</TR>
<?php
	$totApu = $totAnu = $totGan = $totPag = 0;
	$cReg = $cAnu = $cGan = $cPag = 0;
	for ($i=0; $i<count($fAg); $i++) { 
		$objA = new apuesta();
		$fApu = $objA->buscar_apuestas_fecha($fDesde, $fHasta, $fAg[$i]['id']);
		
		$cRegistrada = $cAnulada = $cGanadora = $cPagada = 0;
		$montoApuestas = $montoAnulada = $montoGanadora = $montoPagada = 0;
		
		for($j=0; $j<count($fApu); $j++)
		{
			$cReg++;
			$cRegistrada++;
			$montoApuestas += $fApu[$j]['monto'];
			$totApu += $fApu[$j]['monto'];
			if ($fApu[$j]['estatus'] == 'ANULADA') {
				$cAnu++;
				$cAnulada++;
				$montoAnulada += $fApu[$j]['monto'];
				$totAnu += $fApu[$j]['monto'];
			} else if ($fApu[$j]['estatus'] == 'GANADORA') {
				$cGan++;
				$cGanadora++;
				$montoGanadora += $fApu[$j]['premio'];
				$totGan += $fApu[$j]['premio'];
			} else if ($fApu[$j]['estatus'] == 'PAGADA') {
				$cPag++;
				$cPagada++;
				$montoPagada += $fApu[$j]['premio'];
				$totPag += $fApu[$j]['premio'];
			}
		} ?>
	<TR class="txtR9">
		<TD id="fRep" align="left"><?php echo $fAg[$i]['nombre']; ?></TD>
        <TD id="fRep" align="right"><?php echo number_format($montoApuestas, 2, ',', '.'); ?> (<?php echo $cRegistrada; ?>)</TD>
        <TD id="fRep" align="right"><?php echo number_format($montoApuestas - $montoAnulada, 2, ',', '.'); ?> (<?php echo $cRegistrada - $cAnulada; ?>)</TD>
        <TD id="fRep" align="right"><?php echo number_format($montoAnulada, 2, ',', '.'); ?> (<?php echo $cAnulada; ?>)</TD>
        <TD id="fRep" align="right"><?php echo number_format($montoGanadora, 2, ',', '.'); ?> (<?php echo $cGanadora; ?>)</TD>
        <TD id="fRep" align="right"><?php echo number_format($montoPagada, 2, ',', '.'); ?> (<?php echo $cPagada; ?>)</TD>
	</TR>
<?php } ?>
	<TR class="txtR9">
		<TD id="fRep" align="left"><strong>Totales (BsF.)</strong></TD>
        <TD id="fRep" align="right"><strong><?php echo number_format($totApu, 2, ',', '.'); ?> (<?php echo $cReg; ?>)</strong></TD>
        <TD id="fRep" align="right"><strong><?php echo number_format($totApu - $totAnu, 2, ',', '.'); ?> (<?php echo $cReg - $cAnu; ?>)</strong></TD>
        <TD id="fRep" align="right"><strong><?php echo number_format($totAnu, 2, ',', '.'); ?> (<?php echo $cAnu; ?>)</strong></TD>
        <TD id="fRep" align="right"><strong><?php echo number_format($totGan, 2, ',', '.'); ?> (<?php echo $cGan; ?>)</strong></TD>
        <TD id="fRep" align="right"><strong><?php echo number_format($totPag, 2, ',', '.'); ?> (<?php echo $cPag; ?>)</strong></TD>
	</TR>
	<TR><TD colspan="6" height="15"></TD></TR>
</TABLE>
</DIV>