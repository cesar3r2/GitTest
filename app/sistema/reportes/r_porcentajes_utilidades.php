<?php
	session_start();
	ob_start();
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../include/php/common.php";
	include "../../clases/class.apuesta.php";
	include "../../clases/class.agencia.php";
	include "../../clases/class.banquero.php";
	
	$id_banquero = $_GET['banquero'];
	$fDesde = fecha_sql($_GET['desde']);
	$fHasta = fecha_sql($_GET['hasta']);
	
	$objBan = new banquero();
	$fBan = $objBan->buscar_banquero($id_banquero);
	
	$objAg = new agencia();
	$fAg = $objAg->consultas_lista_banquero($id_banquero);
?>
<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD width="50%" align="right">
			<?php barra_opciones3("", "imprimir('impresion')", "cambiar_contenido('sistema/reportes/porcentajes_utilidades.php', 'sub_contenido')");?>
		</TD>
	</TR>
</TABLE>
<BR>
<DIV id="impresion">
<?php echo $encabezado = encabezado_reporte($fBan[0]['nombre'], $id_banquero);?>
<BR>
<TABLE align="left" width="100%" border="0" cellpadding="1" cellspacing="1">
	<TR>
		<TD class="txtR10" align="center"><strong>Pocentajes de Utilidades de las Agencias</strong></TD>
	</TR>
	<TR>
		<TD class="txtR9" align="center"><strong>Desde el </strong> <?php echo fecha($fDesde); ?> <strong>Hasta el </strong> <?php echo fecha($fHasta); ?></TD>
	</TR>
	<TR><TD height="10"></TD></TR>
</TABLE>
<BR>
<TABLE align="left" width="100%" border="0" cellpadding="4" cellspacing="0">
	<TR class="txtR9">
		<TD id="fRepT" width="20%" align="left"><strong>Nombre Agencia</strong></TD>
        <TD id="fRepT" width="17%" align="right"><strong>Monto Ventas</strong></TD>
        <TD id="fRepT" width="17%" align="right"><strong>Monto Pagados</strong></TD>
        <TD id="fRepT" width="17%" align="right"><strong>Monto Utilidad</strong></TD>
        <TD id="fRepT" width="12%" align="right"><strong>Porcentaje</strong></TD>
        <TD id="fRepT" width="17%" align="right"><strong>Monto Agencia</strong></TD>
	</TR>
<?php
	$totApu = $totAnu = $totPag = 0;
	$totAgencias = 0;
	
	for ($i=0; $i<count($fAg); $i++) { 
		$objA = new apuesta();
		$fApu = $objA->buscar_apuestas_fecha($fDesde, $fHasta, $fAg[$i]['id']);
		
		$montoApuestas = $montoAnulada = $montoPagAg = 0;
		
		for($j=0; $j<count($fApu); $j++)
		{
			$montoApuestas += $fApu[$j]['monto'];
			$totApu += $fApu[$j]['monto'];
			
			if ($fApu[$j]['estatus'] == 'ANULADA') {
				$montoAnulada += $fApu[$j]['monto'];
				$totAnu += $fApu[$j]['monto'];
			}
			
			if ($fApu[$j]['estatus'] == 'PAGADA'){
				$montoPagAg += $fApu[$j]['premio'];
				$totPag += $fApu[$j]['premio'];
			}
		}
		
		$montoVentas = $montoApuestas - $montoAnulada;
		$montoUtilidad = $montoVentas - $montoPagAg;
		$porcentaje =  $fAg[$i]['porcentaje_utilidad'];
		$montoAgencia = $montoUtilidad * $porcentaje / 100;
		
		$totVentas = $totApu - $totAnu;
		$totUtilidad += $montoUtilidad;
		$totAgencias += $montoAgencia;
	?>
	<TR class="txtR9">
		<TD id="fRep" align="left"><?php echo $fAg[$i]['nombre']; ?></TD>
        <TD id="fRep" align="right"><?php echo number_format($montoVentas, 2, ',', '.'); ?></TD>
        <TD id="fRep" align="right"><?php echo number_format($montoPagAg, 2, ',', '.'); ?></TD>
        <TD id="fRep" align="right"><?php echo number_format($montoUtilidad, 2, ',', '.'); ?></TD>
        <TD id="fRep" align="right"><?php echo $porcentaje; ?>%</TD>
        <TD id="fRep" align="right"><?php echo number_format($montoAgencia, 2, ',', '.'); ?></TD>
	</TR>
<?php } ?>
	<TR class="txtR9">
		<TD id="fRep" align="left"><strong>Totales (BsF.)</strong></TD>
        <TD id="fRep" align="right"><strong><?php echo number_format($totVentas, 2, ',', '.'); ?></strong></TD>
        <TD id="fRep" align="right"><strong><?php echo number_format($totPag, 2, ',', '.'); ?></strong></TD>
        <TD id="fRep" align="right"><strong><?php echo number_format($totUtilidad, 2, ',', '.'); ?></strong></TD>
        <TD id="fRep" align="right"><strong>*****</strong></TD>
        <TD id="fRep" align="right"><strong><?php echo number_format($totAgencias, 2, ',', '.'); ?></strong></TD>
	</TR>
	<TR><TD colspan="5" height="15"></TD></TR>
</TABLE>
</DIV>