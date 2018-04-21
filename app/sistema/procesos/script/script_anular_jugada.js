// JavaScript Document

function anularJugadas() {
	var r, mensajeGuardar;
	var deporte = document.getElementById('deporte').value;
	var fecha = document.getElementById('fecha').value;
	var encuentro = document.getElementById('sel_encuentro').value;
	var jugada = document.getElementById('sel_jugada').value;
	var checkMod = document.getElementById('modificar').checked;
	var modificar, accion;
	
	var logEstatus = document.getElementById('logEstatus').value;
	var logEncuentro = document.getElementById('logEncuentro').value;
	var logAltaBaja = document.getElementById('logAltaBaja').value;
	var logABMitad = document.getElementById('logABMitad').value;
	var logRLMitad = document.getElementById('logRLMitad').value;
	var resEstatus = document.getElementById('resEstatus').value;
	var resRunLine = document.getElementById('resRunLine').value;
	var resGanMitad = document.getElementById('resGanMitad').value;
	var resAltaBaja = document.getElementById('resAltaBaja').value;
	var resABMitad = document.getElementById('resABMitad').value;
	var resRLMitad = document.getElementById('resRLMitad').value;
	
	if (checkMod) { 
		modificar = 1;
		accion = 'revertir';
		mensajeGuardar = '¿Confirma que desea revertir las jugadas anuladas?','si/no';
	} else { 
		modificar = 0;
		accion = 'anular';
		mensajeGuardar = '¿Confirma que desea anular las jugadas seleccionadas?','si/no';
	}

	if (deporte!=0 && fecha!=0 && encuentro!=0 && jugada!=0)
	{
		if ((jugada == 'JC') && (resEstatus != 'SUSPENDIDO'))
		{
			jAlert('Para '+accion+' el juego completo el estatus del resultado debe ser SUSPENDIDO', 'Información');
			return;
		}
		if ((jugada == 'GM') && (resGanMitad != 'EMPATE'))
		{
			jAlert('Para '+accion+' las jugadas del ganador de la mitad el resultado debe ser EMPATE', 'Información');
			return;
		}
		if ((jugada == 'RL') && (resRunLine != 'EMPATE'))
		{
			jAlert('Para '+accion+' las jugadas de runline el resultado debe ser EMPATE', 'Información');
			return;
		}
		if ((jugada == 'RLM') && (resRLMitad != 'EMPATE'))
		{
			jAlert('Para '+accion+' las jugadas de runline a mitad el resultado debe ser EMPATE', 'Información');
			return;
		}
		if ((jugada == 'AB') && (logAltaBaja != resAltaBaja))
		{
			jAlert('Para '+accion+' las jugadas de alta/baja el logro y el resultado deben ser iguales', 'Información');
			return;
		}
		if ((jugada == 'ABM') && (logABMitad != resABMitad))
		{
			jAlert('Para '+accion+' las jugadas de alta/baja a mitad del juego el logro y el resultado deben ser iguales', 'Información');
			return;
		}
		
		jConfirm(mensajeGuardar, 'Confirmación', function(r){
		if(r)
		{
				AjaxRequest.post(
									{'parameters': {'deporte':deporte,
													'fecha':fecha,
													'encuentro':encuentro,
													'jugada':jugada,
													'modificar':modificar,
													'accion':'anularJugada'
												   	}
													,'onSuccess':function(req){verificarTransaccionAnularJugadas(req)}
													,'url':'sistema/procesos/transaccion/trans_anular_jugadas.php'
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

function verificarTransaccionAnularJugadas(req)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != false)
	{
		jAlert('Se han procesado correctamente las jugadas seleccionadas', 'Información');
		cambiar_contenido('sistema/procesos/anular_jugadas.php', 'sub_contenido');
	}
	else
	{
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}

function cargarEncuentrosAnular() {
	var deporte = document.getElementById('deporte').value;
	var fecha = document.getElementById('fecha').value;
	var tabla = document.getElementById('tablaDatosEncuentro');
	tabla.innerHTML = '';

	if (deporte == 0) {
		jAlert('Debe seleccionar el deporte para cargar los encuentros', 'Información');
		fecha = 0;
		return;
	}
	
	AjaxRequest.post
						(
							{'parameters':{		'deporte':deporte,
												'fecha':fecha,
												'accion':'buscarEncuentros'
												}
												,'onSuccess':respCargarEncuentrosAnular
												,'url':'sistema/procesos/transaccion/trans_anular_jugadas.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respCargarEncuentrosAnular(req)
{
	var fecha = document.getElementById('fecha');
	var encuentro = document.getElementById('sel_encuentro');
	var resp = eval ("("+ req.responseText +")");
	
	if (resp != "") {
		document.getElementById('sel_encuentro').options.length = 0;
		document.getElementById('sel_encuentro').options[0] = new Option('Seleccione..');
		document.getElementById('sel_encuentro').options[0].value = '0';
		document.getElementById('sel_encuentro').options[0].selected = true;
		
		for(var i=1,j=0; i<=resp.length; i++,j++)
		{
			document.getElementById('sel_encuentro').options[i] = new Option(resp[j]['encuentro']+' - ('+resp[j]['nombre']+')');
			document.getElementById('sel_encuentro').options[i].value = resp[j]['id'];
			document.getElementById('sel_encuentro').options[i].title = "Id: "+resp[j]['id'];
		}
	} else {
		jAlert('No existen encuentros registrados para la fecha seleccionada ('+fecha.value+')', 'Información');
		fecha.value = 0;
		encuentro.innerHTML = '<OPTION value="0">Seleccione..</OPTION>';
		return;
	}
}

function cargarJugadas() {
	var deporte = document.getElementById('deporte').value;
	var fecha = document.getElementById('fecha');
	var encuentro = document.getElementById('sel_encuentro');
	fecha.value = 0;
	encuentro.innerHTML = '<OPTION value="0">Seleccione..</OPTION>';
	var tabla = document.getElementById('tablaDatosEncuentro');
	tabla.innerHTML = '';
	
	switch (deporte)
	{
		case '1':
			document.getElementById('sel_jugada').options.length = 0;
			document.getElementById('sel_jugada').options[0] = new Option('Seleccione..');
			document.getElementById('sel_jugada').options[0].value = '0';
			document.getElementById('sel_jugada').options[0].selected = true;
			document.getElementById('sel_jugada').options[1] = new Option('Juego Completo');
			document.getElementById('sel_jugada').options[1].value = 'JC';
			document.getElementById('sel_jugada').options[2] = new Option('Ganador Mitad');
			document.getElementById('sel_jugada').options[2].value = 'GM';
			document.getElementById('sel_jugada').options[3] = new Option('Alta/Baja');
			document.getElementById('sel_jugada').options[3].value = 'AB';
			document.getElementById('sel_jugada').options[4] = new Option('Alta/Baja Mitad');
			document.getElementById('sel_jugada').options[4].value = 'ABM';
		break;
		
		case '2':
			document.getElementById('sel_jugada').options.length = 0;
			document.getElementById('sel_jugada').options[0] = new Option('Seleccione..');
			document.getElementById('sel_jugada').options[0].value = '0';
			document.getElementById('sel_jugada').options[0].selected = true;
			document.getElementById('sel_jugada').options[1] = new Option('Juego Completo');
			document.getElementById('sel_jugada').options[1].value = 'JC';
			document.getElementById('sel_jugada').options[2] = new Option('RunLine');
			document.getElementById('sel_jugada').options[2].value = 'RL';
			document.getElementById('sel_jugada').options[3] = new Option('Alta/Baja');
			document.getElementById('sel_jugada').options[3].value = 'AB';
			document.getElementById('sel_jugada').options[4] = new Option('Ganador Mitad');
			document.getElementById('sel_jugada').options[4].value = 'GM';
			document.getElementById('sel_jugada').options[5] = new Option('RunLine Mitad');
			document.getElementById('sel_jugada').options[5].value = 'RLM';
			document.getElementById('sel_jugada').options[6] = new Option('Alta/Baja Mitad');
			document.getElementById('sel_jugada').options[6].value = 'ABM';
		break;
		
		case '3':
			document.getElementById('sel_jugada').options.length = 0;
			document.getElementById('sel_jugada').options[0] = new Option('Seleccione..');
			document.getElementById('sel_jugada').options[0].value = '0';
			document.getElementById('sel_jugada').options[0].selected = true;
			document.getElementById('sel_jugada').options[1] = new Option('Juego Completo');
			document.getElementById('sel_jugada').options[1].value = 'JC';
			document.getElementById('sel_jugada').options[2] = new Option('RunLine');
			document.getElementById('sel_jugada').options[2].value = 'RL';
			document.getElementById('sel_jugada').options[3] = new Option('Alta/Baja');
			document.getElementById('sel_jugada').options[3].value = 'AB';
		break;
		
		case '4':
			document.getElementById('sel_jugada').options.length = 0;
			document.getElementById('sel_jugada').options[0] = new Option('Seleccione..');
			document.getElementById('sel_jugada').options[0].value = '0';
			document.getElementById('sel_jugada').options[0].selected = true;
			document.getElementById('sel_jugada').options[1] = new Option('Juego Completo');
			document.getElementById('sel_jugada').options[1].value = 'JC';
			document.getElementById('sel_jugada').options[2] = new Option('RunLine');
			document.getElementById('sel_jugada').options[2].value = 'RL';
			document.getElementById('sel_jugada').options[3] = new Option('Alta/Baja');
			document.getElementById('sel_jugada').options[3].value = 'AB';
		break;
		
		case '5':
			document.getElementById('sel_jugada').options.length = 0;
			document.getElementById('sel_jugada').options[0] = new Option('Seleccione..');
			document.getElementById('sel_jugada').options[0].value = '0';
			document.getElementById('sel_jugada').options[0].selected = true;
			document.getElementById('sel_jugada').options[1] = new Option('Juego Completo');
			document.getElementById('sel_jugada').options[1].value = 'JC';
			document.getElementById('sel_jugada').options[2] = new Option('Alta/Baja');
			document.getElementById('sel_jugada').options[2].value = 'AB';
		break;
		
		case '6':
			document.getElementById('sel_jugada').options.length = 0;
			document.getElementById('sel_jugada').options[0] = new Option('Seleccione..');
			document.getElementById('sel_jugada').options[0].value = '0';
			document.getElementById('sel_jugada').options[0].selected = true;
			document.getElementById('sel_jugada').options[1] = new Option('Juego Completo');
			document.getElementById('sel_jugada').options[1].value = 'JC';
		break;
		
		case '7':
			document.getElementById('sel_jugada').options.length = 0;
			document.getElementById('sel_jugada').options[0] = new Option('Seleccione..');
			document.getElementById('sel_jugada').options[0].value = '0';
			document.getElementById('sel_jugada').options[0].selected = true;
			document.getElementById('sel_jugada').options[1] = new Option('Pelea Completa');
			document.getElementById('sel_jugada').options[1].value = 'JC';
		break;
		
		case '8':
			document.getElementById('sel_jugada').options.length = 0;
			document.getElementById('sel_jugada').options[0] = new Option('Seleccione..');
			document.getElementById('sel_jugada').options[0].value = '0';
			document.getElementById('sel_jugada').options[0].selected = true;
			document.getElementById('sel_jugada').options[1] = new Option('Carrera Completa');
			document.getElementById('sel_jugada').options[1].value = 'JC';
		break;
		
		default:
		break;
	}
}

function datosEncuentroAnular() {
	var deporte = document.getElementById('deporte').value;
	var encuentro = document.getElementById('sel_encuentro').value;
	var jugada = document.getElementById('sel_jugada');
	jugada.value = '0';
	
	AjaxRequest.post
					(
							{'parameters':{		'deporte':deporte,
												'encuentro':encuentro,
												'accion':'datosEncuentro'
												}
												,'onSuccess':respdatosEncuentroAnular
												,'url':'sistema/procesos/transaccion/trans_anular_jugadas.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);	
}

function respdatosEncuentroAnular(req) {
	var resp = eval ("("+ req.responseText +")");
	var deporte = document.getElementById('deporte').value;
	var encuentro = document.getElementById('sel_encuentro');
	var tabla = document.getElementById('tablaDatosEncuentro');
	var logEstatus = document.getElementById('logEstatus');
	var logEncuentro = document.getElementById('logEncuentro');
	var logAltaBaja = document.getElementById('logAltaBaja');
	var logABMitad = document.getElementById('logABMitad');
	var logRLMitad = document.getElementById('logRLMitad');
	var resEstatus = document.getElementById('resEstatus');
	var resRunLine = document.getElementById('resRunLine');
	var resGanMitad = document.getElementById('resGanMitad');
	var resAltaBaja = document.getElementById('resAltaBaja');
	var resABMitad = document.getElementById('resABMitad');
	var resRLMitad = document.getElementById('resRLMitad');
	
	if (resp != false) {	
		var tbl = document.createElement("table");
		
		tbl.width = '100%';
		tbl.setAttribute('cellpadding', '1');
		tbl.setAttribute('cellspacing','1');
		var tblBody = document.createElement("tbody");
		
		// FILA 1
		var row0 = document.createElement("tr");
		var cel0 = document.createElement("td");
		cel0.setAttribute('class', 'titForm');
		cel0.setAttribute('style', 'font-weight:bold');
		cel0.setAttribute('align', 'center');
		var celText0 = document.createTextNode('Datos del Logro');
		cel0.appendChild(celText0);
		row0.appendChild(cel0);
		tblBody.appendChild(row0);
	
		var cel1 = document.createElement("td");
		cel1.setAttribute('class', 'titForm');
		cel1.setAttribute('style', 'font-weight:bold');
		cel1.setAttribute('align', 'center');
		var celText1 = document.createTextNode('Datos del Resultado');
		cel1.appendChild(celText1);
		row0.appendChild(cel1);
		tblBody.appendChild(row0);
	
		// FILA 2
		var row = document.createElement("tr");
		var cel1 = document.createElement("td");
		var cel2 = document.createElement("td");
		
		cel1.setAttribute('class', 'objForm');
		cel1.setAttribute('style', 'font-weight:bold');
		cel2.setAttribute('class', 'objForm');
		cel2.setAttribute('style', 'font-weight:bold');
		
		cel1.setAttribute('align', 'center');
		cel2.setAttribute('align', 'center');
					
		cel1.width='50%';
		cel2.width='50%';
		
		var celText1 = document.createTextNode('Estatus');
		var celText2 = document.createTextNode('Estatus');
			
		cel1.appendChild(celText1);
		cel2.appendChild(celText2);
			
		row.appendChild(cel1);
		row.appendChild(cel2);
			
		tblBody.appendChild(row);
		
		// FILA 3
		var row = document.createElement("tr");
		var cell1 = document.createElement("td");
		var cell2 = document.createElement("td");
				
		cell1.width='50%';
		cell2.width='50%';
		
		cell1.setAttribute('class', 'fondoFila');
		cell2.setAttribute('class', 'fondoFila');
		
		cell1.setAttribute('align', 'center');
		cell2.setAttribute('align', 'center');
			
		var cellText1 = document.createTextNode(resp[0]['estatus_logro']);
		var cellText2 = document.createTextNode(resp[0]['estatus_resultado']);
		
		cell1.appendChild(cellText1);
		cell2.appendChild(cellText2);
		
		row.appendChild(cell1);
		row.appendChild(cell2);
		
		tblBody.appendChild(row);
		
		if (deporte == 1)
		{
			// FILA 4
			var row = document.createElement("tr");
			var cel1 = document.createElement("td");
			var cel2 = document.createElement("td");
			
			cel1.setAttribute('class', 'objForm');
			cel1.setAttribute('style', 'font-weight:bold');
			cel2.setAttribute('class', 'objForm');
			cel2.setAttribute('style', 'font-weight:bold');
			
			cel1.setAttribute('align', 'center');
			cel2.setAttribute('align', 'center');
						
			cel1.width='50%';
			cel2.width='50%';
			
			var celText1 = document.createTextNode('Encuentro');
			var celText2 = document.createTextNode('Resultado Ganador Mitad');
				
			cel1.appendChild(celText1);
			cel2.appendChild(celText2);
				
			row.appendChild(cel1);
			row.appendChild(cel2);
				
			tblBody.appendChild(row);
			
			// FILA 5
			var row = document.createElement("tr");
			var cell1 = document.createElement("td");
			var cell2 = document.createElement("td");
					
			cell1.width='50%';
			cell2.width='50%';
			
			cell1.setAttribute('class', 'fondoFila');
			cell2.setAttribute('class', 'fondoFila');
			
			cell1.setAttribute('align', 'center');
			cell2.setAttribute('align', 'center');
				
			var cellText1 = document.createTextNode(resp[0]['encuentro']);
			var cellText2 = document.createTextNode(resp[0]['g_mediojuego']);
			
			cell1.appendChild(cellText1);
			cell2.appendChild(cellText2);
			
			row.appendChild(cell1);
			row.appendChild(cell2);
			
			tblBody.appendChild(row);
		}
		
		if ((deporte == 2) || (deporte == 3) || (deporte == 4)) // ANULAR JUGADAS DE RUNLINE
		{
			var row = document.createElement("tr");
			var cel1 = document.createElement("td");
			var cel2 = document.createElement("td");
			
			cel1.setAttribute('class', 'objForm');
			cel1.setAttribute('style', 'font-weight:bold');
			cel2.setAttribute('class', 'objForm');
			cel2.setAttribute('style', 'font-weight:bold');
			
			cel1.setAttribute('align', 'center');
			cel2.setAttribute('align', 'center');
						
			cel1.width='50%';
			cel2.width='50%';
			
			var celText1 = document.createTextNode('Valor RunLine');
			var celText2 = document.createTextNode('Ganador RunLine');
				
			cel1.appendChild(celText1);
			cel2.appendChild(celText2);
				
			row.appendChild(cel1);
			row.appendChild(cel2);
				
			tblBody.appendChild(row);
			
			var row = document.createElement("tr");
			var cell1 = document.createElement("td");
			var cell2 = document.createElement("td");
					
			cell1.width='50%';
			cell2.width='50%';
			
			cell1.setAttribute('class', 'fondoFila');
			cell2.setAttribute('class', 'fondoFila');
			
			cell1.setAttribute('align', 'center');
			cell2.setAttribute('align', 'center');
				
			var cellText1 = document.createTextNode(resp[0]['v_runline']);
			var cellText2 = document.createTextNode(resp[0]['runline']);
			
			cell1.appendChild(cellText1);
			cell2.appendChild(cellText2);
			
			row.appendChild(cell1);
			row.appendChild(cell2);
			
			tblBody.appendChild(row);
		}
		if ((deporte == 1) || (deporte == 2) || (deporte == 3) || (deporte == 4) || (deporte == 5))
		{
			// FILA 6
			var row = document.createElement("tr");
			var cel1 = document.createElement("td");
			var cel2 = document.createElement("td");
			
			cel1.setAttribute('class', 'objForm');
			cel1.setAttribute('style', 'font-weight:bold');
			cel2.setAttribute('class', 'objForm');
			cel2.setAttribute('style', 'font-weight:bold');
			
			cel1.setAttribute('align', 'center');
			cel2.setAttribute('align', 'center');
						
			cel1.width='50%';
			cel2.width='50%';
			
			var celText1 = document.createTextNode('Valor Alta/Baja');
			var celText2 = document.createTextNode('Resultado Valor Alta/Baja');
				
			cel1.appendChild(celText1);
			cel2.appendChild(celText2);
				
			row.appendChild(cel1);
			row.appendChild(cel2);
				
			tblBody.appendChild(row);
			
			// FILA 7
			var row = document.createElement("tr");
			var cell1 = document.createElement("td");
			var cell2 = document.createElement("td");
					
			cell1.width='50%';
			cell2.width='50%';
			
			cell1.setAttribute('class', 'fondoFila');
			cell2.setAttribute('class', 'fondoFila');
			
			cell1.setAttribute('align', 'center');
			cell2.setAttribute('align', 'center');
				
			var cellText1 = document.createTextNode(resp[0]['v_altabaja']);
			if (deporte == 1)
				var cellText2 = document.createTextNode(resp[0]['total_carreras']);
			else if (deporte == 2)
				var cellText2 = document.createTextNode(resp[0]['total_puntos']);
			else if ((deporte == 3) || (deporte == 4) || (deporte == 5))
				var cellText2 = document.createTextNode(resp[0]['total_goles']);
			
			cell1.appendChild(cellText1);
			cell2.appendChild(cellText2);
			
			row.appendChild(cell1);
			row.appendChild(cell2);
			
			tblBody.appendChild(row);
		}
		
		if (deporte == 1) { // OPCIONES DE MITAD DE JUEGO EN EL BEISBOL
			// FILA 8
			var row = document.createElement("tr");
			var cel1 = document.createElement("td");
			var cel2 = document.createElement("td");
			
			cel1.setAttribute('class', 'objForm');
			cel1.setAttribute('style', 'font-weight:bold');
			cel2.setAttribute('class', 'objForm');
			cel2.setAttribute('style', 'font-weight:bold');
			
			cel1.setAttribute('align', 'center');
			cel2.setAttribute('align', 'center');
						
			cel1.width='50%';
			cel2.width='50%';
			
			var celText1 = document.createTextNode('Valor Alta/Baja Mitad');
			var celText2 = document.createTextNode('Resultado Valor Alta/Baja Mitad');
				
			cel1.appendChild(celText1);
			cel2.appendChild(celText2);
				
			row.appendChild(cel1);
			row.appendChild(cel2);
				
			tblBody.appendChild(row);
			
			// FILA 9
			var row = document.createElement("tr");
			var cell1 = document.createElement("td");
			var cell2 = document.createElement("td");
					
			cell1.width='50%';
			cell2.width='50%';
			
			cell1.setAttribute('class', 'fondoFila');
			cell2.setAttribute('class', 'fondoFila');
			
			cell1.setAttribute('align', 'center');
			cell2.setAttribute('align', 'center');
				
			var cellText1 = document.createTextNode(resp[0]['v_ab_mediojuego']);
			var cellText2 = document.createTextNode(resp[0]['total_carreras_5to']);
			
			cell1.appendChild(cellText1);
			cell2.appendChild(cellText2);
			
			row.appendChild(cell1);
			row.appendChild(cell2);
			
			tblBody.appendChild(row);
		}
		
		if (deporte == 2) { // OPCIONES DE MITAD DE JUEGO EN EL BASQUETBOL
			// FILA 4
			var row = document.createElement("tr");
			var cel1 = document.createElement("td");
			var cel2 = document.createElement("td");
			
			cel1.setAttribute('class', 'objForm');
			cel1.setAttribute('style', 'font-weight:bold');
			cel2.setAttribute('class', 'objForm');
			cel2.setAttribute('style', 'font-weight:bold');
			
			cel1.setAttribute('align', 'center');
			cel2.setAttribute('align', 'center');
						
			cel1.width='50%';
			cel2.width='50%';
			
			var celText1 = document.createTextNode('Encuentro');
			var celText2 = document.createTextNode('Resultado Ganador Mitad');
				
			cel1.appendChild(celText1);
			cel2.appendChild(celText2);
				
			row.appendChild(cel1);
			row.appendChild(cel2);
				
			tblBody.appendChild(row);
			
			// FILA 5
			var row = document.createElement("tr");
			var cell1 = document.createElement("td");
			var cell2 = document.createElement("td");
					
			cell1.width='50%';
			cell2.width='50%';
			
			cell1.setAttribute('class', 'fondoFila');
			cell2.setAttribute('class', 'fondoFila');
			
			cell1.setAttribute('align', 'center');
			cell2.setAttribute('align', 'center');
				
			var cellText1 = document.createTextNode(resp[0]['encuentro']);
			var cellText2 = document.createTextNode(resp[0]['ganadorm']);
			
			cell1.appendChild(cellText1);
			cell2.appendChild(cellText2);
			
			row.appendChild(cell1);
			row.appendChild(cell2);
			
			tblBody.appendChild(row);
			
			// FILA
			var row = document.createElement("tr");
			var cel1 = document.createElement("td");
			var cel2 = document.createElement("td");
			
			cel1.setAttribute('class', 'objForm');
			cel1.setAttribute('style', 'font-weight:bold');
			cel2.setAttribute('class', 'objForm');
			cel2.setAttribute('style', 'font-weight:bold');
			
			cel1.setAttribute('align', 'center');
			cel2.setAttribute('align', 'center');
						
			cel1.width='50%';
			cel2.width='50%';
			
			var celText1 = document.createTextNode('Valor RunLine Mitad');
			var celText2 = document.createTextNode('Ganador RunLine Mitad');
				
			cel1.appendChild(celText1);
			cel2.appendChild(celText2);
				
			row.appendChild(cel1);
			row.appendChild(cel2);
				
			tblBody.appendChild(row);
			
			// FILA
			var row = document.createElement("tr");
			var cell1 = document.createElement("td");
			var cell2 = document.createElement("td");
					
			cell1.width='50%';
			cell2.width='50%';
			
			cell1.setAttribute('class', 'fondoFila');
			cell2.setAttribute('class', 'fondoFila');
			
			cell1.setAttribute('align', 'center');
			cell2.setAttribute('align', 'center');
				
			var cellText1 = document.createTextNode(resp[0]['v_runline_m']);
			var cellText2 = document.createTextNode(resp[0]['runlinem']);
			
			cell1.appendChild(cellText1);
			cell2.appendChild(cellText2);
			
			row.appendChild(cell1);
			row.appendChild(cell2);
			
			tblBody.appendChild(row);
			
			// FILA
			var row = document.createElement("tr");
			var cel1 = document.createElement("td");
			var cel2 = document.createElement("td");
			
			cel1.setAttribute('class', 'objForm');
			cel1.setAttribute('style', 'font-weight:bold');
			cel2.setAttribute('class', 'objForm');
			cel2.setAttribute('style', 'font-weight:bold');
			
			cel1.setAttribute('align', 'center');
			cel2.setAttribute('align', 'center');
						
			cel1.width='50%';
			cel2.width='50%';
			
			var celText1 = document.createTextNode('Valor Alta/Baja Mitad');
			var celText2 = document.createTextNode('Resultado Valor Alta/Baja Mitad');
				
			cel1.appendChild(celText1);
			cel2.appendChild(celText2);
				
			row.appendChild(cel1);
			row.appendChild(cel2);
				
			tblBody.appendChild(row);
			
			// FILA
			var row = document.createElement("tr");
			var cell1 = document.createElement("td");
			var cell2 = document.createElement("td");
					
			cell1.width='50%';
			cell2.width='50%';
			
			cell1.setAttribute('class', 'fondoFila');
			cell2.setAttribute('class', 'fondoFila');
			
			cell1.setAttribute('align', 'center');
			cell2.setAttribute('align', 'center');
				
			var cellText1 = document.createTextNode(resp[0]['v_altabaja_m']);
			var cellText2 = document.createTextNode(resp[0]['total_puntosm']);
			
			cell1.appendChild(cellText1);
			cell2.appendChild(cellText2);
			
			row.appendChild(cell1);
			row.appendChild(cell2);
			
			tblBody.appendChild(row);
		}
		
		tbl.appendChild(tblBody);
		tabla.innerHTML = '';
		tabla.appendChild(tbl);
		
		logEstatus.value = resp[0]['estatus_logro'];
		logEncuentro.value = resp[0]['encuentro'];
		logAltaBaja.value = resp[0]['v_altabaja'];
		logABMitad.value = resp[0]['v_ab_mediojuego'];
		
		resEstatus.value = resp[0]['estatus_resultado'];
		resGanMitad.value = resp[0]['g_mediojuego'];
		resRunLine.value = resp[0]['runline'];
		
		if (deporte == 1) {
			resAltaBaja.value = resp[0]['total_carreras'];
			resABMitad.value = resp[0]['total_carreras_5to'];
		} else if (deporte == 2) {
			resGanMitad.value = resp[0]['ganadorm'];
			resAltaBaja.value = resp[0]['total_puntos'];
			logRLMitad.value = resp[0]['v_runline_m'];
			resRLMitad.value = resp[0]['runlinem'];
			logABMitad.value = resp[0]['v_altabaja_m'];
			resABMitad.value = resp[0]['total_puntosm'];
			
		} else if ((deporte == 3) || (deporte == 4) || (deporte == 5)) {
			resAltaBaja.value = resp[0]['total_goles'];
		}
	} else {
		jAlert('El resultado del encuentro seleccionado no ha sido registrado', 'información');
		tabla.innerHTML = '';
		encuentro.value = '0';
	}
}