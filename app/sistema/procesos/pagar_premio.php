<?php
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.apuesta.php";
	
	$titulo = 'Pagar Premio';
?>

<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD valign="top"><FONT class="txtForm"><?php echo $titulo;?></FONT></TD>
		<TD width="50%" align="right">
			<?php barra_opciones2('pagarPremio()', "cambiar_contenido('sistema/procesos/pagar_premio.php', 'sub_contenido')");?>
		</TD>
	</TR>
</TABLE>
<table width="100%" style="border-color:#CCC; border-width:1px; border-style:solid" cellpadding="0" cellspacing="0"><tr><td>
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1">
	<TR>
		<TD width="150px" class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Nro. Ticket&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="nro_ticket" id="nro_ticket" size="15" maxlength="10" onKeyPress="return soloNumeros(event);"></TD>
	</TR>
	<TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Nro. Seguridad&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="nro_seguridad" id="nro_seguridad" size="15" maxlength="10" onKeyPress="buscarInfoEnterPagTicket(event, 'mostrarTicketPag'); return soloNumeros(event);">&nbsp;&nbsp;<img src="imagenes/seleccionar.png" border="0" style="cursor:pointer" title="Click para mostrar ticket" onclick="mostrarTicketPagar();"></TD>
	</TR>
    <TR height="30px">
	    <TD class="titForm" align="right">Estatus Apuesta&nbsp;</TD>
    	<TD class="objForm"><font id="estatus" style="color: #CC0000; font-weight: bold;"></font></TD>
    </TR>
</TABLE>
<BR/>
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1">
	<TR>
    	<TD class="titForm" colspan="2" align="center"><strong>Datos de la Apuesta</strong></TD>
    </TR>
	<TR>
    	<TD width="50%" class="objForm"><strong>Fecha:</strong> <font id="fecha"></font></TD>
        <TD width="50%" class="objForm"><strong>Monto:</strong> <font id="monto"></font></TD>
        
    </TR>
    <TR>
    	<TD width="50%" class="objForm"><strong>Hora:</strong> <font id="hora"></font></TD>
        <TD width="50%" class="objForm"><strong>Premio:</strong> <font id="premio"></font></TD>
    </TR>
</TABLE>
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1">
	<TR>
    	<TD class="titForm" colspan="4" align="center"><strong>Jugadas registradas</strong></TD>
    </TR>
    <TR>
    	<TD width="30%" class="titForm"><strong>Equipo</strong></TD>
        <TD width="30%" class="titForm"><strong>Apuesta</strong></TD>
        <TD width="20%" class="titForm"><strong>Logro</strong></TD>
        <TD width="20%" class="titForm"><strong>Estatus</strong></TD>
    </TR>
</TABLE>
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1" id="apuesta">
</TABLE>
</td></tr></table>