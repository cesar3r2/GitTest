// Documento JavaScript
var modificarBanquero = 0;
var paginaBanquero = 'banqueros_list.php';

// ----------------------------------- | Registrar Agencia | --------------------------------- //

function guardarBanquero()
{
	var cedula = document.getElementById('txt_cedula').value;
	var nombre = document.getElementById('txt_nombre').value;
	var direccion = document.getElementById('txt_direccion').value;
	var telefono = document.getElementById('txt_telefono').value;
	var correo = document.getElementById('txt_correo').value;
	var r;
	
	if(modificarBanquero == 0)
		mensajeGuardar='¿Desea guardar el registro del banquero '+nombre+'?','si/no';
	else
		mensajeGuardar='¿Desea modificar el registro del banquero '+nombre+'?','si/no';
	
	if(cedula != "" && nombre!="")
	{
		jConfirm(mensajeGuardar, 'Confirmación', function(r) {
			if(r)
			{
				AjaxRequest.post
									(
										{'parameters':{		'cedula':cedula,
															'nombre':nombre,
															'direccion':direccion,
															'telefono':telefono,
															'correo':correo,
															'modificarBanquero':modificarBanquero,
															'accion':'registrarBanquero'
															}
															,'onSuccess':function(req){verificarTransaccionBanquero(req,nombre)}
															,'url':'sistema/admon/transaccion/banquero_trans.php'
															,'onError': function(req)
															{
																alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
															}
											}
										);
			}
			modificarBanquero = 0;
		} );
	} else {
		jAlert('Ha dejado campos vacíos o sin seleccionar. Por favor verifique los datos', 'Información');
	}
}

function verificarTransaccionBanquero(req, nombre)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != false) {
		jAlert("El banquero "+nombre+" ha sido registrado con éxito", 'Notificación');
		cambiar_contenido('sistema/admon/banqueros_list.php', 'sub_contenido');
	} else {
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}
//------------------------------------ | Editar Banquero | ---------------------------------//

function validaEditarBanquero(formu) {
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
		cambiar_contenido('sistema/admon/banqueros_form.php?accion=edit', 'sub_contenido');
		mostrarInfoBanquero(seleccionado);
	}
}

function mostrarInfoBanquero(codigo)
{
	AjaxRequest.post
						(
							{'parameters':{     'codigo':codigo,
												'accion':'mostrarInformacionBanquero'
												}
												,'onSuccess':respMostrarInfoBanquero
												,'url':'sistema/admon/transaccion/banquero_trans.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respMostrarInfoBanquero(req)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != '')
	{
		modificarBanquero = 1; // para ser modificado
		document.getElementById('txt_cedula').value=resp[0]['cedula'];
		document.getElementById('txt_cedula').disabled=true;
		document.getElementById('txt_nombre').value=resp[0]['nombre'];
		document.getElementById('txt_direccion').value=resp[0]['direccion'];
		document.getElementById('txt_telefono').value=resp[0]['telefono'];
		document.getElementById('txt_correo').value=resp[0]['correo'];
	}
}

//-------------------------------------- | Eliminar Banqueros | -----------------------------------//

function validaEliminarBanqueros(formu) {
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
				eliminarBanqueros(seleccionados);
			}
		} );
	}
}

function eliminarBanqueros(seleccionados)
{
	AjaxRequest.post
						 (
							{'parameters':{   'codigos': seleccionados
											  ,'accion': 'eliminarBanquero'}
											  ,'onSuccess': function(req) {respEliminarBanquero(req,seleccionados)}
											  ,'url': 'sistema/admon/transaccion/banquero_trans.php'
											  ,'onError': function(req) {
													alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respEliminarBanquero(req,seleccionados)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp!=false)
	{
		jAlert("El(los) banquero(s) ha(n) sido eliminado(s) con éxito", 'Notificación');
		cambiar_contenido('sistema/admon/banqueros_list.php', 'sub_contenido');
	}
	else
	{
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}

// -------------------------------------- | Validar Banquero | -----------------------------------//

function validarBanquero() {
	var codigo = document.getElementById('txt_cedula');
	var contenido_codigo = abrirAjax();
	
	contenido_codigo.open("GET", "sistema/admon/banqueros_procesos.php?accion=1&codigo="+codigo.value, true);
    contenido_codigo.onreadystatechange=function()
	{
		if (contenido_codigo.readyState==4)
		{
			var arregloDatos;
			arregloDatos = contenido_codigo.responseText;
			if (arregloDatos != 0) {
				jAlert('El número de cédula del banquero se encuentra registrado', 'Información');
				codigo.value = '';
				codigo.focus();
				return;
			}
		}
	}
	contenido_codigo.send(null);
}

// -------------------------------------- | Buscar Banqueros | -----------------------------------//

function filtro_banquero(e, busqueda) {
	var tecla = 0;
	tecla = e ? e.keyCode : event.keyCode;
	if(tecla == 13)
	{
		if(busqueda != '')
		{
			busqueda_banqueros(busqueda);
		}
	}
}

function busqueda_banqueros(busqueda) {
	if (busqueda != '') {
		cambiar_contenido('sistema/admon/banqueros_list.php?buscar='+busqueda, 'sub_contenido');
	}
}