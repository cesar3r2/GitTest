<?php
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../include/php/common.php";
	include "../../clases/class.logro_hockey.php";
	include "../../clases/class.resultado_hockey.php";
	
	$titulo = 'Cargar Resultados | Hockey';
	$fActual = date("Y-m-d");
	$fAnterior = date("Y-m-d", strtotime("$fActual -1 day"));
	$fecha = fecha($fAnterior);
?>

<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD valign="top"><FONT class="txtForm"><?php echo $titulo;?></FONT></TD>
        <TD width="50%" align="right">
			<?php barra_opciones2('guardarResultadosHockey()', "cambiar_contenido('sistema/procesos/cargar_resultados.php', 'sub_contenido')");?>
		</TD>
	</TR>
</TABLE>

<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1" style="border-color:#CCC; border-width:1px; border-style:solid">
	 <TR>
    	<TD  width="190px" class="titForm" align="right" height="25px">&iquest;Modificar Resultado?&nbsp;</TD>
        <TD class="objForm"><INPUT type="checkbox" id="modificar">&nbsp;SI</TD>
    </TR>
	<TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT><strong>Fecha de Logros</strong>&nbsp;</TD>
		<TD class="objForm">
        	<SELECT id="fecha" onchange="cargarEncuentrosHockey()">
	            <OPTION value="0">Seleccione..</OPTION>
            	<OPTION value="<?php echo $fecha; ?>"><?php echo $fecha; ?></OPTION>
                <OPTION value="<?php echo fecha($fActual); ?>"><?php echo fecha($fActual); ?></OPTION>
            </SELECT>
        </TD>
	</TR>
	<TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT><strong>Encuentro</strong>&nbsp;</TD>
        <TD class="objForm">
        	<SELECT id="sel_encuentro" onchange="datosEncuentroHockey()">
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
	   	<TD class="titForm" align="right"><strong>Marcador Final</strong>&nbsp;</TD>
        <TD class="titForm">
        	<INPUT onKeyPress="return soloNumeros(event);" onblur="javascript: calcularMarcador('tot_goles');" type="text" value="0" id="marcador1" size="2" maxlength="3" onchange="calculaResHockey();"> x 
            <INPUT onKeyPress="return soloNumeros(event);" onblur="javascript: calcularMarcador('tot_goles');" type="text" value="0" id="marcador2" size="2" maxlength="3" onchange="calculaResHockey();">
            &nbsp;&nbsp;
            <img src="imagenes/seleccionar.png" border="0" style="cursor:pointer" onclick="calculaResHockey();">
        </TD>
    </TR>
    <TR>
    	<TD class="titForm" align="right">Ganador Encuentro&nbsp;</TD>
        <TD class="objForm">
        	<SELECT id="sel_ganador">
            	<OPTION value="0">Seleccione..</OPTION>
            </SELECT>
            <input type="hidden" id="favorito" value="" />
        </TD>
    </TR>
    <TR>
    	<TD class="titForm" align="right">Ganador RunLine&nbsp;</TD>
        <TD class="objForm">
        	<SELECT id="sel_runline">
            	<OPTION value="0">Seleccione..</OPTION>
            </SELECT>
            <input type="hidden" id="v_runline" value="" />
        </TD>
    </TR>
    <TR>
    	<TD class="titForm" align="right">Total Goles&nbsp;</TD>
        <TD class="objForm"><INPUT type="text" id="tot_goles" value="0" size="5" maxlength="3" onKeyPress="return soloNumeros(event);">&nbsp;&nbsp;<span id="v_ab"></span></TD>
    </TR>
</TABLE>