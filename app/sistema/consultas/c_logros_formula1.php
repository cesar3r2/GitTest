<?php
	include "../../conexionConf.php";
	include "../../include/php/common.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.logro_formula1.php";
	
	$id_deporte = '8';
	$fecha = fecha_sql($_GET['fecha']);
	
	$obj = new logro_formula1();
	$fObj = $obj->consultas_logros_diarios_ligas($fecha);
	$totObj = count($fObj);
?>
<?php barra_opciones3("", "window.open('sistema/consultas/pdf_logros_formula1.php?fecha=$fecha')", "cambiar_contenido('sistema/consultas/logros_diarios.php', 'sub_contenido')");?>
<DIV id="impresion">
<TABLE align="left" width="100%" border="0" cellpadding="1" cellspacing="1">
	<TR><TD align="center" colspan="4"><FONT style="color: #2B58A5; font-size:14px"><strong>Logros de Fórmula 1 para el <?php echo fecha($fecha); ?></strong></FONT></TD></TR>
</TABLE>
<?php 
if ($totObj == 0) { ?>
<TABLE align="left" width="100%" border="0" cellpadding="5" cellspacing="5">
	<TR bgcolor="#F3F3F3">
		<TD colspan='4' align="center" style="color:#F00">No existen logros registrados para la fecha seleccionada</TD>
	</TR>
</TABLE>
<?php } else {
	for($j=0; $j<$totObj; $j++) { ?>
<TABLE align="left" width="100%" border="0" cellpadding="1" cellspacing="1">
	<THEAD>
    <TR bgcolor="#6FA144"><TD colspan="4" style="text-align:center;"><FONT style="font-weight:bold; color: #FFF;"><?php echo $fObj[$j]['nombre']; ?></FONT></TD></TR>
	<TR bgcolor="#328AA4" height="25">
		<TD width="30%" align="center" style="color: #FFFFFF"><strong>Carrera</strong></TD>
        <TD width="20%" align="center" style="color: #FFFFFF"><strong>Hora</strong></TD>
        <TD width="30%" align="center" style="color: #FFFFFF"><strong>Piloto</strong></TD>
        <TD width="20%" align="center" style="color: #FFFFFF"><strong>Ganar</strong></TD>
	</TR>
	</THEAD>
	<?php 
				$objeto = new logro_formula1();
				$fObj1 = $objeto->consultas_logros_diarios_encuentros($fObj[$j]['id_liga'], $fecha);
				$totObj1 = count($fObj1);
				
				for($i=0; $i<$totObj1; $i++) {
					if($i%2==0) {
						$color='#FCFCFC';
					} else {
						$color='#F0F0F0';
					}
	?>
	<TBODY>
	<TR bgcolor="<?php echo $color;?>">
	    <TD align="center"><strong><?php echo $fObj1[$i]['encuentro']; ?></strong></TD>
    	<TD align="center"><?php echo substr($fObj1[$i]['hora'], 0, 5); ?></TD>
		<TD align="center" style="color: #000;">
			<strong><?php echo $fObj1[$i]['equipo1'].'<br>'.$fObj1[$i]['equipo2'].'<br>'.$fObj1[$i]['equipo3'].'<br>'.$fObj1[$i]['equipo4'].'<br>'.$fObj1[$i]['equipo5'].'<br>'.$fObj1[$i]['equipo6'].'<br>'.$fObj1[$i]['equipo7'].'<br>'.$fObj1[$i]['equipo8'].'<br>'.$fObj1[$i]['equipo9'].'<br>'.$fObj1[$i]['equipo10'].'<br>'.$fObj1[$i]['equipo11'].'<br>'.$fObj1[$i]['equipo12'].'<br>'.$fObj1[$i]['equipo13'].'<br>'.$fObj1[$i]['equipo14'].'<br>'.$fObj1[$i]['equipo15'].'<br>'.$fObj1[$i]['equipo16'].'<br>'.$fObj1[$i]['equipo17'].'<br>'.$fObj1[$i]['equipo18'].'<br>'.$fObj1[$i]['equipo19'].'<br>'.$fObj1[$i]['equipo20'].'<br>'.$fObj1[$i]['equipo21'].'<br>'.$fObj1[$i]['equipo22'].'<br>'.$fObj1[$i]['equipo23'].'<br>'.$fObj1[$i]['equipo24']; ?></strong>
        </TD>
		<TD align="center">
			<?php echo $fObj1[$i]['ganador1'].'<br>'.$fObj1[$i]['ganador2'].'<br>'.$fObj1[$i]['ganador3'].'<br>'.$fObj1[$i]['ganador4'].'<br>'.$fObj1[$i]['ganador5'].'<br>'.$fObj1[$i]['ganador6'].'<br>'.$fObj1[$i]['ganador7'].'<br>'.$fObj1[$i]['ganador8'].'<br>'.$fObj1[$i]['ganador9'].'<br>'.$fObj1[$i]['ganador10'].'<br>'.$fObj1[$i]['ganador11'].'<br>'.$fObj1[$i]['ganador12'].'<br>'.$fObj1[$i]['ganador13'].'<br>'.$fObj1[$i]['ganador14'].'<br>'.$fObj1[$i]['ganador15'].'<br>'.$fObj1[$i]['ganador16'].'<br>'.$fObj1[$i]['ganador17'].'<br>'.$fObj1[$i]['ganador18'].'<br>'.$fObj1[$i]['ganador19'].'<br>'.$fObj1[$i]['ganador20'].'<br>'.$fObj1[$i]['ganador21'].'<br>'.$fObj1[$i]['ganador22'].'<br>'.$fObj1[$i]['ganador23'].'<br>'.$fObj1[$i]['ganador24']; ?>
        </TD>
	</TR>
    </TBODY>
	<?php } ?>
	</TBODY>
	<TR bgcolor="#CCCCCC">
		<TD colspan='4' align="center" height="12"></TD>
	</TR>
</TABLE>
<?php } ?>
<BR><BR>
<?php
}
?>
</DIV>