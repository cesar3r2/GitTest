<?php
	session_start();
	ob_start();
	include "../../include/php/interfaz.php";
	$usuario = strtolower($_SESSION["USUARIO"]);
	$accion = $_GET['accion'];
	$titulo = 'Cambiar Contraseña';
?>

<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD valign="top"><FONT class="txtForm"><?php echo $titulo;?></FONT></TD>
		<TD width="50%" align="right">
			<?php barra_opciones2('cambiarClave()', "cambiar_contenido('sistema/admon/administracion.php', 'contenido')");?>
		</TD>
	</TR>
</TABLE>
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1" style="border-color:#CCC; border-width:1px; border-style:solid">
	<TR>
		<TD class="titForm" width="22%" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Usuario&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="usuario" id="txt_usuario" size="20" maxlength="20" readonly="true" value="<?php echo $usuario?>"></TD>
	</TR>
	<TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Contraseña Actual&nbsp;</TD>
		<TD class="objForm"><INPUT type="password" name="clave1" id="txt_clave" size="20" maxlength="20" onchange="javascript: validar_clave();"></TD>
	</TR>
	<TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Contraseña Nueva&nbsp;</TD>
		<TD class="objForm"><INPUT type="password" name="clave2" id="clave_nva_1" size="20" maxlength="20"></TD>
	</TR>
	<TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Repita Contraseña&nbsp;</TD>
		<TD class="objForm"><INPUT type="password" name="clave3" id="clave_nva_2" size="20" maxlength="20" onchange="javascript: verificarClave();"></TD>
	</TR>
</TABLE>