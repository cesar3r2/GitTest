<?php
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../include/php/common.php";
	include "../../clases/class.deporte.php";
	
	$objDep = new deporte();
	$fDep = $objDep->vista();
	
	$titulo = 'Procesar Ganadores';
	$fActual = date("Y-m-d");
	$fAnterior = date("Y-m-d", strtotime("$fActual -1 day"));
?>

<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD valign="top"><FONT class="txtForm"><?php echo $titulo;?></FONT></TD>
		<TD width="50%" align="right">
			<?php barra_opciones2('procesarGanadores()', "cambiar_contenido('sistema/procesos/procesar_ganadores.php', 'sub_contenido')");?>
		</TD>
	</TR>
</TABLE>
<BR><BR>
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="2">
	<TR>
		<TD width="120px" class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Fecha de Logros&nbsp;</TD>
		<TD class="objForm">
        	<SELECT id="fecha">
	            <OPTION value="<?php echo fecha($fAnterior); ?>"><?php echo fecha($fAnterior); ?></OPTION>
            	<OPTION value="<?php echo fecha($fActual); ?>"><?php echo fecha($fActual); ?></OPTION>
            </SELECT>
        </TD>
	</TR>
	<TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Deporte&nbsp;</TD>
		<TD class="objForm">
        	<SELECT id="deporte">
            <OPTION value="T">Todos los deportes</OPTION>
            </SELECT>
        </TD>
	</TR>
</TABLE>
<TABLE align="left" width="100%" border="0" cellpadding="1" cellspacing="1" id="tablaGanadores">
</TABLE>