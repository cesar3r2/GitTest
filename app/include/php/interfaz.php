<?php
	session_start();
	ob_start();

function barra_opciones1($guardar, $modificar, $eliminar) { ?>
	<TABLE align="left" border="0" cellpadding="0" cellspacing="0">
		<TR height="75px" valign="top">
			<?php if ($guardar != '') { ?>
			<TD style="cursor: pointer; font-size:11px" align="center"><a onclick="<?php echo $guardar?>;"><IMG src="imagenes/add.png" border="0"><br>Agregar</a></TD>
			<?php } ?>
			<?php if ($modificar != '') { ?>
			<TD style="cursor: pointer; font-size:11px" align="center"><a onclick="<?php echo $modificar?>;"><IMG src="imagenes/edit.png" border="0"><br>Modificar</a></TD>
			<?php } ?>
			<?php if ($eliminar != '') { ?>
			<TD style="cursor: pointer; font-size:11px" align="center"><a onclick="<?php echo $eliminar?>;"><IMG src="imagenes/delete.png" border="0"><br>Eliminar</a></TD>
			<?php } ?>
		</TR>
	</TABLE>
<?php } ?>

<?php
function barra_opciones2($guardar, $volver) { ?>
	<div class="row" align="right">
        <div class="col-sm-12">
			<?php if ($guardar != '') { ?>
			<button type="submit" class="btn btn-success btn-xd" onclick="<?php echo $guardar?>;"><i class="fa fa-check"></i> Aceptar</button>
			<?php } ?>
			<?php if ($volver != '') { ?>
			<button type="submit" class="btn btn-danger btn-xd" onclick="<?php echo $volver?>;"><i class="fa fa-close"></i> Cancelar</button>
			<?php } ?>
        </div>
    </div>
<?php } ?>

<?php
function barra_opciones3($generar, $imprimir, $volver) { ?>
	<div class="row" align="right">
        <div class="col-sm-12">
			<?php if ($generar != '') { ?>
			<button type="submit" class="btn btn-success btn-xd" onclick="<?php echo $generar?>;"><i class="fa fa-search"></i> Consultar</button>
			<?php } ?>
			<?php if ($imprimir != '') { ?>
			<button type="submit" class="btn btn-primary btn-xd" onclick="<?php echo $imprimir?>;"><i class="fa fa-print"></i> Imprimir</button>
			<?php } ?>
			<?php if ($volver != '') { ?>
			<button type="submit" class="btn btn-danger btn-xd" onclick="<?php echo $volver?>;"><i class="fa fa-close"></i> Cancelar</button>
			<?php }?>
		</div>
	</div>
<?php } ?>

<?php
function encabezado_reporte($agencia, $rif) {
?>
	<table width="100%" border="0" align="left" cellspacing="0" cellpadding="0">
		<tr>
			<TD width="65"></TD>
			<td colspan="2" class="txtR9" align="right">Fecha: <?php echo date("d/m/Y")?><BR>Hora: <?php echo date('H:i:s');?></td>
		</tr>
		<tr>
			<TD rowspan="3" align="left" valign="middle"><img src="imagenes/logo.jpg" border="0"></TD>
			<td class="txtR11" align="left"><strong>PARLEY360</strong></td>
		</tr>
		<tr>
			<td class="txtR11" align="left"><strong>AGENCIA <?php echo $agencia?></strong></td>
		</tr>
		<tr>
			<td class="txtR9" align="left"> <?php echo $rif?></td>
		</tr>
	<TR>
		<TD></TD>
		<TD colspan="2" height="25"></TD>
	</TR>
  </table>
<?php } ?>

<?php
function paginacion($url, $pag, $totObj1) {
	$adjacents = 3;
	$limite = 10;
	
	if ($pag == 0) $pag = 1;
	$ant = $pag - 1;
	$prox = $pag + 1;
	$ultima = ceil($totObj1/$limite);
	$lpm1 = $ultima - 1;
	
	$paginacion = "";
	if($ultima > 1)
	{
		$paginacion .= "<div class=\"pagination\">";
		//previous button
		if ($pag > 1)
			$paginacion.= "<a style='cursor: pointer' onclick=\"javascript: cambiar_contenido('$url?pag=$ant', 'sub_contenido')\">« anterior</a>";
		else
			$paginacion.= "<span class=\"disabled\">« anterior</span>";
		//pages
		if ($ultima < 7 + ($adjacents * 2)) //not enough pages to bother breaking it up
		{	
			for ($counter = 1; $counter <= $ultima; $counter++)
			{
				if ($counter == $pag)
					$paginacion.= "<span class=\"current\">$counter</span>";
				else
					$paginacion.= "<a style='cursor: pointer' onclick=\"javascript: cambiar_contenido('$url?pag=$counter', 'sub_contenido')\">$counter</a>";
			}
		}
		elseif($ultima > 5 + ($adjacents * 2)) //enough pages to hide some
		{
			//close to beginning; only hide later pages
			if($pag < 1 + ($adjacents * 2))
			{
				for ($counter = 1; $counter < 4 + ($adjacents * 2); $counter++)
				{
					if ($counter == $pag)
						$paginacion.= "<span class=\"current\">$counter</span>";
					else
						$paginacion.= "<a style='cursor: pointer' onclick=\"javascript: cambiar_contenido('$url?pag=$counter', 'sub_contenido')\">$counter</a>";
				}
				$paginacion.= "...";
				$paginacion.= "<a style='cursor: pointer' onclick=\"javascript: cambiar_contenido('$url?pag=$lpm1', 'sub_contenido')\">$lpm1</a>";
				$paginacion.= "<a style='cursor: pointer' onclick=\"javascript: cambiar_contenido('$url?pag=$ultima', 'sub_contenido')\">$ultima</a>";
			}
			//in middle; hide some front and some back
			elseif($ultima - ($adjacents * 2) > $pag && $pag > ($adjacents * 2))
			{
				$paginacion.= "<a style='cursor: pointer' onclick=\"javascript: cambiar_contenido('$url?pag=1', 'sub_contenido')\">1</a>";
				$paginacion.= "<a style='cursor: pointer' onclick=\"javascript: cambiar_contenido('$url?pag=2', 'sub_contenido')\">2</a>";
				$paginacion.= "...";
				for ($counter = $pag - $adjacents; $counter <= $pag + $adjacents; $counter++)
				{
					if ($counter == $pag)
						$paginacion.= "<span class=\"current\">$counter</span>";
					else
						$paginacion.= "<a style='cursor: pointer' onclick=\"javascript: cambiar_contenido('$url?pag=$counter', 'sub_contenido')\">$counter</a>";
				}
				$paginacion.= "...";
				$paginacion.= "<a style='cursor: pointer' onclick=\"javascript: cambiar_contenido('$url?pag=$lpm1', 'sub_contenido')\">$lpm1</a>";
				$paginacion.= "<a style='cursor: pointer' onclick=\"javascript: cambiar_contenido('$url?pag=$ultima', 'sub_contenido')\">$ultima</a>";
			}
			//close to end; only hide early pages
			else
			{
				$paginacion.= "<a style='cursor: pointer' onclick=\"javascript: cambiar_contenido('$url?pag=1', 'sub_contenido')\">1</a>";
				$paginacion.= "<a style='cursor: pointer' onclick=\"javascript: cambiar_contenido('$url?pag=2', 'sub_contenido')\">2</a>";
				$paginacion.= "...";
				for ($counter = $ultima - (2 + ($adjacents * 2)); $counter <= $ultima; $counter++)
				{
					if ($counter == $pag)
						$paginacion.= "<span class=\"current\">$counter</span>";
					else
						$paginacion.= "<a style='cursor: pointer' onclick=\"javascript: cambiar_contenido('$url?pag=$counter', 'sub_contenido')\">$counter</a>";
				}
			}
		}
		//next button
		if ($pag < $counter - 1) 
			$paginacion.= "<a style='cursor: pointer' onclick=\"javascript: cambiar_contenido('$url?pag=$prox', 'sub_contenido')\">siguiente »</a>";
		else
			$paginacion.= "<span class=\"disabled\">siguiente »</span>";
		$paginacion.= "</div>\n";
	}
	return $paginacion;
} ?>