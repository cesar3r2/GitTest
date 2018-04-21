<?php
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../include/php/common.php";
	include "../../clases/class.deporte.php";
	
	$titulo = 'Anular Jugadas';
	
	$objDep = new deporte();
	$fDep = $objDep->vista();
	
	$fActual = date("Y-m-d");
	$fAnterior = date("Y-m-d", strtotime("$fActual -1 day"));
	$fecha = fecha($fAnterior);
?>

<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD valign="top"><FONT class="txtForm"><?php echo $titulo;?></FONT></TD>
        <TD width="50%" align="right">
			<?php barra_opciones2('anularJugadas()', "cambiar_contenido('sistema/procesos/anular_jugadas.php', 'sub_contenido')");?>
		</TD>
	</TR>
</TABLE>
<table width="100%" style="border-color:#CCC; border-width:1px; border-style:solid" cellpadding="0" cellspacing="0"><tr><td>
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1">
	 <TR height="25px">
    	<TD width="150px" class="titForm" align="right">&iquest;Revertir Jugada?&nbsp;</TD>
        <TD class="objForm"><INPUT type="checkbox" id="modificar">&nbsp;SI</TD>
    </TR>
    <TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Deporte&nbsp;</TD>
		<TD class="objForm">
	        <SELECT name="deporte" id="deporte" onchange="cargarJugadas();">
				<OPTION value="0">Seleccione..</OPTION>
                <?php for($i=0; $i<count($fDep); $i++) { ?>
                <OPTION title="Código: <?php echo $fDep[$i]['id']; ?>" value="<?php echo $fDep[$i]['id']; ?>"><?php echo $fDep[$i]['nombre']; ?></OPTION>
                <?php }?>
			</SELECT>
		</TD>
	</TR>
	<TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Fecha de Logros&nbsp;</TD>
		<TD class="objForm">
        	<SELECT id="fecha" onchange="cargarEncuentrosAnular()">
	            <OPTION value="0">Seleccione..</OPTION>
            	<OPTION value="<?php echo $fecha; ?>"><?php echo $fecha; ?></OPTION>
                <OPTION value="<?php echo fecha($fActual); ?>"><?php echo fecha($fActual); ?></OPTION>
            </SELECT>
        </TD>
	</TR>
	<TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Encuentro&nbsp;</TD>
        <TD class="objForm">
        	<SELECT id="sel_encuentro" onchange="datosEncuentroAnular();">
            	<OPTION value="0">Seleccione..</OPTION>
            </SELECT>
        </TD>
	</TR>
    <TR>
    	<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Jugada a Anular&nbsp;</TD>
        <TD class="objForm">
        	<SELECT id="sel_jugada">
            	<OPTION value="0">Seleccione..</OPTION>
            </SELECT>
        </TD>
    </TR>
</TABLE>
<INPUT type="hidden" id="logEncuentro" value="">
<INPUT type="hidden" id="logEstatus" value="">
<INPUT type="hidden" id="resEstatus" value="">
<INPUT type="hidden" id="logAltaBaja" value="">
<INPUT type="hidden" id="logABMitad" value="">
<INPUT type="hidden" id="logRLMitad" value="">
<INPUT type="hidden" id="resGanMitad" value="">
<INPUT type="hidden" id="resRunLine" value="">
<INPUT type="hidden" id="resAltaBaja" value="">
<INPUT type="hidden" id="resABMitad" value="">
<INPUT type="hidden" id="resRLMitad" value="">
<br>
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1" id="tablaDatosEncuentro">
</TABLE>
</td></tr></table>