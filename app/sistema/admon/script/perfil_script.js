// JavaScript Document
var modificarPerfil = 0;
var paginaPerfil = 'perfiles_list.php';

// ----------------------------------- Registrar Perfil ---------------------------------//
function guardarPerfil()
{
	var id = document.getElementById('txt_codigo').value;
	var nombre = document.getElementById('txt_nombre').value;
	var r;
	var marcados = verificar_menu_marcado("fPerfiles");
	
	if(modificarPerfil == 0)
		mensajeGuardar='¿Desea guardar el registro del perfil '+nombre+'?','si/no';
	else
		mensajeGuardar='¿Desea modificar el registro del perfil '+nombre+'?','si/no';
	
	if(id!="" && nombre!="")
	{
			jConfirm(mensajeGuardar, 'Confirmación', function(r){
			if(r)
			{
					AjaxRequest.post
										(
											{'parameters':{'codigo':id,
																'nombre':nombre,
																'modificarPerfil':modificarPerfil,
																'acceso':marcados,
																'accion':'registrarPerfil'
																}
																,'onSuccess':function(req){verificarTransaccionPerfil(req,id)}
																,'url':'sistema/admon/transaccion/perfil_trans.php'
																,'onError': function(req)
																{
																	alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
																}
												}
											);
			}
			modificarPerfil = 0;
			} );
	} else {
		jAlert('Ha dejado campos vacíos o sin seleccionar. Por favor verifique los datos', 'Información');
	}
}

function verificarTransaccionPerfil(req, id)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != false)
	{
		jAlert("El perfil "+id+" ha sido registrado con éxito", 'Notificación');
		cambiar_contenido('sistema/admon/perfiles_list.php', 'sub_contenido');
	}
	else
	{
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}

function verificar_menu_marcado(nombreFormu) {
	var i, j=0, k=0;
	var seleccionados=[];
	var formulario = document.getElementById(nombreFormu);
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
	return seleccionados;
}
//--------------------------------------------------------------------------------------//
//------------------------------------ Editar Perfiles ---------------------------------//

function validaEditarPerfiles(formu) {
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
		cambiar_contenido('sistema/admon/perfiles_form.php?accion=edit', 'sub_contenido');
		mostrarInfoPerfil(seleccionado);
	}
}

function mostrarInfoPerfil(codigo)
{
	AjaxRequest.post
						(
							{'parameters':{'codigo':codigo,
												'accion':'mostrarInformacionPerfil'
												}
												,'onSuccess':respMostrarInfoPerfil
												,'url':'sistema/admon/transaccion/perfil_trans.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respMostrarInfoPerfil(req)
{
	var codigo = document.getElementById('txt_codigo');
	var nombre = document.getElementById('txt_nombre');
	var formulario = document.getElementById('fPerfiles');
	var resp = eval ("("+ req.responseText +")");
	if(resp != '')
	{
		modificarPerfil = 1; // para ser modificado
		codigo.value = resp[0]['id'];
		codigo.disabled = true;
		nombre.value = resp[0]['nombre'];
		var guardado = resp[0]['acceso_menu'];
		var i, j=0, k=0, menu='';
		for (i=0; i<formulario.elements.length; i++) {
			var elemento = formulario.elements[i];
			if(elemento.type == "checkbox") {
				menu = menu+elemento.value+',';
			}
		}
		var a = guardado.split(',');
		var b = menu.split(',');
		
		for (j=0; j<a.length; j++) {
			for (k=0; k<b.length; k++) {
				if (a[j] == b[k]) {
					var elemento = formulario.elements[k];
					elemento.checked = true;
				}
			}
		}
	}
}

//--------------------------------------------------------------------------------------------//
//-------------------------------------- Eliminar Perfiles -----------------------------------//

function validaEliminarPerfiles(formu) {
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
				eliminarPerfil(seleccionados);
			}
		} );
	}
}

function eliminarPerfil(seleccionados)
{
	AjaxRequest.post
						 (
							{'parameters':{'perfiles': seleccionados
											  ,'accion': 'eliminarPerfil' }
											  ,'onSuccess': function(req) {respEliminarPerfiles(req,seleccionados)}
											  ,'url': 'sistema/admon/transaccion/perfil_trans.php'
											  ,'onError': function(req) {
													alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respEliminarPerfiles(req,seleccionados)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp!=false)
	{
		jAlert("El(los) perfil(es) ha(n) sido eliminado(s) con éxito", 'Notificación');
		cambiar_contenido('sistema/admon/perfiles_list.php', 'sub_contenido');
	}

	else
	{
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}
// -------------------------------------------------------------------------------------------//
// -------------------------------------- Validar Perfil -----------------------------------//

function validarPerfil() {
	var codigo = document.getElementById('txt_codigo');
	var contenido_codigo = abrirAjax();
	
	contenido_codigo.open("GET", "sistema/admon/perfil_procesos.php?accion=1&codigo="+codigo.value, true);
   	contenido_codigo.onreadystatechange=function()
	{
		if (contenido_codigo.readyState==4)
		{
			var arregloDatos;
			arregloDatos = contenido_codigo.responseText;
			if (arregloDatos != 0) {
				jAlert('El perfil se encuentra registrado', 'Información');
				codigo.value = '';
				codigo.focus();
				return;
			}
		}
	}
	contenido_codigo.send(null);
}

function filtro_perfil(e, busqueda) {
	var tecla = 0;
	tecla = e ? e.keyCode : event.keyCode;
	if(tecla == 13)
	{
		if(busqueda != '')
		{
			busqueda_perfil(busqueda);
		}
	}
}

function busqueda_perfil(busqueda) {
	if (busqueda != '') {
		cambiar_contenido('sistema/admon/perfiles_list.php?buscar='+busqueda, 'sub_contenido');
	}
}

function busqueda_perfil_2() {
	var busqueda = document.getElementById('filtro_per');
	if (busqueda.value != '') {
		cambiar_contenido('sistema/admon/perfiles_list.php?buscar='+busqueda.value, 'sub_contenido');
	}
}