<?php
	session_start();
	ob_start();
	
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.perfil.php";
	
	$objeto1 = new perfil();
	$fObj1 = $objeto1->lista();
	$totObj1 = count($fObj1);
	
	$url = "sistema/admon/perfiles_list.php";
	$limite = 10;
	$pag = $_GET['pag'];
	$buscar = $_GET['buscar'];
	
	if($pag)
		$inicio = ($pag-1) * $limite;
	else
		$inicio = 0;
	
	if ($buscar != '') {
		$objeto2 = new perfil();
		$fObj2 = $objeto2->busquedaPerfiles($buscar);
		$totObj2 = count($fObj2);
	} else {
		$objeto2 = new perfil();
		$fObj2 = $objeto2->lista_pag($limite, $inicio);
		$totObj2 = count($fObj2);
	}
?>
<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD width="50%" align="left" rowspan="2">
			<?php barra_opciones1("cambiar_contenido('sistema/admon/perfiles_form.php?accion=add', 'sub_contenido')", "validaEditarPerfiles('formPerfiles')", "validaEliminarPerfiles('formPerfiles')");?>
		</TD>
		<TD width="50%" align="right" class="txtForm"><strong>Perfiles</strong> Registrados</TD>
	</TR>
	<TR>
		<TD align="right" valign="middle"><INPUT class="buscador" placeholder="buscar.." type="text" name="filtro_per" id="filtro_per" size="20" onkeypress="javascript: filtro_perfil(event, value);" value="<?php echo $buscar?>"><?php if ($buscar != '') {?><img title="Quitar B&uacute;squeda" onclick="javascript: cambiar_contenido('sistema/admon/perfiles_list.php', 'sub_contenido')" style="cursor:pointer; vertical-align:middle" src="imagenes/borrar_busqueda.png"/><?php }?></TD>
	</TR>
</TABLE>
<FORM name="formPerfiles" id="formPerfiles">
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1">
	<THEAD>
	<TR bgcolor="#CCCCCC">
		<TD width="4%" align="center"><INPUT type="checkbox" name="chkbox" value="0" onclick="javascript: marcarTodos(chkbox)"></TD>
		<TD width="21%" align="left"><strong>C&oacute;digo</strong></TD>
		<TD width="75%" align="left"><strong>Nombre</strong></TD>
	</TR>
	</THEAD>
	<?php if (($totObj1 == 0) || ($totObj2 == 0)){?>
	<TR bgcolor="#F3F3F3">
		<TD colspan='5' align="center">No existen registros encontrados</TD>
	</TR>
	<?php } else {
				for($i=0; $i<$totObj2; $i++) {
					if($i%2==0) {
						$color='#FCFCFC';
					} else {
						$color='#F0F0F0';
					}
	?>
	<TBODY>
	<TR bgcolor="<?php echo $color;?>" style="cursor:pointer">
		<TD width="4%" align="center"><INPUT type="checkbox" id="checkUsr" name="checkUsr<?php echo $i?>" value="<?php echo $fObj2[$i]['id']; ?>"></TD>
		<TD align="left"><?php echo $fObj2[$i]['id']; ?></TD>
		<TD align="left"><?php echo $fObj2[$i]['nombre']; ?></TD>
	</TR>
		<?php }
			} ?>
	</TBODY>
	<TR bgcolor="#CCCCCC">
		<TD colspan='5' align="center" height="15"></TD>
	</TR>
	<TR>
		<TD align="center" colspan="5"><?php if ($buscar == '') echo paginacion($url, $pag, $totObj1); ?></TD>
	</TR>
</TABLE>
</FORM>