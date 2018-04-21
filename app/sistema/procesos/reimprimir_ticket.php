<?php
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.apuesta.php";
	
	$titulo = 'Reimprimir Ticket';
?>

<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD valign="top"><FONT class="txtForm"><?php echo $titulo;?></FONT></TD>
		<TD width="50%" align="right">
			<?php barra_opciones2('reimprimirTicket()', "cambiar_contenido('sistema/procesos/reimprimir_ticket.php', 'sub_contenido')");?>
		</TD>
	</TR>
</TABLE>
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1" style="border-color:#CCC; border-width:1px; border-style:solid">
	<TR>
		<TD width="150px" class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Nro. Ticket&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="nro_ticket" id="nro_ticket" size="15" maxlength="10" onKeyPress="return soloNumeros(event);"></TD>
	</TR>
	<TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Nro. Seguridad&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="nro_seguridad" id="nro_seguridad" size="15" maxlength="10" onKeyPress="return soloNumeros(event);"></TD>
	</TR>
</TABLE>