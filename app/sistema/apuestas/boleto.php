<?php
	session_start();
	ob_start();
	include "../../conexionConf.php";
	include "../../clases/class.apuesta.php";
	include "../../clases/class.agencia.php";
	
	$id_agencia = $_SESSION['AGENCIA'];
	$objAgencia = new agencia();
	$fAgencia = $objAgencia->datos_agencia($id_agencia);
	$montosMax = $fAgencia[0]['premio_max'].'||'.$fAgencia[0]['monto_max'].'||'.$fAgencia[0]['monto_derecho'].'||'.$fAgencia[0]['monto_min'];
	
	$objApu = new apuesta();
	$fApu = $objApu->premios_diarios(date('Y-m-d'), $id_agencia);
	
	$saldo = $fAgencia[0]['disponible'];
	$totalVentas = $fApu[0]['total_ventas'];
	$totalPremios = $fApu[0]['total_premios'];
?>
<TABLE align="right" width="100%" border="0" cellpadding="1" cellspacing="1">
	<TR bgcolor="#6FA144">
    	<TD align="center" height="18px" style="color:#FFFFFF"><strong>Datos de la Apuesta</strong></TD>
    </TR>
	<TR height="18px">
		<TD class="titForm" align="center" colspan="5"><strong>Ingrese el Monto</strong></TD>
	</TR>
	<TR>
		<TD class="objForm" align="center">BsF.&nbsp;&nbsp;<input type="text" name="monto" id="monto" style="text-align:right; font-size:14px" size="12" onKeyPress="buscarInfoEnterMonto(event, 'calcularApuesta'); return soloNumeros(event);" onkeyup="calcularApuesta();" value="<?php echo $fAgencia[0]['monto_min']; ?>" maxlength="4">&nbsp;&nbsp;&nbsp;<img src="imagenes/seleccionar.png" border="0" style="cursor:pointer" title="Calcular Total a Cobrar" onclick="calcularApuesta();">
        <input type="hidden" id="tipo" value="PARLEY" />
        </TD>
	</TR>
    <TR>
		<TD class="objForm" align="center">Ganancia + Apuesta</TD>
	</TR>
        <TR>
		<TD class="objForm" align="center" id="gan_apu">&nbsp;</TD>
	</TR>
    <TR>
		<TD class="titForm" align="center" colspan="5"><strong>TOTAL A COBRAR</strong></TD>
	</TR>
    <TR>
		<TD class="objForm" align="center" id="monto_total" height="30px" style="font-size:16px; font-weight:bold; color: #F00">&nbsp;</TD>
	</TR>
    <TR>
    	<TD>
        	<div id="listado">
            <FORM name="listaLogros" id="listaLogros" style="font-size:12px">
            <TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0" id="lista_apuestas">
                <TR height="18px">
                    <TD class="titForm" width="35%" align="letf">&nbsp;<strong>Equipo(s)</strong></TD>
                    <TD class="titForm" width="35%" align="left">&nbsp;<strong>Jugada</strong></TD>
                    <TD class="titForm" width="20%" align="center"><strong>Logro</strong></TD>
                    <TD class="titForm" width="10%" align="center"></TD>
                </TR>
            </TABLE>
            </FORM>
            </div>
        </TD>
    </TR>
    <TR>
		<TD class="titForm" align="center" colspan="5"><strong>&iquest; Guardar Apuesta ?</strong></TD>
        <INPUT type="hidden" name="premio" id="premio" value="">
        <INPUT type="hidden" name="premio_max" id="premio_max" value="<?php echo $montosMax; ?>">
	</TR>
    <TR align="center">
		<TD align="center" class="objForm">
        <TABLE>
        	<TR><TD align="center" height="60px">
            <button type="submit" class="btn btn-success btn-xd" onclick="guardarApuesta();"><i class="fa fa-check"></i> Aceptar</button></TD>
            <TD align="center">
            <button type="submit" class="btn btn-danger btn-xd" onclick="limpiarApuesta();"><i class="fa fa-close"></i> Cancelar</button></TD>
            </TR>
        </TABLE>
		</TD>
    </TR>
    <?php if ($saldo < $totalPremios) { ?>
    <TR>
    	<TD align="center" style="color:#F00" class="objForm">Ha superado el límite <br> diario de apuestas</TD>
    </TR>
        <TR>
		<TD class="titForm" align="center" colspan="5"><strong>Totales (BsF.)</strong></TD>
	</TR>
    <TR>
    	<TD align="center" class="objForm">Límite Diario: <?php echo number_format($saldo, 2, ',', '.'); ?></TD>
    </TR>
    <TR>
    	<TD align="center" class="objForm">Total Ventas: <?php echo number_format($totalVentas, 2, ',', '.'); ?></TD>
    </TR>
    <TR>
    	<TD align="center" class="objForm">Total Premios: <?php echo number_format($totalPremios, 2, ',', '.'); ?></TD>
    </TR>
    <?php } ?>		
</TABLE>