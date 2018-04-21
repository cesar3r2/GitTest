<?php
	include_once "../../conexionConf.php";
	include_once "../../clases/class.logro_beisbol.php";
	include_once "../../clases/class.liga.php";
	
	$id_deporte = '1';
	$estatusLogro = 'ACTIVO';
	$estatusLiga = 'ACTIVA';
	$fecha = date('Y-m-d');
	//$horaApueta = date("H:i:s", strtotime("-20 minutes"));
	$horaApueta = date("H:i:s", strtotime("+5 minutes"));
	
	$objLiga = new liga();
	$fLiga = $objLiga->buscar_ligas($id_deporte, $estatusLiga);
	
	$ganador  = 'GANAR';
	$runLine  = 'RLINE';
	$sRunLine = 'SRLINE';
	$altaBaja = 'AB';
	$gMJuego  = 'GMITAD';
	$runLineM = 'RLMITAD';
	$abMJuego = 'ABM';
	$inning1  = 'P/INNG';
	$anotar1  = 'P/ANOT';
?>
<FORM name="fLogrosBeisbol" id="fLogrosBeisbol">
<?php
for ($h=0; $h<count($fLiga); $h++) {
?>
<TABLE align="left" width="100%" border="0" cellpadding="1" cellspacing="1">
	<THEAD>
    <TR bgcolor="#6FA144">
    	<TD align="center" colspan="10" style="color:#FFFFFF"><strong><?php echo $fLiga[$h]['nombre']; ?></strong></TD>
    </TR>
    <TR bgcolor="#328AA4" height="20">
    	<TD></TD>
		<TD colspan="4" align="center" style="color: #FFFFFF;"><strong>Juego Completo</strong></TD>
        <TD colspan="3" align="center" style="color: #FFFFFF;"><strong>Primera Mitad</strong></TD>
        <TD colspan="2" align="center" style="color: #FFFFFF"></TD>
	</TR>
	<TR bgcolor="#328AA4" height="25">
		<TD align="center" style="color: #FFFFFF"><strong>Encuentro</strong></TD>
        <TD align="center" style="color: #FFFFFF"><strong>&nbsp;&nbsp;Ganar&nbsp;&nbsp;</strong></TD>
        <TD align="center" style="color: #FFFFFF"><strong>RunLine</strong></TD>
        <TD align="center" style="color: #FFFFFF"><strong>Super RL</strong></TD>
        <TD align="center" style="color: #FFFFFF"><strong>AltaBaja</strong></TD>
        <TD align="center" style="color: #FFFFFF"><strong>&nbsp;&nbsp;Ganar&nbsp;&nbsp;</strong></TD>
        <TD align="center" style="color: #FFFFFF"><strong>RunLine</strong></TD>
        <TD align="center" style="color: #FFFFFF"><strong>AltaBaja</strong></TD>
        <TD align="center" style="color: #FFFFFF"><strong>P. Inng</strong></TD>
        <TD align="center" style="color: #FFFFFF"><strong>&nbsp;P. Anot&nbsp;</strong></TD>
	</TR>
	</THEAD>
	<?php
    $objeto = new logro_beisbol();
	$fObj1 = $objeto->logros_apuestas($fecha, $horaApueta, $fLiga[$h]['id'], $estatusLogro);
	$totObj1 = count($fObj1);
	
	if ($totObj1 == 0){?>
	<TR bgcolor="#F3F3F3">
		<TD colspan='10' align="center">No existen logros disponibles para la fecha y hora actual</TD>
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
					$vSRunline = number_format($fObj1[$i]['v_srunline'], 1, ',','.');
					$vAltabaja = number_format($fObj1[$i]['v_altabaja'], 1, ',','.');
					$vRunlineM = number_format($fObj1[$i]['v_runline_m'], 1, ',','.');
					$vABmitad = number_format($fObj1[$i]['v_ab_mediojuego'], 1, ',','.');
					$clave = $id_deporte.$h.$i;
	?>
	<TBODY>
	<TR bgcolor="<?php echo $color;?>" style="cursor:pointer;" onmouseover="fila_sobre(this)" onmouseout="fila_quita(this)">
		<TD align="center" style="color: #000000;">
        	<TABLE align="left" border="0" cellpadding="0" cellspacing="0">
            	<TR>
	            	<TD valign="middle"><img width="20" height="20" src="imagenes/logos/beisbol/<?php echo $fObj1[$i]['equipo1']; ?>.png" border="0" onerror="this.src='imagenes/logos/beisbol/logo_error.png'" align="middle"></TD>
                    <TD valign="middle"><div class="cssToolTip">&nbsp;<strong><?php echo $fObj1[$i]['equipo1']; ?></strong><span><?php echo $fObj1[$i]['lanzador1']; ?></span></div></TD>
                </TR>
                <TR>
	            	<TD colspan="2" align="left">
                    	&nbsp;<strong>Vs.</strong>&nbsp;&nbsp;[<?php echo substr($fObj1[$i]['hora'], 0, 5); ?>]
	                    <input type="hidden" id="hora_logro<?php echo $clave; ?>" value="<?php echo $fObj1[$i]['hora']; ?>">
                    </TD>
                </TR>
                <TR>
	            	<TD valign="middle"><img width="18" height="18" src="imagenes/logos/beisbol/<?php echo $fObj1[$i]['equipo2']; ?>.png" border="0" onerror="this.src='imagenes/logos/beisbol/logo_error.png'" align="middle"></TD>
                    <TD valign="middle"><div class="cssToolTip">&nbsp;<strong><?php echo $fObj1[$i]['equipo2']; ?></strong><span><?php echo $fObj1[$i]['lanzador2']; ?></span></div></TD>
                </TR>
        	</TABLE>
        </TD>
		<TD align="center" id="linkApu">
        	<a title="Ganar" id="link1<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo1']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador1']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador1', 'link2<?php echo $clave;?>', 'link1<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador1']!='') echo $fObj1[$i]['ganador1']; ?></a><br><br>
            <a title="Ganar" id="link2<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo2']; ?>', '<?php echo $ganador; ?>', '<?php echo $fObj1[$i]['ganador2']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ganador2', 'link1<?php echo $clave;?>', 'link2<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['ganador2']!='') echo $fObj1[$i]['ganador2']; ?></a>
        </TD>
        <TD align="center" id="linkApu">
			<a title="RunLine" id="link3<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo1']; ?>', '<?php echo $runLine.'('.$signo1.$vRunline.')'; ?>', '<?php echo $fObj1[$i]['runline1']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'runline1', 'link4<?php echo $clave;?>', 'link3<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['v_runline']!=0) echo $signo1.$fObj1[$i]['v_runline'].' ('.$fObj1[$i]['runline1'].')'; ?></a><br><br>
            <a title="RunLine" id="link4<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo2']; ?>', '<?php echo $runLine.'('.$signo2.$vRunline.')'; ?>', '<?php echo $fObj1[$i]['runline2']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'runline2', 'link3<?php echo $clave;?>', 'link4<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['v_runline']!=0) echo $signo2.$fObj1[$i]['v_runline'].' ('.$fObj1[$i]['runline2'].')'; ?></a>
		</TD>
        <TD align="center" id="linkApu">
			<a title="Super RunLine" id="link5<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo1']; ?>', '<?php echo $sRunLine.'('.$signo1.$vSRunline.')'; ?>', '<?php echo $fObj1[$i]['srunline1']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'srunline1', 'link6<?php echo $clave;?>', 'link5<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['v_srunline']!=0) echo $signo1.$fObj1[$i]['v_srunline'].' ('.$fObj1[$i]['srunline1'].')'; ?></a><br><br>
            <a title="Super RunLine" id="link6<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo2']; ?>', '<?php echo $sRunLine.'('.$signo2.$vSRunline.')'; ?>', '<?php echo $fObj1[$i]['srunline2']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'srunline2', 'link5<?php echo $clave;?>', 'link6<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['v_srunline']!=0) echo $signo2.$fObj1[$i]['v_srunline'].' ('.$fObj1[$i]['srunline2'].')'; ?></a>
		</TD>
        <TD align="left" id="linkApu">
        	<a title="AltaBaja" id="link7<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['encuentro']; ?>', '<?php echo $altaBaja.'/ALTA('.$vAltabaja.')'; ?>', '<?php echo $fObj1[$i]['altabaja1']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'altabaja1', 'link8<?php echo $clave;?>', 'link7<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['v_altabaja']!=0) echo '&nbsp;<span style="color:#F00">A</span> '.$fObj1[$i]['v_altabaja'].' ('.$fObj1[$i]['altabaja1'].')'; ?></a><br><br>
            <a title="AltaBaja" id="link8<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['encuentro']; ?>', '<?php echo $altaBaja.'/BAJA('.$vAltabaja.')'; ?>', '<?php echo $fObj1[$i]['altabaja2']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'altabaja2', 'link7<?php echo $clave;?>', 'link8<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['v_altabaja']!=0) echo '&nbsp;<span style="color:#F00">B</span> '.$fObj1[$i]['v_altabaja'].' ('.$fObj1[$i]['altabaja2'].')'; ?></a>
        </TD>
        <TD align="center" id="linkApu">
        	<a title="Ganar Mitad" id="link9<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo1']; ?>', '<?php echo $gMJuego; ?>', '<?php echo $fObj1[$i]['g_mediojuego1']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'g_mediojuego1', 'link10<?php echo $clave;?>', 'link9<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['g_mediojuego1']!='') echo $fObj1[$i]['g_mediojuego1']; ?></a><br><br>
            <a title="Ganar Mitad" id="link10<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo2']; ?>', '<?php echo $gMJuego; ?>', '<?php echo $fObj1[$i]['g_mediojuego2']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'g_mediojuego2', 'link9<?php echo $clave;?>', 'link10<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['g_mediojuego2']!='') echo $fObj1[$i]['g_mediojuego2']; ?></a>
        </TD>
        <TD align="center" id="linkApu">
			<a title="RunLine Mitad" id="link11<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo1']; ?>', '<?php echo $runLineM.'('.$signo1.$vRunlineM.')'; ?>', '<?php echo $fObj1[$i]['runline_m1']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'runlinem1', 'link12<?php echo $clave;?>', 'link11<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['v_runline_m']!=0) echo $signo1.$fObj1[$i]['v_runline_m'].' ('.$fObj1[$i]['runline_m1'].')'; ?></a><br><br>
            <a title="RunLine Mitad" id="link12<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo2']; ?>', '<?php echo $runLineM.'('.$signo2.$vRunlineM.')'; ?>', '<?php echo $fObj1[$i]['runline_m2']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'runlinem2', 'link11<?php echo $clave;?>', 'link12<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['v_runline_m']!=0) echo $signo2.$fObj1[$i]['v_runline_m'].' ('.$fObj1[$i]['runline_m2'].')'; ?></a>
		</TD>
        <TD align="left" id="linkApu">
        	<a title="AltaBaja Mitad" id="link13<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['encuentro']; ?>', '<?php echo $abMJuego.'/ALTA('.$vABmitad.')'; ?>', '<?php echo $fObj1[$i]['ab_mediojuego1']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ab_mediojuego1', 'link14<?php echo $clave;?>', 'link13<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['v_ab_mediojuego']!=0) echo '&nbsp;<span style="color:#F00">A</span> '.$fObj1[$i]['v_ab_mediojuego'].' ('.$fObj1[$i]['ab_mediojuego1'].')'; ?></a><br><br>
            <a title="AltaBaja Mitad" id="link14<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['encuentro']; ?>', '<?php echo $abMJuego.'/BAJA('.$vABmitad.')'; ?>', '<?php echo $fObj1[$i]['ab_mediojuego2']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'ab_mediojuego2', 'link13<?php echo $clave;?>', 'link14<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['v_ab_mediojuego']!=0) echo '&nbsp;<span style="color:#F00">B</span> '.$fObj1[$i]['v_ab_mediojuego'].' ('.$fObj1[$i]['ab_mediojuego2'].')'; ?></a>
        </TD>
         <TD align="left" id="linkApu" style="padding-left:3px">
        	<a title="Primer Inning" id="link15<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['encuentro']; ?>', '<?php echo $inning1.'(SI)'; ?>', '<?php echo $fObj1[$i]['p_inning1']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'p_inning1', 'link16<?php echo $clave;?>', 'link15<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['p_inning1']!='') echo '&nbsp;<span style="color:#F00">SI</span> ('.$fObj1[$i]['p_inning1'].')'; ?></a><br><br>
            <a title="Primer Inning" id="link16<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['encuentro']; ?>', '<?php echo $inning1.'(NO)'; ?>', '<?php echo $fObj1[$i]['p_inning2']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'p_inning2', 'link15<?php echo $clave;?>', 'link16<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['p_inning2']!='') echo '&nbsp;<span style="color:#F00">NO</span> ('.$fObj1[$i]['p_inning2'].')'; ?></a>
        </TD>
        <TD align="center" id="linkApu">
        <a title="Primero Anotar" id="link17<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo1']; ?>', '<?php echo $anotar1; ?>', '<?php echo $fObj1[$i]['p_anotar1']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'p_anotar1', 'link18<?php echo $clave;?>', 'link17<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['p_anotar1']!='') echo $fObj1[$i]['p_anotar1']; ?></a><br><br>
        <a title="Primero Anotar" id="link18<?php echo $clave;?>" onClick="javascript: cargar_logro('<?php echo $fObj1[$i]['equipo2']; ?>', '<?php echo $anotar1; ?>', '<?php echo $fObj1[$i]['p_anotar2']; ?>', '<?php echo $id_deporte; ?>', '<?php echo $fObj1[$i]['id']; ?>', 'p_anotar2', 'link17<?php echo $clave;?>', 'link18<?php echo $clave;?>', '<?php echo $clave;?>');"><?php if ($fObj1[$i]['p_anotar2']!='') echo $fObj1[$i]['p_anotar2']; ?></a>
        </TD>
	</TR>
    <?php }
    } ?>
	</TBODY>
	<TR bgcolor="#328AA4">
		<TD colspan='10' align="center" height="2"></TD>
	</TR>
</TABLE>
<?php }?>
</FORM>