<?php
	session_start();
	ob_start();
	include_once "conexionConf.php";
	include_once "clases/class.menu.php";
	include_once "clases/class.perfil.php";
	
	$perfil = $_SESSION["PERFIL_USUARIO"];
	$objP = new perfil();
	$filaP = $objP->buscar_perfil($perfil);
	$modulos = explode(',', $filaP[0]['acceso_menu']);
?>
<div class="collapse navbar-collapse">
	<ul class="nav navbar-nav navbar-right">
	<?php
		for ($i=0; $i<count($modulos)-1; $i++)
		{
			$obj = new menu();
			$fila = $obj->vistaMenu($modulos[$i]);
			if(count($fila) != 0) {
		?>
			<li>
				<a style="cursor: pointer; font-size:15px" onclick="cambiar_contenido('<?php echo $fila[0]['enlace'] ?>', 'contenido')"><i class="fa <?php echo $fila[0]['icono']; ?>" style="color:#FFF; font-size:15px"></i> <?php echo $fila[0]['descripcion']; ?></a>
			</li>
	<?php  }
		} ?>
	</ul>
</div>