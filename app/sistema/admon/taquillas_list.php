<?php
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.agencia.php";
	include "../../clases/class.taquilla.php";
	
	$objeto1 = new taquilla();
	$fObj1 = $objeto1->lista();
	$totObj1 = count($fObj1);
	
	$url = "sistema/admon/taquillas_list.php";
	$limite = 10;
	$pag = $_GET['pag'];
	$buscar = $_GET['buscar'];
	
	if($pag)
		$inicio = ($pag-1) * $limite;
	else
		$inicio = 0;
	
	if ($buscar != '') {
		$objeto2 = new taquilla();
		$fObj2 = $objeto2->busquedaTaquillas($buscar);
		$totObj2 = count($fObj2);
	} else {
		$objeto2 = new taquilla();
		$fObj2 = $objeto2->lista_pag($limite, $inicio);
		$totObj2 = count($fObj2);
	}
?>
<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD width="50%" align="left" rowspan="2">
			<?php barra_opciones1("cambiar_contenido('sistema/admon/taquillas_form.php?accion=add', 'sub_contenido')", "validaEditarTaquilla('formTaquillas')", "validaEliminarTaquillas('formTaquillas')");?>
		</TD>
		<TD width="50%" align="right"><h3><strong id="titH3">Taquillas</strong> Registradas</h3></TD>
	</TR>
	<TR>
		<TD align="right" valign="middle"><INPUT class="buscador" placeholder="buscar.." type="text" name="filtro_taquillas" id="filtro_taquillas" size="20" onkeypress="javascript: filtro_taquilla(event, value);" value="<?php echo $buscar?>"><?php if ($buscar != '') {?><img border="0" title="Quitar B&uacute;squeda" onclick="javascript: cambiar_contenido('sistema/admon/taquillas_list.php', 'sub_contenido')" style="cursor:pointer; vertical-align:middle" src="imagenes/borrar_busqueda.png"/><?php } ?></TD>
	</TR>
</TABLE>
<FORM name="formTaquillas" id="formTaquillas">
<TABLE align="left" width="100%" border="0">
	<THEAD>
	<TR bgcolor="#CCCCCC">
		<TD width="4%" align="center"><INPUT type="checkbox" name="chkbox" value="0" onclick="javascript: marcarTodos(chkbox)"></TD>
        <TD width="16%" align="left"><strong>Código</strong></TD>
		<TD width="25%" align="left"><strong>Nombre</strong></TD>
		<TD width="55%" align="left"><strong>Agencia</strong></TD>
        
	</TR>
	</THEAD>
	<?php if (($totObj1 == 0) || ($totObj2 == 0)){?>
	<TR bgcolor="#F3F3F3">
		<TD colspan='5' align="center">No existen registros encontrados</TD>
	</TR>
	<?php } else {
				for($i=0; $i<$totObj2; $i++) {
					if($i%2==0) {
						$color='#F5F5F5';
					} else {
						$color= '#FFFFFF';
					}
					$objAge = new agencia();
					$fAge = $objAge->buscar_agencia($fObj2[$i]['id_agencia']);
	?>
	<TBODY>
	<TR bgcolor="<?php echo $color;?>" style="cursor:pointer">
		<TD width="4%" align="center"><INPUT type="checkbox" id="checkUsr" name="checkUsr<?php echo $i?>" value="<?php echo $fObj2[$i]['id']; ?>"></TD>
		<TD align="left"><?php echo $fObj2[$i]['id']; ?></TD>
		<TD align="left"><?php echo $fObj2[$i]['nombre']; ?></TD>
        <TD align="left"><?php echo $fAge[0]['nombre']; ?></TD>
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