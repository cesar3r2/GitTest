// Documento JavaScript
var modificarTaquilla = 0;
var paginaTaquilla = 'taquillas_list.php';

// ----------------------------------- | Registrar Taquilla | --------------------------------- //

function guardarTaquilla()
{
	var id = document.getElementById('id').value;
	var nombre = document.getElementById('txt_nombre').value;
	var agencia = document.getElementById('sel_agencia').value;
	var r;
	
	if(modificarTaquilla == 0)
		mensajeGuardar='¿Desea guardar el registro de la taquilla '+nombre+'?','si/no';
	else
		mensajeGuardar='¿Desea modificar el registro de la taquilla '+nombre+'?','si/no';
	
	if(id != "" && nombre!="" && agencia!=0)
	{
		jConfirm(mensajeGuardar, 'Confirmación', function(r) {
			if(r)
			{
				AjaxRequest.post
									(
										{'parameters':{     'id':id,
															'nombre':nombre,
															'agencia':agencia,
															'modificarTaquilla':modificarTaquilla,
															'accion':'registrarTaquilla'
															}
															,'onSuccess':function(req){verificarTransaccionTaquilla(req,nombre)}
															,'url':'sistema/admon/transaccion/taquilla_trans.php'
															,'onError': function(req)
															{
																alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
															}
											}
										);
			}
			modificarTaquilla = 0;
		} );
	} else {
		jAlert('Ha dejado campos vacíos o sin seleccionar. Por favor verifique los datos', 'Información');
	}
}

function verificarTransaccionTaquilla(req, nombre)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != false) {
		jAlert("La taquilla "+nombre+" ha sido registrada con éxito", 'Notificación');
		cambiar_contenido('sistema/admon/taquillas_list.php', 'sub_contenido');
	} else {
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}

//------------------------------------ | Editar Taquilla | ---------------------------------//

function validaEditarTaquilla(formu) {
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
		cambiar_contenido('sistema/admon/taquillas_form.php?accion=edit', 'sub_contenido');
		mostrarInfoTaquilla(seleccionado);
	}
}

function mostrarInfoTaquilla(codigo)
{
	AjaxRequest.post
						(
							{'parameters':{     'codigo':codigo,
												'accion':'mostrarInformacionTaquilla'
												}
												,'onSuccess':respMostrarInfoTaquilla
												,'url':'sistema/admon/transaccion/taquilla_trans.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respMostrarInfoTaquilla(req)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != '')
	{
		modificarTaquilla = 1; // para ser modificado
		document.getElementById('id').value=resp[0]['id'];
		document.getElementById('sel_agencia').value=resp[0]['id_agencia'];
		document.getElementById('sel_agencia').disabled=true;
		document.getElementById('txt_nombre').value=resp[0]['nombre'];
	}
}

//-------------------------------------- | Eliminar Taquillas | -----------------------------------//

function validaEliminarTaquillas(formu) {
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
				eliminarTaquillas(seleccionados);
			}
		} );
	}
}

function eliminarTaquillas(seleccionados)
{
	AjaxRequest.post
						 (
							{'parameters':{   'codigos': seleccionados
											  ,'accion': 'eliminarTaquilla'}
											  ,'onSuccess': function(req) {respEliminarTaquilla(req,seleccionados)}
											  ,'url': 'sistema/admon/transaccion/taquilla_trans.php'
											  ,'onError': function(req) {
													alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respEliminarTaquilla(req,seleccionados)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp!=false)
	{
		jAlert("La(s) taquilla(s) ha(n) sido eliminada(s) con éxito", 'Notificación');
		cambiar_contenido('sistema/admon/taquillas_list.php', 'sub_contenido');
	}
	else
	{
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}

// -------------------------------------- | Validar Taquilla | -----------------------------------//

function validarTaquilla() {
	var codigo = document.getElementById('sel_agencia');
	var nombre = document.getElementById('txt_nombre');
	var contenido_codigo = abrirAjax();
	
	contenido_codigo.open("GET", "sistema/admon/taquillas_procesos.php?accion=1&codigo="+codigo.value+"&nombre="+nombre.value, true);
    contenido_codigo.onreadystatechange=function()
	{
		if (contenido_codigo.readyState==4)
		{
			var arregloDatos;
			arregloDatos = contenido_codigo.responseText;
			if (arregloDatos != 0) {
				jAlert('El número de cédula o rif de la agencia se encuentra registrado', 'Información');
				codigo.value = '';
				codigo.focus();
				return;
			}
		}
	}
	contenido_codigo.send(null);
}

// -------------------------------------- | Buscar Agencias | -----------------------------------//

function filtro_taquilla(e, busqueda) {
	var tecla = 0;
	tecla = e ? e.keyCode : event.keyCode;
	if(tecla == 13)
	{
		if(busqueda != '')
		{
			busqueda_taquillas(busqueda);
		}
	}
}

function busqueda_taquillas(busqueda) {
	if (busqueda != '') {
		cambiar_contenido('sistema/admon/taquillas_list.php?buscar='+busqueda, 'sub_contenido');
	}
}