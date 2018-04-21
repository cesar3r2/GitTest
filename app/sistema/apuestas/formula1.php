<?php
	include_once "../../conexionConf.php";
	include_once "../../clases/class.logro_formula1.php";
	include_once "../../clases/class.liga.php";
	
	$id_deporte = '8';
	$estatusLogro = 'ACTIVO';
	$estatusLiga = 'ACTIVA';
	$fecha = date('Y-m-d');
	//$horaApueta = date("H:i:s", strtotime("-20 minutes"));
	$horaApueta = date("H:i:s", strtotime("+5 minutes"));
	
	$objLiga = new liga();
	$fLiga = $objLiga->buscar_ligas($id_deporte, $estatusLiga);
	
	$ganador  = 'GANAR';
	$runLine  = 'RLINE';
	$altaBaja = 'AB';
?>
<FORM name="fLogrosHockey" id="fLogrosHockey">
<?php
for ($h=0; $h<count($fLiga); $h++) {
?>
<TABLE align="left" width="100%" border="0" cellpadding="1" cellspacing="1">
	<THEAD>
    <TR bgcolor="#6FA144">
    	<TD align="center" colspan="3" style="color:#FFFFFF"><strong><?php echo $fLiga[$h]['nombre']; ?></strong></TD>
    </TR>
	<TR bgcolor="#328AA4" height="25">
	    <TD width="40%" align="center" style="color: #FFFFFF"><strong>Carrera</strong></TD>
		<TD width="30%" align="center" style="color: #FFFFFF"><strong>Piloto</strong></TD>
        <TD width="30%" align="center" style="color: #FFFFFF"><strong>Ganar</strong></TD>
	</TR>
	</THEAD>
	<?php
    $objeto = new logro_formula1();
	$fObj1 = $objeto->logros_apuestas($fecha, $horaApueta, $fLiga[$h]['id'], $estatusLogro);
	$totObj1 = count($fObj1);
	
	if ($totObj1 == 0){?>
	<TR bgcolor="#F3F3F3">
		<TD colspan='3' align="center">No existen logros disponibles para la fecha y hora actual</TD>
	</TR>
	<?php } else {
				for($i=0; $i<$totObj1; $i++) {
					if($i%2==0) {
						$color='#F3F3F3';
					} else {
						$color='#DDDDDD';
					}
					$clave = $id_deporte.$h.$i;
	?>
	<TBODY>
	<TR bgcolor="<?php echo $color;?>" style="cursor:pointer;">
	    <TD align="center" style="color: #000;">
        	<TABLE align="left" border="0" cellpadding="0" cellspacing="0">
            	<TR>
	            	<TD><img width="18" height="18" src="imagenes/logos/formula1/<?php echo $fObj1[$i]['encuentro']; ?>.png" border="0" onerror="this.src='imagenes/logos/formula1/logo_error.png';"></TD>
                    <TD>
                    	&nbsp;<strong><?php echo $fObj1[$i]['encuentro']; ?></strong>
                        [<?php echo substr($fObj1[$i]['hora'], 0, 5); ?>]
	                    <input type="hidden" id="hora_logro<?php echo $clave; ?>" value="<?php echo $fObj1[$i]['hora']; ?>">
                    </TD>
                </TR>
            </TABLE>
        </TD>
		<TD align="left" style="color: #000;">
        <strong>
			<?php echo $fObj1[$i]['equipo1'].'<br><br>'.$fObj1[$i]['equipo2'].'<br><br>'.$fObj1[$i]['equipo3'].'<br><br>'.$fObj1[$i]['equipo4'].'<br><br>'.$fObj1[$i]['equipo5'].'<br><br>'.$fObj1[$i]['equipo6'].'<br><br>'.$fObj1[$i]['equipo7'].'<br><br>'.$fObj1[$i]['equipo8'].'<br><br>'.$fObj1[$i]['equipo9'].'<br><br>'.$fObj1[$i]['equipo10'].'<br><br>'.$fObj1[$i]['equipo11'].'<br><br>'.$fObj1[$i]['equipo12'].'<br><br>'.$fObj1[$i]['equipo13'].'<br><br>'.$fObj1[$i]['equipo14'].'<br><br>'.$fObj1[$i]['equipo15'].'<br><br>'.$fObj1[$i]['equipo16'].'<br><br>'.$fObj1[$i]['equipo17'].'<br><br>'.$fObj1[$i]['equipo18'].'<br><br>'.$fObj1[$i]['equipo19'].'<br><br>'.$fObj1[$i]['equipo20'].'<br><br>'.$fObj1[$i]['equipo21'].'<br><br>'.$fObj1[$i]['equipo22'].'<br><br>'.$fObj1[$i]['equipo23'].'<br><br>'.$fObj1[$i]['equipo24']; ?>
        </strong>
        </TD>
		<TD align="center" id="linkApu">
        	<a title="Ganador" id="link1<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo1']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador1']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador1', 'link2<?php echo $clave;?>', 'link1<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador1']!='') echo $fObj1[$i]['ganador1']; ?></a><br><br>
            <a title="Ganador" id="link2<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo2']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador2']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador2', 'link1<?php echo $clave;?>', 'link2<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador2']!='') echo $fObj1[$i]['ganador2']; ?></a><br><br>
            <a title="Ganador" id="link3<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo3']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador3']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador3', 'link1<?php echo $clave;?>', 'link3<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador3']!='') echo $fObj1[$i]['ganador3']; ?></a><br><br>
            <a title="Ganador" id="link4<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo4']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador4']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador4', 'link1<?php echo $clave;?>', 'link4<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador4']!='') echo $fObj1[$i]['ganador4']; ?></a><br><br>
            <a title="Ganador" id="link5<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo5']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador5']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador5', 'link1<?php echo $clave;?>', 'link5<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador5']!='') echo $fObj1[$i]['ganador5']; ?></a><br><br>
            <a title="Ganador" id="link6<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo6']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador6']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador6', 'link1<?php echo $clave;?>', 'link6<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador6']!='') echo $fObj1[$i]['ganador6']; ?></a><br><br>
            <a title="Ganador" id="link7<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo7']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador7']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador7', 'link1<?php echo $clave;?>', 'link7<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador7']!='') echo $fObj1[$i]['ganador7']; ?></a><br><br>
            <a title="Ganador" id="link8<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo8']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador8']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador8', 'link1<?php echo $clave;?>', 'link8<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador8']!='') echo $fObj1[$i]['ganador8']; ?></a><br><br>
            <a title="Ganador" id="link9<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo9']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador9']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador9', 'link1<?php echo $clave;?>', 'link9<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador9']!='') echo $fObj1[$i]['ganador9']; ?></a><br><br>
            <a title="Ganador" id="link10<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo10']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador10']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador10', 'link1<?php echo $clave;?>', 'link10<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador10']!='') echo $fObj1[$i]['ganador10']; ?></a><br><br>
            <a title="Ganador" id="link11<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo11']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador11']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador11', 'link1<?php echo $clave;?>', 'link11<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador11']!='') echo $fObj1[$i]['ganador11']; ?></a><br><br>
            <a title="Ganador" id="link12<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo12']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador12']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador12', 'link1<?php echo $clave;?>', 'link12<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador12']!='') echo $fObj1[$i]['ganador12']; ?></a><br><br>
            <a title="Ganador" id="link13<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo13']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador13']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador13', 'link1<?php echo $clave;?>', 'link13<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador13']!='') echo $fObj1[$i]['ganador13']; ?></a><br><br>
            <a title="Ganador" id="link14<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo14']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador14']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador14', 'link1<?php echo $clave;?>', 'link14<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador14']!='') echo $fObj1[$i]['ganador14']; ?></a><br><br>
            <a title="Ganador" id="link15<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo15']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador15']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador15', 'link1<?php echo $clave;?>', 'link15<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador15']!='') echo $fObj1[$i]['ganador15']; ?></a><br><br>
            <a title="Ganador" id="link16<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo16']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador16']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador16', 'link1<?php echo $clave;?>', 'link16<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador16']!='') echo $fObj1[$i]['ganador16']; ?></a><br><br>
             <a title="Ganador" id="link17<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo17']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador17']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador17', 'link1<?php echo $clave;?>', 'link17<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador17']!='') echo $fObj1[$i]['ganador17']; ?></a><br><br>
             <a title="Ganador" id="link18<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo18']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador18']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador18', 'link1<?php echo $clave;?>', 'link18<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador18']!='') echo $fObj1[$i]['ganador18']; ?></a><br><br>
             <a title="Ganador" id="link19<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo19']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador19']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador19', 'link1<?php echo $clave;?>', 'link19<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador19']!='') echo $fObj1[$i]['ganador19']; ?></a><br><br>
             <a title="Ganador" id="link20<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo20']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador20']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador20', 'link1<?php echo $clave;?>', 'link20<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador20']!='') echo $fObj1[$i]['ganador20']; ?></a><br><br>
             <a title="Ganador" id="link21<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo21']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador21']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador21', 'link1<?php echo $clave;?>', 'link21<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador21']!='') echo $fObj1[$i]['ganador21']; ?></a><br><br>
             <a title="Ganador" id="link22<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo22']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador22']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador22', 'link1<?php echo $clave;?>', 'link22<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador22']!='') echo $fObj1[$i]['ganador22']; ?></a><br><br>
             <a title="Ganador" id="link23<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo23']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador23']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador23', 'link1<?php echo $clave;?>', 'link23<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador23']!='') echo $fObj1[$i]['ganador23']; ?></a><br><br>
             <a title="Ganador" id="link24<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo24']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador24']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador24', 'link1<?php echo $clave;?>', 'link24<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador24']!='') echo $fObj1[$i]['ganador24']; ?></a>
        </TD>
	</TR>
    <?php }
    } ?>
	</TBODY>
	<TR bgcolor="#328AA4">
		<TD colspan='3' align="center" height="2"></TD>
	</TR>
</TABLE>
<BR>
<?php }?>
</FORM>
</BODY>
</HTML>