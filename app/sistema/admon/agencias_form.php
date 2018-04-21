<?php
	session_start();
	ob_start();
	
	$tipo = $_SESSION['PERFIL_USUARIO'];
	$usuario = $_SESSION["USUARIO"];
	
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.estado.php";
	include "../../clases/class.empresa.php";
	include "../../clases/class.agencia.php";
	include "../../clases/class.banquero.php";
	
	$accion = $_GET['accion'];
	
	if ($accion == 'add')
		$titulo = 'Agregar agencia';
	elseif ($accion == 'edit')
		$titulo = 'Modificar agencia';

	$objEstado = new estado();
	$fEstado = $objEstado->lista();
	
	$objEmpresa = new empresa();
	$fEmpresa = $objEmpresa->lista();
	
	$objAgencia = new agencia();
	$fAgencia = $objAgencia->proximo_codigo();
	
	$objBanquero = new banquero();
	if ($tipo == 1)
		$fBanquero = $objBanquero->lista();
	else if ($tipo == 2)
		$fBanquero = $objBanquero->buscar_banquero($usuario);
?>

<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD valign="top"><FONT class="txtForm"><?php echo $titulo;?></FONT></TD>
		<TD width="50%" align="right">
			<?php barra_opciones2('guardarAgencia()', "cambiar_contenido('sistema/admon/agencias_list.php', 'sub_contenido')");?>
		</TD>
	</TR>
</TABLE>
<table width="100%" style="border-color:#CCC; border-width:1px; border-style:solid" cellpadding="0" cellspacing="0"><tr><td>
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1">
	<TR>
		<TD class="titForm" width="20%" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Nombre&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="nombre" id="txt_nombre" size="35" maxlength="50"></TD>
	</TR>
    <TR>
		<TD class="titForm" align="right">C.I/R.I.F&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="ci_rif" id="txt_rif" size="15" maxlength="12">
        <INPUT type="hidden" name="id_agencia" id="id_agencia" value="<?php echo $fAgencia[0]['ultimo']+1; ?>"></TD>
	</TR>
	<TR>
		<TD class="titForm" align="right">Direcci&oacute;n&nbsp;</TD>
		<TD class="objForm"><textarea name="direccion" id="txt_direccion" cols="50" rows="1"></textarea></TD>
	</TR>
	<TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Estado&nbsp;</TD>
		<TD class="objForm"><SELECT name="estado" id="sel_estado">
				<OPTION value="0">Seleccione..</OPTION>
				<?php for($i=0; $i<count($fEstado); $i++) {?>
				<OPTION title="Código: <?php echo $fEstado[$i]['codigo']?>" value="<?php echo $fEstado[$i]['codigo']?>"><?php echo $fEstado[$i]['nombre']?></OPTION>
				<?php }?>
			 </SELECT>
		</TD>
	</TR>
   	<TR>
		<TD class="titForm" align="right">Ciudad&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="ciudad" id="txt_ciudad" size="20" maxlength="50"></TD>
	</TR>
	<TR>
		<TD class="titForm" align="right">Teléfono&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="telefono" id="txt_telefono" size="15" maxlength="11" onKeyPress="return soloNumeros(event);"></TD>
	</TR>
    <TR>
		<TD class="titForm" align="right">Correo&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="email" id="txt_email" size="35" maxlength="50"  onBlur="javascript: validarEmail(this.value, id);"></TD>
	</TR>
    <TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Banquero&nbsp;</TD>
		<TD class="objForm"><SELECT name="banquero" id="sel_banquero" onchange="cagarGrupos(this.value, 0, 0)">
				<OPTION value="0">Seleccione..</OPTION>
				<?php for($i=0; $i<count($fBanquero); $i++) {?>
				<OPTION title="Cédula: <?php echo $fBanquero[$i]['cedula']?>" value="<?php echo $fBanquero[$i]['cedula']?>"><?php echo $fBanquero[$i]['nombre']?></OPTION>
				<?php }?>
			 </SELECT>
		</TD>
	</TR>
    <TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Grupo&nbsp;</TD>
		<TD class="objForm"><SELECT name="grupo" id="sel_grupo">
				<OPTION value="-1">Seleccione..</OPTION>
			 </SELECT>
		</TD>
	</TR>
    <TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Estatus&nbsp;</TD>
		<TD class="objForm">
        	<SELECT name="estatus" id="sel_estatus">
				<OPTION value="0">Seleccione..</OPTION>
				<OPTION value="ACTIVA">ACTIVA</OPTION>
                <OPTION value="INACTIVA">INACTIVA</OPTION>
			 </SELECT>
		</TD>
	</TR>
</TABLE>
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1">
    <TR>
		<TD class="titForm" colspan="2" align="center"><strong>Configuración de la agencia</strong></TD>
	</TR>
    <TR>
		<TD width="30%" class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Porcentaje de Ventas</TD>
		<TD class="objForm"><INPUT type="text" name="por_ventas" id="txt_por_ventas" value="0" size="10" maxlength="3" onKeyPress="return soloNumeros(event);" style="text-align:right"> % Parley&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<INPUT type="text" name="por_derecho" id="txt_por_derecho" value="0" size="5" maxlength="3" onKeyPress="return soloNumeros(event);" style="text-align:right"> % Por derecho</TD>
	</TR>
    <TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Porcentaje de Utilidad</TD>
		<TD class="objForm"><INPUT type="text" name="por_utilidad" id="txt_por_utilidad" value="0" size="10" maxlength="3" onKeyPress="return soloNumeros(event);" style="text-align:right"> %</TD>
	</TR>
    <TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Monto Mínimo del Ticket&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="monto_min" id="monto_min" value="10" size="10" maxlength="8" onKeyPress="return soloNumeros(event);" style="text-align:right"> BsF</TD>
	</TR>
    <TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Monto Máximo del Ticket&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="monto_max" id="monto_max" value="0" size="10" maxlength="8" onKeyPress="return soloNumeros(event);" style="text-align:right"> BsF Parley&nbsp;&nbsp;&nbsp;<INPUT type="text" name="monto_derecho" id="txt_monto_derecho" value="0" size="5" maxlength="5" onKeyPress="return soloNumeros(event);" style="text-align:right"> BsF Por derecho</TD>
	</TR>
    <TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Monto Máximo del Premio&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="premio_max" id="premio_max" value="0" size="10" maxlength="8" onKeyPress="return soloNumeros(event);" style="text-align:right"> BsF</TD>
	</TR>
    <TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Monto Disponible Diario&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="saldo" id="txt_saldo" value="0" size="10" maxlength="8" onKeyPress="return soloNumeros(event);" style="text-align:right"> BsF</TD>
	</TR>
</TABLE>
</td></tr></table>