<?php
	session_start();
	ob_start();
	include "conexionConf.php";
	include "clases/class.agencia.php";
	
	if ($_SESSION["ESTATUS_USUARIO"] != "AUTENTICADO") {
		$url = "login.php";
		echo "<script language=\"JavaScript\" type=\"text/javascript\">location.href=\"".$url."\"</script>";
	}
	
	$id_agencia = $_SESSION['AGENCIA'];
	$obj = new agencia();
	$fila = $obj->datos_agencia($id_agencia);
	
	if ($_SESSION["PERFIL_USUARIO"] == '4')
		$inicio = 'sistema/apuestas/apuestas.php';
	else
		$inicio = 'inicio.php';
	
	$rand = rand(0,1000000);
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head>
<title>Parley360 - Ag. <?php echo $fila[0]['nombre']; ?></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
<meta name="keywords" content="parley, parlay, 360, parley360, parley360.com.ve, apuestas deportivas"/>
<link rel="icon" type="image/x-icon" href="imagenes/icono_360.png">
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/font-awesome.min.css" rel="stylesheet">
<link type="text/css" rel="stylesheet" href="../css/main.css"/>
<link href="css/animate.css" rel="stylesheet">
<link type="text/css" rel="stylesheet" href="estilos/estilos.css"/>
<link type="text/css" rel="stylesheet" href="estilos/estilos_simplemodal.css"/>
<link type="text/css" rel="stylesheet" href="estilos/jquery.alerts.css"/>
<link type="text/css" rel="stylesheet" href="estilos/estilos_pag.css"/>
<link type="text/css" rel="stylesheet" media="all" href="include/js/jscalendar/calendar-blue.css" title="win2k-cold-1"/>
<link type="text/css" rel="stylesheet" media="screen" href="estilos/popbox.css" charset="utf-8">
<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css"/>
</head>
<body onload="set_interval(); cambiar_contenido('<?php echo $inicio; ?>', 'contenido');" onmousemove="reset_interval()" onclick="reset_interval()" onkeypress="reset_interval()" onscroll="reset_interval()">
	<header class="navbar navbar-inverse navbar-fixed-top wet-asphalt" role="banner">
        <div class="container">
			<div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.php"><img src="imagenes/logo.png" alt="logo"></a>
            </div>
            <?php include_once('include/menu/menu.php'); ?>
        </div>
    </header><!--/header-->
    <section id="content">
    	<div class="container">
            <div class="row">
            	<div class="col-md-12">
    				<div id="contenido"></div>
    			</div>
    		</div>
    	</div>
    </section>
    <section id="notificacion">
   		<div class="popbox" style="text-align:center">
        	<div class="collapseNot">
            	<div class="box">
                	<div id="mensajeNoti"></div>
                </div>
            </div>
            <a class="open" onClick="cargarMensajes();" style="cursor:pointer; color: #000; font-size:11px">
            	<i class="fa fa-info" style="color: #069"> </i>&nbsp;&nbsp;Notificaciones
            </a>
        </div>
    </section>
    <footer id="footer2" class="midnight-blue">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    &copy; 2016. <a href="#">Parley360</a>. Todos los derechos reservados.
                </div>
            </div>
        </div>
    </footer><!--/#footer-->

<script type="text/javascript" src="include/jquery/jquery.js"></script>
<script type="text/javascript" src="include/jquery/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="include/jquery/jquery-ui-1.8.5.custom.min.js"></script>
<script type="text/javascript" src="include/jquery/jquery.alerts.js"></script>
<script type="text/javascript" src="include/js/jscalendar/calendar.js"></script>
<script type="text/javascript" src="include/js/jscalendar/lang/calendar-es.js"></script>
<script type="text/javascript" src="include/js/jscalendar/calendar-setup.js"></script>
<script type="text/javascript" src="include/js/interface.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="include/js/funciones.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="include/js/simplemodal.js"></script>
<script type="text/javascript" src="include/js/AjaxRequest.js"></script>
<script type="text/javascript" src="include/js/base64.js"></script>
<script type='text/javascript' src='include/js/popbox.js'></script>
<script type="text/javascript" src="sistema/admon/script/usuario_script.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="sistema/admon/script/perfil_script.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="sistema/admon/script/empresa_script.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="sistema/admon/script/banquero_script.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="sistema/admon/script/grupo_script.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="sistema/admon/script/agencia_script.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="sistema/admon/script/taquilla_script.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="sistema/admon/script/liga_script.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="sistema/admon/script/notificacion_script.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="sistema/apuestas/script/script_apuestas.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="sistema/reportes/script/script_reportes.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="sistema/procesos/script/script_anular.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="sistema/procesos/script/script_anular_jugada.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="sistema/procesos/script/script_reimprimir.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="sistema/procesos/script/script_procesar.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="sistema/procesos/script/script_actualizar_premio.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="sistema/procesos/script/script_pagar.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="sistema/procesos/script/script_resultados.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="sistema/procesos/script/script_calculadora.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="sistema/procesos/script/script_logros.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="sistema/consultas/script/script_ticket.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="sistema/consultas/script/script_apuestas.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="sistema/consultas/script/script_logros.js?v=<?=$rand?>"></script>
<script type="text/javascript" src="sistema/consultas/script/script_resultados.js?v=<?=$rand?>"></script>
<script type='text/javascript' charset='utf-8'>
	$(document).ready(function(){
		$('.popbox').popbox();
	});
</script>
<script language="javascript">
	var timer = 0;
	function set_interval() {
		timer = setInterval("auto_logout()",3600000);
	}
	function reset_interval() {
		if (timer != 0) {
			clearInterval(timer);
			timer = 0;
			timer = setInterval("auto_logout()",3600000);
		}
	}
	function auto_logout()	{
		window.location="logout.php";
	}
</script>
</body>
</html>