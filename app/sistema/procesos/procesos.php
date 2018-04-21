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
						<h2 class="title"><i class="fa fa-cogs 3x" style="color:#5F9929"></i>&nbsp;procesos</h2>
						<div id="sub_contenido">
						<P align="justify">
							Este módulo permite realizar los distintos procesos que son llevados a cabo en las apuestas deportivas parley, entre ellos se encuentran las opciones para: anular un ticket que haya sido registrado previamente (en caso de errores en la generación del ticket), reimprimir cualquier ticket siempre y cuando no haya sido anulado ni pagado (debe tener a la mano el número del ticket y el número de seguridad que lo identifica), registrar los pagos de los tickets que resulten ganadores en todas sus jugadas. Entre otros.
						</P>
                       <!-- <img src="imagenes/banner.png" border="0">-->
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-3">
				<div id="sidebar">
					<ul>
						<li>
							<h2><strong>Menú</strong> procesos</h2>
							<ul>
								<?php
								for ($i=0; $i<count($modulos); $i++)
								{
									$obj = new menu();
									$fila = $obj->vistaSubmenu('2', $modulos[$i]);
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