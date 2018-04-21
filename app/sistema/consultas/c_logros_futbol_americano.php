<?php
	include "../../conexionConf.php";
	include "../../include/php/common.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.logro_futbol_americano.php";
	
	$id_deporte = '4';
	$fecha = fecha_sql($_GET['fecha']);
	
	$obj = new logro_futbol_americano();
	$fObj = $obj->consultas_logros_diarios_ligas($fecha);
	$totObj = count($fObj);
?>
<?php barra_opciones3("", "window.open('sistema/consultas/pdf_logros_futbol_americano.php?fecha=$fecha')", "cambiar_contenido('sistema/consultas/logros_diarios.php', 'sub_contenido')");?>
<DIV id="impresion">
<TABLE align="left" width="100%" border="0" cellpadding="1" cellspacing="1">
	<TR><TD align="center" colspan="9"><FONT style="color: #2B58A5; font-size:14px"><strong>Logros de Fútbol Americano para el <?php echo fecha($fecha); ?></strong></FONT></TD></TR>
</TABLE>
<?php 
if ($totObj == 0) { ?>
<TABLE align="left" width="100%" border="0" cellpadding="5" cellspacing="5">
	<TR bgcolor="#F3F3F3">
		<TD colspan='5' align="center" style="color:#F00">No existen logros registrados para la fecha seleccionada</TD>
	</TR>
</TABLE>
<?php } else {
	for($j=0; $j<$totObj; $j++) { ?>
<TABLE align="left" width="100%" border="0" cellpadding="1" cellspacing="1">
	<THEAD>
    <TR bgcolor="#6FA144"><TD colspan="5" style="text-align:center;"><FONT style="font-weight:bold; color: #FFF;"><?php echo $fObj[$j]['nombre']; ?></FONT></TD></TR>
	<TR bgcolor="#328AA4" height="25">
		<TD width="25%" align="center" style="color: #FFFFFF"><strong>Encuentro</strong></TD>
        <TD width="15%" align="center" style="color: #FFFFFF"><strong>Hora</strong></TD>
        <TD width="20%" align="center" style="color: #FFFFFF"><strong>Ganar</strong></TD>
        <TD width="20%" align="center" style="color: #FFFFFF"><strong>RunLine</strong></TD>
        <TD width="20%" align="center" style="color: #FFFFFF"><strong>AltaBaja</strong></TD>
	</TR>
	</THEAD>
	<?php
				$objeto = new logro_futbol_americano();
				$fObj1 = $objeto->consultas_logros_diarios_encuentros($fObj[$j]['id_liga'], $fecha);
				$totObj1 = count($fObj1);
				
				for($i=0; $i<$totObj1; $i++) {
					if($i%2==0) {
						$color='#FCFCFC';
					} else {
						$color='#F0F0F0';
					}
					if ($fObj1[$i]['favorito'] == 1) {
						$signo1 = '-';
						$signo2 = '+';
					} else {
						$signo1 = '+';
						$signo2 = '-';
					}
	?>
	<TBODY>
	<TR bgcolor="<?php echo $color;?>">
		<TD align="center" style="color: #000;"><strong><?php echo $fObj1[$i]['equipo1'].'<br>Vs.<br>'.$fObj1[$i]['equipo2']; ?></strong></TD>
        <TD align="center"><?php echo substr($fObj1[$i]['hora'], 0, 5); ?></TD>
		<TD align="center"><?php echo $fObj1[$i]['ganador1'].'<br><br>'.$fObj1[$i]['ganador2']; ?></TD>
        <TD align="center">
			<?php if ($fObj1[$i]['v_runline']!=0) echo $signo1.$fObj1[$i]['v_runline'].' ('.$fObj1[$i]['runline1'].')<br><br>'.$signo2.$fObj1[$i]['v_runline'].' ('.$fObj1[$i]['runline2'].')'; ?>
        </TD>
        <TD align="center">
			<?php if ($fObj1[$i]['v_altabaja']!=0) echo '<span style="color:#F00">A</span> '.$fObj1[$i]['v_altabaja'].' ('.$fObj1[$i]['altabaja1'].')<br><br><span style="color:#F00">B</span> '.$fObj1[$i]['v_altabaja'].' ('.$fObj1[$i]['altabaja2'].')'; ?>
        </TD>
	</TR>
    <?php } ?>
	</TBODY>
	<TR bgcolor="#CCCCCC">
		<TD colspan='5' align="center" height="12"></TD>
	</TR>
</TABLE>
<?php } ?>
<BR><BR>
<?php
}
?>
</DIV>