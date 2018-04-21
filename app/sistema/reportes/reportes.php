<?php
	session_start();
	ob_start();
	include "../../conexionConf.php";
	include "../../clases/class.menu.php";
	include "../../clases/class.perfil.php";
	$perfil = $_SESSION["PERFIL_USUARIO"];
	
	$objP = new perfil();
	$filaP = $objP->buscar_perfil($perfil);
	$modulos = explode(',', $filaP[0]['acceso_menu']);
?>
		<div class="row">
        	<div class="col-md-9">
				<div id="content">
					<div class="post">
						<h2 class="title"><i class="fa fa-bar-chart 3x" style="color:#5F9929"></i>&nbsp;Reportes</h2>
						<div id="sub_contenido">
						<P align="justify">
							Este módulo le muestra las opciones para generar e imprimir los reportes de las apuestas registradas, éstas se muestran por rango de fechas (lo que le permite la generación de reportes diarios, semanales, mensuales y/o anuales) y estatus de las apuestas (las cuales pueden ser: registradas, anuladas, ganadoras o pagadas). También se pueden generar e imprimir los movimientos de caja registrados por la taquilla de su agencia (tickets vendidos, anulados, ganadores y pagados), igualmente puede filtrarlos por rango de fechas. Entre otros.
						</P>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-3">
				<div id="sidebar">
					<ul>
						<li>
							<h2><strong>Menú</strong> Reportes</h2>
							<ul>
								<?php
								for ($i=0; $i<count($modulos); $i++)
								{
									$obj = new menu();
									$fila = $obj->vistaSubmenu('5', $modulos[$i]);
									if(count($fila) != 0) {
								?>
								<li><a style="cursor: pointer; font-size:14px; line-height: 28px" onclick="cambiar_contenido('<?php echo $fila[0]['enlace']?>', 'sub_contenido')"><i class="fa fa-check-square" style="color: #5F9929"></i>&nbsp;&nbsp;<?php echo $fila[0]['descripcion']?></a></li>
						<?php 	}
								} ?>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</div>
	<div style="clear: both;">&nbsp;</div>