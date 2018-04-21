<?php
	include_once "../../conexionConf.php";
	include_once "../../clases/class.logro_tennis.php";
	include_once "../../clases/class.liga.php";
	
	$id_deporte = '6';
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
    	<TD align="center" colspan="9" style="color:#FFFFFF"><strong><?php echo $fLiga[$h]['nombre']; ?></strong></TD>
    </TR>
	<TR bgcolor="#328AA4" height="25">
		<TD width="50%" align="center" style="color: #FFFFFF"><strong>Encuentro</strong></TD>
        <TD width="50%" align="center" style="color: #FFFFFF"><strong>Ganar</strong></TD>
	</TR>
	</THEAD>
	<?php
    $objeto = new logro_tennis();
	$fObj1 = $objeto->logros_apuestas($fecha, $horaApueta, $fLiga[$h]['id'], $estatusLogro);
	$totObj1 = count($fObj1);
	
	if ($totObj1 == 0){?>
	<TR bgcolor="#F3F3F3">
		<TD colspan='2' align="center">No existen logros disponibles para la fecha y hora actual</TD>
	</TR>
	<?php } else {
				for($i=0; $i<$totObj1; $i++) {
					if($i%2==0) {
						$color='#F3F3F3';
					} else {
						$color= '#DDDDDD';
					}
					$clave = $id_deporte.$h.$i;
	?>
	<TBODY>
	<TR bgcolor="<?php echo $color;?>" style="cursor:pointer;" onmouseover="fila_sobre(this)" onmouseout="fila_quita(this)">
		<TD align="center" style="color: #000;">
        	<TABLE align="left" border="0" cellpadding="0" cellspacing="0">
            	<TR>
	            	<TD><img width="18" height="18" src="imagenes/logos/tennis/<?php echo $fObj1[$i]['equipo1']; ?>.png" border="0" onerror="this.src='imagenes/logos/tennis/logo_error.png';"></TD>
                    <TD>&nbsp;<strong><?php echo $fObj1[$i]['equipo1']; ?></strong></TD>
                </TR>
                <TR>
	            	<TD colspan="2" align="left">
                    	&nbsp;<strong>Vs.</strong>&nbsp;&nbsp;[<?php echo substr($fObj1[$i]['hora'], 0, 5); ?>]
	                    <input type="hidden" id="hora_logro<?php echo $clave; ?>" value="<?php echo $fObj1[$i]['hora']; ?>">
                    </TD>
                </TR>
                <TR>
	            	<TD><img width="18" height="18" src="imagenes/logos/tennis/<?php echo $fObj1[$i]['equipo2']; ?>.png" border="0" onerror="this.src='imagenes/logos/tennis/logo_error.png';"></TD>
                    <TD>&nbsp;<strong><?php echo $fObj1[$i]['equipo2']; ?></strong></TD>
                </TR>
        	</TABLE>
        </TD>
		<TD align="center" id="linkApu">
        	<a title="Ganador" id="link1<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo1']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador1']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador1', 'link2<?php echo $clave;?>', 'link1<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador1']!='') echo $fObj1[$i]['ganador1']; ?></a><br><br>
            <a title="Ganador" id="link2<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo2']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador2']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador2', 'link1<?php echo $clave;?>', 'link2<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador2']!='') echo $fObj1[$i]['ganador2']; ?></a>
        </TD>
	</TR>
    <?php }
    } ?>
	</TBODY>
	<TR bgcolor="#328AA4">
		<TD colspan='2' align="center" height="2"></TD>
	</TR>
</TABLE>
<BR>
<?php } ?>
</FORM>