<?php
    ob_start();
	
	include "../../conexionConf.php";
	include "../../include/php/common.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.logro_tennis.php";
	
	$id_deporte = '6';
	$fecha = $_GET['fecha'];
	
	$obj = new logro_tennis();
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
        <TD style="width: 70%;" align="right"><FONT style="font-weight:bold; font-size:15px">Logros de Tennis para el <?php echo fecha($fecha); ?></FONT></TD>
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
    <TR><TD colspan="3" style="text-align:center;"><FONT style="font-weight:bold; color: #2B58A5; font-size:13px"><?php echo $fObj[$j]['nombre']; ?></FONT></TD></TR>
	<TR bgcolor="#CCCCCC">
		<TD style="width: 35%;" align="center" class="textoSM"><strong>Encuentro</strong></TD>
        <TD style="width: 30%;" align="center" class="textoSM"><strong>Hora</strong></TD>
        <TD style="width: 35%;" align="center" class="textoSM"><strong>Ganar</strong></TD>
	</TR>
	<?php 
				$objeto = new logro_tennis();
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
		$nombre_arc = 'logrosTennis'.$fec[0].$fec[1].$fec[2];
        $html2pdf->Output($nombre_arc.'.pdf', 'D');
    }
    catch(HTML2PDF_exception $e) {
        echo $e;
        exit;
    }
?>