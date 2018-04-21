<?php
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.taquilla.php";
	include "../../clases/class.agencia.php";
	
	$accion = $_GET['accion'];
	
	if ($accion == 'add')
		$titulo = 'Agregar taquilla';
	elseif ($accion == 'edit')
		$titulo = 'Modificar taquilla';
	
	$objTaq = new taquilla();
	$fTaq = $objTaq->proximo_codigo();
	
	$objAgencia = new agencia();
	$fAgencia = $objAgencia->lista();
?>

<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD valign="top"><FONT class="txtForm"><?php echo $titulo;?></FONT></TD>
		<TD width="50%" align="right">
			<?php barra_opciones2('guardarTaquilla()', "cambiar_contenido('sistema/admon/taquillas_list.php', 'sub_contenido')");?>
		</TD>
	</TR>
</TABLE>
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="2">
	<TR>
		<TD width="120px" class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Nombre&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="nombre" id="txt_nombre" size="20" maxlength="12">
       		<INPUT type="hidden" name="id" id="id" value="<?php echo $fTaq[0]['ultimo']+1; ?>">
        </TD>
	</TR>
	<TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Agencia&nbsp;</TD>
		<TD class="objForm"><SELECT name="agencia" id="sel_agencia">
				<OPTION value="0">Seleccione..</OPTION>
				<?php for($i=0; $i<count($fAgencia); $i++) {?>
				<OPTION title="Código: <?php echo $fAgencia[$i]['id']?>" value="<?php echo $fAgencia[$i]['id']?>"><?php echo $fAgencia[$i]['nombre']?></OPTION>
				<?php }?>
			 </SELECT>
		</TD>
	</TR>
</TABLE>