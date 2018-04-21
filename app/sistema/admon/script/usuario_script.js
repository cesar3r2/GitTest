// Documento JavaScript
var modificarUsuario = 0;
var paginaUsuario = 'usuarios_list.php';

// ----------------------------------- | Registrar Usuarios | --------------------------------- //

function guardarUsuario()
{
	var usuario = document.getElementById('txt_usuario').value;
	var nombre = document.getElementById('txt_nombre').value;
	var clave = document.getElementById('txt_clave').value;
	var tipo = document.getElementById('sel_tipo').value;
	var agencia = document.getElementById('sel_agencia').value;
	var pcs = document.getElementById('nro_pcs').value;
	var r;
	
	if(modificarUsuario == 0) {
		mensajeGuardar='¿Desea guardar el registro del usuario '+usuario+'?','si/no';
	} else {
		mensajeGuardar='¿Desea modificar el registro del usuario '+usuario+'?','si/no';
	}
	
	if ((tipo == 4) && ( pcs == 0)) {
		jAlert('Debe introducir la cantidad de PCs de la agencia. Por favor verifique los datos', 'Información');
		return;
	}	
	
	if(usuario!="" && nombre!="" && tipo!='0' && agencia!='0')
	{
		jConfirm(mensajeGuardar, 'Confirmación', function(r) {
			if(r)
			{
				AjaxRequest.post
									(
										{'parameters':{		'usuario':usuario,
															'nombre':nombre,
															'clave':clave,
															'tipo':tipo,
															'agencia':agencia,
															'pcs':pcs,
															'modificarUsuario':modificarUsuario,
															'accion':'registrarUsuario'
															}
															,'onSuccess':function(req){verificarTransaccionUsr(req,usuario)}
															,'url':'sistema/admon/transaccion/usr_trans.php'
															,'onError': function(req)
															{
																alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
															}
											}
										);
			}
			modificarUsuario = 0;
		} );
	} else {
		jAlert('Ha dejado campos vacíos o sin seleccionar. Por favor verifique los datos', 'Información');
	}
}

function verificarTransaccionUsr(req, usuario)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != false) {
		jAlert("El usuario "+usuario+" ha sido registrado con éxito", 'Notificación');
		cambiar_contenido('sistema/admon/usuarios_list.php', 'sub_contenido');
	} else {
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}

//------------------------------------ | Editar Usuarios | ---------------------------------//

function validaEditarUsuarios(formu) {
	var i, j=0;
	var seleccionado;
	var formulario = document.getElementById(formu);
	for (i=0; i<formulario.elements.length; i++) {
		var elemento = formulario.elements[i];
		if(elemento.type == "checkbox") {
			if(elemento.checked) {
				j=j+1;
				seleccionado = elemento.value;
			}
		}
	}
	if (j == 0) {
		jAlert('Debe seleccionar un registro de la lista para editarlo', 'Información');
	} else if (j > 1) {
		jAlert('Solo debe seleccionar un registro de la lista para editarlo', 'Información');
	} else {
		cambiar_contenido('sistema/admon/usuarios_form.php?accion=edit', 'sub_contenido');
		mostrarInfoUsuario(seleccionado);
	}
}

function mostrarInfoUsuario(usuario)
{
	AjaxRequest.post
						(
							{'parameters':{'usuario':usuario,
												'accion':'mostrarInformacionUsuario'
												}
												,'onSuccess':respMostrarInfoUsuario
												,'url':'sistema/admon/transaccion/usr_trans.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respMostrarInfoUsuario(req)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != '')
	{
		modificarUsuario = 1; // para ser modificado
		document.getElementById('txt_usuario').value=resp[0]['usuario'];
		document.getElementById('txt_usuario').disabled=true;
		document.getElementById('txt_nombre').value=resp[0]['nombre'];
		//document.getElementById('txt_clave').value=Base64.decode(resp[0]['clave']);
		document.getElementById('sel_agencia').value=resp[0]['id_agencia'];
		document.getElementById('sel_tipo').value=resp[0]['tipo'];
		
		if (resp[0]['tipo'] == 4) {
			document.getElementById('nro_pcs').disabled = false;
			document.getElementById('nro_pcs').value = resp[0]['nro_pcs'];
		}	
	}
}

//-------------------------------------- | Eliminar Usuarios | -----------------------------------//

function validaEliminarUsuarios(formu) {
	var i, j=0, k=0;
	var seleccionados=[];
	var formulario = document.getElementById(formu);
	for (i=0; i<formulario.elements.length; i++) {
		var elemento = formulario.elements[i];
		if(elemento.type == "checkbox") {
			if(elemento.checked) {
				j=j+1;
				seleccionados[k] = elemento.value;
				k++;
			}
		}
	}
	if (j == 0) {
		jAlert('Debe seleccionar por lo menos un registro de la lista para eliminar', 'Información');
	} else {
		jConfirm('¿Confirma que desea eliminar el (los) registro(s) seleccionado(s)?', 'Confirmación', function(r) {
			if(r) {
				eliminarUsuario(seleccionados);
			}
		} );
	}
}

function eliminarUsuario(seleccionados)
{
	AjaxRequest.post
						 (
							{'parameters':{'usuarios': seleccionados
											  ,'accion': 'eliminarUsuario'}
											  ,'onSuccess': function(req) {respEliminarUsuario(req,seleccionados)}
											  ,'url': 'sistema/admon/transaccion/usr_trans.php'
											  ,'onError': function(req) {
													alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respEliminarUsuario(req,seleccionados)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp!=false)
	{
		jAlert("El(los) usuario(s) ha(n) sido eliminado(s) con éxito", 'Notificación');
		cambiar_contenido('sistema/admon/usuarios_list.php', 'sub_contenido');
	}
	else
	{
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}

// -------------------------------------- | Validar Usuarios | -----------------------------------//

function validarUsuario() {
	var codigo = document.getElementById('txt_usuario');
	var contenido_codigo = abrirAjax();
	
	contenido_codigo.open("GET", "sistema/admon/usr_procesos.php?accion=1&usuario="+codigo.value, true);
    contenido_codigo.onreadystatechange=function()
	{
		if (contenido_codigo.readyState==4)
		{
			var arregloDatos;
			arregloDatos = contenido_codigo.responseText;
			if (arregloDatos != 0) {
				jAlert('El usuario se encuentra registrado', 'Información');
				codigo.value = '';
				codigo.focus();
				return;
			}
		}
	}
	contenido_codigo.send(null);
}

function tipoDeUsuario() {
	var codigo = document.getElementById('usuario');
	var contenido_codigo = abrirAjax();
	
	contenido_codigo.open("GET", "app/sistema/admon/usr_procesos.php?accion=4&usuario="+codigo.value, true);
    contenido_codigo.onreadystatechange=function()
	{
		if (contenido_codigo.readyState==4)
		{
			var arregloDatos;
			arregloDatos = contenido_codigo.responseText.split('||');
			if (arregloDatos != '') {
				document.getElementById('tipo_usr').value = arregloDatos[0];
				document.getElementById('nro_pcs').value = arregloDatos[1];
			}
		}
	}
	contenido_codigo.send(null);
}

// -------------------------------------- | Buscar Usuarios | -----------------------------------//

function filtro_usuario(e, busqueda) {
	var tecla = 0;
	tecla = e ? e.keyCode : event.keyCode;
	if(tecla == 13)
	{
		if(busqueda != '')
		{
			busqueda_usuarios(busqueda);
		}
	}
}

function busqueda_usuarios(busqueda) {
	if (busqueda != '') {
		cambiar_contenido('sistema/admon/usuarios_list.php?buscar='+busqueda, 'sub_contenido');
	}
}

function busqueda_usuarios_2() {
	var busqueda = document.getElementById('filtro_usr');
	if (busqueda.value != '') {
		cambiar_contenido('sistema/admon/usuarios_list.php?buscar='+busqueda.value, 'sub_contenido');
	}
}


/************** CAMBIAR CONTRASEÑA ***************/

function validar_clave() {
	var usuario = document.getElementById('txt_usuario');
	var clave_act = document.getElementById('txt_clave');

	AjaxRequest.post
						(
							{'parameters':{		'usuario':usuario.value,
												'clave':clave_act.value,
												'accion':'validarClave'
												}
												,'onSuccess': function(req) {resp_validar_clave(req)}
												,'url':'sistema/admon/transaccion/usr_trans.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function resp_validar_clave(req) {
	var clave_act = document.getElementById('txt_clave');

	var resp = eval ("("+ req.responseText +")");

	if (resp == false) {
		jAlert('La contraseña actual no coincide con la del usuario. Por favor verifique sus datos', 'información');
		clave_act.value = '';
		clave_act.focus();
		return;
	}
}

function verificarClave()
{
	var clave1=document.getElementById('clave_nva_1');
	var clave2=document.getElementById('clave_nva_2');
	if(clave1.value != clave2.value)
	{
		jAlert('Las contraseñas suministradas no coinciden. Por favor verifique sus datos', 'información');
		clave2.value = '';
		clave2.focus();
		return;
	}
}

function cambiarClave()
{
	var usuario = document.getElementById('txt_usuario').value;
	var clave_act = document.getElementById('txt_clave').value;
	var clave1 = document.getElementById('clave_nva_1').value;
	var clave2 = document.getElementById('clave_nva_2').value;
	var r;
	
	var mensaje='¿Confirma modificar la constraseña de acceso del usuario '+usuario+'?';
	

	if(clave_act!="" && clave1!="" && clave2!="")
	{
		jConfirm(mensaje, 'Confirmación', function(r) {
			if(r)
			{
				AjaxRequest.post
									(
										{'parameters':{'usuario':usuario,
															'clave':clave1,
															'accion':'cambiarClave'
															}
															,'onSuccess':function(req){verificarCambioClave(req,usuario)}
															,'url':'sistema/admon/transaccion/usr_trans.php'
															,'onError': function(req)
															{
																alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
															}
											}
										);
			}
		} );
	}
	else {
		jAlert('Ha dejado campos vacíos. Por favor verifique sus datos', 'información');
	}
}


function verificarCambioClave(req, usuario)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != false) {
		jAlert("La contraseña del usuario "+usuario+" ha sido registrada con éxito", 'Notificación');
		cambiar_contenido('sistema/admon/cambiar_clave.php', 'sub_contenido');
	} else {
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}

function mostrarOpcTaq() {
	var tipo = document.getElementById('sel_tipo').value;
	if (tipo == 4) {
		document.getElementById('nro_pcs').disabled = false;
	} else {
		document.getElementById('nro_pcs').value = 0;
		document.getElementById('nro_pcs').disabled = true;
	}
}

function validarTipo() {
	var agencia = document.getElementById('sel_agencia').value;
	var tipo = document.getElementById('sel_tipo').value;
	
	if (tipo == 3 || tipo == 4) {
		var contenido_codigo = abrirAjax();
		contenido_codigo.open("GET", "sistema/admon/usr_procesos.php?accion=3&agencia="+agencia+"&tipo="+tipo, true);
		contenido_codigo.onreadystatechange=function()
		{
			if (contenido_codigo.readyState==4)
			{
				var datos;
				datos = contenido_codigo.responseText;
				if (datos > 0) {
					jAlert('El tipo de usuario seleccionado ya se encuentra registrado para la agencia seleccionada', 'información');
					limpiarAg();
				}
			}
		}
		contenido_codigo.send(null);
	}
}

function limpiarAg() {
	var agencia = document.getElementById('sel_agencia');
	var tipo = document.getElementById('sel_tipo');
	var pcs = document.getElementById('nro_pcs');
	
	agencia.value = 0;
	tipo.value = 0;
	pcs.value = 0;
	pcs.disabled = true;
}