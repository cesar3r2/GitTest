<?php
	session_start();
	ob_start();
	
	$tipo = $_SESSION['PERFIL_USUARIO'];
	$usuario = $_SESSION["USUARIO"];
	
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.perfil.php";
	include "../../clases/class.agencia.php";
	
	$accion = $_GET['accion'];
	
	if ($accion == 'add')
		$titulo = 'Agregar usuario';
	elseif ($accion == 'edit')
		$titulo = 'Modificar usuario';
	
	$objPerfil = new perfil();
	if ($tipo == 1)
		$fPerfil = $objPerfil->lista();
	if ($tipo == 2)
		$fPerfil = $objPerfil->lista_banquero();

	$objAgencia = new agencia();
	if ($tipo == 1)
		$fAgencia = $objAgencia->lista();
	else if ($tipo == 2)
		$fAgencia = $objAgencia->lista_banquero($usuario);
?>

<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD valign="top"><FONT class="txtForm"><?php echo $titulo;?></FONT></TD>
		<TD width="50%" align="right">
			<?php barra_opciones2('guardarUsuario()', "cambiar_contenido('sistema/admon/usuarios_list.php', 'sub_contenido')"); ?>
		</TD>
	</TR>
</TABLE>
<TABLE align="left" width="100%" border="0" cellpadding="2" cellspacing="1" style="border-color:#CCC; border-width:1px; border-style:solid">
	<TR>
		<TD class="titForm" width="20%" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Usuario&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="usuario" id="txt_usuario" size="20" maxlength="20" onChange="validarUsuario();"></TD>
	</TR>
	<TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Contraseña&nbsp;</TD>
		<TD class="objForm"><INPUT type="password" name="clave" id="txt_clave" size="20" maxlength="20"></TD>
	</TR>
	<TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Nombre&nbsp;</TD>
		<TD class="objForm"><INPUT type="text" name="nombre" id="txt_nombre" size="50" maxlength="80"></TD>
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
    <TR>
		<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Tipo&nbsp;</TD>
		<TD class="objForm"><SELECT name="tipo" id="sel_tipo" onchange="mostrarOpcTaq(); validarTipo();">
				<OPTION value="0">Seleccione..</OPTION>
				<?php for($i=0; $i<count($fPerfil); $i++) {?>
				<OPTION title="Código: <?php echo $fPerfil[$i]['id']?>" value="<?php echo $fPerfil[$i]['id']?>"><?php echo $fPerfil[$i]['nombre']?></OPTION>
				<?php }?>
			 </SELECT>
		</TD>
	</TR>
    <TR>
    	<TD class="titForm" align="right"><FONT class="txt-rojo">*&nbsp;</FONT>Cantidad de PC's&nbsp;</TD>
		<TD class="objForm">
        	<SELECT id="nro_pcs" disabled="disabled">
            	<OPTION value="0">...</OPTION>
                <?php
                for($i=1; $i<=10; $i++) { ?>
					<OPTION value="<?php echo $i?>"><?php echo $i?></OPTION>
				<?php } ?>
            </SELECT>
        </TD>
    </TR>
</TABLE>