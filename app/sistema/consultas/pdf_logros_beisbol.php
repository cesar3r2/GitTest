<?php
    ob_start();
	
	include "../../conexionConf.php";
	include "../../include/php/common.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.logro_beisbol.php";
	
	$id_deporte = '1';
	$fecha = $_GET['fecha'];
	
	$obj = new logro_beisbol();
	$fObj = $obj->consultas_logros_diarios_ligas($fecha);
	$totObj = count($fObj);
?>
<style>
.tdLine {
	border-bottom-style: solid;
	border-bottom-width: 1px;
	border-right-color: #333;
}
</style>

<page>
<TABLE style="width: 100%;">
	<TR>
    	<TD style="width: 30%;" align="left"><img src="../../imagenes/titulo.jpg"></TD>
        <TD style="width: 70%;" align="right"><FONT style="font-weight:bold; font-size:15px">Logros de Béisbol para el <?php echo fecha($fecha); ?></FONT></TD>
    </TR>
</TABLE>
<br><br>
<?php if ($totObj == 0) { ?>
<TABLE style="width: 100%; font-size:11px;" align="center">
	<TR><TD style="width: 100%; color:#F00; text-align:center">No existen logros registrados para la fecha seleccionada</TD></TR>
</TABLE>
<?php } else {
for($j=0; $j<$totObj; $j++) {
?>
<TABLE style="width: 100%; font-size:12px;" align="center" border="0" cellpadding="0" cellspacing="0">
    <TR><TD colspan="9" style="text-align:center;"><FONT style="font-weight:bold; color: #2B58A5; font-size:13px"><?php echo $fObj[$j]['nombre']; ?></FONT></TD></TR>
	<TR bgcolor="#CCCCCC">
		<TD style="width: 15%;" align="center" class="textoSM"><strong>Encuentro</strong></TD>
        <TD style="width: 9%;" align="center" class="textoSM"><strong>Hora</strong></TD>
        <TD style="width: 10%;" align="center" class="textoSM"><strong>Ganar</strong></TD>
        <TD style="width: 12%;" align="center" class="textoSM"><strong>RunLine</strong></TD>
        <TD style="width: 12%;" align="center" class="textoSM"><strong>AltaBaja</strong></TD>
        <TD style="width: 10%;" align="center" class="textoSM"><strong>G. Mitad</strong></TD>
        <TD style="width: 12%;" align="center" class="textoSM"><strong>AB Mitad</strong></TD>
        <TD style="width: 10%;" align="center" class="textoSM"><strong>1erInning</strong></TD>
        <TD style="width: 10%;" align="center" class="textoSM"><strong>Anota1ero</strong></TD>
	</TR>
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
	<TR class="textoSM" bgcolor="<?php echo $color; ?>">
		<TD class="tdLine" style="text-align:center; color: #000;"><?php echo $fObj1[$i]['equipo1'].'<br>Vs.<br>'.$fObj1[$i]['equipo2']; ?></TD>
        <TD class="tdLine" align="center"><?php echo substr($fObj1[$i]['hora'], 0, 5); ?></TD>
		<TD class="tdLine" align="center"><?php echo $fObj1[$i]['ganador1'].'<br><br>'.$fObj1[$i]['ganador2']; ?></TD>
        <TD class="tdLine" align="center"><?php if ($fObj1[$i]['v_runline']!=0) echo $signo1.$fObj1[$i]['v_runline'].' ('.$fObj1[$i]['runline1'].')<br><br>'.$signo2.$fObj1[$i]['v_runline'].' ('.$fObj1[$i]['runline2'].')'; ?></TD>
        <TD class="tdLine" align="center"><?php if ($fObj1[$i]['v_altabaja']!=0) echo 'A '.$fObj1[$i]['v_altabaja'].' ('.$fObj1[$i]['altabaja1'].')<br><br>'.'B '.$fObj1[$i]['v_altabaja'].' ('.$fObj1[$i]['altabaja2'].')'; ?></TD>
        <TD class="tdLine" align="center"><?php if ($fObj1[$i]['g_mediojuego1']!='') echo $fObj1[$i]['g_mediojuego1'].'<br><br>'.$fObj1[$i]['g_mediojuego2']; ?></TD>
        <TD class="tdLine" align="center"><?php if ($fObj1[$i]['v_ab_mediojuego']!=0) echo 'A '.$fObj1[$i]['v_ab_mediojuego'].' ('.$fObj1[$i]['ab_mediojuego1'].')<br><br>'.'B '.$fObj1[$i]['v_ab_mediojuego'].' ('.$fObj1[$i]['ab_mediojuego2'].')'; ?></TD>
        <TD class="tdLine" align="center"><?php if ($fObj1[$i]['p_inning1']!='') echo 'SI ('.$fObj1[$i]['p_inning1'].')<br><br>NO ('.$fObj1[$i]['p_inning2'].')'; ?></TD>
        <TD class="tdLine" align="center"><?php if ($fObj1[$i]['p_anotar1']!='') echo $fObj1[$i]['p_anotar1'].'<br><br>'.$fObj1[$i]['p_anotar2']; ?></TD>
	</TR>
   <?php } ?>
	</TABLE>
    <BR>
<?php } ?>
<?php } ?>
<BR><BR>
<p align="center" style="font-size:11px;">Los logros mostrados son referenciales y están sujetos a cambios sin previo aviso.<br>
En caso de existir cambios en los logros, las jugadas realizadas anteriormente siguen en juego.</p>
</page>
<?php
	$content = ob_get_clean();
    require_once(dirname(__FILE__).'/../../include/html2pdf/html2pdf.class.php');
    try
    {
        $html2pdf = new HTML2PDF('P', 'Letter', 'es', true, 'UTF-8', array(15, 10, 15, 15));
        $html2pdf->setDefaultFont('Arial');
        $html2pdf->writeHTML($content, isset($_GET['vuehtml']));
		$fec = split('/', $fecha);
		$nombre_arc = 'logrosBeisbol'.$fec[0].$fec[1].$fec[2];
        $html2pdf->Output($nombre_arc.'.pdf', 'D');
    }
    catch(HTML2PDF_exception $e) {
        echo $e;
        exit;
    }
?>