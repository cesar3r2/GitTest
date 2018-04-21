<?php
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.banquero.php";
	
	$accion = $_GET['accion'];
	
	if ($accion == 'add')
		$titulo = 'Agregar banquero';
	elseif ($accion == 'edit')
		$titulo = 'Modificar banquero';
?>

<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD valign="top"><FONT class="txtForm"><?php echo $titulo;?></FONT></TD>
		<TD width="50%" align="right">
			<?php barra_opciones2('guardarBanquero()', "cambiar_contenido('sistema/admon/banqueros_list.php', 'sub_contenido')");?>
		</TD>
	</TR>
</TABLE>
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1" style="border-color:#CCC; border-width:1px; border-style:solid">
	<TR>
		<TD class="titForm" width="18%" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Cédula&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="cedula" id="txt_cedula" size="15" maxlength="8" onKeyPress="return soloNumeros(event);" onchange="javascript: validarBanquero();"></TD>
	</TR>
	<TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Nombre&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="nombre" id="txt_nombre" size="35" maxlength="50"></TD>
	</TR>
	<TR>
		<TD class="titForm" align="right">Direcci&oacute;n&nbsp;</TD>
		<TD class="objForm"><textarea name="direccion" id="txt_direccion" cols="50" rows="1"></textarea></TD>
	</TR>
	<TR>
		<TD class="titForm" align="right">Tel&eacute;fono&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="telefono" id="txt_telefono" size="15" maxlength="11" onKeyPress="return soloNumeros(event);"></TD>
	</TR>
    <TR>
		<TD class="titForm" align="right">Correo&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="correo" id="txt_correo" size="35" maxlength="80" onBlur="javascript: validarEmail(this.value, id);" ></TD>
	</TR>
</TABLE>