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
			<?php barra_opciones3("", "imprimir('impresion')", "cambiar_contenido('sistema/reportes/porcentajes_ventas.php', 'sub_contenido')");?>
		</TD>
	</TR>
</TABLE>
<BR>
<DIV id="impresion">
<?php echo $encabezado = encabezado_reporte($fBan[0]['nombre'], $id_banquero);?>
<BR>
<TABLE align="left" width="100%" border="0" cellpadding="1" cellspacing="1">
	<TR>
		<TD class="txtR10" align="center"><strong>Pocentajes de Ventas de las Agencias</strong></TD>
	</TR>
	<TR>
		<TD class="txtR9" align="center"><strong>Desde el </strong> <?php echo fecha($fDesde); ?> <strong>Hasta el </strong> <?php echo fecha($fHasta); ?></TD>
	</TR>
	<TR><TD height="10"></TD></TR>
</TABLE>
<BR>
<TABLE align="left" width="100%" border="0" cellpadding="4" cellspacing="0">
	<TR class="txtR9">
		<TD id="fRepT" width="15%" align="left"><strong>Agencia</strong></TD>
        <TD id="fRepT" width="15%" align="right"><strong>Ventas</strong></TD>
        <TD id="fRepT" width="20%" align="right"><strong>Por Parley</strong></TD>
        <TD id="fRepT" width="20%" align="right"><strong>Por Derecho</strong></TD>
        <TD id="fRepT" width="15%" align="right"><strong>Agencia</strong></TD>
        <TD id="fRepT" width="15%" align="right"><strong>Banca</strong></TD>
	</TR>
<?php
	$totApu = $totParley = $totDerecho = 0;
	$totAgencias = $totBancas = 0;
	
	for ($i=0; $i<count($fAg); $i++) { 
		$objA = new apuesta();
		$fApu = $objA->buscar_apuestas_fecha($fDesde, $fHasta, $fAg[$i]['id']);
		
		$montoApuestas = $montoParley = $montoDerecho = $montoAgencia = $montoBanca = 0;
		
		for($j=0; $j<count($fApu); $j++)
		{
			if ($fApu[$j]['estatus'] != 'ANULADA') {
				$montoApuestas += $fApu[$j]['monto'];
				$totApu += $fApu[$j]['monto'];
			}
			if ($fApu[$j]['estatus'] != 'ANULADA' && $fApu[$j]['tipo'] == 'PARLEY')
			{
				$montoParley += $fApu[$j]['monto'];
				$totParley += $fApu[$j]['monto'];
			}
			if ($fApu[$j]['estatus'] != 'ANULADA' && $fApu[$j]['tipo'] == 'POR DERECHO')
			{
				$montoDerecho += $fApu[$j]['monto'];
				$totDerecho += $fApu[$j]['monto'];
			}
		}
		$montoVentas = $montoApuestas;
		$porParley =  $fAg[$i]['porcentaje_venta'];
		$porDerecho =  $fAg[$i]['porcentaje_derecho'];
		$montoAgPar = $montoParley * $porParley / 100;
		$montoAgDer = $montoDerecho * $porDerecho / 100;
		
		$montoAgencia = $montoAgPar + $montoAgDer;
		$montoBanca = $montoVentas - $montoAgencia;
		
		$totVentas = $totApu;
		$totAgencias += $montoAgencia;
		$totBancas += $montoBanca;

	?>
	<TR class="txtR9">
		<TD id="fRep" align="left"><?php echo $fAg[$i]['nombre']; ?></TD>
        <TD id="fRep" align="right"><?php echo number_format($montoVentas, 2, ',', '.'); ?></TD>
        <TD id="fRep" align="right"><?php echo number_format($montoParley, 2, ',', '.').'<br>'.'('.$porParley.'%) - ('.number_format($montoAgPar, 2, ',', '.').')'; ?></TD>
        <TD id="fRep" align="right"><?php echo number_format($montoDerecho, 2, ',', '.').'<br>'.'('.$porDerecho.'%) - ('.number_format($montoAgDer, 2, ',', '.').')'; ?></TD>
        <TD id="fRep" align="right"><?php echo number_format($montoAgencia, 2, ',', '.'); ?></TD>
        <TD id="fRep" align="right"><?php echo number_format($montoBanca, 2, ',', '.'); ?></TD>
	</TR>
<?php } ?>
	<TR class="txtR9">
		<TD id="fRep" align="left"><strong>Totales (BsF.)</strong></TD>
        <TD id="fRep" align="right"><strong><?php echo number_format($totVentas, 2, ',', '.'); ?></strong></TD>
        <TD id="fRep" align="right"><strong><?php echo number_format($totParley, 2, ',', '.'); ?></strong></TD>
        <TD id="fRep" align="right"><strong><?php echo number_format($totDerecho, 2, ',', '.'); ?></strong></TD>
        <TD id="fRep" align="right"><strong><?php echo number_format($totAgencias, 2, ',', '.'); ?></strong></TD>
        <TD id="fRep" align="right"><strong><?php echo number_format($totBancas, 2, ',', '.'); ?></strong></TD>
	</TR>
	<TR><TD colspan="5" height="15"></TD></TR>
</TABLE>
</DIV>