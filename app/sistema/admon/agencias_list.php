<?php
	session_start();
	ob_start();
	
	$tipo = $_SESSION['PERFIL_USUARIO'];
	$usuario = $_SESSION["USUARIO"];
	
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.agencia.php";
	
	
	$objeto1 = new agencia();
	if ($tipo == 1)
		$fObj1 = $objeto1->lista();
	else if ($tipo == 2)
		$fObj1 = $objeto1->lista_banquero($usuario);
	$totObj1 = count($fObj1);
		
	$url = "sistema/admon/agencias_list.php";
	$limite = 10;
	$pag = $_GET['pag'];
	$buscar = $_GET['buscar'];
	
	if($pag)
		$inicio = ($pag-1) * $limite;
	else
		$inicio = 0;
	
	if ($buscar != '') {
		$objeto2 = new agencia();
		if ($tipo == 1)
			$fObj2 = $objeto2->busquedaAgencias($buscar);
		else if ($tipo == 2)
			$fObj2 = $objeto2->busquedaAgencias_banqueros($usuario, $buscar);
		$totObj2 = count($fObj2);
	} else {
		$objeto2 = new agencia();
		if ($tipo == 1)
			$fObj2 = $objeto2->lista_pag($limite, $inicio);
		else if ($tipo == 2)
			$fObj2 = $objeto2->lista_pag_banquero($usuario, $limite, $inicio);
		$totObj2 = count($fObj2);
	}
?>
<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD width="50%" align="left" rowspan="2">
			<?php barra_opciones1("cambiar_contenido('sistema/admon/agencias_form.php?accion=add', 'sub_contenido')", "validaEditarAgencia('formAgencias')", "validaEliminarAgencias('formAgencias')");?>
		</TD>
		<TD width="50%" align="right" class="txtForm"><strong>Agencias</strong> Registradas</TD>
	</TR>
	<TR>
		<TD align="right" valign="middle"><INPUT class="buscador" placeholder="buscar.." type="text" name="filtro_agencias" id="filtro_agencias" size="20" onkeypress="javascript: filtro_agencia(event, value);" value="<?php echo $buscar?>"><?php if ($buscar != '') {?><img border="0" title="Quitar B&uacute;squeda" onclick="javascript: cambiar_contenido('sistema/admon/agencias_list.php', 'sub_contenido')" style="cursor:pointer; vertical-align:middle" src="imagenes/borrar_busqueda.png"/><?php } ?></TD>
	</TR>
</TABLE>
<FORM name="formAgencias" id="formAgencias">
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1">
	<THEAD>
	<TR bgcolor="#CCCCCC">
		<TD width="4%" align="center"><INPUT type="checkbox" name="chkbox" value="0" onclick="javascript: marcarTodos(chkbox)"></TD>
		<TD width="25%" align="left"><strong>Nombre</strong></TD>
        <TD width="16%" align="left"><strong>Teléfono</strong></TD>
		<TD width="20%" align="right"><strong>Premio Máximo</strong></TD>
        <TD width="20%" align="right"><strong>Saldo Diario</strong></TD>
        <TD width="15%" align="center"><strong>Estatus</strong></TD>
	</TR>
	</THEAD>
	<?php if (($totObj1 == 0) || ($totObj2 == 0)){?>
	<TR bgcolor="#F3F3F3">
		<TD colspan='6' align="center">No existen registros encontrados</TD>
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
		<TD align="left"><?php echo $fObj2[$i]['nombre']; ?></TD>
        <TD align="left"><?php echo $fObj2[$i]['telefono']; ?></TD>
        <TD align="right"><?php echo number_format($fObj2[$i]['premio_max'], 2, ',', '.'); ?></TD>
		<TD align="right"><?php echo number_format($fObj2[$i]['disponible'], 2, ',', '.'); ?></TD>
        <TD align="center"><?php echo $fObj2[$i]['estatus']; ?></TD>
	</TR>
		<?php }
			} ?>
	</TBODY>
	<TR bgcolor="#CCCCCC">
		<TD colspan='6' align="center" height="15"></TD>
	</TR>
	<TR>
		<TD align="center" colspan="6"><?php if ($buscar == '') echo paginacion($url, $pag, $totObj1); ?></TD>
	</TR>
</TABLE>
</FORM>