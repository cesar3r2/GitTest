<?php
	include "conexionConf.php";
	include "clases/class.usuario.php";
	include "include/php/interfaz.php";
	
	//echo $_COOKIE['taquilla_ps'];
	
	$navegador = strtolower($_SERVER['HTTP_USER_AGENT']);
	if (!stristr($navegador, "firefox") && !stristr($navegador, "chrome") && !stristr($navegador, "msie 9.0") && !stristr($navegador, "msie 8.0") && !stristr($navegador, "msie 7.0")) {
		include "no_navegador.php";
		return;
	}
	
	$rand = rand(0,1000000);
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>BetCES Parley - Apuestas Deportivas</title>
<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
<meta name="keywords" content="parley, parlay, betces, betcesparley, betces.com.ve, apuestas deportivas"/>
<link rel="icon" type="image/x-icon" href="imagenes/icono_logo.png">
<link type="text/css" rel="stylesheet" href="estilos/estilos_login.css"/>
<link type="text/css" rel="stylesheet" href="estilos/jquery.alerts.css"/>
<link type="text/css" rel="stylesheet" href="estilos/font.min.css"/>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
</head>
<body onload="javascript: cargar_cursor();">
<table align="center" width="850px" border="0" cellpadding="0" cellspacing="0">
	<tr><td align="center" height="82px"><img align="center" src="imagenes/banner_index.png"></td></tr>
</table>
<br>
<table align="center" width="300px" cellpadding="2" cellspacing="2" border="0" style="margin-top:70px">
	<tr>
		<td align="center" valign="middle">
            <img src="imagenes/titulo_login.png" border="0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <img src="imagenes/lock.png" border="0"/>
        </td>
	</tr>
</table>
<br>    
<table width="280px" align="center" cellpadding="2" cellspacing="2" border="0" style="background: none repeat scroll 0 0 #F1F1F1; border: 1px solid #E5E5E5; padding: 0px 20px 5px;">
	<tr><td height="10"></td></tr>
	<tr><td align="left"><h3>Inicio de Sesión</h3></td></tr>
	<tr><td height="15px"></td></tr>
	<tr><td><input type="text" name="usuario" size="30" id="usuario" maxlength="20" onkeypress="javascript: buscarInfoEnter(event, 'buscarUsuario');" onchange="tipoDeUsuario();" placeholder="Usuario"></td></tr>
	<tr><td height="15px"></td></tr>
	<tr><td align="left"><input type="password" name="clave" size="30" maxlength="30" id="clave" onkeypress="javascript: buscarInfoEnter(event, 'buscarUsuario');" placeholder="Contraseña">
    <input type="hidden" id="tipo_usr" value="0"><input type="hidden" id="nro_pcs" value="0">
    </td></tr>
	<tr><td height="25px"></td></tr>
	<tr><td align="center"><button id="aceptar" name="aceptar" class="boton" onclick="javascript: loguear_usuario();" ><i class="fa fa-check"></i> Aceptar</button>&nbsp;&nbsp;&nbsp;<button id="limpiar" name="limpiar" class="boton" onclick="javascript: limpiar_logueo();"><i class="fa fa-close"></i> Cancelar</button></td></tr>
	<tr><td height="15"></td></tr>
</table>
<br>
<table align="center" width="280px" cellpadding="2" cellspacing="2" border="0">
	<tr><td id="mensaje" class="alerta" style="visibility: hidden;" align="center"></td></tr>
</table>
<br><br><br><br>
<div id="footer">
  <p id="legal">&copy; 2016. BetCES Parley | Apuestas Deportivas<BR/>Todos los derechos reservados</p>
</div>
<script type="text/javascript" src="sistema/admon/script/usuario_script.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="include/jquery/jquery.js"></script>
<script type="text/javascript" src="include/jquery/jquery.alerts.js"></script>
<script type="text/javascript" src="include/js/funciones.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="include/js/interface.js?v=<?=$rand?>"></script>
<script type="text/javascript">
function cargar_cursor() {
	var usuario = document.getElementById('usuario');
	usuario.focus();
}
</script>
</body>
</html>