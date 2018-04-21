<?php
	include_once "../../conexionConf.php";
	include_once "../../clases/class.logro_futbol_americano.php";
	include_once "../../clases/class.liga.php";
	
	$id_deporte = '4';
	$estatusLogro = 'ACTIVO';
	$estatusLiga = 'ACTIVA';
	$fecha = date('Y-m-d');
	//$horaApueta = date("H:i:s", strtotime("-20 minutes"));
	$horaApueta = date("H:i:s", strtotime("+5 minutes"));
	
	$objLiga = new liga();
	$fLiga = $objLiga->buscar_ligas($id_deporte, $estatusLiga);
	
	$ganador  = 'GANAR';
	$altaBaja = 'AB';
	$runLine = 'RLINE';
?>
<FORM name="fLogrosFutbolAm" id="fLogrosFutbolAm">
<?php
for ($h=0; $h<count($fLiga); $h++) {
?>
<TABLE align="left" width="100%" border="0" cellpadding="1" cellspacing="1">
	<THEAD>
    <TR bgcolor="#6FA144">
    	<TD align="center" colspan="9" style="color:#FFFFFF"><strong><?php echo $fLiga[$h]['nombre']; ?></strong></TD>
    </TR>
	<TR bgcolor="#328AA4" height="25">
		<TD width="25%" align="center" style="color: #FFFFFF"><strong>Encuentro</strong></TD>
        <TD width="25%" align="center" style="color: #FFFFFF"><strong>Ganar</strong></TD>
        <TD width="25%" align="center" style="color: #FFFFFF"><strong>RunLine</strong></TD>
        <TD width="25%" align="center" style="color: #FFFFFF"><strong>AltaBaja</strong></TD>
	</TR>
	</THEAD>
	<?php
    $objeto = new logro_futbol_americano();
	$fObj1 = $objeto->logros_apuestas($fecha, $horaApueta, $fLiga[$h]['id'], $estatusLogro);
	$totObj1 = count($fObj1);
	
	if ($totObj1 == 0){?>
	<TR bgcolor="#F3F3F3">
		<TD colspan='4' align="center">No existen logros disponibles para la fecha y hora actual</TD>
	</TR>
	<?php } else {
				for($i=0; $i<$totObj1; $i++) {
					if($i%2==0) {
						$color='#F3F3F3';
					} else {
						$color='#DDDDDD';
					}
					if ($fObj1[$i]['favorito'] == 1) {
						$signo1 = '-';
						$signo2 = '+';
					} else {
						$signo1 = '+';
						$signo2 = '-';
					}
					$vRunline = number_format($fObj1[$i]['v_runline'], 1, ',','.');
					$vAltabaja = number_format($fObj1[$i]['v_altabaja'], 1, ',','.');
					$clave = $id_deporte.$h.$i;
	?>
	<TBODY>
	<TR bgcolor="<?php echo $color;?>" style="cursor:pointer;" onmouseover="fila_sobre(this)" onmouseout="fila_quita(this)">
		<TD align="center" style="color: #000;">
		<TABLE align="left" border="0" cellpadding="0" cellspacing="0">
            	<TR>
	            	<TD><img width="20" height="13.33" src="imagenes/logos/futbol_ame/<?php echo $fObj1[$i]['equipo1']; ?>.gif" border="0" onerror="this.src='imagenes/logos/futbol_ame/logo_error.png';"></TD>
                    <TD>&nbsp;<strong><?php echo $fObj1[$i]['equipo1']; ?></strong></TD>
                </TR>
                <TR>
	            	<TD colspan="2" align="left">
                    	&nbsp;<strong>Vs.</strong>&nbsp;&nbsp;[<?php echo substr($fObj1[$i]['hora'], 0, 5); ?>]
	                    <input type="hidden" id="hora_logro<?php echo $clave; ?>" value="<?php echo $fObj1[$i]['hora']; ?>">
                    </TD>
                </TR>
                <TR>
	            	<TD><img width="20" height="13.33" src="imagenes/logos/futbol_ame/<?php echo $fObj1[$i]['equipo2']; ?>.gif" border="0" onerror="this.src='imagenes/logos/futbol_ame/logo_error.png';"></TD>
                    <TD>&nbsp;<strong><?php echo $fObj1[$i]['equipo2']; ?></strong></TD>
                </TR>
        	</TABLE>
        </TD>
		<TD align="center" id="linkApu">
        	<a title="Ganador" id="link1<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo1']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador1']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador1', 'link2<?php echo $clave;?>', 'link1<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador1']!='') echo $fObj1[$i]['ganador1']; ?></a><br><br>
            <a title="Ganador" id="link2<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo2']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador2']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador2', 'link1<?php echo $clave;?>', 'link2<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador2']!='') echo $fObj1[$i]['ganador2']; ?></a>
        </TD>
        <TD align="center" id="linkApu">
        	<a title="RunLine" id="link3<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo1']; ?>', '<?php echo $runLine.'('.$signo1.$vRunline.')'; ?>', '<?php echo $fObj1[$i]['runline1']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'runline1', 'link4<?php echo $clave;?>', 'link3<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['v_runline']!=0) echo $signo1.$fObj1[$i]['v_runline'].' ('.$fObj1[$i]['runline1'].')'; ?></a><br><br>
            <a title="RunLine" id="link4<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo2']; ?>', '<?php echo $runLine.'('.$signo2.$vRunline.')'; ?>', '<?php echo $fObj1[$i]['runline2']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'runline2', 'link3<?php echo $clave;?>', 'link4<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['v_runline']!=0) echo $signo2.$fObj1[$i]['v_runline'].' ('.$fObj1[$i]['runline2'].')'; ?></a>
        </TD>
        <TD align="left" id="linkApu" style=" padding-left:45px">
        	<a title="AltaBaja" id="link5<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['encuentro']; ?>', '<?php echo $altaBaja.'/ALTA('.$vAltabaja.')'; ?>', '<?php echo $fObj1[$i]['altabaja1']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'altabaja1', 'link6<?php echo $clave;?>', 'link5<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['v_altabaja']!=0) echo '<span style="color: #F00">A</span> '.$fObj1[$i]['v_altabaja'].' ('.$fObj1[$i]['altabaja1'].')'; ?></a><br><br>
            <a title="AltaBaja" id="link6<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['encuentro']; ?>', '<?php echo $altaBaja.'/BAJA('.$vAltabaja.')'; ?>', '<?php echo $fObj1[$i]['altabaja2']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'altabaja2', 'link5<?php echo $clave;?>', 'link6<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['v_altabaja']!=0) echo '<span style="color: #F00">B</span> '.$fObj1[$i]['v_altabaja'].' ('.$fObj1[$i]['altabaja2'].')'; ?></a>
        </TD>
	</TR>
    <?php }
    } ?>
	</TBODY>
	<TR bgcolor="#328AA4">
		<TD colspan='4' align="center" height="2"></TD>
	</TR>
</TABLE>
<BR>
<?php } ?>
</FORM>