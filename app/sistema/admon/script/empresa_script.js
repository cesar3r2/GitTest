// Documento JavaScript
var paginaEmpresa = 'empresa_list.php';

// ----------------------------------- | Registrar Empresa | --------------------------------- //

function guardarEmpresa()
{
	var rif = document.getElementById('txt_rif').value;
	var nombre = document.getElementById('txt_nombre').value;
	var nombre_comercial = document.getElementById('txt_nombre_comercial').value;
	var direccion = document.getElementById('txt_direccion').value;
	var telefono = document.getElementById('txt_telefono').value;
	var r;
	
	mensajeGuardar = '¿Desea modificar el registro de la empresa?','si/no';
	
	if(rif!="" && nombre!="")
	{
		jConfirm(mensajeGuardar, 'Confirmación', function(r) {
			if(r)
			{
				AjaxRequest.post
									(
										{'parameters':{'rif':rif,
															'nombre':nombre,
															'nombre_comercial':nombre_comercial,
															'direccion':direccion,
															'telefono':telefono,
															'accion':'registrarEmpresa'
															}
															,'onSuccess':function(req){verificarTransaccionEmpresa(req)}
															,'url':'sistema/admon/transaccion/empresa_trans.php'
															,'onError': function(req)
															{
																alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
															}
											}
										);
			}
		} );
	} else {
		jAlert('Ha dejado campos vacíos o sin seleccionar. Por favor verifique los datos', 'Información');
	}
}

function verificarTransaccionEmpresa(req)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != false) {
		jAlert("La empresa ha sido registrada con éxito", 'Notificación');
		cambiar_contenido('sistema/admon/empresa_list.php', 'sub_contenido');
	} else {
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}

//------------------------------------ | Editar Empresa | ---------------------------------//

function validaEditarEmpresa(formu) {
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
		cambiar_contenido('sistema/admon/empresa_form.php', 'sub_contenido');
		mostrarInfoEmpresa(seleccionado);
	}
}

function mostrarInfoEmpresa(rif)
{
	AjaxRequest.post
						(
							{'parameters':{'rif':rif,
												'accion':'mostrarInformacionEmpresa'
												}
												,'onSuccess':respMostrarInfoEmpresa
												,'url':'sistema/admon/transaccion/empresa_trans.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respMostrarInfoEmpresa(req)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != '')
	{
		document.getElementById('txt_rif').value=resp[0]['rif'];
		document.getElementById('txt_rif').disabled=true;
		document.getElementById('txt_nombre').value=resp[0]['nombre'];
		document.getElementById('txt_nombre_comercial').value=resp[0]['nombre_comercial'];
		document.getElementById('txt_direccion').value=resp[0]['direccion'];
		document.getElementById('txt_telefono').value=resp[0]['telefono'];
	}
}