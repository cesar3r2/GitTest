<?php
	session_start();
	ob_start();
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.estado.php";
	include "../../clases/class.agencia.php";
	
	$titulo = 'Mi Agencia';

	$id_agencia = $_SESSION['AGENCIA'];
	$obj = new agencia();
	$fila = $obj->datos_agencia($id_agencia);

	$objEstado = new estado();
	$fEstado = $objEstado->lista();
?>

<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD valign="top"><FONT class="txtForm"><?php echo $titulo;?></FONT></TD>
		<TD width="50%" align="right">
			<?php barra_opciones2('guardarMiAgencia()', "cambiar_contenido('sistema/admon/administracion.php', 'contenido')");?>
		</TD>
	</TR>
</TABLE>
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1" style="border-color:#CCC; border-width:1px; border-style:solid">
	<TR>
		<TD width="25%" class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Nombre&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="nombre" id="txt_nombre" size="35" maxlength="50" value="<?php echo $fila[0]['nombre']; ?>">
        <INPUT type="hidden" id="id_agencia" value="<?php echo $fila[0]['id']; ?>">
        </TD>
	</TR>
	<TR>
		<TD class="titForm" align="right">Direcci&oacute;n&nbsp;</TD>
		<TD class="objForm"><textarea name="direccion" id="txt_direccion" cols="50" rows="1"><?php echo $fila[0]['direccion']; ?></textarea></TD>
	</TR>
	<TR>
		<TD class="titForm" align="right">Tel&eacute;fono&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="telefono" id="txt_telefono" size="15" value="<?php echo $fila[0]['telefono']; ?>" maxlength="11" onKeyPress="return soloNumeros(event);"></TD>
	</TR>
    <TR>
		<TD class="titForm" align="right">Correo&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="email" id="txt_email" size="35" maxlength="50"  onBlur="javascript: validarEmail(this.value, id);" value="<?php echo $fila[0]['correo']; ?>"></TD>
	</TR>
     <TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>M. Mínimo del Ticket&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="monto_min" id="monto_min" value="<?php echo $fila[0]['monto_min']; ?>" size="10" maxlength="8" onKeyPress="return soloNumeros(event);" style="text-align:right"> BsF.</TD>
	</TR>
    <TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>M. Máximo del Ticket&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="monto_max" id="monto_max" value="<?php echo $fila[0]['monto_max']; ?>" size="10" maxlength="8" onKeyPress="return soloNumeros(event);" style="text-align:right"> BsF. Parley&nbsp;&nbsp;&nbsp;<INPUT type="text" name="monto_derecho" id="txt_monto_derecho" value="<?php echo $fila[0]['monto_derecho']; ?>" size="5" maxlength="5" onKeyPress="return soloNumeros(event);" style="text-align:right"> BsF. Por derecho</TD>
	</TR>
    <TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>M. Máximo del Premio&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="premio_max" id="premio_max" size="10" maxlength="8" onKeyPress="return soloNumeros(event);" style="text-align:right" value="<?php echo $fila[0]['premio_max']; ?>">&nbsp;&nbsp;BsF.</TD>
	</TR>
    <TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>M. Disponible Diario&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="saldo" id="txt_saldo" size="10" maxlength="8" onKeyPress="return soloNumeros(event);" style="text-align:right" value="<?php echo $fila[0]['disponible']; ?>">&nbsp;&nbsp;BsF.</TD>
	</TR>
</TABLE>