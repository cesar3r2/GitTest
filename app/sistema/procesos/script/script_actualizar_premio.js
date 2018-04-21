// JavaScript Document

function buscarDatosTicket() {
	var nroTicket = document.getElementById('nro_ticket').value;
	
	if (nroTicket != "") {
		AjaxRequest.post
						(
							{'parameters':{		'nro_ticket':nroTicket,
												'accion':'buscarInfoTicket'
												}
												,'onSuccess':respBuscarDatosTicket
												,'url':'sistema/procesos/transaccion/trans_actualizar_premio.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
	
	} else {
		jAlert('Debe introducir el número del ticket', 'Información');
	}
}

function respBuscarDatosTicket(req)
{
	var resp = eval ("("+ req.responseText +")");
	var nroTicket = document.getElementById('nro_ticket');
	if(resp != false)
	{
		if (resp[0]['estatus'] != 'GANADORA')
		{
			jAlert('La apuesta debe ser GANADORA. Actualmeste está '+resp[0]['estatus'], 'Información');
			return;
		} else if (resp[0]['estatus'] == 'GANADORA') {
			var premioActual = document.getElementById('premio_actual');
			var estatus = document.getElementById('estatus');
			nroTicket.disabled = 'true';
			premioActual.value = resp[0]['premio'];
			estatus.value = resp[0]['estatus'];
		}
	}
	else
	{
		jAlert('Los datos del ticket no son válidos', 'Información');
		nroTicket.value = '';
		nroTicket.focus();
		return;
	}
}

function actualizarPremio() {
	var r, mensajeGuardar;
	var nroTicket = document.getElementById('nro_ticket').value;
	var premioActual = document.getElementById('premio_actual').value;
	var premioNuevo = document.getElementById('premio_nuevo').value;
	mensajeGuardar = '¿Confirma que desea actualizar el premio del Ticket Nro. '+nroTicket+'?','si/no';
	
	if (nroTicket != "" && premioNuevo!="" && premioActual!="")
	{
		jConfirm(mensajeGuardar, 'Confirmación', function(r){
		if(r)
		{
				AjaxRequest.post
				(
							{'parameters':{		'nro_ticket':nroTicket,
												'premio_nuevo':premioNuevo,
												'accion':'actualizarPremio'
												}
												,'onSuccess':function(req){respActualizarPremio(req, nroTicket)}
												,'url':'sistema/procesos/transaccion/trans_actualizar_premio.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
											}
								);
						}
			} 
			);
	} else {
		jAlert('Ha dejado campos vacíos o sin seleccionar. Por favor verifique los datos', 'Información');
	}	
}

function respActualizarPremio(req, nroTicket)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != false)
	{
		jAlert('Se ha actualizado el premio del ticket Nro. '+nroTicket, 'Información');
		cambiar_contenido('sistema/procesos/actualizar_premio.php', 'sub_contenido');
	}
	else
	{
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}

function buscarInfoEnterPreTicket(e, operacion)
{
	var code;
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	if (code == 13) {
		if(operacion=='mostrarTicketPre')
		{
			buscarDatosTicket();
		}
	}
}