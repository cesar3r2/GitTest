<?php
	session_start();
	ob_start();
	include "../../conexionConf.php";
	include "../../clases/class.menu.php";
	include "../../clases/class.perfil.php";
	include "../../include/php/interfaz.php";
	
	$perfil = $_SESSION["PERFIL_USUARIO"];
	
	$objP = new perfil();
	$filaP = $objP->buscar_perfil($perfil);
	$modulos = explode(',', $filaP[0]['acceso_menu']);
?>
	<div class="row">
        <div class="col-md-9">
			<div id="content">
				<div class="post">
					<h2 class="title"><i class="fa fa-money 3x" style="color:#5F9929"></i>&nbsp;Apuestas</h2>
					<div id="sub_contenido">
			            <?php include_once('logros.php'); ?>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-3">
			<div id="sidebar">
	        	<table width="225px" style="position:fixed; border-color:#CCC; border-width:1px; border-style:solid" cellpadding="0" cellspacing="0" border="0">
	            <tr><td>
				<?php include_once('boleto.php'); ?>
	            </td></tr>
	            </table>
			</div>
		</div>
	</div>