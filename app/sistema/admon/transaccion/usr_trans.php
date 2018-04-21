<?php
	include_once("../../../include/php/common.php");
	include_once("../../../include/php/JSON.php");
	include_once('../../../conexionConf.php');
	include "../../../clases/class.usuario.php";
		
	$objUsr = new usuario();
	$operacion = $_POST['accion'];
	
	switch($operacion) {
		case 'registrarUsuario':
			$datos_form['USUARIO'] = $_POST['usuario'];
			$datos_form['CLAVE'] = $_POST['clave'];
			$datos_form['NOMBRE'] = $_POST['nombre'];
			$datos_form['TIPO'] = $_POST['tipo'];

			if ($_POST['tipo'] == 4)
				$datos_form['COOKIE'] = '-1';
			else
				$datos_form['COOKIE'] = '';
			$datos_form['ID_AGENCIA'] = $_POST['agencia'];
			$datos_form['PCS'] = $_POST['pcs'];
			$opcion = $_POST['modificarUsuario'];
			
			$patron = buscar_patron();
			$datos_form['CLAVE'] = sha1(md5($patron.$_POST['clave'].$patron));

			if($opcion == 1) {
				if ($_POST['clave'] != '')
					$usuario = $objUsr->modificar($datos_form);
				else
					$usuario = $objUsr->modificar_sin_clave($datos_form);
			} else {
				$usuario = $objUsr->agregar($datos_form);
			}
		break;
		
		case 'mostrarInformacionUsuario':
			sleep(1);
			$usr = $_POST['usuario'];
			$usuario = $objUsr->buscar_usuario($usr);
		break;
		
		case 'eliminarUsuario':
			$usr = $_POST['usuarios'];
			$usuarios = $objUsr->eliminar($usr);
		break;
		
		case 'cambiarClave':
			$usr = $_POST['usuario'];
			$clave = $_POST['clave'];
			
			$patron = buscar_patron();
			$clave_form = sha1(md5($patron.$clave.$patron));

			$usuario = $objUsr->cambiar_clave($usr, $clave_form);
		break;
		
		case 'mostrarLista':
			$usuario = $objUsr->lista();
			$nFilas = count($fObj);
		break;

		case 'loguearUsr':
			$objUsr = new usuario();
			$objUsr1 = new usuario();
			$usuarioForm = $_POST['usuario'];
			$clave = $_POST['clave'];
			$tipo = $_POST['tipo'];
			$pcs = $_POST['nro_pcs'];
			$sw = 0;
			$cookie = $_COOKIE['taquilla_ps'];

			$patron = buscar_patron();
			$claveForm = sha1(md5($patron.$clave.$patron));

			if ($tipo != 4) {
				$fUsr = $objUsr->validar_usuario($usuarioForm, $claveForm);
			} else {
				$fUsr1 = $objUsr1->validar_usuario($usuarioForm, $claveForm);
				$fUsr = $objUsr->validar_usuario_cookie($usuarioForm, $claveForm, $cookie);
				if ((count($fUsr) == 0) && $fUsr1[0]['nro_pcs'] > $pcs)
					$sw = 1;
			}
			if ($sw == 0)
				$usuario = count($fUsr);
			elseif ($sw == 1)
				$usuario = 1;
		break;
		
		case 'validarClave':
			$usuario = $_POST['usuario'];
			$clave = $_POST['clave'];

			$objUsr = new usuario();
			$fUsr = $objUsr->buscar_usuario($usuario);

			$patron = buscar_patron();
			$claveForm = base64_encode(sha1(md5($patron.$clave.$patron)));
			
			if ($claveForm == $fUsr[0]['clave'])
				$usuario = true;
			else 
				$usuario = false;
		break;

		default:
		break;
	}
	$json = new Services_JSON();
	$resp = $json->encode($usuario);
	echo $resp;
?>
