<?php
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.menu.php";
	
	$accion = $_GET['accion'];
	
	if ($accion == 'add')
		$titulo = 'Agregar perfil';
	elseif ($accion == 'edit')
		$titulo = 'Modificar perfil';
		
	$objMenu = new menu();
	$filaMenu = $objMenu->lista();
?>

<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD valign="top"><FONT class="txtForm"><?php echo $titulo; ?></FONT></TD>
		<TD width="50%" align="right">
			<?php barra_opciones2('guardarPerfil()', "cambiar_contenido('sistema/admon/perfiles_list.php', 'sub_contenido')");?>
		</TD>
	</TR>
</TABLE>
<table width="100%" style="border-color:#CCC; border-width:1px; border-style:solid" cellpadding="0" cellspacing="0"><tr><td>
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1">
	<TR>
		<TD class="titForm" width="15%" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>C&oacute;digo&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="codigo" id="txt_codigo" size="10" maxlength="5" onChange="validarPerfil();"onKeyPress="return soloNumeros(event);"></TD>
	</TR>
	<TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Nombre&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="nombre" id="txt_nombre" size="50" maxlength="80"></TD>
	</TR>
</TABLE>
<FORM name="fPerfiles" id="fPerfiles">
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1">
    <TR height="25px">
    	<TD class="titForm" align="center"><INPUT type="checkbox" name="chkbox" value="0" onclick="javascript: marcarTodos(chkbox)"></TD>
		<TD class="titForm" align="center"><strong>Acceso al Menú</strong></TD>
	</TR>
    <?php for ($i=0; $i<count($filaMenu); $i++) {
		?>
     <TR height="25px">
     	<TD class="objForm" width="4%" align="center"><INPUT type="checkbox" id="checkP" name="checkP<?php echo $i?>" value="<?php echo $filaMenu[$i]['id']; ?>"></TD>
        <TD class="objForm"><?php echo $filaMenu[$i]['descripcion']; ?></TD>
     </TR>
     <?php } ?>
     <TR height="12px">
		<TD class="titForm"></TD>
		<TD class="titForm"></TD>
	</TR>
</TABLE>
</FORM>
</td></tr></table>