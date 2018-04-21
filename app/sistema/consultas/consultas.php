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
						<h2 class="title"><i class="fa fa-search 3x" style="color:#5F9929"></i>&nbsp;Consultas</h2>
						<div id="sub_contenido">
						<P align="justify">
							En este módulo ponemos a disposición la consulta e impresión de los logros y resultados diarios de todos los deportes, también puede obtener información detallada de un ticket en particular y de todas las apuestas registradas en la aplicación. Además se pueden seguir los resultados en vivo de varias disciplinas deportivas, para ello haga click en: <a style="color: #489100; font-size:12px;" href="sistema/consultas/resultados_envivo.php" target="_blank"><strong>Resultados En Vivo</strong></a>
						</P>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-3">
				<div id="sidebar">
					<ul>
						<li>
							<h2><strong>Menú</strong> consultas</h2>
							<ul>
								<?php
								for ($i=0; $i<count($modulos); $i++)
								{
									$obj = new menu();
									$fila = $obj->vistaSubmenu('4', $modulos[$i]);
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