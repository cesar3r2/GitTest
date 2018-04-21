<?php
	session_start();
	ob_start();
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	$titulo = 'Calculadora Parley';
?>
<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD valign="top"><FONT class="txtForm"><?php echo $titulo;?></FONT></TD>
	</TR>
    <TR>
		<TD valign="top" height="20px"></TD>
	</TR>
</TABLE>
<div class="row">
<div class="col-md-9">
<TABLE width="100%" align="left" border="0" cellpadding="2" cellspacing="1" id="lista_apuestas" style="border-color:#CCC; border-width:1px; border-style:solid">
	<TR height="17px">
		<TD class="titForm" width="60%" align="center">&nbsp;<strong>Número de Apuesta</strong></TD>
		<TD class="titForm" width="40%" align="center"><strong>Nro. Logro</strong></TD>
	</TR>
    <TR>
    	<TD class="objForm"><font style="margin-left:78px">(1) - Primera</font></TD>
        <TD class="objForm" align="center"><INPUT name="logro1" id="logro1" style="text-align:right" size="5" maxlength="5" onkeypress="return soloNumerosLogros(event);" onkeyup="calcularApuestaCalc();"></TD>
    </TR>
     <TR>
    	<TD class="objForm"><font style="margin-left:78px">(2) - Segunda</font></TD>
        <TD class="objForm" align="center"><INPUT name="logro2" id="logro2" style="text-align:right" size="5" maxlength="5" onkeypress="return soloNumerosLogros(event);" onkeyup="calcularApuestaCalc();"></TD>
    </TR>
     <TR>
    	<TD class="objForm"><font style="margin-left:78px">(3) - Tercera</font></TD>
        <TD class="objForm" align="center"><INPUT name="logro3" id="logro3" style="text-align:right" size="5" maxlength="5" onkeypress="return soloNumerosLogros(event);" onkeyup="calcularApuestaCalc();"></TD>
    </TR>
     <TR>
    	<TD class="objForm"><font style="margin-left:78px">(4) - Cuarta</font></TD>
        <TD class="objForm" align="center"><INPUT name="logro4" id="logro4" style="text-align:right" size="5" maxlength="5" onkeypress="return soloNumerosLogros(event);" onkeyup="calcularApuestaCalc();"></TD>
    </TR>
     <TR>
    	<TD class="objForm"><font style="margin-left:78px">(5) - Quinta</font></TD>
        <TD class="objForm" align="center"><INPUT name="logro5" id="logro5" style="text-align:right" size="5" maxlength="5" onkeypress="return soloNumerosLogros(event);" onkeyup="calcularApuestaCalc();"></TD>
    </TR>
     <TR>
    	<TD class="objForm"><font style="margin-left:78px">(6) - Sexta</font></TD>
        <TD class="objForm" align="center"><INPUT name="logro6" id="logro6" style="text-align:right" size="5" maxlength="5" onkeypress="return soloNumerosLogros(event);" onkeyup="calcularApuestaCalc();"></TD>
    </TR>
     <TR>
    	<TD class="objForm"><font style="margin-left:78px">(7) - Séptima</font></TD>
        <TD class="objForm" align="center"><INPUT name="logro7" id="logro7" style="text-align:right" size="5" maxlength="5" onkeypress="return soloNumerosLogros(event);" onkeyup="calcularApuestaCalc();"></TD>
    </TR>
     <TR>
    	<TD class="objForm"><font style="margin-left:78px">(8) - Octava</font></TD>
        <TD class="objForm" align="center"><INPUT name="logro8" id="logro8" style="text-align:right" size="5" maxlength="5" onkeypress="return soloNumerosLogros(event);" onkeyup="calcularApuestaCalc();"></TD>
    </TR>
     <TR>
    	<TD class="objForm"><font style="margin-left:78px">(9) - Novena</font></TD>
        <TD class="objForm" align="center"><INPUT name="logro9" id="logro9" style="text-align:right" size="5" maxlength="5" onkeypress="return soloNumerosLogros(event);" onkeyup="calcularApuestaCalc();"></TD>
    </TR>
     <TR>
    	<TD class="objForm"><font style="margin-left:72px">(10) - Décima</font></TD>
        <TD class="objForm" align="center"><INPUT name="logro10" id="logro10" style="text-align:right" size="5" maxlength="5" onkeypress="return soloNumerosLogros(event);" onkeyup="calcularApuestaCalc();"></TD>
    </TR>
    <TR height="12px">
		<TD class="titForm"></TD>
		<TD class="titForm"></TD>
	</TR>
</TABLE>
</div>
<div class="col-md-3">
<TABLE width="100%" align="right" border="0" cellpadding="1" cellspacing="1" style="border-color:#CCC; border-width:1px; border-style:solid">
	<TR height="18px">
		<TD class="titForm" align="center" colspan="5"><strong>Monto de la Apuesta</strong></TD>
	</TR>
	<TR>
		<TD class="objForm" align="center">BsF.&nbsp;<input type="text" name="monoto" id="monto" style="text-align:right" size="5" onKeyPress="buscarInfoEnterMontoCalc(event, 'calcularApuesta'); return soloNumeros(event);" value="50" maxlength="4">&nbsp;&nbsp;<img src="imagenes/seleccionar.png" border="0" style="cursor:pointer" title="Calcular Total a Cobrar" onclick="calcularApuestaCalc();"></TD>
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
    <TR align="center" height="50px">
		<TD align="center" class="objForm" >
            <button type="submit" class="btn btn-danger btn-xd" onclick="limpiarApuestaCalc();"><i class="fa fa-close"></i> Cancelar</button>
		</TD>
    </TR>
</TABLE>
</div>
</div>