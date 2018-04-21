<?php
	session_start();
	ob_start();
	
	$tipo = $_SESSION['PERFIL_USUARIO'];
	$usuario = $_SESSION["USUARIO"];
	
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.agencia.php";
	
	$titulo = 'Movimientos de Caja';
	
	$objAgencia = new agencia();
	if ($tipo == 1)
		$fAgencia = $objAgencia->consultas_lista();
	else if ($tipo == 2)
		$fAgencia = $objAgencia->consultas_lista_banquero($usuario);
	else if ($tipo == 3)
		$fAgencia = $objAgencia->consultas_lista_agencia($usuario);
?>

<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD valign="top"><FONT class="txtForm"><?php echo $titulo;?></FONT></TD>
		<TD width="50%" align="right">
			<?php barra_opciones3("repMovCaja()", "", "");?>
		</TD>
	</TR>
</TABLE>
<br>
<FORM id="movCaja">
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1" style="border-color:#CCC; border-width:1px; border-style:solid">
	<TR>
		<TD width="20%" class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Agencia&nbsp;</TD>
		<TD class="objForm"><SELECT name="agencia" id="sel_agencia">
				<OPTION value="0">Seleccione..</OPTION>
				<?php for($i=0; $i<count($fAgencia); $i++) {?>
				<OPTION title="Código: <?php echo $fAgencia[$i]['id']?>" value="<?php echo $fAgencia[$i]['id']?>"><?php echo $fAgencia[$i]['nombre']?></OPTION>
				<?php }?>
			 </SELECT>
		</TD>
	</TR>
    <TR height="30px">
    	<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Movimientos&nbsp;</TD>
        <TD class="objForm">
        	<input type="radio" name="apuestas" id="apuestas" value="hoy" onclick="cambiar_fechas_reportes(this.value);" checked="checked"> del día actual&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        	<input type="radio" name="apuestas" id="apuestas" value="ayer" onclick="cambiar_fechas_reportes(this.value);"> del día anterior&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" name="apuestas" id="apuestas" value="rango" onclick="cambiar_fechas_reportes(this.value);"> por rango
            <input type="hidden" id="hoy" value="<?php echo date('d/m/Y'); ?>" />
            <input type="hidden" id="ayer" value="<?php echo date("d/m/Y", strtotime("-1 day")); ?>" />
        </TD>
    </TR>
	<TR>
		<TD width="120px" class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Fecha Desde&nbsp;</TD>
		<TD class="objForm"><table border="0" cellpadding="0" cellspacing="0"><TR><TD><INPUT type="text" name="fecha_desde" id="fecha_desde" size="10" maxlength="10" onChange="soloFecha(this, 'fecha_desde')" value="<?php echo date('d/m/Y');?>"></TD><td>&nbsp;<IMG style="cursor:pointer;" id="d_fecha1" src="include/js/jscalendar/cal.gif" onclick='Calendar.setup({inputField:"fecha_desde", ifFormat:"%d/%m/%Y",button:"d_fecha1"});'></td></TR></table></TR>
	</TR>
	<TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Fecha Hasta&nbsp;</TD>
		<TD class="objForm"><table border="0" cellpadding="0" cellspacing="0"><TR><TD><INPUT type="text" name="fecha_hasta" id="fecha_hasta" size="10" maxlength="10" onChange="soloFecha(this, 'fecha_hasta')" value="<?php echo date('d/m/Y');?>"></TD><td>&nbsp;<IMG style="cursor:pointer;" id="d_fecha2" src="include/js/jscalendar/cal.gif" onclick='Calendar.setup({inputField:"fecha_hasta", ifFormat:"%d/%m/%Y",button:"d_fecha2"});'></td></TR></table></TD>
	</TR>
</TABLE>
</FORM>