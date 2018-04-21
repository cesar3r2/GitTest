// Documento JavaScript

function guardarNotificacion()
{
	var id = document.getElementById('id_notificacion').value;
	var descripcion = document.getElementById('descripcion').value;
	var estatus = document.getElementById('estatus').value;
	var r;
	
	mensajeGuardar='¿Confirma el registro de la notificación seleccionada?','si/no';
	
	if(id != -1 && estatus!="")
	{
		jConfirm(mensajeGuardar, 'Confirmación', function(r) {
			if(r)
			{
				AjaxRequest.post
									(
										{'parameters':{		'id':id,
															'descripcion':descripcion,
															'estatus':estatus,
															'accion':'guardarNotificacion'
															}
															,'onSuccess':function(req){verificarTransNotificacion(req)}
															,'url':'sistema/admon/transaccion/notificacion_trans.php'
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

function verificarTransNotificacion(req)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != false) {
		jAlert("La notificacion ha sido registrada con éxito", 'Notificación');
		cambiar_contenido('sistema/admon/notificaciones_admin.php', 'sub_contenido');
	} else {
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}

function mostrarNotificacion(id)
{
	AjaxRequest.post
						(
							{'parameters':{     'id':id,
												'accion':'mostrarInfoNotificacion'
												}
												,'onSuccess':respMostrarInfoNotificacion
												,'url':'sistema/admon/transaccion/notificacion_trans.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respMostrarInfoNotificacion(req)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != '')
	{
		document.getElementById('descripcion').value=resp[0]['descripcion'];
		document.getElementById('estatus').value=resp[0]['estatus'];
	}
}