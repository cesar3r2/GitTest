<?php
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.deporte.php";
	
	$titulo = 'Resultados Diarios';
	
	$objDep = new deporte();
	$fDep = $objDep->vista();
?>

<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD valign="top"><FONT class="txtForm"><?php echo $titulo;?></FONT></TD>
	</TR>
    <TD width="50%" align="right">
			<?php barra_opciones3("resultadosDiarios()", "", "");?>
	</TD>
</TABLE>
<br>
<FORM id="resultadosDiarios">
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1" style="border-color:#CCC; border-width:1px; border-style:solid">
	<TR>
		<TD width="20%" class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Deporte&nbsp;</TD>
		<TD class="objForm">
	        <SELECT name="deporte" id="deporte">
				<OPTION value="0">Seleccione..</OPTION>
                <?php for($i=0; $i<count($fDep); $i++) { ?>
                <OPTION value="<?php echo $fDep[$i]['id']; ?>"><?php echo $fDep[$i]['nombre']; ?></OPTION>
                <?php }?>
			</SELECT>
		</TD>
	</TR>
    <TR height="30px">
    	<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Resultados&nbsp;</TD>
        <TD class="objForm">
        	<input type="radio" name="apuestas" id="apuestas" value="hoy" onclick="cambiar_fechas_resultados(this.value);" checked="checked"> del día actual&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        	<input type="radio" name="apuestas" id="apuestas" value="ayer" onclick="cambiar_fechas_resultados(this.value);"> del día anterior&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" name="apuestas" id="apuestas" value="otro" onclick="cambiar_fechas_resultados(this.value);"> de otro día
            <input type="hidden" id="hoy" value="<?php echo date('d/m/Y'); ?>" />
            <input type="hidden" id="ayer" value="<?php echo date("d/m/Y", strtotime("-1 day")); ?>" />
        </TD>
    </TR>
	<TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Fecha&nbsp;</TD>
		<TD class="objForm"><table border="0" cellpadding="0" cellspacing="0"><TR><TD><INPUT type="text" name="fecha" id="fecha" size="10" maxlength="10" onChange="soloFecha(this, 'fecha')" value="<?php echo date('d/m/Y');?>"></TD><td>&nbsp;<IMG style="cursor:pointer;" id="d_fecha" src="include/js/jscalendar/cal.gif" onclick='Calendar.setup({inputField:"fecha", ifFormat:"%d/%m/%Y",button:"d_fecha"});'></td></TR></table></TD></TR>
	</TR>
</TABLE>
</FORM>