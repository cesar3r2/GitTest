<?php
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../include/php/common.php";
	include "../../clases/class.deporte.php";
	include "../../clases/class.logro_beisbol.php";
	include "../../clases/class.logro_basquetbol.php";
	include "../../clases/class.logro_futbol.php";
	include "../../clases/class.logro_futbol_americano.php";
	include "../../clases/class.logro_hockey.php";
	include "../../clases/class.logro_tennis.php";
	include "../../clases/class.logro_boxeo.php";
	include "../../clases/class.logro_formula1.php";
		
	$titulo = 'Procesar Apuestas';
	
	$objDep = new deporte();
	$fDep = $objDep->vista();
	
	$objBe = new logro_beisbol();
	$fBe = $objBe->logros_sin_resultados();
	
	$objBa = new logro_basquetbol();
	$fBa = $objBa->logros_sin_resultados();
	
	$objFu = new logro_futbol();
	$fFu = $objFu->logros_sin_resultados();
	
	$objFa = new logro_futbol_americano();
	$fFa = $objFa->logros_sin_resultados();
	
	$objHo = new logro_hockey();
	$fHo = $objHo->logros_sin_resultados();
	
	$objTe = new logro_tennis();
	$fTe = $objTe->logros_sin_resultados();
	
	$objBo = new logro_boxeo();
	$fBo = $objBo->logros_sin_resultados();
	
	$objF1 = new logro_formula1();
	$fF1 = $objF1->logros_sin_resultados();
?>

<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD valign="top"><FONT class="txtForm"><?php echo $titulo;?></FONT></TD>
		<TD width="50%" align="right">
			<?php barra_opciones2('procesarApuestas()', "cambiar_contenido('sistema/procesos/procesar_apuestas.php', 'sub_contenido')");?>
		</TD>
	</TR>
</TABLE>
<table width="100%" style="border-color:#CCC; border-width:1px; border-style:solid" cellpadding="0" cellspacing="0"><tr><td>
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1">
	<TR>
		<TD width="130px" class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Procesar&nbsp;</TD>
		<TD class="objForm">
        	<SELECT id="procesar">
	            <OPTION value="AT">Apuestas y Tickets</OPTION>
            	<OPTION value="A">Sólo Apuestas</OPTION>
                <OPTION value="T">Sólo Tickets</OPTION>
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
<TABLE align="left" width="100%" border="0" cellpadding="3" cellspacing="1">
	<TR bgcolor="#6FA144">
    	<TD colspan="6" align="center" style="color:#FFF"><strong>Encuentros pendientes por resultados</strong></TD>
    </TR>
    <TR bgcolor="#E46F29">
    	<TD colspan="6" align="center" style="color:#FFF"><strong>BÉISBOL</strong></TD>
    </TR>
    <TR bgcolor="#328AA4" style="color:#FFF">
    	<TD width="10%"><strong>ID</strong></TD>
        <TD width="45%"><strong>Encuentro</strong></TD>
        <TD width="15%"><strong>Fecha</strong></TD>
        <TD width="15%"><strong>Hora</strong></TD>
        <TD width="15%"><strong>Nro. Apuestas</strong></TD>
    </TR>
    <?php
	if (count($fBe) > 0) {
    	for ($i=0; $i<count($fBe); $i++) {
			$objBeAp = new logro_beisbol();
			$fBeAp = $objBeAp->apuesta_detalle_sin_resultados($fBe[$i]['id']);
	?>
    <TR>
        <TD class="objForm"><?php echo $fBe[$i]['id']; ?></TD>
        <TD class="objForm"><?php echo $fBe[$i]['equipo1'].' Vs. '.$fBe[$i]['equipo2']; ?></TD>
        <TD class="objForm"><?php echo fecha($fBe[$i]['fecha']); ?></TD>
        <TD class="objForm"><?php echo $fBe[$i]['hora']; ?></TD>
        <TD class="objForm"><?php echo $fBeAp[0]['apu_pendientes']; ?></TD>
    </TR>
    <?php
    	}
	} else {
	?>
    <TR>
    	<TD align="center" colspan="5" class="objForm">No existen encuentros pendientes por registrar</TD>
    </TR>
    <?php
	}
	?>
    <TR bgcolor="#E46F29">
    	<TD colspan="6" align="center" style="color:#FFF"><strong>BÁSQUETBOL</strong></TD>
    </TR>
    <TR bgcolor="#328AA4" style="color:#FFF">
    	<TD width="10%"><strong>ID</strong></TD>
        <TD width="45%"><strong>Encuentro</strong></TD>
        <TD width="15%"><strong>Fecha</strong></TD>
        <TD width="15%"><strong>Hora</strong></TD>
        <TD width="15%"><strong>Nro. Apuestas</strong></TD>
    </TR>
    <?php
	if (count($fBa) > 0) {
    	for ($i=0; $i<count($fBa); $i++) {
			$objBaAp = new logro_basquetbol();
			$fBaAp = $objBaAp->apuesta_detalle_sin_resultados($fBa[$i]['id']);
	?>
    <TR>
        <TD class="objForm"><?php echo $fBa[$i]['id']; ?></TD>
        <TD class="objForm"><?php echo $fBa[$i]['equipo1'].' Vs. '.$fBa[$i]['equipo2']; ?></TD>
        <TD class="objForm"><?php echo fecha($fBa[$i]['fecha']); ?></TD>
        <TD class="objForm"><?php echo $fBa[$i]['hora']; ?></TD>
        <TD class="objForm"><?php echo $fBaAp[0]['apu_pendientes']; ?></TD>
    </TR>
    <?php
    	}
	} else {
	?>
    <TR>
    	<TD align="center" colspan="5" class="objForm">No existen encuentros pendientes por registrar</TD>
    </TR>
    <?php
	}
	?>
    <TR bgcolor="#E46F29">
    	<TD colspan="6" align="center" style="color:#FFF"><strong>FÚTBOL</strong></TD>
    </TR>
    <TR bgcolor="#328AA4" style="color:#FFF">
    	<TD width="10%"><strong>ID</strong></TD>
        <TD width="45%"><strong>Encuentro</strong></TD>
        <TD width="15%"><strong>Fecha</strong></TD>
        <TD width="15%"><strong>Hora</strong></TD>
        <TD width="15%"><strong>Nro. Apuestas</strong></TD>
    </TR>
    <?php
	if (count($fFu) > 0) {
    	for ($i=0; $i<count($fFu); $i++) {
			$objFuAp = new logro_futbol();
			$fFuAp = $objFuAp->apuesta_detalle_sin_resultados($fFu[$i]['id']);
	?>
    <TR>
        <TD class="objForm"><?php echo $fFu[$i]['id']; ?></TD>
        <TD class="objForm"><?php echo $fFu[$i]['equipo1'].' Vs. '.$fFu[$i]['equipo2']; ?></TD>
        <TD class="objForm"><?php echo fecha($fFu[$i]['fecha']); ?></TD>
        <TD class="objForm"><?php echo $fFu[$i]['hora']; ?></TD>
        <TD class="objForm"><?php echo $fFuAp[0]['apu_pendientes']; ?></TD>
    </TR>
    <?php
    	}
	} else {
	?>
    <TR>
    	<TD align="center" colspan="5" class="objForm">No existen encuentros pendientes por registrar</TD>
    </TR>
    <?php
	}
	?>
    <TR bgcolor="#E46F29">
    	<TD colspan="6" align="center" style="color:#FFF"><strong>FÚTBOL AMERICANO</strong></TD>
    </TR>
    <TR bgcolor="#328AA4" style="color:#FFF">
    	<TD width="10%"><strong>ID</strong></TD>
        <TD width="45%"><strong>Encuentro</strong></TD>
        <TD width="15%"><strong>Fecha</strong></TD>
        <TD width="15%"><strong>Hora</strong></TD>
        <TD width="15%"><strong>Nro. Apuestas</strong></TD>
    </TR>
    <?php
	if (count($fFa) > 0) {
    	for ($i=0; $i<count($fFa); $i++) {
			$objFaAp = new logro_futbol_americano();
			$fFaAp = $objFaAp->apuesta_detalle_sin_resultados($fFa[$i]['id']);
	?>
    <TR>
        <TD class="objForm"><?php echo $fFa[$i]['id']; ?></TD>
        <TD class="objForm"><?php echo $fFa[$i]['equipo1'].' Vs. '.$fFa[$i]['equipo2']; ?></TD>
        <TD class="objForm"><?php echo fecha($fFa[$i]['fecha']); ?></TD>
        <TD class="objForm"><?php echo $fFa[$i]['hora']; ?></TD>
        <TD class="objForm"><?php echo $fFaAp[0]['apu_pendientes']; ?></TD>
    </TR>
    <?php
    	}
	} else {
	?>
    <TR>
    	<TD align="center" colspan="5" class="objForm">No existen encuentros pendientes por registrar</TD>
    </TR>
    <?php
	}
	?>
    <TR bgcolor="E46F29">
    	<TD colspan="6" align="center" style="color:#FFF"><strong>HOCKEY</strong></TD>
    </TR>
    <TR bgcolor="#328AA4" style="color:#FFF">
    	<TD width="10%"><strong>ID</strong></TD>
        <TD width="45%"><strong>Encuentro</strong></TD>
        <TD width="15%"><strong>Fecha</strong></TD>
        <TD width="15%"><strong>Hora</strong></TD>
        <TD width="15%"><strong>Nro. Apuestas</strong></TD>
    </TR>
    <?php
	if (count($fHo) > 0) {
    	for ($i=0; $i<count($fHo); $i++) {
			$objHoAp = new logro_futbol();
			$fHoAp = $objHoAp->apuesta_detalle_sin_resultados($fHo[$i]['id']);
	?>
    <TR>
        <TD class="objForm"><?php echo $fHo[$i]['id']; ?></TD>
        <TD class="objForm"><?php echo $fHo[$i]['equipo1'].' Vs. '.$fHo[$i]['equipo2']; ?></TD>
        <TD class="objForm"><?php echo fecha($fHo[$i]['fecha']); ?></TD>
        <TD class="objForm"><?php echo $fHo[$i]['hora']; ?></TD>
        <TD class="objForm"><?php echo $fHoAp[0]['apu_pendientes']; ?></TD>
    </TR>
    <?php
    	}
	} else {
	?>
    <TR>
    	<TD align="center" colspan="5" class="objForm">No existen encuentros pendientes por registrar</TD>
    </TR>
    <?php
	}
	?>
    <TR bgcolor="E46F29">
    	<TD colspan="6" align="center" style="color:#FFF"><strong>TENNIS</strong></TD>
    </TR>
    <TR bgcolor="#328AA4" style="color:#FFF">
    	<TD width="10%"><strong>ID</strong></TD>
        <TD width="45%"><strong>Encuentro</strong></TD>
        <TD width="15%"><strong>Fecha</strong></TD>
        <TD width="15%"><strong>Hora</strong></TD>
        <TD width="15%"><strong>Nro. Apuestas</strong></TD>
    </TR>
    <?php
	if (count($fTe) > 0) {
    	for ($i=0; $i<count($fTe); $i++) {
			$objTeAp = new logro_tennis();
			$fTeAp = $objTeAp->apuesta_detalle_sin_resultados($fTe[$i]['id']);
	?>
    <TR>
        <TD class="objForm"><?php echo $fTe[$i]['id']; ?></TD>
        <TD class="objForm"><?php echo $fTe[$i]['equipo1'].' Vs. '.$fTe[$i]['equipo2']; ?></TD>
        <TD class="objForm"><?php echo fecha($fTe[$i]['fecha']); ?></TD>
        <TD class="objForm"><?php echo $fTe[$i]['hora']; ?></TD>
        <TD class="objForm"><?php echo $fTeAp[0]['apu_pendientes']; ?></TD>
    </TR>
    <?php
    	}
	} else {
	?>
    <TR>
    	<TD align="center" colspan="5" class="objForm">No existen encuentros pendientes por registrar</TD>
    </TR>
    <?php
	}
	?>
    <TR bgcolor="E46F29">
    	<TD colspan="6" align="center" style="color:#FFF"><strong>BOXEO</strong></TD>
    </TR>
    <TR bgcolor="#328AA4" style="color:#FFF">
    	<TD width="10%"><strong>ID</strong></TD>
        <TD width="45%"><strong>Pelea</strong></TD>
        <TD width="15%"><strong>Fecha</strong></TD>
        <TD width="15%"><strong>Hora</strong></TD>
        <TD width="15%"><strong>Nro. Apuestas</strong></TD>
    </TR>
    <?php
	if (count($fBo) > 0) {
    	for ($i=0; $i<count($fBo); $i++) {
			$objBoAp = new logro_boxeo();
			$fBoAp = $objBoAp->apuesta_detalle_sin_resultados($fBo[$i]['id']);
	?>
    <TR>
        <TD class="objForm"><?php echo $fBo[$i]['id']; ?></TD>
        <TD class="objForm"><?php echo $fBo[$i]['equipo1'].' Vs. '.$fBo[$i]['equipo2']; ?></TD>
        <TD class="objForm"><?php echo fecha($fBo[$i]['fecha']); ?></TD>
        <TD class="objForm"><?php echo $fBo[$i]['hora']; ?></TD>
        <TD class="objForm"><?php echo $fBoAp[0]['apu_pendientes']; ?></TD>
    </TR>
    <?php
    	}
	} else {
	?>
    <TR>
    	<TD align="center" colspan="5" class="objForm">No existen peleas pendientes por registrar</TD>
    </TR>
    <?php
	}
	?>
    <TR bgcolor="E46F29">
    	<TD colspan="6" align="center" style="color:#FFF"><strong>FÓRMULA 1</strong></TD>
    </TR>
    <TR bgcolor="#328AA4" style="color:#FFF">
    	<TD width="10%"><strong>ID</strong></TD>
        <TD width="45%"><strong>Carrea</strong></TD>
        <TD width="15%"><strong>Fecha</strong></TD>
        <TD width="15%"><strong>Hora</strong></TD>
        <TD width="15%"><strong>Nro. Apuestas</strong></TD>
    </TR>
    <?php
	if (count($fF1) > 0) {
    	for ($i=0; $i<count($fF1); $i++) {
			$objF1Ap = new logro_boxeo();
			$fF1Ap = $objF1Ap->apuesta_detalle_sin_resultados($fF1[$i]['id']);
		
	?>
    <TR>
        <TD class="objForm"><?php echo $fF1[$i]['id']; ?></TD>
        <TD class="objForm"><?php echo $fF1[$i]['equipo1'].' Vs. '.$fF1[$i]['equipo2']; ?></TD>
        <TD class="objForm"><?php echo fecha($fF1[$i]['fecha']); ?></TD>
        <TD class="objForm"><?php echo $fF1[$i]['hora']; ?></TD>
        <TD class="objForm"><?php echo $fF1Ap[0]['apu_pendientes']; ?></TD>
    </TR>
    <?php
    	}
	} else {
	?>
    <TR>
    	<TD align="center" colspan="5" class="objForm">No existen carreras pendientes por registrar</TD>
    </TR>
    <?php
	}
	?>
</TABLE>
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1" id="tablaGanadores">
</TABLE>
</td></tr></table>