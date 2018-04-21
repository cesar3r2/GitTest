// JavaScript Document

function reimprimirTicket() {
	var nroTicket = document.getElementById('nro_ticket').value;
	var nroSeguridad = document.getElementById('nro_seguridad').value;
	
	if (nroTicket != "" && nroSeguridad != "") {
		buscarInfoTicket(nroTicket, nroSeguridad);
	} else {
		jAlert('Ha dejado campos vacíos o sin seleccionar. Por favor verifique los datos', 'Información');
	}
}

function buscarInfoTicket(nroTicket, nroSeguridad)
{
	AjaxRequest.post
						(
							{'parameters':{		'nro_ticket':nroTicket,
												'nro_seguridad':nroSeguridad,
												'accion':'buscarInfoTicket'
												}
												,'onSuccess':respMostrarInfoTicketImprimir
												,'url':'sistema/procesos/transaccion/trans_reimprimir.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}
function respMostrarInfoTicketImprimir(req)
{
	var resp = eval ("("+ req.responseText +")");
	var nroTicket = document.getElementById('nro_ticket').value;
	if(resp != false)
	{
		if ((resp[0]['estatus'] != 'PENDIENTE') && (resp[0]['estatus'] != 'GANADORA'))
		{
			jAlert('El ticket solicitado no puede ser mostrado. La apuesta está '+resp[0]['estatus'], 'Información');
			return;
		} else  if (resp.length == 1) {
			openMyModal('sistema/apuestas/ticket.php?id='+nroTicket);
		}
	}
	else
	{
		jAlert('Los datos del ticket no son válidos', 'Información');
		return;
	}
}