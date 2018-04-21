<?php
    ob_start();
	
	include "../../conexionConf.php";
	include "../../include/php/common.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.logro_formula1.php";
	
	$id_deporte = '8';
	$fecha = $_GET['fecha'];
	
	$obj = new logro_formula1();
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
        <TD style="width: 70%;" align="right"><FONT style="font-weight:bold; font-size:15px">Logros de Fórmula 1 para el <?php echo fecha($fecha); ?></FONT></TD>
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
    <TR><TD colspan="4" style="text-align:center;"><FONT style="font-weight:bold; color: #2B58A5; font-size:13px"><?php echo $fObj[$j]['nombre']; ?></FONT></TD></TR>
	<TR bgcolor="#CCCCCC">
		<TD style="width: 30%;" align="center" class="textoSM"><strong>Carrera</strong></TD>
        <TD style="width: 20%;" align="center" class="textoSM"><strong>Hora</strong></TD>
        <TD style="width: 30%;" align="center" class="textoSM"><strong>Piloto</strong></TD>
        <TD style="width: 20%;" align="center" class="textoSM"><strong>Ganar</strong></TD>
	</TR>
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
					if ($fObj1[$i]['favorito'] == 1) {
						$signo1 = '-';
						$signo2 = '+';
					} else {
						$signo1 = '+';
						$signo2 = '-';
					}
	?>
	<TR class="textoSM" bgcolor="<?php echo $color; ?>">
		 <TD align="center"><?php echo $fObj1[$i]['encuentro']; ?></TD>
    	<TD align="center"><?php echo substr($fObj1[$i]['hora'], 0, 5); ?></TD>
		<TD align="center" style="color: #000;">
			<?php echo $fObj1[$i]['equipo1'].'<br>'.$fObj1[$i]['equipo2'].'<br>'.$fObj1[$i]['equipo3'].'<br>'.$fObj1[$i]['equipo4'].'<br>'.$fObj1[$i]['equipo5'].'<br>'.$fObj1[$i]['equipo6'].'<br>'.$fObj1[$i]['equipo7'].'<br>'.$fObj1[$i]['equipo8'].'<br>'.$fObj1[$i]['equipo9'].'<br>'.$fObj1[$i]['equipo10'].'<br>'.$fObj1[$i]['equipo11'].'<br>'.$fObj1[$i]['equipo12'].'<br>'.$fObj1[$i]['equipo13'].'<br>'.$fObj1[$i]['equipo14'].'<br>'.$fObj1[$i]['equipo15'].'<br>'.$fObj1[$i]['equipo16'].'<br>'.$fObj1[$i]['equipo17'].'<br>'.$fObj1[$i]['equipo18'].'<br>'.$fObj1[$i]['equipo19'].'<br>'.$fObj1[$i]['equipo20'].'<br>'.$fObj1[$i]['equipo21'].'<br>'.$fObj1[$i]['equipo22'].'<br>'.$fObj1[$i]['equipo23'].'<br>'.$fObj1[$i]['equipo24']; ?>
        </TD>
		<TD align="center">
			<?php echo $fObj1[$i]['ganador1'].'<br>'.$fObj1[$i]['ganador2'].'<br>'.$fObj1[$i]['ganador3'].'<br>'.$fObj1[$i]['ganador4'].'<br>'.$fObj1[$i]['ganador5'].'<br>'.$fObj1[$i]['ganador6'].'<br>'.$fObj1[$i]['ganador7'].'<br>'.$fObj1[$i]['ganador8'].'<br>'.$fObj1[$i]['ganador9'].'<br>'.$fObj1[$i]['ganador10'].'<br>'.$fObj1[$i]['ganador11'].'<br>'.$fObj1[$i]['ganador12'].'<br>'.$fObj1[$i]['ganador13'].'<br>'.$fObj1[$i]['ganador14'].'<br>'.$fObj1[$i]['ganador15'].'<br>'.$fObj1[$i]['ganador16'].'<br>'.$fObj1[$i]['ganador17'].'<br>'.$fObj1[$i]['ganador18'].'<br>'.$fObj1[$i]['ganador19'].'<br>'.$fObj1[$i]['ganador20'].'<br>'.$fObj1[$i]['ganador21'].'<br>'.$fObj1[$i]['ganador22'].'<br>'.$fObj1[$i]['ganador23'].'<br>'.$fObj1[$i]['ganador24']; ?>
        </TD>
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
		$nombre_arc = 'logrosFormula1_'.$fec[0].$fec[1].$fec[2];
        $html2pdf->Output($nombre_arc.'.pdf', 'D');
    }
    catch(HTML2PDF_exception $e) {
        echo $e;
        exit;
    }
?>