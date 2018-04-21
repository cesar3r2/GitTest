// JavaScript Document

function procesarGanadores() {
	var r, mensajeGuardar;
	var fecha = document.getElementById('fecha').value;
	var deporte = document.getElementById('deporte').value;
	var contenido = abrirAjax();
	mensajeGuardar = '¿Confirma que desea generar los tickets ganadores del '+fecha+'?','si/no';
	
	if (fecha != "" && deporte != 0) {
		jConfirm(mensajeGuardar, 'Confirmación', function(r){
			if(r)
			{
				if (deporte == 'T')
					contenido.open("GET", "sistema/procesos/transaccion/trans_procesar.php?accion=procesarGanadoresTodos&fecha="+fecha, true);
				contenido.onreadystatechange=function()
				{
					if (contenido.readyState==4)
					{
						var arregloDatos;
						arregloDatos = contenido.responseText;
						if ((arregloDatos != "") && (arregloDatos != "++")) {
							jAlert('Se han procesado correctamente los tickets ganadores', 'Información');
							mostrar_tickets(arregloDatos);
							return;
						}
						else
						{
							jAlert('No hubo tickets ganadores para la opción seleccionada', 'Información');
							return;
						}
					}
				}
				contenido.send(null);
			}
		} );
	} else {
		jAlert('Ha dejado campos vacíos o sin seleccionar. Por favor verifique los datos', 'Información');
	}
}

function mostrar_tickets(resultado) {
	var registro, ticket, apuesta, premio;
	var tabla = document.getElementById('tablaGanadores');
   	var tbl = document.createElement("table");
	
	tbl.width = '100%';
	tbl.setAttribute('cellpadding', '1');
	tbl.setAttribute('cellspacing','1');
    var tblBody = document.createElement("tbody");
	
	registro = resultado.split('+');
	ticket = registro[0].split('||');
	apuesta = registro[1].split('||');
	premio = registro[2].split('||');
	
	var row0 = document.createElement("tr");
	var cel0 = document.createElement("td");
	cel0.setAttribute('class', 'titForm');
	cel0.setAttribute('colspan', '4');
	cel0.setAttribute('style', 'font-weight:bold');
	cel0.setAttribute('align', 'center');
	var celText0 = document.createTextNode('Listado de Tickets Ganadores');
	cel0.appendChild(celText0);
	row0.appendChild(cel0);
	tblBody.appendChild(row0);
	
	var row = document.createElement("tr");
	var cel1 = document.createElement("td");
	var cel2 = document.createElement("td");
	var cel3 = document.createElement("td");
	var cel4 = document.createElement("td");
	
	cel1.setAttribute('class', 'titForm');
	cel1.setAttribute('style', 'font-weight:bold');
	cel2.setAttribute('class', 'titForm');
	cel2.setAttribute('style', 'font-weight:bold');
	cel3.setAttribute('class', 'titForm');
	cel3.setAttribute('style', 'font-weight:bold');
	cel4.setAttribute('class', 'titForm');
	cel4.setAttribute('style', 'font-weight:bold');
	
	cel1.setAttribute('align', 'center');
	cel2.setAttribute('align', 'right');
	cel3.setAttribute('align', 'right');
	cel4.setAttribute('align', 'right');
				
	cel1.width='25%';
	cel2.width='25%';
	cel3.width='25%';
	cel4.width='25%';
	
	var celText1 = document.createTextNode('Nro. de Ticket');
	var celText2 = document.createTextNode('Monto Apuesta (BsF)');
	var celText3 = document.createTextNode('Monto Ganancia (BsF)');
	var celText4 = document.createTextNode('Monto Premio (BsF)');
		
	cel1.appendChild(celText1);
	cel2.appendChild(celText2);
	cel3.appendChild(celText3);
	cel4.appendChild(celText4);
		
	row.appendChild(cel1);
	row.appendChild(cel2);
	row.appendChild(cel3);
	row.appendChild(cel4);
		
	tblBody.appendChild(row);
	var tGanancia=0, tApuesta=0, tPremio=0, ganancia=0;
	
	for(var i=0; i<(ticket.length)-1; i++)	
	{
		var row = document.createElement("tr");

		var cell1 = document.createElement("td");
		var cell2 = document.createElement("td");
		var cell3 = document.createElement("td");
		var cell4 = document.createElement("td");
				
		cell1.width='25%';
		cell2.width='25%';
		cell3.width='25%';
		cell4.width='25%';
		
		cell1.setAttribute('class', 'fondoFila');
		cell2.setAttribute('class', 'fondoFila');
		cell3.setAttribute('class', 'fondoFila');
		cell4.setAttribute('class', 'fondoFila');
		
		cell1.setAttribute('align', 'center');
		cell2.setAttribute('align', 'right');
		cell3.setAttribute('align', 'right');
		cell4.setAttribute('align', 'right');
		
		ganancia = premio[i] - apuesta[i];
		
		tGanancia += ganancia;
		tApuesta += parseFloat(apuesta[i]);
		tPremio += parseFloat(premio[i]);
		
		var cellText1 = document.createTextNode(ticket[i]);
		var cellText2 = document.createTextNode(apuesta[i]);
		var cellText3 = document.createTextNode(ganancia.toFixed(2));
		var cellText4 = document.createTextNode(premio[i]);
		
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
	
	var row = document.createElement("tr");
	var cel1 = document.createElement("td");
	var cel2 = document.createElement("td");
	var cel3 = document.createElement("td");
	var cel4 = document.createElement("td");
	
	cel1.setAttribute('class', 'titForm');
	cel1.setAttribute('style', 'font-weight:bold');
	cel2.setAttribute('class', 'titForm');
	cel2.setAttribute('style', 'font-weight:bold');
	cel3.setAttribute('class', 'titForm');
	cel3.setAttribute('style', 'font-weight:bold');
	cel4.setAttribute('class', 'titForm');
	cel4.setAttribute('style', 'font-weight:bold');
	
	cel1.setAttribute('align', 'center');
	cel2.setAttribute('align', 'right');
	cel3.setAttribute('align', 'right');
	cel4.setAttribute('align', 'right');
				
	cel1.width='25%';
	cel2.width='25%';
	cel3.width='25%';
	cel4.width='25%';
	
	var registros = (ticket.length)-1;
	var celText1 = document.createTextNode(registros+' Gan. | TOTALES');
	var celText2 = document.createTextNode(tApuesta.toFixed(2));
	var celText3 = document.createTextNode(tGanancia.toFixed(2));
	var celText4 = document.createTextNode(tPremio.toFixed(2));
		
	cel1.appendChild(celText1);
	cel2.appendChild(celText2);
	cel3.appendChild(celText3);
	cel4.appendChild(celText4);
		
	row.appendChild(cel1);
	row.appendChild(cel2);
	row.appendChild(cel3);
	row.appendChild(cel4);
		
	tblBody.appendChild(row);
	tbl.appendChild(tblBody);
	tabla.innerHTML='';
	tabla.appendChild(tbl);
}

function procesarApuestas() {
	var procesar = document.getElementById('procesar').value;
	var deporte = document.getElementById('deporte').value;
	var mensajeGuardar;
	mensajeGuardar = '¿Confirma que desea procesar las apuestas pendientes?','si/no';
	
	jConfirm(mensajeGuardar, 'Confirmación', function(r){
	if(r)
		{
				AjaxRequest.post(
									{'parameters': {'procesar':procesar,
													'deporte':deporte,
													'accion':'procesarApuestas'
												   	}
													,'onSuccess':function(req){respProcesarApuestas(req)}
													,'url':'sistema/procesos/transaccion/trans_procesar_apuestas.php'
													,'onError': function(req)
													{
														alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
													}
									}
								);
			}
		}
	);
}

function respProcesarApuestas(req) {
	var resp = eval ("("+ req.responseText +")");
	if(resp != false) {
		jAlert("Las apuestas han sido procesadas correctamente", 'Notificación');
		cambiar_contenido('sistema/procesos/procesar_apuestas.php', 'sub_contenido');
	} else {
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}