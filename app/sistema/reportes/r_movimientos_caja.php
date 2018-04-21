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
	//$id_agencia = $_SESSION['AGENCIA'];
	
	$objA = new apuesta();
	$fApu = $objA->buscar_apuestas_fecha($fDesde, $fHasta, $id_agencia);
	
	$objAg = new agencia();
	$fAg = $objAg->datos_agencia($id_agencia);
	$agencia = strtoupper($fAg[0]['nombre']);
	$rif = $fAg[0]['ci_rif'];
?>
<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD width="50%" align="right">
			<?php barra_opciones3("", "imprimir('impresion')", "cambiar_contenido('sistema/reportes/movimientos_caja.php', 'sub_contenido')");?>
		</TD>
	</TR>
</TABLE>
<BR>
<DIV id="impresion">
<?php echo $encabezado = encabezado_reporte($agencia, $rif);?>
<BR>
<TABLE align="left" width="100%" border="0" cellpadding="1" cellspacing="1">
	<TR>
		<TD class="txtR10" align="center"><strong>Movimientos de Caja Registrados</strong></TD>
	</TR>
	<TR>
		<TD class="txtR9" align="center"><strong>Desde el </strong> <?php echo fecha($fDesde); ?> <strong>Hasta el </strong> <?php echo fecha($fHasta); ?></TD>
	</TR>
	<TR><TD height="10"></TD></TR>
</TABLE>
<BR>
<?php
	$cAnulada = $cGanadora = $cPagada = 0;
	$montoApuestas = $montoAnulada = $montoGanadora = $montoPagado = 0;
	$montoApuPremio = $montoAnuPremio = $montoGanPremio = $montoPagPremio = 0;
	for($i=0; $i<count($fApu); $i++)
	{
		$montoApuestas += $fApu[$i]['monto'];
		$montoApuPremio += $fApu[$i]['premio'];
		
		if ($fApu[$i]['estatus'] == 'ANULADA') {
			$cAnulada++;
			$montoAnulada += $fApu[$i]['monto'];
			$montoAnuPremio += $fApu[$i]['premio'];
		} else if ($fApu[$i]['estatus'] == 'GANADORA') {
			$cGanadora++;
			$montoGanadora += $fApu[$i]['monto'];
			$montoGanPremio += $fApu[$i]['premio'];
		} else if ($fApu[$i]['estatus'] == 'PAGADA') {
			$cPagada++;
			$montoPagada += $fApu[$i]['monto'];
			$montoPagPremio += $fApu[$i]['premio'];
		}
	}
	$entrada = $montoApuestas - $montoAnulada;
	$salida = $montoGanPremio + $montoPagPremio;
	$saldo = $entrada - $salida;
	if ($saldo >= 0)
		$color = '#090';
	else
		$color = '#F00';
?>

<TABLE align="left" width="100%" border="0" cellpadding="4" cellspacing="0">
	<TR class="txtR10">
		<TD id="fRepT" width="30%" align="left"><strong>Item</strong></TD>
        <TD id="fRepT" width="10%" align="center"><strong>Cantidad</strong></TD>
        <TD id="fRepT" width="20%" align="right"><strong>Jugado (BsF.)</strong></TD>
        <TD id="fRepT" width="20%" align="right"><strong>Ganancia (BsF.)</strong></TD>
        <TD id="fRepT" width="20%" align="right"><strong>Premio (BsF.)</strong></TD>
	</TR>
	<TR class="txtR9">
		<TD id="fRep" align="left"><strong>Total Tickets Registrados</strong></TD>
        <TD id="fRep" align="center"><?php echo count($fApu); ?></TD>
        <TD id="fRep" align="right"><?php echo number_format($montoApuestas, 2, ',', '.'); ?></TD>
        <TD id="fRep" align="right"><?php echo number_format($montoApuPremio-$montoApuestas, 2, ',', '.'); ?></TD>
        <TD id="fRep" align="right"><?php echo number_format($montoApuPremio, 2, ',', '.'); ?></TD>
	</TR>
   	<TR class="txtR9">
        <TD id="fRep" align="left"><strong>Tickets Válidos</strong></TD>
        <TD id="fRep" align="center"><?php echo count($fApu) - $cAnulada; ?></TD>
        <TD id="fRep" align="right"><strong style="color: #090"><?php echo number_format($montoApuestas - $montoAnulada, 2, ',', '.'); ?></strong></TD>
        <TD id="fRep" align="right"><?php echo number_format(($montoApuPremio-$montoAnuPremio)-($montoApuestas-$montoAnulada), 2, ',', '.'); ?></TD>
        <TD id="fRep" align="right"><?php echo number_format($montoApuPremio - $montoAnuPremio, 2, ',', '.'); ?></TD>
	</TR>
    <TR class="txtR9">
        <TD id="fRep" align="left"><strong>Tickets Anulados</strong></TD>
        <TD id="fRep" align="center"><?php echo $cAnulada; ?></TD>
        <TD id="fRep" align="right"><?php echo number_format($montoAnulada, 2, ',', '.'); ?></TD>
        <TD id="fRep" align="right"><?php echo number_format($montoAnuPremio-$montoAnulada, 2, ',', '.'); ?></TD>
        <TD id="fRep" align="right"><?php echo number_format($montoAnuPremio, 2, ',', '.'); ?></TD>
	</TR>
    <TR class="txtR9">
        <TD id="fRep" align="left"><strong>Tickets Ganadores</strong></TD>
        <TD id="fRep" align="center"><?php echo $cGanadora; ?></TD>
        <TD id="fRep" align="right"><?php echo number_format($montoGanadora, 2, ',', '.'); ?></TD>
        <TD id="fRep" align="right"><?php echo number_format($montoGanPremio-$montoGanadora, 2, ',', '.'); ?></TD>
        <TD id="fRep" align="right" style="color: #F00"><?php echo number_format($montoGanPremio, 2, ',', '.'); ?></TD>
	</TR>
    <TR class="txtR9">
        <TD id="fRep" align="left"><strong>Tickets Pagados</strong></TD>
        <TD id="fRep" align="center"><?php echo $cPagada; ?></TD>
        <TD id="fRep" align="right"><?php echo number_format($montoPagada, 2, ',', '.'); ?></TD>
        <TD id="fRep" align="right"><?php echo number_format($montoPagPremio-$montoPagada, 2, ',', '.'); ?></TD>
        <TD id="fRep" align="right"><strong style="color: #F00"><?php echo number_format($montoPagPremio, 2, ',', '.'); ?></strong></TD>
	</TR> 
    <TR class="txtR10" bgcolor="#F0F0F0"><TD colspan="5" id="fRep" align="center"><strong>Saldo Disponible: <font style="color: <?php echo $color;?>"><?php echo number_format($saldo, 2, ',', '.'); ?></font></strong></TD></TR>
	<TR><TD colspan="5" height="15"></TD></TR>
</TABLE>
<BR>
<?php 
	$montoVentas = $montoApuestas - $montoAnulada;
	$porcentaje =  $fAg[0]['porcentaje_venta'];
	$montoAgencia = $montoVentas * $porcentaje / 100;
	$montoBanca = $montoVentas - $montoAgencia;
	
	if ($porcentaje != 0) {
?>
<TABLE align="left" width="100%" border="0" cellpadding="4" cellspacing="0">
	<TR>
		<TD colspan="3" class="txtR10" align="center"><strong>Porcentajes de las Ventas</strong></TD>
	</TR>
	<TR class="txtR9">
		<TD width="50%" id="fRepT" align="left"><strong>Monto correspondiente a las Ventas Realizadas</strong></TD>
        <TD width="35%" id="fRepT" align="right"><?php echo number_format($montoVentas, 2, ',', '.'); ?> BsF.</TD>
        <TD width="15%" id="fRepT"></TD>
	</TR>
    <TR class="txtR9">
        <TD id="fRep" align="left"><strong>Monto correspondiente a la Agencia (<?php echo $porcentaje; ?>%)</strong></TD>
        <TD id="fRep" align="right"><?php echo number_format($montoAgencia, 2, ',', '.'); ?> BsF.</TD>
        <TD id="fRep"></TD>
	</TR>
    <TR class="txtR9">
        <TD id="fRep" align="left"><strong>Monto correspondiente a la Banca</strong></TD>
        <TD id="fRep" align="right"><?php echo number_format($montoBanca, 2, ',', '.'); ?> BsF.</TD>
        <TD id="fRep"></TD>
	</TR>
    <TR><TD colspan="5" height="15"></TD></TR>
</TABLE>
<?php } ?>
<BR>
<?php 
	$montoUtilidad = $saldo;
	$porcentajeU =  $fAg[0]['porcentaje_utilidad'];
	$montoAgenciaU = $montoUtilidad * $porcentajeU / 100;
	$montoBancaU = $montoUtilidad - $montoAgenciaU;
	
	if ($porcentaje != 0) {
?>
<TABLE align="left" width="100%" border="0" cellpadding="4" cellspacing="0">
	<TR>
		<TD colspan="3" class="txtR10" align="center"><strong>Porcentajes de las Utilidades</strong></TD>
	</TR>
	<TR class="txtR9">
		<TD width="50%" id="fRepT" align="left"><strong>Monto correspondiente a las Utilidades</strong></TD>
        <TD width="35%" id="fRepT" align="right"><?php echo number_format($montoUtilidad, 2, ',', '.'); ?> BsF.</TD>
        <TD width="15%" id="fRepT"></TD>
	</TR>
    <TR class="txtR9">
        <TD id="fRep" align="left"><strong>Monto correspondiente a la Agencia (<?php echo $porcentajeU; ?>%)</strong></TD>
        <TD id="fRep" align="right"><?php echo number_format($montoAgenciaU, 2, ',', '.'); ?> BsF.</TD>
        <TD id="fRep"></TD>
	</TR>
    <TR class="txtR9">
        <TD id="fRep" align="left"><strong>Monto correspondiente a la Banca</strong></TD>
        <TD id="fRep" align="right"><?php echo number_format($montoBancaU, 2, ',', '.'); ?> BsF.</TD>
        <TD id="fRep"></TD>
	</TR>
</TABLE>
<?php } ?>
</DIV>