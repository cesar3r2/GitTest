<?php
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../include/php/common.php";
	include "../../clases/class.logro_boxeo.php";
	include "../../clases/class.resultado_boxeo.php";
	
	$titulo = 'Cargar Resultados | Boxeo';
	$fActual = date("Y-m-d");
	$fAnterior = date("Y-m-d", strtotime("$fActual -1 day"));
	$fecha = fecha($fAnterior);
?>

<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD valign="top"><FONT class="txtForm"><?php echo $titulo;?></FONT></TD>
        <TD width="50%" align="right">
			<?php barra_opciones2('guardarResultadosBoxeo()', "cambiar_contenido('sistema/procesos/cargar_resultados.php', 'sub_contenido')");?>
		</TD>
	</TR>
</TABLE>

<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1" style="border-color:#CCC; border-width:1px; border-style:solid">
	 <TR>
    	<TD width="190px" class="titForm" align="right" height="25px">&iquest;Modificar Resultado?&nbsp;</TD>
        <TD class="objForm"><INPUT type="checkbox" id="modificar">&nbsp;SI</TD>
    </TR>
	<TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT><strong>Fecha de Logros</strong>&nbsp;</TD>
		<TD class="objForm">
        	<SELECT id="fecha" onchange="cargarEncuentrosBoxeo()">
	            <OPTION value="0">Seleccione..</OPTION>
            	<OPTION value="<?php echo $fecha; ?>"><?php echo $fecha; ?></OPTION>
                <OPTION value="<?php echo fecha($fActual); ?>"><?php echo fecha($fActual); ?></OPTION>
            </SELECT>
        </TD>
	</TR>
	<TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT><strong>Pelea</strong>&nbsp;</TD>
        <TD class="objForm">
        	<SELECT id="sel_encuentro" onchange="datosEncuentroBoxeo()">
            	<OPTION value="0">Seleccione..</OPTION>
            </SELECT>
        </TD>
	</TR>
    <TR>
    	<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Estatus&nbsp;</TD>
        <TD class="objForm">
        	<SELECT id="sel_estatus">
            	<OPTION value="0">Seleccione..</OPTION>
                <OPTION value="FINALIZADO" selected="selected">FINALIZADO</OPTION>
                <OPTION value="EN PROCESO">EN PROCESO</OPTION>
                <OPTION value="SUSPENDIDO">SUSPENDIDO</OPTION>
            </SELECT>
        </TD>
    </TR>
    <TR>
    	<TD class="titForm" align="right">Ganador Pelea&nbsp;</TD>
        <TD class="objForm">
        	<SELECT id="sel_ganador">
            	<OPTION value="0">Seleccione..</OPTION>
            </SELECT>
        </TD>
    </TR>
    <TR>
    	<TD class="titForm" align="right">Marcador Final&nbsp;</TD>
        <TD class="objForm"><INPUT type="text" id="txt_marcador" value="" size="25" maxlength="30"></TD>
    </TR>
</TABLE>