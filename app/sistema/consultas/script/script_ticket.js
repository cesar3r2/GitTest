// JavaScript Document
function mostrarTicketConsulta() {
	var nroTicket = document.getElementById('nro_ticket').value;
	var nroSeguridad = document.getElementById('nro_seguridad').value;
	
	if (nroTicket != "" && nroSeguridad != "") {
		mostrarInfoTicketConsulta(nroTicket, nroSeguridad);
	} else {
		jAlert('Ha dejado campos vacíos o sin seleccionar. Por favor verifique los datos', 'Información');
	}
}

function mostrarInfoTicketConsulta(nroTicket, nroSeguridad)
{
	AjaxRequest.post
						(
							{'parameters':{		'nro_ticket':nroTicket,
												'nro_seguridad':nroSeguridad,
												'accion':'mostrarInfoTicket'
												}
												,'onSuccess':respMostrarInfoTicketConsulta
												,'url':'sistema/consultas/transaccion/trans_ticket.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respMostrarInfoTicketConsulta(req)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != '')
	{
		var estatus = document.getElementById('estatus');
		var fecha = document.getElementById('fecha');
		var hora = document.getElementById('hora');
		var monto = document.getElementById('monto');
		var premio = document.getElementById('premio');
		
		estatus.innerHTML = resp[0]['estatus'];
		fecha.innerHTML = formatoFecha(resp[0]['fecha']);
		hora.innerHTML = resp[0]['hora'];
		monto.innerHTML = resp[0]['monto'];
		premio.innerHTML = resp[0]['premio'];
				
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
			var cellText4 = document.createTextNode(resp[i]['estatus']);
			
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
		
		//buscarJugadasAnuladasTicket();
	} 
	else
	{
		jAlert('Los datos del ticket no son válidos', 'Información');
		return;
	}
}

function buscarJugadasAnuladasTicket(nroTicket) {
	var nroTicket = document.getElementById('nro_ticket').value;
	AjaxRequest.post
						(
							{'parameters':{		'nro_ticket':nroTicket,
												'accion':'buscarAnuladas'
												}
												,'onSuccess':respBuscarJugadasAnuladasTicket
												,'url':'sistema/consultas/transaccion/trans_ticket.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);	
}

function respBuscarJugadasAnuladasTicket(req)
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
			var cellText4 = document.createTextNode(resp[i]['estatus']);
			
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
		
		document.getElementById('mensaje').innerHTML = 'ESTE TICKET POSEE JUGADAS ANULADAS. DEBE CALCULAR NUEVAMENTE EL MONTO DEL PREMIO';
	} 
}

function buscarInfoEnterVerTicket(e, operacion)
{
	var code;
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	if (code == 13) {
		if(operacion=='mostrarTicket')
		{
			mostrarTicketConsulta();
		}
	}
}