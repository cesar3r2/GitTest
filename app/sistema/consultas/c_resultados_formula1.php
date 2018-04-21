<?php
	include "../../conexionConf.php";
	include "../../include/php/common.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.logro_formula1.php";
	include "../../clases/class.resultado_formula1.php";
	
	$id_deporte = '8';
	$fecha = fecha_sql($_GET['fecha']);
	
	$obj = new logro_formula1();
	$fObj = $obj->consultas_logros_diarios_ligas($fecha);
	$totObj = count($fObj);
?>
<?php barra_opciones3("", "imprimir('impresion')", "cambiar_contenido('sistema/consultas/resultados_diarios.php', 'sub_contenido')");?>
<DIV id="impresion">
<TABLE  align="left" width="100%" border="0" cellpadding="1" cellspacing="1">
   	<TR><TD align="center" colspan="4"><FONT style="color : #2B58A5; font-size:14px"><strong>Resultados de Fórmula 1 para el <?php echo fecha($fecha); ?></strong></FONT></TD></TR>
</TABLE>
<?php 
if ($totObj == 0) { ?>
<TABLE align="left" width="100%" border="0" cellpadding="5" cellspacing="5">
	<TR bgcolor="#F3F3F3">
		<TD colspan='4' align="center" style="color:#F00">No existen resultados registrados para la fecha seleccionada</TD>
	</TR>
</TABLE>
<?php  } else {
for($j=0; $j<$totObj; $j++) {
?>	
	
<TABLE align="left" width="100%" border="0" cellpadding="1" cellspacing="1">
	<THEAD>
    <TR bgcolor="#6FA144"><TD colspan="4" style="text-align:center;"><FONT style="font-weight:bold; color: #FFF"><?php echo $fObj[$j]['nombre']; ?></FONT></TD></TR>
	<TR bgcolor="#328AA4" height="20">
		<TD width="25%" align="center" style="color: #FFFFFF"><strong>Carrera</strong></TD>
        <TD width="25%" align="center" style="color: #FFFFFF"><strong>Ganador</strong></TD>
        <TD width="25%" align="center" style="color: #FFFFFF"><strong>Tiempo</strong></TD>
        <TD width="25%" align="center" style="color: #FFFFFF"><strong>Estatus</strong></TD>
	</TR>
	</THEAD>
	<?php
	$objeto = new resultado_formula1();
	$fObj1 = $objeto->consultas_resultados_diarios_encuentros($fObj[$j]['id_liga'], $fecha);
	$totObj1 = count($fObj1);
	
	if ($totObj1 == 0) { ?>
	<TR bgcolor="#F3F3F3">
		<TD colspan='4' align="center" style="color:#F00">No existen resultados registrados para este campeonato</TD>
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
        <TD align="center"><strong><span style="color:#F00"><?php echo $fObj1[$i]['tiempo']; ?></span></strong></TD>
		<TD align="center"><?php echo $fObj1[$i]['estatus']; ?></TD>
	</TR>
   <?php }
	}
	?>
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