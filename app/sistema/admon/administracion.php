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
						<h2 class="title"><i class="fa fa-user-secret 3x" style="color:#5F9929"></i>&nbsp;Administración</h2>
						<div id="sub_contenido">
						<P align="justify">
							Este módulo tiene como objetivo principal proveer al usuario las herramientas para configurar la operación básica de la aplicación, de forma que los cambios que se efectúan en los parámetros afectan inmediatamente la presentación o funcionamiento del sistema. Aquí podrá actualizar los datos de su agencia, además del monto disponible para cancelar diariamente los tickets ganadores. Adicionalmente puede cambiar la contraseña del usuario para ingresar a la aplicación. Entre otros.
						</P>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-3">
				<div id="sidebar">
					<ul>
						<li>
							<h2><strong>Menú</strong> Administración</h2>
							<ul>
								<?php
								for ($i=0; $i<count($modulos); $i++)
								{
									$obj = new menu();
									$fila = $obj->vistaSubmenu('9', $modulos[$i]);
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