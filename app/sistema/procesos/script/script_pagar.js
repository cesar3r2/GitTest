// JavaScript Document

function pagarPremio() {
	var r, mensajeGuardar;
	var nroTicket = document.getElementById('nro_ticket').value;
	var nroSeguridad = document.getElementById('nro_seguridad').value;
	var estatus = document.getElementById('estatus').innerHTML;
	
	mensajeGuardar = '¿Confirma que desea pagar el Ticket Nro. '+nroTicket+'?','si/no';

	if(nroTicket!="" && nroSeguridad!="" && estatus!="")
	{
		jConfirm(mensajeGuardar, 'Confirmación', function(r){
		if(r)
		{
				AjaxRequest.post(
									{'parameters': {'nro_ticket':nroTicket,
													'nro_seguridad':nroSeguridad,
													'accion':'pagarTicket'
												   	}
													,'onSuccess':function(req){verificarTransaccionPagar(req, nroTicket)}
													,'url':'sistema/procesos/transaccion/trans_pagar.php'
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

function verificarTransaccionPagar(req, nroTicket)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != false)
	{
		jAlert('Se ha pagado correctamente el ticket número '+nroTicket, 'Información');
		cambiar_contenido('sistema/procesos/pagar_premio.php', 'sub_contenido');
	}
	else
	{
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}


function mostrarTicketPagar() {
	var nroTicket = document.getElementById('nro_ticket').value;
	var nroSeguridad = document.getElementById('nro_seguridad').value;
	
	if (nroTicket != "" && nroSeguridad != "") {
		mostrarInfoTicketPagar(nroTicket, nroSeguridad);
	} else {
		jAlert('Ha dejado campos vacíos o sin seleccionar. Por favor verifique los datos', 'Información');
	}
}

function mostrarInfoTicketPagar(nroTicket, nroSeguridad)
{
	AjaxRequest.post
						(
							{'parameters':{		'nro_ticket':nroTicket,
												'nro_seguridad':nroSeguridad,
												'accion':'mostrarInfoPremio'
												}
												,'onSuccess':respMostrarInfoTicketPagar
												,'url':'sistema/procesos/transaccion/trans_pagar.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respMostrarInfoTicketPagar(req)
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
		
		nroTicket.disabled = 'disabled';
		nroSeguridad.disabled = 'disabled';
		
		estatus.innerHTML = resp[0]['estatus_ap'];
		fecha.innerHTML = formatoFecha(resp[0]['fecha']);
		hora.innerHTML = resp[0]['hora'];
		monto.innerHTML = resp[0]['monto'];
		premio.innerHTML = resp[0]['premio'];
		
		if (resp[0]['estatus_ap'] != 'GANADORA')	
		{
			jAlert('El número de ticket introducido no puede ser pagado. La apuesta está '+resp[0]['estatus_ap'], 'Información');
			cambiar_contenido('sistema/procesos/pagar_premio.php', 'sub_contenido');
			return;
		}
		
		var tabla = document.getElementById('apuesta');
       	var tbl = document.createElement("table");
		tbl.width='100%';
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
		
		//buscarJugadasAnuladas(nroTicket.value);
	} 
	else
	{
		jAlert('Los datos del ticket no son válidos', 'Información');
		return;
	}
}

function buscarJugadasAnuladas(nroTicket) {
	AjaxRequest.post
						(
							{'parameters':{		'nro_ticket':nroTicket,
												'accion':'buscarAnuladas'
												}
												,'onSuccess':respBuscarJugadasAnuladas
												,'url':'sistema/procesos/transaccion/trans_pagar.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);	
}

function respBuscarJugadasAnuladas(req)
{
	var resp = eval ("("+ req.responseText +")");
	
	if(resp != '')
	{
		var tablaAnu = document.getElementById('anuladas');
		var tabla = document.getElementById('jugadas_anuladas');
       	var tbl = document.createElement("table");
		tablaAnu.style.visibility = 'visible';
		tabla.style.visibility = 'visible';
		tbl.width='100%';
		tbl.setAttribute('cellpadding', '1');
		tbl.setAttribute('cellspacing','1');
        var tblBody = document.createElement("tbody");
		
		for(var i=0; i<resp.length; i++)	
		{
			var row = document.createElement("tr");
			
			var cell1 = document.createElement("td");
			var cell2 = document.createElement("td");
			var cell3 = document.createElement("td");
					
			cell1.width='35%';
			cell2.width='45%';
			cell3.width='20%';
			
			cell1.setAttribute('class', 'fondoFila');
			cell2.setAttribute('class', 'fondoFila');
			cell3.setAttribute('class', 'fondoFila');
			
			var cellText1 = document.createTextNode(resp[i]['equipo']);
			var cellText2 = document.createTextNode(resp[i]['descripcion_logro']);
			var cellText3 = document.createTextNode(resp[i]['nro_logro']);
			
			cell1.appendChild(cellText1);
			cell2.appendChild(cellText2);
			cell3.appendChild(cellText3);
			
			row.appendChild(cell1);
			row.appendChild(cell2);
			row.appendChild(cell3);
			
			tblBody.appendChild(row);
		}
				
		tbl.appendChild(tblBody);
		tabla.innerHTML='';
		tabla.appendChild(tbl);
		
		document.getElementById('mensaje').innerHTML = 'ESTE TICKET POSEE JUGADAS ANULADAS. DEBE CALCULAR NUEVAMENTE EL MONTO DEL PREMIO';
	} 
}

function buscarInfoEnterPagTicket(e, operacion)
{
	var code;
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	if (code == 13) {
		if(operacion=='mostrarTicketPag')
		{
			mostrarTicketPagar();
		}
	}
}