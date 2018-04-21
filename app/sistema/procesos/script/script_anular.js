// JavaScript Document

function anularTicket() {
	var r, mensajeGuardar;
	var nroTicket = document.getElementById('nro_ticket').value;
	var nroSeguridad = document.getElementById('nro_seguridad').value;
	var estatus = document.getElementById('estatus').innerHTML;
	
	mensajeGuardar = '¿Confirma que desea anular el Ticket Nro. '+nroTicket+'?','si/no';

	if(nroTicket!="" && nroSeguridad!="" && estatus!="")
	{
		jConfirm(mensajeGuardar, 'Confirmación', function(r){
		if(r)
		{
				AjaxRequest.post(
									{'parameters': {'nro_ticket':nroTicket,
													'nro_seguridad':nroSeguridad,
													'accion':'anularTicket'
												   	}
													,'onSuccess':function(req){verificarTransaccionAnular(req, nroTicket)}
													,'url':'sistema/procesos/transaccion/trans_anular.php'
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

function verificarTransaccionAnular(req, nroTicket)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != false)
	{
		jAlert('Se ha anulado correctamente el ticket número '+nroTicket, 'Información');
		cambiar_contenido('sistema/procesos/anular_ticket.php', 'sub_contenido');
	}
	else
	{
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}


function mostrarTicket() {
	var nroTicket = document.getElementById('nro_ticket').value;
	var nroSeguridad = document.getElementById('nro_seguridad').value;
	
	if (nroTicket != "" && nroSeguridad != "") {
		mostrarInfoTicket(nroTicket, nroSeguridad);
	} else {
		jAlert('Ha dejado campos vacíos o sin seleccionar. Por favor verifique los datos', 'Información');
	}
}

function mostrarInfoTicket(nroTicket, nroSeguridad)
{
	AjaxRequest.post
						(
							{'parameters':{		'nro_ticket':nroTicket,
												'nro_seguridad':nroSeguridad,
												'accion':'mostrarInfoTicket'
												}
												,'onSuccess':respMostrarInfoTicket
												,'url':'sistema/procesos/transaccion/trans_anular.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respMostrarInfoTicket(req)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != '')
	{
		var nroTicket = document.getElementById('nro_ticket');
		var nroSeguridad = document.getElementById('nro_seguridad');
		var estatus = document.getElementById('estatus');
		var fecha = document.getElementById('fecha');
		var hora = document.getElementById('hora');
		var monto = document.getElementById('monto');
		var premio = document.getElementById('premio');

		var fecha_actual = document.getElementById('fecha_actual').value;
		var hora_actual = document.getElementById('hora_actual').value;
		var hora_ticket, fecha_ticket;
		
		hora_ticket = resp[0]['hora'];
		fecha_ticket = resp[0]['fecha'];
		var tiempoVenta = calcularTiempo(hora_actual, hora_ticket);
		var tiempo = tiempoVenta.split(':');
		var tiempoTrans = tiempo[0]+tiempo[1];
		
		if (Date.parse(fecha_ticket) != Date.parse(fecha_actual))
		{
			jAlert('El ticket no puede ser anulado. No fue registrado en el día actual', 'Información');
			nroTicket.value = '';
			nroSeguridad.value = '';
			nroTicket.focus();
			return;
		} else if (parseInt(tiempoTrans) > 30) {
			jAlert('El ticket no puede ser anulado. Para esta operación usted dispone de 30 minutos luego de registrarlo', 'Información');
			nroTicket.value = '';
			nroSeguridad.value = '';
			nroTicket.focus();
			return;
		}
		
		nroTicket.disabled = 'disabled';
		nroSeguridad.disabled = 'disabled';
		
		estatus.innerHTML = resp[0]['estatus_ap'];
		fecha.innerHTML = formatoFecha(resp[0]['fecha']);
		hora.innerHTML = resp[0]['hora'];
		monto.innerHTML = resp[0]['monto'];
		premio.innerHTML = resp[0]['premio'];
		
		if (resp[0]['estatus'] != 'PENDIENTE')	
		{
			jAlert('El número de ticket introducido no puede ser anulado. La apuesta está '+resp[0]['estatus'], 'Información');
			cambiar_contenido('sistema/procesos/anular_ticket.php', 'sub_contenido');
			return;
		}
		
		var tabla = document.getElementById('apuesta');
       	var tbl = document.createElement("table");
		tbl.width = '100%';
		tbl.setAttribute('cellpadding', '1');
		tbl.setAttribute('cellspacing','1');
        var tblBody = document.createElement("tbody");
		
		for(var i=0; i<resp.length; i++)	
		{
			var row = document.createElement("tr");
			
			var cell1 = document.createElement("td");
			var cell2 = document.createElement("td");
			var cell3 = document.createElement("td");
			var cell4 = document.createElement("td");
					
			cell1.width='30%';
			cell2.width='30%';
			cell3.width='20%';
			cell4.width='20%';
			
			cell1.setAttribute('class', 'fondoFila');
			cell2.setAttribute('class', 'fondoFila');
			cell3.setAttribute('class', 'fondoFila');
			cell4.setAttribute('class', 'fondoFila');
			
			var cellText1 = document.createTextNode(resp[i]['equipo']);
			var cellText2 = document.createTextNode(resp[i]['descripcion_logro']);
			var cellText3 = document.createTextNode(resp[i]['nro_logro']);
			var cellText4 = document.createTextNode(resp[i]['estatus_det']);
			
			cell1.appendChild(cellText1);
			cell2.appendChild(cellText2);
			cell3.appendChild(cellText3);
			cell4.appendChild(cellText4);
			
			row.appendChild(cell1);
			row.appendChild(cell2);
			row.appendChild(cell3);
			row.appendChild(cell4);
			
			tblBody.appendChild(row);
		}
		tbl.appendChild(tblBody);
		tabla.innerHTML='';
		tabla.appendChild(tbl);
	} 
	else
	{
		jAlert('Los datos del ticket no son válidos', 'Información');
		return;
	}
}

function calcularTiempo(v1,v2)
{
    horas1 = v1.split(":");
    horas2 = v2.split(":");
    horatotale = new Array();
    for(a=0; a<3; a++)
    {
        horas1[a] = (isNaN(parseInt(horas1[a])))?0:parseInt(horas1[a])
        horas2[a] = (isNaN(parseInt(horas2[a])))?0:parseInt(horas2[a])
        horatotale[a] = (horas1[a]-horas2[a]);
    }
    horatotal = new Date();
    horatotal.setHours(horatotale[0]);
    horatotal.setMinutes(horatotale[1]);
    horatotal.setSeconds(horatotale[2]);
	
	var hora =  horatotal.getHours();
	var minuto = horatotal.getMinutes();
	var segundo = horatotal.getSeconds();
	
	if (hora < 10) {hora = "0" + hora}
	if (minuto < 10) {minuto = "0" + minuto}
	if (segundo < 10) {segundo = "0" + segundo}
	
	return hora+':'+minuto+':'+segundo;
}

function buscarInfoEnterAnuTicket(e, operacion)
{
	var code;
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	if (code == 13) {
		if(operacion=='mostrarTicketAnu')
		{
			mostrarTicket();
		}
	}
}