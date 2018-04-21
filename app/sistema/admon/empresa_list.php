<?php
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.empresa.php";
	
	$objeto1 = new empresa();
	$fObj1 = $objeto1->lista();
	$totObj1 = count($fObj1);
?>
<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD width="50%" align="left" rowspan="2">
			<?php barra_opciones1("", "validaEditarEmpresa('formEmpresa')", "");?>
		</TD>
		<TD width="50%" align="right" class="txtForm"><strong>Empresa</strong> Registrada</TD>
	</TR>
</TABLE>
<FORM name="formEmpresa" id="formEmpresa">
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1">
	<THEAD>
	<TR bgcolor="#CCCCCC">
		<TD width="4%" align="center"></TD>
		<TD width="14%" align="left"><strong>R.I.F</strong></TD>
		<TD width="34%" align="left"><strong>Nombre</strong></TD>
		<TD width="34%" align="left"><strong>Direcci&oacute;n</strong></TD>
		<TD width="14%" align="left"><strong>Tel&eacute;fono</strong></TD>
	</TR>
	</THEAD>
	<?php if ($totObj1 == 0){?>
	<TR bgcolor="#F3F3F3">
		<TD colspan='5' align="center">No existen registros encontrados</TD>
	</TR>
	<?php } else {
				for($i=0; $i<$totObj1; $i++) {
					if($i%2==0) {
						$color='#FCFCFC';
					} else {
						$color='#F0F0F0';
					}
	?>
	<TBODY>
	<TR bgcolor="<?php echo $color;?>" style="cursor:pointer">
		<TD width="4%" align="center"><INPUT type="checkbox" id="checkUsr" name="checkUsr<?php echo $i?>" value="<?php echo $fObj1[$i]['rif']; ?>"></TD>
		<TD align="left"><?php echo $fObj1[$i]['rif']; ?></TD>
		<TD align="left"><?php echo $fObj1[$i]['nombre']; ?></TD>
		<TD align="left"><?php echo $fObj1[$i]['direccion']; ?></TD>
		<TD align="left"><?php echo $fObj1[$i]['telefono']; ?></TD>
	</TR>
		<?php }
			} ?>
	</TBODY>
	<TR bgcolor="#CCCCCC">
		<TD colspan='5' align="center" height="15"></TD>
	</TR>
</TABLE>
</FORM>