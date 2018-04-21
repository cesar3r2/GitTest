<?php
	include "../../conexionConf.php";
	include "../../include/php/common.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.logro_beisbol.php";
	include "../../clases/class.resultado_beisbol.php";
	
	$id_deporte = '1';
	$fecha = fecha_sql($_GET['fecha']);
	
	$obj = new logro_beisbol();
	$fObj = $obj->consultas_logros_diarios_ligas($fecha);
	$totObj = count($fObj);
?>
<?php barra_opciones3("", "imprimir('impresion')", "cambiar_contenido('sistema/consultas/resultados_diarios.php', 'sub_contenido')");?>
<DIV id="impresion">
<TABLE  align="left" width="100%" border="0" cellpadding="1" cellspacing="1">
   	<TR><TD align="center" colspan="9"><FONT style="color : #2B58A5; font-size:14px"><strong>Resultados de Béisbol para el <?php echo fecha($fecha); ?></FONT></strong></TD></TR>
</TABLE>
<?php 
if ($totObj == 0) { ?>
<TABLE align="left" width="100%" border="0" cellpadding="5" cellspacing="5">
	<TR bgcolor="#F3F3F3">
		<TD colspan='12' align="center" style="color:#F00">No existen resultados registrados para la fecha seleccionada</TD>
	</TR>
</TABLE>
<?php  } else {
for($j=0; $j<$totObj; $j++) {
?>	
	
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1">
	<THEAD>
    <TR bgcolor="#6FA144"><TD colspan="12" style="text-align:center;"><FONT style="font-weight:bold; color: #FFF; font-size:14px"><?php echo $fObj[$j]['nombre']; ?></FONT></TD></TR>
    <TR bgcolor="#328AA4" height="20">
    	<TD></TD>
		<TD colspan="5" align="center" style="color: #FFFFFF"><strong>Juego Completo</strong></TD>
        <TD colspan="4" align="center" style="color: #FFFFFF"><strong>Primera Mitad</strong></TD>
        <TD colspan="2" align="center" style="color: #FFFFFF"></TD>
	</TR>
	<TR bgcolor="#328AA4" height="20">
		<TD align="center" style="color: #FFFFFF"><strong>Encuentro</strong></TD>
        <TD align="center" style="color: #FFFFFF"><strong>Ganador</strong></TD>
        <TD align="center" style="color: #FFFFFF"><strong>RunLine</strong></TD>
        <TD align="center" style="color: #FFFFFF"><strong>Super RL</strong></TD>
        <TD align="center" style="color: #FFFFFF"><strong>A/B</strong></TD>
        <TD align="center" style="color: #FFFFFF"><strong>Res.</strong></TD>
        <TD align="center" style="color: #FFFFFF"><strong>Ganador</strong></TD>
        <TD align="center" style="color: #FFFFFF"><strong>RunLine</strong></TD>
		<TD align="center" style="color: #FFFFFF"><strong>A/B</strong></TD>
        <TD align="center" style="color: #FFFFFF"><strong>Res.</strong></TD>
        <TD align="center" style="color: #FFFFFF"><strong>P. Inng</strong></TD>
		<TD align="center" style="color: #FFFFFF"><strong>P. Anot</strong></TD>
	</TR>
	</THEAD>
	<?php
	$objeto = new resultado_beisbol();
	$fObj1 = $objeto->consultas_resultados_diarios_encuentros($fObj[$j]['id_liga'], $fecha);
	$totObj1 = count($fObj1);
	
	if ($totObj1 == 0) { ?>
	<TR bgcolor="#F3F3F3">
		<TD colspan="12" align="center" style="color:#F00">No existen resultados registrados para esta liga</TD>
	</TR>
	<?php 
	} else {
	
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
		<TD align="center"><?php echo $fObj1[$i]['ganador']; ?></TD>
        <TD align="center"><?php echo $fObj1[$i]['runline']; ?></TD>
        <TD align="center"><?php echo $fObj1[$i]['srunline']; ?></TD>
        <TD align="center"><span style="color:#F00"><?php echo $fObj1[$i]['total_carreras']; ?></span></TD>
        <TD align="center"><strong><?php echo $fObj1[$i]['marcador']; ?></strong></TD>
		<TD align="center"><?php echo $fObj1[$i]['g_mediojuego']; ?></TD>
        <TD align="center"><?php echo $fObj1[$i]['runlinem']; ?></TD>
        <TD align="center"><span style="color:#F00"><?php echo $fObj1[$i]['total_carreras_5to']; ?></span></TD>
        <TD align="center"><strong><?php echo $fObj1[$i]['marcadorm']; ?></strong></TD>
        <TD align="center"><?php echo $fObj1[$i]['p_inning']; ?></TD>
        <TD align="center"><?php echo $fObj1[$i]['p_anotar']; ?></TD>
	</TR>
    <?php }
	}
	?>
	</TBODY>
	<TR bgcolor="#CCCCCC">
		<TD colspan="12" align="center" height="12"></TD>
	</TR>
</TABLE>
<?php } ?>
<BR><BR>
<?php
}
?>
</DIV>