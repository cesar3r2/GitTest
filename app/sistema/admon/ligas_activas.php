<?php
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.liga.php";
	
	$accion = $_GET['accion'];
	
	$titulo = 'Ligas Activas';
		
	$objLiga = new liga();
	$filaLiga = $objLiga->todas_ligas();
?>

<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD valign="top"><FONT class="txtForm"><?php echo $titulo; ?></FONT></TD>
		<TD width="50%" align="right">
			<?php barra_opciones2('activarLigas()', "cambiar_contenido('sistema/admon/administracion.php', 'contenido')");?>
		</TD>
	</TR>
</TABLE>
<BR>
<FORM name="fLigas" id="fLigas">
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1" style="border-color:#CCC; border-width:1px; border-style:solid">
    <TR height="25px">
    	<TD class="titForm" align="center"><INPUT type="checkbox" name="chkbox" value="0" onclick="javascript: marcarTodos(chkbox)"></TD>
        <TD class="titForm" align="center" width="8%"><strong>ID</strong></TD>
        <TD class="titForm" align="left" width="25%"><strong>Deporte</strong></TD>
		<TD class="titForm" align="left" width="42%"><strong>Ligas Deportivas</strong></TD>
        <TD class="titForm" align="left" width="25%"><strong>Estatus</strong></TD>
	</TR>
    <?php for ($i=0; $i<count($filaLiga); $i++) {
			if ($filaLiga[$i]['estatus']=='ACTIVA')
				$color = '#5F9929';
			else
				$color = '#E32023';
		?>
     <TR height="25px">
     	<TD class="objForm" width="4%" align="center"><INPUT type="checkbox" id="checkL" name="checkL<?php echo $i?>" value="<?php echo $filaLiga[$i]['idliga']; ?>" <?php if ($filaLiga[$i]['estatus']=='ACTIVA') {?> checked="checked" <?php }?>></TD>
        <TD class="objForm" align="center"><?php echo $filaLiga[$i]['idliga']; ?></TD>
        <TD class="objForm"><?php echo $filaLiga[$i]['nombredeporte']; ?></TD>
        <TD class="objForm"><?php echo $filaLiga[$i]['nombreliga']; ?></TD>
        <TD class="objForm" style="color: <?php echo $color?>"><?php echo $filaLiga[$i]['estatus']; ?></TD>
     </TR>
     <?php } ?>
     <TR><TD colspan="5" class="titForm" height="12px"></TD></TR>
</TABLE>
</FORM>