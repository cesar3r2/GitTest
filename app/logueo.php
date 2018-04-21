<?php
	session_start();
	ob_start();

	include "conexionConf.php";
	include "clases/class.usuario.php";
	include "clases/class.auditoria.php";
		
	$_SESSION["ESTATUS_USUARIO"] = "AUTENTICADO";
	$_SESSION["USUARIO"] = $_GET['usuario'];
	
	$objUsr = new usuario();
	$fUsr = $objUsr->buscar_usuario($_GET['usuario']);
	$_SESSION["NOMBRE_USUARIO"] = $fUsr[0]["nombre"];
	$_SESSION["PERFIL_USUARIO"] = $fUsr[0]["tipo"];
	$_SESSION["AGENCIA"] = $fUsr[0]["id_agencia"];
	$_SESSION['ipUser'] = $_SERVER['REMOTE_ADDR'];
	
	if ($fUsr[0]["tipo"] == 4) {
		$obj = new usuario();
		srand(time());
		$valor = rand(10000000, 99999999);
		if ($fUsr[0]["cookie"] == '-1')
		{
			setcookie('taquilla_ps', $valor, time() + (60*60*24*365));
			$fila = $obj->actualizar_cookie($_GET['usuario'], $valor);
			
		}
		else if (!stristr($_COOKIE['taquilla_ps'], $fUsr[0]["cookie"]))
		{
			setcookie('taquilla_ps', $valor, time() + (60*60*24*365));
			$cookie = $fUsr[0]["cookie"].','.$valor;
			$fila = $obj->actualizar_cookie($_GET['usuario'], $cookie);
		}
	}
	
	$datos['USUARIO'] = $_SESSION["USUARIO"];
	$datos['FECHA'] = date('Y-m-d');
	$datos['HORA'] = date('H:i:s');
	$datos['IP'] = $_SESSION["ipUser"];
	
	$objAudi = new auditoria();
	$fAudi = $objAudi->registrar_inicio_sesion($datos);
	
	echo "<script language=\"JavaScript\" type=\"text/javascript\">location.href=\"index.php\"</script>";
?>