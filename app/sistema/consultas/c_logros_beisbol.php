<?php
	include "../../conexionConf.php";
	include "../../include/php/common.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.logro_beisbol.php";
	
	$id_deporte = '1';
	$fecha = fecha_sql($_GET['fecha']);
	
	$obj = new logro_beisbol();
	$fObj = $obj->consultas_logros_diarios_ligas($fecha);
	$totObj = count($fObj);
?>
<?php barra_opciones3("", "window.open('sistema/consultas/pdf_logros_beisbol.php?fecha=$fecha')", "cambiar_contenido('sistema/consultas/logros_diarios.php', 'sub_contenido')");?>
<DIV id="impresion">
<TABLE  align="left" width="100%" border="0" cellpadding="1" cellspacing="1">
   	<TR><TD align="center" colspan="9"><FONT style="color: #2B58A5; font-size:14px"><strong>Logros de Béisbol para el <?php echo fecha($fecha); ?></strong></FONT></TD></TR>
</TABLE>
<?php 
if ($totObj == 0) { ?>
<TABLE align="left" width="100%" border="0" cellpadding="5" cellspacing="5">
	<TR bgcolor="#F3F3F3">
		<TD colspan='10' align="center" style="color:#F00">No existen logros registrados para la fecha seleccionada</TD>
	</TR>
</TABLE>
<?php } else {
for($j=0; $j<$totObj; $j++) {
?>
<TABLE align="left" width="100%" border="0" cellpadding="1" cellspacing="1">
	<THEAD>
    <TR bgcolor="#6FA144"><TD colspan="10" style="text-align:center;"><FONT style="font-weight:bold; color: #FFF;"><?php echo $fObj[$j]['nombre']; ?></FONT></TD></TR>
    <TR bgcolor="#328AA4" height="20">
    	<TD></TD>
		<TD colspan="4" align="center" style="color: #FFFFFF;"><strong>Juego Completo</strong></TD>
        <TD colspan="3" align="center" style="color: #FFFFFF;"><strong>Primera Mitad</strong></TD>
        <TD colspan="2" align="center" style="color: #FFFFFF"></TD>
	</TR>
	<TR bgcolor="#328AA4" height="25">
		<TD width="16%" align="center" style="color: #FFFFFF"><strong>Encuentro</strong></TD>
        <TD width="8%" align="center" style="color: #FFFFFF"><strong>Ganar</strong></TD>
        <TD width="10%" align="center" style="color: #FFFFFF"><strong>RunLine</strong></TD>
        <TD width="10%" align="center" style="color: #FFFFFF"><strong>Super RL</strong></TD>
        <TD width="10%" align="center" style="color: #FFFFFF"><strong>AltaBaja</strong></TD>
        <TD width="8%" align="center" style="color: #FFFFFF"><strong>Ganar</strong></TD>
        <TD width="10%" align="center" style="color: #FFFFFF"><strong>RunLine</strong></TD>
        <TD width="10%" align="center" style="color: #FFFFFF"><strong>AltaBaja</strong></TD>
        <TD width="9%" align="center" style="color: #FFFFFF"><strong>P. Inng</strong></TD>
        <TD width="9%" align="center" style="color: #FFFFFF"><strong>P. Anot</strong></TD>
	</TR>
	</THEAD>
	<?php
				$objeto = new logro_beisbol();
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
		<TD align="left" style="color: #000;"><?php echo '<strong>'.$fObj1[$i]['equipo1'].'<br>Vs.</strong> ['.substr($fObj1[$i]['hora'], 0, 5).']<br><strong>'.$fObj1[$i]['equipo2'].'</strong>'; ?></TD>
        <TD align="center"><?php echo $fObj1[$i]['ganador1'].'<br><br>'.$fObj1[$i]['ganador2']; ?></TD>
		<TD align="center">
        	<?php if ($fObj1[$i]['v_runline']!=0) echo $signo1.$fObj1[$i]['v_runline'].' ('.$fObj1[$i]['runline1'].')<br><br>'.$signo2.$fObj1[$i]['v_runline'].' ('.$fObj1[$i]['runline2'].')'; ?>
        </TD>
        <TD align="center">
			<?php if ($fObj1[$i]['v_srunline']!=0) echo $signo1.$fObj1[$i]['v_srunline'].' ('.$fObj1[$i]['srunline1'].')<br><br>'.$signo2.$fObj1[$i]['v_srunline'].' ('.$fObj1[$i]['srunline2'].')'; ?>
        </TD>
        <TD align="left">
			<?php if ($fObj1[$i]['v_altabaja']!=0) echo '<span style="color:#F00">A</span> '.$fObj1[$i]['v_altabaja'].' ('.$fObj1[$i]['altabaja1'].')<br><br><span style="color:#F00">B</span> '.$fObj1[$i]['v_altabaja'].' ('.$fObj1[$i]['altabaja2'].')'; ?>
        </TD>
        <TD align="center">
        	<?php if ($fObj1[$i]['g_mediojuego1']!='') echo $fObj1[$i]['g_mediojuego1'].'<br><br>'.$fObj1[$i]['g_mediojuego2']; ?>
        </TD>
        <TD align="center">
        	<?php if ($fObj1[$i]['v_runline_m']!=0) echo $signo1.$fObj1[$i]['v_runline_m'].' ('.$fObj1[$i]['runline_m1'].')<br><br>'.$signo2.$fObj1[$i]['v_runline_m'].' ('.$fObj1[$i]['runline_m2'].')'; ?>
        </TD>
        <TD align="left">
        	<?php if ($fObj1[$i]['v_ab_mediojuego']!=0) echo '<span style="color:#F00">A</span> '.$fObj1[$i]['v_ab_mediojuego'].' ('.$fObj1[$i]['ab_mediojuego1'].')<br><br><span style="color:#F00">B</span> '.$fObj1[$i]['v_ab_mediojuego'].' ('.$fObj1[$i]['ab_mediojuego2'].')'; ?>
        </TD>
        <TD align="left">
        	<?php if ($fObj1[$i]['p_inning1']!='') echo '<span style="color:#F00">SI</span> ('.$fObj1[$i]['p_inning1'].')<br><br><span style="color:#F00">NO</span> ('.$fObj1[$i]['p_inning2'].')'; ?>
        </TD>
        <TD align="center">
        	<?php if ($fObj1[$i]['p_anotar1']!='') echo $fObj1[$i]['p_anotar1'].'<br><br>'.$fObj1[$i]['p_anotar2']; ?>
        </TD>
	</TR>
    <?php } ?>
	</TBODY>
	<TR bgcolor="#CCCCCC">
		<TD colspan='10' align="center" height="12"></TD>
	</TR>
</TABLE>
<?php } ?>
<BR><BR>
<?php
}
?>
</DIV>