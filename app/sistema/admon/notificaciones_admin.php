<?php
	session_start();
	ob_start();
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.notificacion.php";
	
	$titulo = 'Notificaciones';

	$objNot = new notificacion();
	$fNot = $objNot->listado_notificaciones();
?>

<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD valign="top"><FONT class="txtForm"><?php echo $titulo;?></FONT></TD>
		<TD width="50%" align="right">
			<?php barra_opciones2('guardarNotificacion()', "cambiar_contenido('sistema/admon/administracion.php', 'contenido')");?>
		</TD>
	</TR>
</TABLE>
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1" style="border-color:#CCC; border-width:1px; border-style:solid">
	<TR>
		<TD width="20%" class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Id Notificación&nbsp;</TD>
		<TD class="objForm">
        	<SELECT id="id_notificacion" onchange="mostrarNotificacion(this.value);">
            	<OPTION value="-1">Seleccione..</OPTION>
            	<?php for($i=0; $i<count($fNot); $i++) { ?>
                	<OPTION value="<?php echo $fNot[$i]['id']; ?>"><?php echo $fNot[$i]['id']; ?></OPTION>
                <?php } ?>
            </SELECT>
        </TD>
	</TR>
    <TR>
		<TD class="titForm" align="right">Descripción&nbsp;</TD>
		<TD class="objForm"><TEXTAREA id="descripcion" cols="60" rows="2"></TEXTAREA></TD>
	</TR>
    <TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Estatus&nbsp;</TD>
		<TD class="objForm">
        	<SELECT id="estatus">
                <OPTION value="ACTIVA">ACTIVA</OPTION>
                <OPTION value="INACTIVA">INACTIVA</OPTION>
            </SELECT>
        </TD>
	</TR>
</TABLE>