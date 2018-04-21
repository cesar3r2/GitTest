<?php
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.apuesta.php";
	
	$titulo = 'Actualizar Premio';
?>

<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD valign="top"><FONT class="txtForm"><?php echo $titulo;?></FONT></TD>
		<TD width="50%" align="right">
			<?php barra_opciones2('actualizarPremio()', "cambiar_contenido('sistema/procesos/actualizar_premio.php', 'sub_contenido')");?>
		</TD>
	</TR>
</TABLE>
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1" style="border-color:#CCC; border-width:1px; border-style:solid">
	<TR>
		<TD width="150px" class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Nro. Ticket&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="nro_ticket" id="nro_ticket" size="15" maxlength="10" onKeyPress="buscarInfoEnterPreTicket(event, 'mostrarTicketPre'); return soloNumeros(event);">&nbsp;&nbsp;<img src="imagenes/seleccionar.png" border="0" style="cursor:pointer" title="Datos del ticket" onclick="buscarDatosTicket();"></TD>
	</TR>
    <TR>
		<TD class="titForm" align="right">Estatus&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="estatus" id="estatus" size="15" maxlength="10" readonly="readonly"></TD>
	</TR>
	<TR>
		<TD class="titForm" align="right">Monto Premio Actual&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="premio_actual" id="premio_actual" size="15" readonly="readonly"></TD>
	</TR>
    <TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Monto Premio Nuevo&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="premio_nuevo" id="premio_nuevo" size="15" maxlength="10" onKeyPress="return soloNumeros(event);"></TD>
	</TR>
</TABLE>