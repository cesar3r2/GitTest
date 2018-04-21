<?php
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
?>

<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD valign="top"><FONT class="txtForm">Modificar datos de la empresa</FONT></TD>
		<TD width="50%" align="right">
			<?php barra_opciones2('guardarEmpresa()', "cambiar_contenido('sistema/admon/empresa_list.php', 'sub_contenido')");?>
		</TD>
	</TR>
</TABLE>
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1" style="border-color:#CCC; border-width:1px; border-style:solid">
	<TR>
		<TD class="titForm" width="20%" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>R.I.F.&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="rif" id="txt_rif" size="20" maxlength="20"></TD>
	</TR>
	<TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Nombre&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="nombre" id="txt_nombre" size="40" maxlength="80"></TD>
	</TR>
	<TR>
		<TD class="titForm" align="right">Nombre Comercial&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="nombre_comercial" id="txt_nombre_comercial" size="40" maxlength="80"></TD>
	</TR>
    <TR>
		<TD class="titForm" align="right">Direcci&oacute;n&nbsp;</TD>
		<TD class="objForm"><textarea name="direccion" id="txt_direccion" cols="50" rows="1"></textarea></TD>
	</TR>
	<TR>
		<TD class="titForm" align="right">Tel&eacute;fono&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="telefono" id="txt_telefono" size="15" maxlength="11"></TD>
	</TR>
</TABLE>