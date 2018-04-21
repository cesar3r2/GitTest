<?php
	session_start();
	ob_start();
	
	$tipo = $_SESSION['PERFIL_USUARIO'];
	$usuario = $_SESSION["USUARIO"];
	
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.agencia.php";
	
	$titulo = 'Apuestas Detalladas';
	
	$objAgencia = new agencia();
	if ($tipo == 1)
		$fAgencia = $objAgencia->consultas_lista();
	else if ($tipo == 2)
		$fAgencia = $objAgencia->consultas_lista_banquero($usuario);
	else if (($tipo == 3) || ($tipo == 4))
		$fAgencia = $objAgencia->consultas_lista_agencia($usuario);
?>

<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD valign="top"><FONT class="txtForm"><?php echo $titulo;?></FONT></TD>
    </TR>
    <TR>
		<TD align="right">
			<?php barra_opciones3("conApuestasDetalladas()", "", "");?>
		</TD>
	</TR>
</TABLE>
<FORM id="apuestasDet">
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1" style="border-color:#CCC; border-width:1px; border-style:solid">
	<TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Agencia&nbsp;</TD>
		<TD class="objForm"><SELECT name="agencia" id="sel_agencia">
				<OPTION value="0">Seleccione..</OPTION>
                <?php if ($tipo == 1) { ?>
                <OPTION value="TODAS">*** TODAS ***</OPTION>
                <?php } ?>
				<?php for($i=0; $i<count($fAgencia); $i++) { ?>
				<OPTION title="Código: <?php echo $fAgencia[$i]['id']?>" value="<?php echo $fAgencia[$i]['id']?>"><?php echo $fAgencia[$i]['nombre']?></OPTION>
				<?php }?>
			 </SELECT>
		</TD>
	</TR>
   	<TR>
		<TD width="20%" class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Estatus&nbsp;</TD>
		<TD class="objForm">
			<SELECT name="estatus" id="estatus">
				<OPTION value="0">Seleccione..</OPTION>
                <OPTION value="TODOS">*** TODOS ***</OPTION>
               	<OPTION value="PENDIENTE">PENDIENTE</OPTION>
               	<OPTION value="GANADORA">GANANDORA</OPTION>
                <OPTION value="PERDEDORA">PERDEDORA</OPTION>
                <OPTION value="PAGADA">PAGADA</OPTION>
                <OPTION value="ANULADA">ANULADA</OPTION>
			</SELECT>
		</TD>
	</TR>
    <TR height="30px">
    	<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Apuestas&nbsp;</TD>
        <TD class="objForm">
        	<input type="radio" name="apuestas" id="apuestas" value="hoy" onclick="cambiar_fechas(this.value);" checked="checked"> del día actual&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        	<input type="radio" name="apuestas" id="apuestas" value="ayer" onclick="cambiar_fechas(this.value);"> del día anterior&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" name="apuestas" id="apuestas" value="rango" onclick="cambiar_fechas(this.value);"> por rango
            <input type="hidden" id="hoy" value="<?php echo date('d/m/Y'); ?>" />
            <input type="hidden" id="ayer" value="<?php echo date("d/m/Y", strtotime("-1 day")); ?>" />
        </TD>
    </TR>
	<TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Fecha Desde&nbsp;</TD>
		<TD class="objForm"><table border="0" cellpadding="0" cellspacing="0"><TR><TD><INPUT type="text" name="fecha_desde" id="fecha_desde" size="10" maxlength="10" onChange="soloFecha(this, 'fecha_desde')" value="<?php echo date('d/m/Y');?>"></TD><td>&nbsp;<IMG style="cursor:pointer;" id="d_fecha1" src="include/js/jscalendar/cal.gif" onclick='Calendar.setup({inputField:"fecha_desde", ifFormat:"%d/%m/%Y",button:"d_fecha1"});'></td></TR></table></TD>
	</TR>
	<TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Fecha Hasta&nbsp;</TD>
		<TD class="objForm"><table border="0" cellpadding="0" cellspacing="0"><TR><TD><INPUT type="text" name="fecha_hasta" id="fecha_hasta" size="10" maxlength="10" onChange="soloFecha(this, 'fecha_hasta')" value="<?php echo date('d/m/Y');?>"></TD><td>&nbsp;<IMG style="cursor:pointer;" id="d_fecha2" src="include/js/jscalendar/cal.gif" onclick='Calendar.setup({inputField:"fecha_hasta", ifFormat:"%d/%m/%Y",button:"d_fecha2"});'></td></TR></table></TD>
	</TR>
</TABLE>
</FORM>