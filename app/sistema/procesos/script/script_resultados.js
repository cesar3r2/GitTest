function resultadosBeisbol() {
	cambiar_contenido('sistema/procesos/resultados_beisbol.php', 'sub_contenido');
}

function resultadosBasquetbol() {
	cambiar_contenido('sistema/procesos/resultados_basquetbol.php', 'sub_contenido');
}

function resultadosFutbol() {
	cambiar_contenido('sistema/procesos/resultados_futbol.php', 'sub_contenido');
}

function resultadosFutbolAmericano() {
	cambiar_contenido('sistema/procesos/resultados_futbol_americano.php', 'sub_contenido');
}

function resultadosHockey() {
	cambiar_contenido('sistema/procesos/resultados_hockey.php', 'sub_contenido');
}

function resultadosTennis() {
	cambiar_contenido('sistema/procesos/resultados_tennis.php', 'sub_contenido');
}

function resultadosBoxeo() {
	cambiar_contenido('sistema/procesos/resultados_boxeo.php', 'sub_contenido');
}

function resultadosFormula1() {
	cambiar_contenido('sistema/procesos/resultados_formula1.php', 'sub_contenido');
}


function mostrarEncuentrosBeisbol() {
	var fecha = document.getElementById('fecha').value;
	cambiar_contenido('sistema/procesos/resultados_beisbol.php?fecha='+fecha, 'sub_contenido');
}

// BEISBOL
function cargarEncuentros() {
	var fecha = document.getElementById('fecha').value;
	var checkMod = document.getElementById('modificar').checked;
	var modificar;
	if (checkMod)
		modificar = 1;
	else
		modificar = 0;
	AjaxRequest.post
						(
							{'parameters':{		'modificar':modificar,
												'fecha':fecha,
												'accion':'buscarEncuentros'
												}
												,'onSuccess':respCargarEncuentros
												,'url':'sistema/procesos/transaccion/trans_resultados.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respCargarEncuentros(req)
{
	var resp = eval ("("+ req.responseText +")");
	var fecha = document.getElementById('fecha');
	if (resp !="") {
		document.getElementById('sel_encuentro').options.length = 0;
		document.getElementById('sel_encuentro').options[0] = new Option('Seleccione..');
		document.getElementById('sel_encuentro').options[0].value = '0';
		document.getElementById('sel_encuentro').options[0].selected = true;
		
		for(var i=1,j=0; i<=resp.length; i++,j++)
		{
			document.getElementById('sel_encuentro').options[i] = new Option(resp[j]['encuentro']+' - ('+resp[j]['nombre']+')');
			document.getElementById('sel_encuentro').options[i].value = resp[j]['codigo']+'||'+resp[j]['encuentro'];
			document.getElementById('sel_encuentro').options[i].title = "Id: "+resp[j]['codigo'];
		}
	} else {
		jAlert('No existen encuentros registrados para la fecha seleccionada ('+fecha.value+')', 'Información');
		fecha.value = 0;
		return;
	}
}

function datosEncuentro()
{
	var checkMod = document.getElementById('modificar').checked;
	var modificar;
	if (checkMod)
		modificar = 1;
	else
		modificar = 0;
	var encuentro = document.getElementById('sel_encuentro').value;
	var idEncuentro;
	idEncuentro = encuentro.split('||');
	AjaxRequest.post
						(
							{'parameters':{		'modificar':modificar,
												'id_encuentro':idEncuentro[0],
												'accion':'mostrarEncuentro'
												}
												,'onSuccess':respDatosEncuentro
												,'url':'sistema/procesos/transaccion/trans_resultados.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respDatosEncuentro(req)
{
	var modificar = document.getElementById('modificar').checked;
	var signo1, signo2, fav1, fav2, marcador, marcadorm;
	var resp = eval ("("+ req.responseText +")");
	
	document.getElementById('sel_ganador').options.length = 0;
	document.getElementById('sel_ganador').options[0] = new Option('Seleccione..');
	document.getElementById('sel_ganador').options[0].value = '0';
	document.getElementById('sel_ganador').options[0].selected = true;
	document.getElementById('sel_ganador').options[1] = new Option(resp[0]['equipo1']);
	document.getElementById('sel_ganador').options[1].value = resp[0]['equipo1'];
	document.getElementById('sel_ganador').options[2] = new Option(resp[0]['equipo2']);
	document.getElementById('sel_ganador').options[2].value = resp[0]['equipo2'];
	document.getElementById('favorito').value = resp[0]['favorito'];
	
	if (resp[0]['favorito'] == 1) {
		signo1 = '-';
		signo2 = '+';
		fav1 = '(F)';
		fav2 = '';
	} else if (resp[0]['favorito'] == 2) {
		signo1 = '+';
		signo2 = '-';
		fav1 = '';
		fav2 = '(F)';
	}
	
	document.getElementById('sel_runline').options.length = 0;
	document.getElementById('sel_runline').options[0] = new Option('Seleccione..');
	document.getElementById('sel_runline').options[0].value = '0';
	document.getElementById('sel_runline').options[0].selected = true;
	document.getElementById('sel_runline').options[1] = new Option(resp[0]['equipo1']+'('+signo1+resp[0]['v_runline']+')  '+fav1);
	document.getElementById('sel_runline').options[1].value = resp[0]['equipo1'];
	document.getElementById('sel_runline').options[2] = new Option(resp[0]['equipo2']+'('+signo2+resp[0]['v_runline']+')  '+fav2);
	document.getElementById('sel_runline').options[2].value = resp[0]['equipo2'];
	document.getElementById('v_runline').value = resp[0]['v_runline'];
	
	document.getElementById('sel_srunline').options.length = 0;
	document.getElementById('sel_srunline').options[0] = new Option('Seleccione..');
	document.getElementById('sel_srunline').options[0].value = '0';
	document.getElementById('sel_srunline').options[0].selected = true;
	document.getElementById('sel_srunline').options[1] = new Option(resp[0]['equipo1']+'('+signo1+resp[0]['v_srunline']+')  '+fav1);
	document.getElementById('sel_srunline').options[1].value = resp[0]['equipo1'];
	document.getElementById('sel_srunline').options[2] = new Option(resp[0]['equipo2']+'('+signo2+resp[0]['v_srunline']+')  '+fav2);
	document.getElementById('sel_srunline').options[2].value = resp[0]['equipo2'];
	document.getElementById('v_srunline').value = resp[0]['v_srunline'];

	document.getElementById('sel_ganador_mitad').options.length = 0;
	document.getElementById('sel_ganador_mitad').options[0] = new Option('Seleccione..');
	document.getElementById('sel_ganador_mitad').options[0].value = '0';
	document.getElementById('sel_ganador_mitad').options[0].selected = true;
	document.getElementById('sel_ganador_mitad').options[1] = new Option(resp[0]['equipo1']);
	document.getElementById('sel_ganador_mitad').options[1].value = resp[0]['equipo1'];
	document.getElementById('sel_ganador_mitad').options[2] = new Option(resp[0]['equipo2']);
	document.getElementById('sel_ganador_mitad').options[2].value = resp[0]['equipo2'];
	document.getElementById('sel_ganador_mitad').options[3] = new Option('EMPATE');
	document.getElementById('sel_ganador_mitad').options[3].value = 'EMPATE';
	
	document.getElementById('sel_runlinem').options.length = 0;
	document.getElementById('sel_runlinem').options[0] = new Option('Seleccione..');
	document.getElementById('sel_runlinem').options[0].value = '0';
	document.getElementById('sel_runlinem').options[0].selected = true;
	document.getElementById('sel_runlinem').options[1] = new Option(resp[0]['equipo1']+'('+signo1+resp[0]['v_runline_m']+')  '+fav1);
	document.getElementById('sel_runlinem').options[1].value = resp[0]['equipo1'];
	document.getElementById('sel_runlinem').options[2] = new Option(resp[0]['equipo2']+'('+signo2+resp[0]['v_runline_m']+')  '+fav2);
	document.getElementById('sel_runlinem').options[2].value = resp[0]['equipo2'];
	document.getElementById('sel_runlinem').options[3] = new Option('EMPATE');
	document.getElementById('sel_runlinem').options[3].value = 'EMPATE';
	document.getElementById('v_runlinem').value = resp[0]['v_runline_m'];
	
	document.getElementById('sel_p_anotar').options.length = 0;
	document.getElementById('sel_p_anotar').options[0] = new Option('Seleccione..');
	document.getElementById('sel_p_anotar').options[0].value = '0';
	document.getElementById('sel_p_anotar').options[0].selected = true;
	document.getElementById('sel_p_anotar').options[1] = new Option(resp[0]['equipo1']);
	document.getElementById('sel_p_anotar').options[1].value = resp[0]['equipo1'];
	document.getElementById('sel_p_anotar').options[2] = new Option(resp[0]['equipo2']);
	document.getElementById('sel_p_anotar').options[2].value = resp[0]['equipo2'];
	
	document.getElementById('v_ab').innerHTML = 'AB: ('+resp[0]['v_altabaja']+')';
	document.getElementById('v_ab_m').innerHTML = 'ABM: ('+resp[0]['v_ab_mediojuego']+')';
	
	if (modificar) {
		document.getElementById('sel_estatus').value = resp[0]['estado_res'];
		if (resp[0]['equipo1'] == resp[0]['ganador'])
			document.getElementById('sel_ganador').options[1].selected = true;
		else if (resp[0]['equipo2'] == resp[0]['ganador'])
			document.getElementById('sel_ganador').options[2].selected = true;
		if (resp[0]['equipo1'] == resp[0]['runline'])
			document.getElementById('sel_runline').options[1].selected = true;
		else if (resp[0]['equipo2'] == resp[0]['runline'])
			document.getElementById('sel_runline').options[2].selected = true;
		if (resp[0]['equipo1'] == resp[0]['srunline'])
			document.getElementById('sel_srunline').options[1].selected = true;
		else if (resp[0]['equipo2'] == resp[0]['srunline'])
			document.getElementById('sel_srunline').options[2].selected = true;
		if (resp[0]['equipo1'] == resp[0]['g_mediojuego'])
			document.getElementById('sel_ganador_mitad').options[1].selected = true;
		else if (resp[0]['equipo2'] == resp[0]['g_mediojuego'])
			document.getElementById('sel_ganador_mitad').options[2].selected = true;
		else
			document.getElementById('sel_ganador_mitad').options[3].selected = true;
		if (resp[0]['equipo1'] == resp[0]['runlinem'])
			document.getElementById('sel_runlinem').options[1].selected = true;
		else if (resp[0]['equipo2'] == resp[0]['runlinem'])
			document.getElementById('sel_runlinem').options[2].selected = true;
		else
			document.getElementById('sel_runlinem').options[3].selected = true;
		if (resp[0]['equipo1'] == resp[0]['p_anotar'])
			document.getElementById('sel_p_anotar').options[1].selected = true;
		else if (resp[0]['equipo2'] == resp[0]['p_anotar'])
			document.getElementById('sel_p_anotar').options[2].selected = true;
		document.getElementById('sel_p_inning').value = resp[0]['p_inning'];
		document.getElementById('tot_carreras').value = resp[0]['total_carreras'];
		document.getElementById('carreras_mitad').value = resp[0]['total_carreras_5to'];
		marcador = resp[0]['marcador'].split('x');
		document.getElementById('marcador1').value = marcador[0];
		document.getElementById('marcador2').value = marcador[1];
		marcadorm = resp[0]['marcadorm'].split('x');
		document.getElementById('marcadorm1').value = marcadorm[0];
		document.getElementById('marcadorm2').value = marcadorm[1];
	}
}

function guardarResultadosBeisbol() {
	var r, mensajeGuardar;
	var fecha = document.getElementById('fecha').value;
	var encuentro = document.getElementById('sel_encuentro').value;
	var estatus = document.getElementById('sel_estatus').value;
	var ganador = document.getElementById('sel_ganador').value;
	var runline = document.getElementById('sel_runline').value;
	var srunline = document.getElementById('sel_srunline').value;
	var carreras = document.getElementById('tot_carreras').value;
	var ganadorMitad = document.getElementById('sel_ganador_mitad').value;
	var runlinem = document.getElementById('sel_runlinem').value;
	var carrerasMitad = document.getElementById('carreras_mitad').value;
	var anotar1 = document.getElementById('sel_p_anotar').value;
	var inning1 = document.getElementById('sel_p_inning').value;
	var marcador1 = document.getElementById('marcador1').value;
	var marcador2 = document.getElementById('marcador2').value;
	var marcadorm1 = document.getElementById('marcadorm1').value;
	var marcadorm2 = document.getElementById('marcadorm2').value;
	var checkMod = document.getElementById('modificar').checked;
	var modificar, marcador, marcadorm;
	
	if (checkMod)
		modificar = 1;
	else
		modificar = 0;
	var idEncuentro;
	
	idEncuentro = encuentro.split('||');
	marcador = marcador1+'x'+marcador2;
	marcadorm = marcadorm1+'x'+marcadorm2;
	
	mensajeGuardar = '¿Confirma que desea registrar el resultado del encuentro?','si/no';

	if(fecha!=0 && encuentro!=0 && estatus!=0)
	{
		jConfirm(mensajeGuardar, 'Confirmación', function(r){
		if(r)
		{
				AjaxRequest.post(
									{'parameters': {'modificar':modificar,
													'fecha':fecha,
													'id_logro':idEncuentro[0],
													'encuentro':idEncuentro[1],
													'estatus':estatus,
													'ganador':ganador,
													'runline':runline,
													'srunline':srunline,
													'carreras':carreras,
													'ganadorMitad':ganadorMitad,
													'runlinem':runlinem,
													'carrerasMitad':carrerasMitad,
													'anotar1':anotar1,
													'inning1':inning1,
													'marcador':marcador,
													'marcadorm':marcadorm,
													'accion':'guardarResultado'
												   	}
													,'onSuccess':function(req){verificarResultadosBeisbol(req)}
													,'url':'sistema/procesos/transaccion/trans_resultados.php'
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

function verificarResultadosBeisbol(req)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != false)
	{
		jAlert('Se ha registrado correctamente el resultado', 'Información');
		cambiar_contenido('sistema/procesos/resultados_beisbol.php', 'sub_contenido');
	}
	else
	{
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}

// RESULTADO BASQUETBOL

function cargarEncuentrosBasquetbol() {
	var fecha = document.getElementById('fecha').value;
	var checkMod = document.getElementById('modificar').checked;
	var modificar;
	if (checkMod)
		modificar = 1;
	else
		modificar = 0;
	AjaxRequest.post
						(
							{'parameters':{		'modificar':modificar,
												'fecha':fecha,
												'accion':'buscarEncuentrosBasquetbol'
												}
												,'onSuccess':respCargarEncuentrosBasquetbol
												,'url':'sistema/procesos/transaccion/trans_resultados.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respCargarEncuentrosBasquetbol(req)
{
	var resp = eval ("("+ req.responseText +")");
	var fecha = document.getElementById('fecha');
	if (resp !="") {
		document.getElementById('sel_encuentro').options.length = 0;
		document.getElementById('sel_encuentro').options[0] = new Option('Seleccione..');
		document.getElementById('sel_encuentro').options[0].value = '0';
		document.getElementById('sel_encuentro').options[0].selected = true;
		
		for(var i=1,j=0; i<=resp.length; i++,j++)
		{
			document.getElementById('sel_encuentro').options[i] = new Option(resp[j]['encuentro']+' - ('+resp[j]['nombre']+')');
			document.getElementById('sel_encuentro').options[i].value = resp[j]['codigo']+'||'+resp[j]['encuentro'];
			document.getElementById('sel_encuentro').options[i].title = "Id: "+resp[j]['codigo'];
		}
	} else {
		jAlert('No existen encuentros registrados para la fecha seleccionada ('+fecha.value+')', 'Información');
		fecha.value = 0;
		return;
	}
}

function datosEncuentroBasquetbol()
{
	var checkMod = document.getElementById('modificar').checked;
	var modificar;
	if (checkMod)
		modificar = 1;
	else
		modificar = 0;
	var encuentro = document.getElementById('sel_encuentro').value;
	var idEncuentro;
	idEncuentro = encuentro.split('||');
	AjaxRequest.post
						(
							{'parameters':{		'modificar':modificar,
												'id_encuentro':idEncuentro[0],
												'accion':'mostrarEncuentroBasquetbol'
												}
												,'onSuccess':respDatosEncuentroBasquetbol
												,'url':'sistema/procesos/transaccion/trans_resultados.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respDatosEncuentroBasquetbol(req)
{
	var modificar = document.getElementById('modificar').checked;
	var signo1, signo2, fav1, fav2, marcador, marcadorm;
	var resp = eval ("("+ req.responseText +")");
	
	document.getElementById('sel_ganador').options.length = 0;
	document.getElementById('sel_ganador').options[0] = new Option('Seleccione..');
	document.getElementById('sel_ganador').options[0].value = '0';
	document.getElementById('sel_ganador').options[0].selected = true;
	document.getElementById('sel_ganador').options[1] = new Option(resp[0]['equipo1']);
	document.getElementById('sel_ganador').options[1].value = resp[0]['equipo1'];
	document.getElementById('sel_ganador').options[2] = new Option(resp[0]['equipo2']);
	document.getElementById('sel_ganador').options[2].value = resp[0]['equipo2'];
	document.getElementById('favorito').value = resp[0]['favorito'];
	
	if (resp[0]['favorito'] == 1) {
		signo1 = '-';
		signo2 = '+';
		fav1 = '(F)';
		fav2 = '';
	} else if (resp[0]['favorito'] == 2){
		signo1 = '+';
		signo2 = '-';
		fav1 = '';
		fav2 = '(F)';
	}
	document.getElementById('sel_runline').options.length = 0;
	document.getElementById('sel_runline').options[0] = new Option('Seleccione..');
	document.getElementById('sel_runline').options[0].value = '0';
	document.getElementById('sel_runline').options[0].selected = true;
	document.getElementById('sel_runline').options[1] = new Option(resp[0]['equipo1']+'('+signo1+resp[0]['v_runline']+')  '+fav1);
	document.getElementById('sel_runline').options[1].value = resp[0]['equipo1'];
	document.getElementById('sel_runline').options[2] = new Option(resp[0]['equipo2']+'('+signo2+resp[0]['v_runline']+')  '+fav2);
	document.getElementById('sel_runline').options[2].value = resp[0]['equipo2'];
	document.getElementById('sel_runline').options[3] = new Option('EMPATE');
	document.getElementById('sel_runline').options[3].value = 'EMPATE';
	document.getElementById('v_runline').value = resp[0]['v_runline'];
	
	document.getElementById('v_ab').innerHTML = 'AB: ('+resp[0]['v_altabaja']+')';

	// MITAD DE JUEGO
	document.getElementById('sel_ganadorm').options.length = 0;
	document.getElementById('sel_ganadorm').options[0] = new Option('Seleccione..');
	document.getElementById('sel_ganadorm').options[0].value = '0';
	document.getElementById('sel_ganadorm').options[0].selected = true;
	document.getElementById('sel_ganadorm').options[1] = new Option(resp[0]['equipo1']);
	document.getElementById('sel_ganadorm').options[1].value = resp[0]['equipo1'];
	document.getElementById('sel_ganadorm').options[2] = new Option(resp[0]['equipo2']);
	document.getElementById('sel_ganadorm').options[2].value = resp[0]['equipo2'];
	document.getElementById('sel_ganadorm').options[3] = new Option('EMPATE');
	document.getElementById('sel_ganadorm').options[3].value = 'EMPATE';
	
	document.getElementById('sel_runlinem').options.length = 0;
	document.getElementById('sel_runlinem').options[0] = new Option('Seleccione..');
	document.getElementById('sel_runlinem').options[0].value = '0';
	document.getElementById('sel_runlinem').options[0].selected = true;
	document.getElementById('sel_runlinem').options[1] = new Option(resp[0]['equipo1']+'('+signo1+resp[0]['v_runline_m']+')  '+fav1);
	document.getElementById('sel_runlinem').options[1].value = resp[0]['equipo1'];
	document.getElementById('sel_runlinem').options[2] = new Option(resp[0]['equipo2']+'('+signo2+resp[0]['v_runline_m']+')  '+fav2);
	document.getElementById('sel_runlinem').options[2].value = resp[0]['equipo2'];
	document.getElementById('sel_runlinem').options[3] = new Option('EMPATE');
	document.getElementById('sel_runlinem').options[3].value = 'EMPATE';
	document.getElementById('v_runlinem').value = resp[0]['v_runline_m'];
	
	document.getElementById('v_ab_m').innerHTML = 'ABM: ('+resp[0]['v_altabaja_m']+')';
	
	if (modificar) {
		document.getElementById('sel_estatus').value = resp[0]['estado_res'];
		if (resp[0]['equipo1'] == resp[0]['ganador'])
			document.getElementById('sel_ganador').options[1].selected = true;
		else if (resp[0]['equipo2'] == resp[0]['ganador'])
			document.getElementById('sel_ganador').options[2].selected = true;
		if (resp[0]['equipo1'] == resp[0]['runline'])
			document.getElementById('sel_runline').options[1].selected = true;
		else if (resp[0]['equipo2'] == resp[0]['runline'])
			document.getElementById('sel_runline').options[2].selected = true;
		else
			document.getElementById('sel_runline').options[3].selected = true;
		
		document.getElementById('tot_puntos').value = resp[0]['total_puntos'];
		marcador = resp[0]['marcador'].split('x');
		document.getElementById('marcador1').value = marcador[0];
		document.getElementById('marcador2').value = marcador[1];
		
		//MITAD DE JUEGO
		if (resp[0]['equipo1'] == resp[0]['ganadorm'])
			document.getElementById('sel_ganadorm').options[1].selected = true;
		else if (resp[0]['equipo2'] == resp[0]['ganadorm'])
			document.getElementById('sel_ganadorm').options[2].selected = true;
		else
			document.getElementById('sel_ganadorm').options[3].selected = true;
		
		if (resp[0]['equipo1'] == resp[0]['runlinem'])
			document.getElementById('sel_runlinem').options[1].selected = true;
		else if (resp[0]['equipo2'] == resp[0]['runlinem'])
			document.getElementById('sel_runlinem').options[2].selected = true;
		else
			document.getElementById('sel_runlinem').options[3].selected = true;
		
		document.getElementById('tot_puntosm').value = resp[0]['total_puntosm'];
		marcadorm = resp[0]['marcadorm'].split('x');
		document.getElementById('marcadorm1').value = marcadorm[0];
		document.getElementById('marcadorm2').value = marcadorm[1];
	}
}

function guardarResultadosBasquetbol() {
	var r, mensajeGuardar, marcador, marcadorm;
	var fecha = document.getElementById('fecha').value;
	var encuentro = document.getElementById('sel_encuentro').value;
	var estatus = document.getElementById('sel_estatus').value;
	var ganador = document.getElementById('sel_ganador').value;
	var runline = document.getElementById('sel_runline').value;
	var puntos = document.getElementById('tot_puntos').value;
	var ganadorm = document.getElementById('sel_ganadorm').value;
	var runlinem = document.getElementById('sel_runlinem').value;
	var puntosm = document.getElementById('tot_puntosm').value;
	var marcador1 = document.getElementById('marcador1').value;
	var marcador2 = document.getElementById('marcador2').value;
	var marcadorm1 = document.getElementById('marcadorm1').value;
	var marcadorm2 = document.getElementById('marcadorm2').value;
	var checkMod = document.getElementById('modificar').checked;
	var modificar;
	
	if (checkMod)
		modificar = 1;
	else
		modificar = 0;
	var idEncuentro;
	
	idEncuentro = encuentro.split('||');
	marcador = marcador1+'x'+marcador2;
	marcadorm = marcadorm1+'x'+marcadorm2;
	
	mensajeGuardar = '¿Confirma que desea registrar el resultado del encuentro?','si/no';

	if(fecha!=0 && encuentro!=0 && estatus!=0)
	{
		jConfirm(mensajeGuardar, 'Confirmación', function(r){
		if(r)
		{
				AjaxRequest.post(
									{'parameters': {'modificar':modificar,
													'fecha':fecha,
													'id_logro':idEncuentro[0],
													'encuentro':idEncuentro[1],
													'estatus':estatus,
													'ganador':ganador,
													'runline':runline,
													'puntos':puntos,
													'marcador':marcador,
													'ganadorm':ganadorm,
													'runlinem':runlinem,
													'puntosm':puntosm,
													'marcadorm':marcadorm,
													'accion':'guardarResultadoBasquetbol'
												   	}
													,'onSuccess':function(req){verificarResultadosBasquetbol(req)}
													,'url':'sistema/procesos/transaccion/trans_resultados.php'
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

function verificarResultadosBasquetbol(req)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != false)
	{
		jAlert('Se ha registrado correctamente el resultado', 'Información');
		cambiar_contenido('sistema/procesos/resultados_basquetbol.php', 'sub_contenido');
	}
	else
	{
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}

// FÚTBOL

function cargarEncuentrosFutbol() {
	var fecha = document.getElementById('fecha').value;
	var checkMod = document.getElementById('modificar').checked;
	var modificar;
	if (checkMod)
		modificar = 1;
	else
		modificar = 0;
	AjaxRequest.post
						(
							{'parameters':{		'modificar':modificar,
												'fecha':fecha,
												'accion':'buscarEncuentrosFutbol'
												}
												,'onSuccess':respCargarEncuentrosFutbol
												,'url':'sistema/procesos/transaccion/trans_resultados.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respCargarEncuentrosFutbol(req)
{
	var resp = eval ("("+ req.responseText +")");
	var fecha = document.getElementById('fecha');
	if (resp !="") {
		document.getElementById('sel_encuentro').options.length = 0;
		document.getElementById('sel_encuentro').options[0] = new Option('Seleccione..');
		document.getElementById('sel_encuentro').options[0].value = '0';
		document.getElementById('sel_encuentro').options[0].selected = true;
		
		for(var i=1,j=0; i<=resp.length; i++,j++)
		{
			document.getElementById('sel_encuentro').options[i] = new Option(resp[j]['encuentro']+' - ('+resp[j]['nombre']+')');
			document.getElementById('sel_encuentro').options[i].value = resp[j]['codigo']+'||'+resp[j]['encuentro'];
			document.getElementById('sel_encuentro').options[i].title = "Id: "+resp[j]['codigo'];
		}
	} else {
		jAlert('No existen encuentros registrados para la fecha seleccionada ('+fecha.value+')', 'Información');
		fecha.value = 0;
		return;
	}
}

function datosEncuentroFutbol()
{
	var checkMod = document.getElementById('modificar').checked;
	var modificar;
	if (checkMod)
		modificar = 1;
	else
		modificar = 0;
	var encuentro = document.getElementById('sel_encuentro').value;
	var idEncuentro;
	idEncuentro = encuentro.split('||');
	AjaxRequest.post
						(
							{'parameters':{		'modificar':modificar,
												'id_encuentro':idEncuentro[0],
												'accion':'mostrarEncuentroFutbol'
												}
												,'onSuccess':respDatosEncuentroFutbol
												,'url':'sistema/procesos/transaccion/trans_resultados.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respDatosEncuentroFutbol(req)
{
	var modificar = document.getElementById('modificar').checked;
	var signo1, signo2, fav1, fav2, marcador;
	var resp = eval ("("+ req.responseText +")");
	
	document.getElementById('sel_ganador').options.length = 0;
	document.getElementById('sel_ganador').options[0] = new Option('Seleccione..');
	document.getElementById('sel_ganador').options[0].value = '0';
	document.getElementById('sel_ganador').options[0].selected = true;
	document.getElementById('sel_ganador').options[1] = new Option(resp[0]['equipo1']);
	document.getElementById('sel_ganador').options[1].value = resp[0]['equipo1'];
	document.getElementById('sel_ganador').options[2] = new Option(resp[0]['equipo2']);
	document.getElementById('sel_ganador').options[2].value = resp[0]['equipo2'];
	document.getElementById('sel_ganador').options[3] = new Option('EMPATE');
	document.getElementById('sel_ganador').options[3].value = 'EMPATE';
	document.getElementById('favorito').value = resp[0]['favorito'];
	
	if (resp[0]['favorito'] == 1) {
		signo1 = '-';
		signo2 = '+';
		fav1 = '(F)';
		fav2 = '';
	} else if (resp[0]['favorito'] == 2){
		signo1 = '+';
		signo2 = '-';
		fav1 = '';
		fav2 = '(F)';
	}
	document.getElementById('sel_runline').options.length = 0;
	document.getElementById('sel_runline').options[0] = new Option('Seleccione..');
	document.getElementById('sel_runline').options[0].value = '0';
	document.getElementById('sel_runline').options[0].selected = true;
	document.getElementById('sel_runline').options[1] = new Option(resp[0]['equipo1']+'('+signo1+resp[0]['v_runline']+')  '+fav1);
	document.getElementById('sel_runline').options[1].value = resp[0]['equipo1'];
	document.getElementById('sel_runline').options[2] = new Option(resp[0]['equipo2']+'('+signo2+resp[0]['v_runline']+')  '+fav2);
	document.getElementById('sel_runline').options[2].value = resp[0]['equipo2'];
	document.getElementById('sel_runline').options[3] = new Option('EMPATE');
	document.getElementById('sel_runline').options[3].value = 'EMPATE';
	document.getElementById('v_runline').value = resp[0]['v_runline'];
	
	document.getElementById('v_ab').innerHTML = 'AB: ('+resp[0]['v_altabaja']+')';
	
	if (modificar) {
		document.getElementById('sel_estatus').value = resp[0]['estado_res'];
		if (resp[0]['equipo1'] == resp[0]['ganador'])
			document.getElementById('sel_ganador').options[1].selected = true;
		else if (resp[0]['equipo2'] == resp[0]['ganador'])
			document.getElementById('sel_ganador').options[2].selected = true;
		else
			document.getElementById('sel_ganador').options[3].selected = true;
			
		if (resp[0]['equipo1'] == resp[0]['runline'])
			document.getElementById('sel_runline').options[1].selected = true;
		else if (resp[0]['equipo2'] == resp[0]['runline'])
			document.getElementById('sel_runline').options[2].selected = true;
		else
			document.getElementById('sel_runline').options[3].selected = true;

		document.getElementById('tot_goles').value = resp[0]['total_goles'];
		marcador = resp[0]['marcador'].split('x');
		document.getElementById('marcador1').value = marcador[0];
		document.getElementById('marcador2').value = marcador[1];
	}
}

function guardarResultadosFutbol() {
	var r, mensajeGuardar, marcador;
	var fecha = document.getElementById('fecha').value;
	var encuentro = document.getElementById('sel_encuentro').value;
	var estatus = document.getElementById('sel_estatus').value;
	var ganador = document.getElementById('sel_ganador').value;
	var runline = document.getElementById('sel_runline').value;
	var goles = document.getElementById('tot_goles').value;
	var marcador1 = document.getElementById('marcador1').value;
	var marcador2 = document.getElementById('marcador2').value;
	var checkMod = document.getElementById('modificar').checked;
	var modificar;
	
	if (checkMod)
		modificar = 1;
	else
		modificar = 0;
	var idEncuentro;
	
	idEncuentro = encuentro.split('||');
	marcador = marcador1+'x'+marcador2;
	
	mensajeGuardar = '¿Confirma que desea registrar el resultado del encuentro?','si/no';

	if(fecha!=0 && encuentro!=0 && estatus!=0)
	{
		jConfirm(mensajeGuardar, 'Confirmación', function(r){
		if(r)
		{
				AjaxRequest.post(
									{'parameters': {'modificar':modificar,
													'fecha':fecha,
													'id_logro':idEncuentro[0],
													'encuentro':idEncuentro[1],
													'estatus':estatus,
													'ganador':ganador,
													'runline':runline,
													'goles':goles,
													'marcador':marcador,
													'accion':'guardarResultadoFutbol'
												   	}
													,'onSuccess':function(req){verificarResultadosFutbol(req)}
													,'url':'sistema/procesos/transaccion/trans_resultados.php'
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

function verificarResultadosFutbol(req)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != false)
	{
		jAlert('Se ha registrado correctamente el resultado', 'Información');
		cambiar_contenido('sistema/procesos/resultados_futbol.php', 'sub_contenido');
	}
	else
	{
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}

function calcularMarcador(total) {
	var marcador1 = document.getElementById('marcador1').value;
	var marcador2 = document.getElementById('marcador2').value;
	var total = document.getElementById(total);	
	total.value = parseInt(marcador1) + parseInt(marcador2);
}

function calcularMarcadorMitad(total) {
	var marcador1 = document.getElementById('marcadorm1').value;
	var marcador2 = document.getElementById('marcadorm2').value;
	var total = document.getElementById(total);	
	total.value = parseInt(marcador1) + parseInt(marcador2);
}

// FÚTBOL AMERICANO

function cargarEncuentrosFutbolAmericano() {
	var fecha = document.getElementById('fecha').value;
	var checkMod = document.getElementById('modificar').checked;
	var modificar;
	if (checkMod)
		modificar = 1;
	else
		modificar = 0;
	AjaxRequest.post
						(
							{'parameters':{		'modificar':modificar,
												'fecha':fecha,
												'accion':'buscarEncuentrosFutbolAmericano'
												}
												,'onSuccess':respCargarEncuentrosFutbolAmericano
												,'url':'sistema/procesos/transaccion/trans_resultados.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respCargarEncuentrosFutbolAmericano(req)
{
	var resp = eval ("("+ req.responseText +")");
	var fecha = document.getElementById('fecha');
	if (resp !="") {
		document.getElementById('sel_encuentro').options.length = 0;
		document.getElementById('sel_encuentro').options[0] = new Option('Seleccione..');
		document.getElementById('sel_encuentro').options[0].value = '0';
		document.getElementById('sel_encuentro').options[0].selected = true;
		
		for(var i=1,j=0; i<=resp.length; i++,j++)
		{
			document.getElementById('sel_encuentro').options[i] = new Option(resp[j]['encuentro']+' - ('+resp[j]['nombre']+')');
			document.getElementById('sel_encuentro').options[i].value = resp[j]['codigo']+'||'+resp[j]['encuentro'];
			document.getElementById('sel_encuentro').options[i].title = "Id: "+resp[j]['codigo'];
		}
	} else {
		jAlert('No existen encuentros registrados para la fecha seleccionada ('+fecha.value+')', 'Información');
		fecha.value = 0;
		return;
	}
}

function datosEncuentroFutbolAmericano()
{
	var checkMod = document.getElementById('modificar').checked;
	var modificar;
	if (checkMod)
		modificar = 1;
	else
		modificar = 0;
	var encuentro = document.getElementById('sel_encuentro').value;
	var idEncuentro;
	idEncuentro = encuentro.split('||');
	AjaxRequest.post
						(
							{'parameters':{		'modificar':modificar,
												'id_encuentro':idEncuentro[0],
												'accion':'mostrarEncuentroFutbolAmericano'
												}
												,'onSuccess':respDatosEncuentroFutbolAmericano
												,'url':'sistema/procesos/transaccion/trans_resultados.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respDatosEncuentroFutbolAmericano(req)
{
	var modificar = document.getElementById('modificar').checked;
	var signo1, signo2, fav1, fav2, marcador;
	var resp = eval ("("+ req.responseText +")");
	
	document.getElementById('sel_ganador').options.length = 0;
	document.getElementById('sel_ganador').options[0] = new Option('Seleccione..');
	document.getElementById('sel_ganador').options[0].value = '0';
	document.getElementById('sel_ganador').options[0].selected = true;
	document.getElementById('sel_ganador').options[1] = new Option(resp[0]['equipo1']);
	document.getElementById('sel_ganador').options[1].value = resp[0]['equipo1'];
	document.getElementById('sel_ganador').options[2] = new Option(resp[0]['equipo2']);
	document.getElementById('sel_ganador').options[2].value = resp[0]['equipo2'];
	document.getElementById('favorito').value = resp[0]['favorito'];
	
	if (resp[0]['favorito'] == 1) {
		signo1 = '-';
		signo2 = '+';
		fav1 = '(F)';
		fav2 = '';
	} else if (resp[0]['favorito'] == 2){
		signo1 = '+';
		signo2 = '-';
		fav1 = '';
		fav2 = '(F)';
	}
	document.getElementById('sel_runline').options.length = 0;
	document.getElementById('sel_runline').options[0] = new Option('Seleccione..');
	document.getElementById('sel_runline').options[0].value = '0';
	document.getElementById('sel_runline').options[0].selected = true;
	document.getElementById('sel_runline').options[1] = new Option(resp[0]['equipo1']+'('+signo1+resp[0]['v_runline']+')  '+fav1);
	document.getElementById('sel_runline').options[1].value = resp[0]['equipo1'];
	document.getElementById('sel_runline').options[2] = new Option(resp[0]['equipo2']+'('+signo2+resp[0]['v_runline']+')  '+fav2);
	document.getElementById('sel_runline').options[2].value = resp[0]['equipo2'];
	document.getElementById('sel_runline').options[3] = new Option('EMPATE');
	document.getElementById('sel_runline').options[3].value = 'EMPATE';
	document.getElementById('v_runline').value = resp[0]['v_runline'];
	
	document.getElementById('v_ab').innerHTML = 'AB: ('+resp[0]['v_altabaja']+')';
	
	if (modificar) {
		document.getElementById('sel_estatus').value = resp[0]['estado_res'];
		if (resp[0]['equipo1'] == resp[0]['ganador'])
			document.getElementById('sel_ganador').options[1].selected = true;
		else if (resp[0]['equipo2'] == resp[0]['ganador'])
			document.getElementById('sel_ganador').options[2].selected = true;
			
		if (resp[0]['equipo1'] == resp[0]['runline'])
			document.getElementById('sel_runline').options[1].selected = true;
		else if (resp[0]['equipo2'] == resp[0]['runline'])
			document.getElementById('sel_runline').options[2].selected = true;
		else
			document.getElementById('sel_runline').options[3].selected = true;

		document.getElementById('tot_goles').value = resp[0]['total_goles'];
		marcador = resp[0]['marcador'].split('x');
		document.getElementById('marcador1').value = marcador[0];
		document.getElementById('marcador2').value = marcador[1];
	}
}

function guardarResultadosFutbolAmericano() {
	var r, mensajeGuardar, marcador;
	var fecha = document.getElementById('fecha').value;
	var encuentro = document.getElementById('sel_encuentro').value;
	var estatus = document.getElementById('sel_estatus').value;
	var ganador = document.getElementById('sel_ganador').value;
	var runline = document.getElementById('sel_runline').value;
	var goles = document.getElementById('tot_goles').value;
	var marcador1 = document.getElementById('marcador1').value;
	var marcador2 = document.getElementById('marcador2').value;
	var checkMod = document.getElementById('modificar').checked;
	var modificar;
	
	if (checkMod)
		modificar = 1;
	else
		modificar = 0;
	var idEncuentro;
	
	idEncuentro = encuentro.split('||');
	marcador = marcador1+'x'+marcador2;
	
	mensajeGuardar = '¿Confirma que desea registrar el resultado del encuentro?','si/no';

	if(fecha!=0 && encuentro!=0 && estatus!=0)
	{
		jConfirm(mensajeGuardar, 'Confirmación', function(r){
		if(r)
		{
				AjaxRequest.post(
									{'parameters': {'modificar':modificar,
													'fecha':fecha,
													'id_logro':idEncuentro[0],
													'encuentro':idEncuentro[1],
													'estatus':estatus,
													'ganador':ganador,
													'runline':runline,
													'goles':goles,
													'marcador':marcador,
													'accion':'guardarResultadoFutbolAmericano'
												   	}
													,'onSuccess':function(req){verificarResultadosFutbolAmericano(req)}
													,'url':'sistema/procesos/transaccion/trans_resultados.php'
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

function verificarResultadosFutbolAmericano(req)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != false)
	{
		jAlert('Se ha registrado correctamente el resultado', 'Información');
		cambiar_contenido('sistema/procesos/resultados_futbol_americano.php', 'sub_contenido');
	}
	else
	{
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}

// HOCKEY

function cargarEncuentrosHockey() {
	var fecha = document.getElementById('fecha').value;
	var checkMod = document.getElementById('modificar').checked;
	var modificar;
	if (checkMod)
		modificar = 1;
	else
		modificar = 0;
	AjaxRequest.post
						(
							{'parameters':{		'modificar':modificar,
												'fecha':fecha,
												'accion':'buscarEncuentrosHockey'
												}
												,'onSuccess':respCargarEncuentrosHockey
												,'url':'sistema/procesos/transaccion/trans_resultados.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respCargarEncuentrosHockey(req)
{
	var resp = eval ("("+ req.responseText +")");
	var fecha = document.getElementById('fecha');
	if (resp !="") {
		document.getElementById('sel_encuentro').options.length = 0;
		document.getElementById('sel_encuentro').options[0] = new Option('Seleccione..');
		document.getElementById('sel_encuentro').options[0].value = '0';
		document.getElementById('sel_encuentro').options[0].selected = true;
		
		for(var i=1,j=0; i<=resp.length; i++,j++)
		{
			document.getElementById('sel_encuentro').options[i] = new Option(resp[j]['encuentro']+' - ('+resp[j]['nombre']+')');
			document.getElementById('sel_encuentro').options[i].value = resp[j]['codigo']+'||'+resp[j]['encuentro'];
			document.getElementById('sel_encuentro').options[i].title = "Id: "+resp[j]['codigo'];
		}
	} else {
		jAlert('No existen encuentros registrados para la fecha seleccionada ('+fecha.value+')', 'Información');
		fecha.value = 0;
		return;
	}
}

function datosEncuentroHockey()
{
	var checkMod = document.getElementById('modificar').checked;
	var modificar;
	if (checkMod)
		modificar = 1;
	else
		modificar = 0;
	var encuentro = document.getElementById('sel_encuentro').value;
	var idEncuentro;
	idEncuentro = encuentro.split('||');
	AjaxRequest.post
						(
							{'parameters':{		'modificar':modificar,
												'id_encuentro':idEncuentro[0],
												'accion':'mostrarEncuentroHockey'
												}
												,'onSuccess':respDatosEncuentroHockey
												,'url':'sistema/procesos/transaccion/trans_resultados.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respDatosEncuentroHockey(req)
{
	var modificar = document.getElementById('modificar').checked;
	var signo1, signo2, fav1, fav2, marcador;
	var resp = eval ("("+ req.responseText +")");
	
	document.getElementById('sel_ganador').options.length = 0;
	document.getElementById('sel_ganador').options[0] = new Option('Seleccione..');
	document.getElementById('sel_ganador').options[0].value = '0';
	document.getElementById('sel_ganador').options[0].selected = true;
	document.getElementById('sel_ganador').options[1] = new Option(resp[0]['equipo1']);
	document.getElementById('sel_ganador').options[1].value = resp[0]['equipo1'];
	document.getElementById('sel_ganador').options[2] = new Option(resp[0]['equipo2']);
	document.getElementById('sel_ganador').options[2].value = resp[0]['equipo2'];
	document.getElementById('favorito').value = resp[0]['favorito'];
	
	if (resp[0]['favorito'] == 1) {
		signo1 = '-';
		signo2 = '+';
		fav1 = '(F)';
		fav2 = '';
	} else if (resp[0]['favorito'] == 2){
		signo1 = '+';
		signo2 = '-';
		fav1 = '';
		fav2 = '(F)';
	}
	document.getElementById('sel_runline').options.length = 0;
	document.getElementById('sel_runline').options[0] = new Option('Seleccione..');
	document.getElementById('sel_runline').options[0].value = '0';
	document.getElementById('sel_runline').options[0].selected = true;
	document.getElementById('sel_runline').options[1] = new Option(resp[0]['equipo1']+'('+signo1+resp[0]['v_runline']+')  '+fav1);
	document.getElementById('sel_runline').options[1].value = resp[0]['equipo1'];
	document.getElementById('sel_runline').options[2] = new Option(resp[0]['equipo2']+'('+signo2+resp[0]['v_runline']+')  '+fav2);
	document.getElementById('sel_runline').options[2].value = resp[0]['equipo2'];
	document.getElementById('v_runline').value = resp[0]['v_runline'];
	
	document.getElementById('v_ab').innerHTML = 'AB: ('+resp[0]['v_altabaja']+')';
	
	if (modificar) {
		document.getElementById('sel_estatus').value = resp[0]['estado_res'];
		if (resp[0]['equipo1'] == resp[0]['ganador'])
			document.getElementById('sel_ganador').options[1].selected = true;
		else if (resp[0]['equipo2'] == resp[0]['ganador'])
			document.getElementById('sel_ganador').options[2].selected = true;
			
		if (resp[0]['equipo1'] == resp[0]['runline'])
			document.getElementById('sel_runline').options[1].selected = true;
		else if (resp[0]['equipo2'] == resp[0]['runline'])
			document.getElementById('sel_runline').options[2].selected = true;
		
		document.getElementById('tot_goles').value = resp[0]['total_goles'];
		marcador = resp[0]['marcador'].split('x');
		document.getElementById('marcador1').value = marcador[0];
		document.getElementById('marcador2').value = marcador[1];
	}
}

function guardarResultadosHockey() {
	var r, mensajeGuardar, marcador;
	var fecha = document.getElementById('fecha').value;
	var encuentro = document.getElementById('sel_encuentro').value;
	var estatus = document.getElementById('sel_estatus').value;
	var ganador = document.getElementById('sel_ganador').value;
	var runline = document.getElementById('sel_runline').value;
	var goles = document.getElementById('tot_goles').value;
	var marcador1 = document.getElementById('marcador1').value;
	var marcador2 = document.getElementById('marcador2').value;
	var checkMod = document.getElementById('modificar').checked;
	var modificar;
	
	if (checkMod)
		modificar = 1;
	else
		modificar = 0;
	var idEncuentro;
	
	idEncuentro = encuentro.split('||');
	marcador = marcador1+'x'+marcador2;
	
	mensajeGuardar = '¿Confirma que desea registrar el resultado del encuentro?','si/no';

	if(fecha!=0 && encuentro!=0 && estatus!=0)
	{
		jConfirm(mensajeGuardar, 'Confirmación', function(r){
		if(r)
		{
				AjaxRequest.post(
									{'parameters': {'modificar':modificar,
													'fecha':fecha,
													'id_logro':idEncuentro[0],
													'encuentro':idEncuentro[1],
													'estatus':estatus,
													'ganador':ganador,
													'runline':runline,
													'goles':goles,
													'marcador':marcador,
													'accion':'guardarResultadoHockey'
												   	}
													,'onSuccess':function(req){verificarResultadosHockey(req)}
													,'url':'sistema/procesos/transaccion/trans_resultados.php'
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

function verificarResultadosHockey(req)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != false)
	{
		jAlert('Se ha registrado correctamente el resultado', 'Información');
		cambiar_contenido('sistema/procesos/resultados_hockey.php', 'sub_contenido');
	}
	else
	{
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}

// TENNIS

function cargarEncuentrosTennis() {
	var fecha = document.getElementById('fecha').value;
	var checkMod = document.getElementById('modificar').checked;
	var modificar;
	if (checkMod)
		modificar = 1;
	else
		modificar = 0;
	AjaxRequest.post
						(
							{'parameters':{		'modificar':modificar,
												'fecha':fecha,
												'accion':'buscarEncuentrosTennis'
												}
												,'onSuccess':respCargarEncuentrosTennis
												,'url':'sistema/procesos/transaccion/trans_resultados.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respCargarEncuentrosTennis(req)
{
	var resp = eval ("("+ req.responseText +")");
	var fecha = document.getElementById('fecha');
	if (resp !="") {
		document.getElementById('sel_encuentro').options.length = 0;
		document.getElementById('sel_encuentro').options[0] = new Option('Seleccione..');
		document.getElementById('sel_encuentro').options[0].value = '0';
		document.getElementById('sel_encuentro').options[0].selected = true;
		
		for(var i=1,j=0; i<=resp.length; i++,j++)
		{
			document.getElementById('sel_encuentro').options[i] = new Option(resp[j]['encuentro']+' - ('+resp[j]['nombre']+')');
			document.getElementById('sel_encuentro').options[i].value = resp[j]['codigo']+'||'+resp[j]['encuentro'];
			document.getElementById('sel_encuentro').options[i].title = "Id: "+resp[j]['codigo'];
		}
	} else {
		jAlert('No existen encuentros registrados para la fecha seleccionada ('+fecha.value+')', 'Información');
		fecha.value = 0;
		return;
	}
}

function datosEncuentroTennis()
{
	var checkMod = document.getElementById('modificar').checked;
	var modificar;
	if (checkMod)
		modificar = 1;
	else
		modificar = 0;
	var encuentro = document.getElementById('sel_encuentro').value;
	var idEncuentro;
	idEncuentro = encuentro.split('||');
	AjaxRequest.post
						(
							{'parameters':{		'modificar':modificar,
												'id_encuentro':idEncuentro[0],
												'accion':'mostrarEncuentroTennis'
												}
												,'onSuccess':respDatosEncuentroTennis
												,'url':'sistema/procesos/transaccion/trans_resultados.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respDatosEncuentroTennis(req)
{
	var modificar = document.getElementById('modificar').checked;
	var marcador;
	var resp = eval ("("+ req.responseText +")");
	
	document.getElementById('sel_ganador').options.length = 0;
	document.getElementById('sel_ganador').options[0] = new Option('Seleccione..');
	document.getElementById('sel_ganador').options[0].value = '0';
	document.getElementById('sel_ganador').options[0].selected = true;
	document.getElementById('sel_ganador').options[1] = new Option(resp[0]['equipo1']);
	document.getElementById('sel_ganador').options[1].value = resp[0]['equipo1'];
	document.getElementById('sel_ganador').options[2] = new Option(resp[0]['equipo2']);
	document.getElementById('sel_ganador').options[2].value = resp[0]['equipo2'];
	
	if (modificar) {
		document.getElementById('sel_estatus').value = resp[0]['estado_res'];
		if (resp[0]['equipo1'] == resp[0]['ganador'])
			document.getElementById('sel_ganador').options[1].selected = true;
		else if (resp[0]['equipo2'] == resp[0]['ganador'])
			document.getElementById('sel_ganador').options[2].selected = true;
					
		document.getElementById('txt_marcador').value = resp[0]['marcador'];
	}
}

function guardarResultadosTennis() {
	var r, mensajeGuardar, marcador;
	var fecha = document.getElementById('fecha').value;
	var encuentro = document.getElementById('sel_encuentro').value;
	var estatus = document.getElementById('sel_estatus').value;
	var ganador = document.getElementById('sel_ganador').value;
	var marcador = document.getElementById('txt_marcador').value;
	var checkMod = document.getElementById('modificar').checked;
	var modificar;
	
	if (checkMod)
		modificar = 1;
	else
		modificar = 0;
	var idEncuentro;
	
	idEncuentro = encuentro.split('||');
	
	mensajeGuardar = '¿Confirma que desea registrar el resultado del encuentro?','si/no';

	if(fecha!=0 && encuentro!=0 && estatus!=0)
	{
		jConfirm(mensajeGuardar, 'Confirmación', function(r){
		if(r)
		{
				AjaxRequest.post(
									{'parameters': {'modificar':modificar,
													'fecha':fecha,
													'id_logro':idEncuentro[0],
													'encuentro':idEncuentro[1],
													'estatus':estatus,
													'ganador':ganador,
													'marcador':marcador,
													'accion':'guardarResultadoTennis'
												   	}
													,'onSuccess':function(req){verificarResultadosTennis(req)}
													,'url':'sistema/procesos/transaccion/trans_resultados.php'
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

function verificarResultadosTennis(req)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != false)
	{
		jAlert('Se ha registrado correctamente el resultado', 'Información');
		cambiar_contenido('sistema/procesos/resultados_tennis.php', 'sub_contenido');
	}
	else
	{
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}

// BOXEO

function cargarEncuentrosBoxeo() {
	var fecha = document.getElementById('fecha').value;
	var checkMod = document.getElementById('modificar').checked;
	var modificar;
	if (checkMod)
		modificar = 1;
	else
		modificar = 0;
	AjaxRequest.post
						(
							{'parameters':{		'modificar':modificar,
												'fecha':fecha,
												'accion':'buscarEncuentrosBoxeo'
												}
												,'onSuccess':respCargarEncuentrosBoxeo
												,'url':'sistema/procesos/transaccion/trans_resultados.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respCargarEncuentrosBoxeo(req)
{
	var resp = eval ("("+ req.responseText +")");
	var fecha = document.getElementById('fecha');
	if (resp !="") {
		document.getElementById('sel_encuentro').options.length = 0;
		document.getElementById('sel_encuentro').options[0] = new Option('Seleccione..');
		document.getElementById('sel_encuentro').options[0].value = '0';
		document.getElementById('sel_encuentro').options[0].selected = true;
		
		for(var i=1,j=0; i<=resp.length; i++,j++)
		{
			document.getElementById('sel_encuentro').options[i] = new Option(resp[j]['encuentro']+' - ('+resp[j]['nombre']+')');
			document.getElementById('sel_encuentro').options[i].value = resp[j]['codigo']+'||'+resp[j]['encuentro'];
			document.getElementById('sel_encuentro').options[i].title = "Id: "+resp[j]['codigo'];
		}
	} else {
		jAlert('No existen encuentros registrados para la fecha seleccionada ('+fecha.value+')', 'Información');
		fecha.value = 0;
		return;
	}
}

function datosEncuentroBoxeo()
{
	var checkMod = document.getElementById('modificar').checked;
	var modificar;
	if (checkMod)
		modificar = 1;
	else
		modificar = 0;
	var encuentro = document.getElementById('sel_encuentro').value;
	var idEncuentro;
	idEncuentro = encuentro.split('||');
	AjaxRequest.post
						(
							{'parameters':{		'modificar':modificar,
												'id_encuentro':idEncuentro[0],
												'accion':'mostrarEncuentroBoxeo'
												}
												,'onSuccess':respDatosEncuentroBoxeo
												,'url':'sistema/procesos/transaccion/trans_resultados.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respDatosEncuentroBoxeo(req)
{
	var modificar = document.getElementById('modificar').checked;
	var marcador;
	var resp = eval ("("+ req.responseText +")");
	
	document.getElementById('sel_ganador').options.length = 0;
	document.getElementById('sel_ganador').options[0] = new Option('Seleccione..');
	document.getElementById('sel_ganador').options[0].value = '0';
	document.getElementById('sel_ganador').options[0].selected = true;
	document.getElementById('sel_ganador').options[1] = new Option(resp[0]['equipo1']);
	document.getElementById('sel_ganador').options[1].value = resp[0]['equipo1'];
	document.getElementById('sel_ganador').options[2] = new Option(resp[0]['equipo2']);
	document.getElementById('sel_ganador').options[2].value = resp[0]['equipo2'];
	
	if (modificar) {
		document.getElementById('sel_estatus').value = resp[0]['estado_res'];
		if (resp[0]['equipo1'] == resp[0]['ganador'])
			document.getElementById('sel_ganador').options[1].selected = true;
		else if (resp[0]['equipo2'] == resp[0]['ganador'])
			document.getElementById('sel_ganador').options[2].selected = true;
					
		document.getElementById('txt_marcador').value = resp[0]['marcador'];
	}
}

function guardarResultadosBoxeo() {
	var r, mensajeGuardar, marcador;
	var fecha = document.getElementById('fecha').value;
	var encuentro = document.getElementById('sel_encuentro').value;
	var estatus = document.getElementById('sel_estatus').value;
	var ganador = document.getElementById('sel_ganador').value;
	var marcador = document.getElementById('txt_marcador').value;
	var checkMod = document.getElementById('modificar').checked;
	var modificar;
	
	if (checkMod)
		modificar = 1;
	else
		modificar = 0;
	var idEncuentro;
	
	idEncuentro = encuentro.split('||');
	
	mensajeGuardar = '¿Confirma que desea registrar el resultado de la pelea?','si/no';

	if(fecha!=0 && encuentro!=0 && estatus!=0)
	{
		jConfirm(mensajeGuardar, 'Confirmación', function(r){
		if(r)
		{
				AjaxRequest.post(
									{'parameters': {'modificar':modificar,
													'fecha':fecha,
													'id_logro':idEncuentro[0],
													'encuentro':idEncuentro[1],
													'estatus':estatus,
													'ganador':ganador,
													'marcador':marcador,
													'accion':'guardarResultadoBoxeo'
												   	}
													,'onSuccess':function(req){verificarResultadosBoxeo(req)}
													,'url':'sistema/procesos/transaccion/trans_resultados.php'
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

function verificarResultadosBoxeo(req)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != false)
	{
		jAlert('Se ha registrado correctamente el resultado', 'Información');
		cambiar_contenido('sistema/procesos/resultados_boxeo.php', 'sub_contenido');
	}
	else
	{
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}

// FORMULA 1

function cargarEncuentrosFormula1() {
	var fecha = document.getElementById('fecha').value;
	var checkMod = document.getElementById('modificar').checked;
	var modificar;
	if (checkMod)
		modificar = 1;
	else
		modificar = 0;
	AjaxRequest.post
						(
							{'parameters':{		'modificar':modificar,
												'fecha':fecha,
												'accion':'buscarEncuentrosFormula1'
												}
												,'onSuccess':respCargarEncuentrosFormula1
												,'url':'sistema/procesos/transaccion/trans_resultados.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respCargarEncuentrosFormula1(req)
{
	var resp = eval ("("+ req.responseText +")");
	var fecha = document.getElementById('fecha');
	if (resp !="") {
		document.getElementById('sel_encuentro').options.length = 0;
		document.getElementById('sel_encuentro').options[0] = new Option('Seleccione..');
		document.getElementById('sel_encuentro').options[0].value = '0';
		document.getElementById('sel_encuentro').options[0].selected = true;
		
		for(var i=1,j=0; i<=resp.length; i++,j++)
		{
			document.getElementById('sel_encuentro').options[i] = new Option(resp[j]['encuentro']+' - ('+resp[j]['nombre']+')');
			document.getElementById('sel_encuentro').options[i].value = resp[j]['codigo']+'||'+resp[j]['encuentro'];
			document.getElementById('sel_encuentro').options[i].title = "Id: "+resp[j]['codigo'];
		}
	} else {
		jAlert('No existen encuentros registrados para la fecha seleccionada ('+fecha.value+')', 'Información');
		fecha.value = 0;
		return;
	}
}

function datosEncuentroFormula1()
{
	var checkMod = document.getElementById('modificar').checked;
	var modificar;
	if (checkMod)
		modificar = 1;
	else
		modificar = 0;
	var encuentro = document.getElementById('sel_encuentro').value;
	var idEncuentro;
	idEncuentro = encuentro.split('||');
	AjaxRequest.post
						(
							{'parameters':{		'modificar':modificar,
												'id_encuentro':idEncuentro[0],
												'accion':'mostrarEncuentroFormula1'
												}
												,'onSuccess':respDatosEncuentroFormula1
												,'url':'sistema/procesos/transaccion/trans_resultados.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respDatosEncuentroFormula1(req)
{
	var modificar = document.getElementById('modificar').checked;
	var marcador;
	var resp = eval ("("+ req.responseText +")");

	document.getElementById('sel_ganador').options.length = 0;
	document.getElementById('sel_ganador').options[0] = new Option('Seleccione..');
	document.getElementById('sel_ganador').options[0].value = '0';
	document.getElementById('sel_ganador').options[0].selected = true;

	for(var i=1; i<=24; i++)
	{
		var valor = 'equipo'+i;
		document.getElementById('sel_ganador').options[i] = new Option(resp[0][valor]);
		document.getElementById('sel_ganador').options[i].value = resp[0][valor];
	}
	
	if (modificar) {
		document.getElementById('sel_estatus').value = resp[0]['estado_res'];		
		for(var i=1; i<=24; i++)
		{
			var valor = 'equipo'+i;
			if (resp[0][valor] == resp[0]['ganador'])
				document.getElementById('sel_ganador').options[i].selected = true;
		}
		document.getElementById('txt_marcador').value = resp[0]['tiempo'];
	}
}

function guardarResultadosFormula1() {
	var r, mensajeGuardar, marcador;
	var fecha = document.getElementById('fecha').value;
	var encuentro = document.getElementById('sel_encuentro').value;
	var estatus = document.getElementById('sel_estatus').value;
	var ganador = document.getElementById('sel_ganador').value;
	var marcador = document.getElementById('txt_marcador').value;
	var checkMod = document.getElementById('modificar').checked;
	var modificar;
	
	if (checkMod)
		modificar = 1;
	else
		modificar = 0;
	var idEncuentro;
	
	idEncuentro = encuentro.split('||');
	
	mensajeGuardar = '¿Confirma que desea registrar el resultado de la carrera?','si/no';

	if(fecha!=0 && encuentro!=0 && estatus!=0)
	{
		jConfirm(mensajeGuardar, 'Confirmación', function(r){
		if(r)
		{
				AjaxRequest.post(
									{'parameters': {'modificar':modificar,
													'fecha':fecha,
													'id_logro':idEncuentro[0],
													'encuentro':idEncuentro[1],
													'estatus':estatus,
													'ganador':ganador,
													'marcador':marcador,
													'accion':'guardarResultadoFormula1'
												   	}
													,'onSuccess':function(req){verificarResultadosFormula1(req)}
													,'url':'sistema/procesos/transaccion/trans_resultados.php'
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

function verificarResultadosFormula1(req)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != false)
	{
		jAlert('Se ha registrado correctamente el resultado', 'Información');
		cambiar_contenido('sistema/procesos/resultados_formula1.php', 'sub_contenido');
	}
	else
	{
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}

function calculaResBeisbol() {
	var ganador = document.getElementById('sel_ganador');
	var favorito = document.getElementById('favorito').value;
	var runline = document.getElementById('sel_runline');
	var vrunline = document.getElementById('v_runline').value;
	var srunline = document.getElementById('sel_srunline');
	var vsrunline = document.getElementById('v_srunline').value;
	var marcador1 = document.getElementById('marcador1').value;
	var marcador2 = document.getElementById('marcador2').value;
	var difRes1 = parseInt(marcador1) - parseInt(marcador2);
	var difRes2 = parseInt(marcador2) - parseInt(marcador1);
	
	if (vrunline == '') {
		jAlert('Debe seleccionar el encuentro', 'Información');
		return;
	}
	
	if (parseInt(marcador1) > parseInt(marcador2))
		ganador.options[1].selected = true;
	else if (parseInt(marcador2) > parseInt(marcador1))
		ganador.options[2].selected = true;
	else
		ganador.options[0].selected = true;
	
	if (parseInt(marcador1) > parseInt(marcador2) && favorito==2)
		runline.options[1].selected = true;	
	else if (parseInt(marcador1) < parseInt(marcador2) && favorito==1)
		runline.options[2].selected = true;
	else if (parseInt(marcador1) < parseInt(marcador2) && favorito==2 && parseInt(difRes2)>parseFloat(vrunline))
		runline.options[2].selected = true;
	else if (parseInt(marcador1) > parseInt(marcador2) && favorito==1 && parseInt(difRes1)<parseFloat(vrunline))
		runline.options[2].selected = true;
	else if (parseInt(marcador1) > parseInt(marcador2) && favorito==1 && parseInt(difRes1)>parseFloat(vrunline))
		runline.options[1].selected = true;
	else if (parseInt(marcador1) < parseInt(marcador2) && favorito==2 && parseInt(difRes2)<parseFloat(vrunline))
		runline.options[1].selected = true;
	else
		runline.options[0].selected = true;
		
	if (parseInt(marcador1) > parseInt(marcador2) && favorito==2)
		srunline.options[1].selected = true;	
	else if (parseInt(marcador1) < parseInt(marcador2) && favorito==1)
		srunline.options[2].selected = true;
	else if (parseInt(marcador1) < parseInt(marcador2) && favorito==2 && parseInt(difRes2)>parseFloat(vsrunline))
		srunline.options[2].selected = true;
	else if (parseInt(marcador1) > parseInt(marcador2) && favorito==1 && parseInt(difRes1)<parseFloat(vsrunline))
		srunline.options[2].selected = true;
	else if (parseInt(marcador1) > parseInt(marcador2) && favorito==1 && parseInt(difRes1)>parseFloat(vsrunline))
		srunline.options[1].selected = true;
	else if (parseInt(marcador1) < parseInt(marcador2) && favorito==2 && parseInt(difRes2)<parseFloat(vsrunline))
		srunline.options[1].selected = true;
	else
		srunline.options[0].selected = true;
}

function calculaResBeisbolMitad() {
	var ganador_mitad = document.getElementById('sel_ganador_mitad');
	var favorito = document.getElementById('favorito').value;
	var runlinem = document.getElementById('sel_runlinem');
	var vrunlinem = document.getElementById('v_runlinem').value;
	var marcadorm1 = document.getElementById('marcadorm1').value;
	var marcadorm2 = document.getElementById('marcadorm2').value;
	var difResm1 = parseInt(marcadorm1) - parseInt(marcadorm2);
	var difResm2 = parseInt(marcadorm2) - parseInt(marcadorm1);
	
	if (vrunlinem == '') {
		jAlert('Debe seleccionar el encuentro', 'Información');
		return;
	}
	
	if (parseInt(marcadorm1) > parseInt(marcadorm2))
		ganador_mitad.options[1].selected = true;
	else if (parseInt(marcadorm2) > parseInt(marcadorm1))
		ganador_mitad.options[2].selected = true;
	else
		ganador_mitad.options[3].selected = true;
	
	if (parseInt(marcadorm1) > parseInt(marcadorm2) && favorito==2)
		runlinem.options[1].selected = true;	
	else if (parseInt(marcadorm1) < parseInt(marcadorm2) && favorito==1)
		runlinem.options[2].selected = true;
	else if (parseInt(marcadorm1) < parseInt(marcadorm2) && favorito==2 && parseInt(difResm2)>parseFloat(vrunlinem))
		runlinem.options[2].selected = true;
	else if (parseInt(marcadorm1) > parseInt(marcadorm2) && favorito==1 && parseInt(difResm1)<parseFloat(vrunlinem))
		runlinem.options[2].selected = true;
	else if (parseInt(marcadorm1) > parseInt(marcadorm2) && favorito==1 && parseInt(difResm1)>parseFloat(vrunlinem))
		runlinem.options[1].selected = true;
	else if (parseInt(marcadorm1) < parseInt(marcadorm2) && favorito==2 && parseInt(difResm2)<parseFloat(vrunlinem))
		runlinem.options[1].selected = true;
	else if (parseInt(marcadorm1) == parseInt(marcadorm2) && favorito==1)
		runlinem.options[2].selected = true;
	else if (parseInt(marcadorm1) == parseInt(marcadorm2) && favorito==2)
		runlinem.options[1].selected = true;
}

function calculaResBasquetbol() {
	var ganador = document.getElementById('sel_ganador');
	var favorito = document.getElementById('favorito').value;
	var runline = document.getElementById('sel_runline');
	var vrunline = document.getElementById('v_runline').value;
	var marcador1 = document.getElementById('marcador1').value;
	var marcador2 = document.getElementById('marcador2').value;
	var difRes1 = parseInt(marcador1) - parseInt(marcador2);
	var difRes2 = parseInt(marcador2) - parseInt(marcador1);
	
	if (vrunline == '') {
		jAlert('Debe seleccionar el encuentro', 'Información');
		return;
	}
	
	if (parseInt(marcador1) > parseInt(marcador2))
		ganador.options[1].selected = true;
	else if (parseInt(marcador2) > parseInt(marcador1))
		ganador.options[2].selected = true;
	else
		ganador.options[0].selected = true;
	
	if (parseInt(marcador1) > parseInt(marcador2) && favorito==2)
		runline.options[1].selected = true;	
	else if (parseInt(marcador1) < parseInt(marcador2) && favorito==1)
		runline.options[2].selected = true;
	else if (parseInt(marcador1) < parseInt(marcador2) && favorito==2 && parseInt(difRes2)>parseFloat(vrunline))
		runline.options[2].selected = true;
	else if (parseInt(marcador1) > parseInt(marcador2) && favorito==1 && parseInt(difRes1)<parseFloat(vrunline))
		runline.options[2].selected = true;
	else if (parseInt(marcador1) > parseInt(marcador2) && favorito==1 && parseInt(difRes1)>parseFloat(vrunline))
		runline.options[1].selected = true;
	else if (parseInt(marcador1) < parseInt(marcador2) && favorito==2 && parseInt(difRes2)<parseFloat(vrunline))
		runline.options[1].selected = true;
	else
		runline.options[3].selected = true;
}

function calculaResBasquetbolMitad() {
	var ganador_mitad = document.getElementById('sel_ganadorm');
	var favorito = document.getElementById('favorito').value;
	var runlinem = document.getElementById('sel_runlinem');
	var vrunlinem = document.getElementById('v_runlinem').value;
	var marcadorm1 = document.getElementById('marcadorm1').value;
	var marcadorm2 = document.getElementById('marcadorm2').value;
	var difResm1 = parseInt(marcadorm1) - parseInt(marcadorm2);
	var difResm2 = parseInt(marcadorm2) - parseInt(marcadorm1);
	
	if (vrunlinem == '') {
		jAlert('Debe seleccionar el encuentro', 'Información');
		return;
	}
	
	if (parseInt(marcadorm1) > parseInt(marcadorm2))
		ganador_mitad.options[1].selected = true;
	else if (parseInt(marcadorm2) > parseInt(marcadorm1))
		ganador_mitad.options[2].selected = true;
	else
		ganador_mitad.options[3].selected = true;
	
	if (parseInt(marcadorm1) > parseInt(marcadorm2) && favorito==2)
		runlinem.options[1].selected = true;	
	else if (parseInt(marcadorm1) < parseInt(marcadorm2) && favorito==1)
		runlinem.options[2].selected = true;
	else if (parseInt(marcadorm1) < parseInt(marcadorm2) && favorito==2 && parseInt(difResm2)>parseFloat(vrunlinem))
		runlinem.options[2].selected = true;
	else if (parseInt(marcadorm1) > parseInt(marcadorm2) && favorito==1 && parseInt(difResm1)<parseFloat(vrunlinem))
		runlinem.options[2].selected = true;
	else if (parseInt(marcadorm1) > parseInt(marcadorm2) && favorito==1 && parseInt(difResm1)>parseFloat(vrunlinem))
		runlinem.options[1].selected = true;
	else if (parseInt(marcadorm1) < parseInt(marcadorm2) && favorito==2 && parseInt(difResm2)<parseFloat(vrunlinem))
		runlinem.options[1].selected = true;
	else if (parseInt(marcadorm1) == parseInt(marcadorm2) && favorito==1)
		runlinem.options[2].selected = true;
	else if (parseInt(marcadorm1) == parseInt(marcadorm2) && favorito==2)
		runlinem.options[1].selected = true;
	else
		runlinem.options[3].selected = true;
}

function calculaResFutbol() {
	var ganador = document.getElementById('sel_ganador');
	var favorito = document.getElementById('favorito').value;
	var runline = document.getElementById('sel_runline');
	var vrunline = document.getElementById('v_runline').value;
	var marcador1 = document.getElementById('marcador1').value;
	var marcador2 = document.getElementById('marcador2').value;
	var difRes1 = parseInt(marcador1) - parseInt(marcador2);
	var difRes2 = parseInt(marcador2) - parseInt(marcador1);
	
	if (vrunline == '') {
		jAlert('Debe seleccionar el encuentro', 'Información');
		return;
	}
	
	if (parseInt(marcador1) > parseInt(marcador2))
		ganador.options[1].selected = true;
	else if (parseInt(marcador2) > parseInt(marcador1))
		ganador.options[2].selected = true;
	else if (parseInt(marcador2) == parseInt(marcador1))
		ganador.options[3].selected = true;
	else
		ganador.options[0].selected = true;
	
	if (parseInt(marcador1) > parseInt(marcador2) && favorito==2)
		runline.options[1].selected = true;	
	else if (parseInt(marcador1) < parseInt(marcador2) && favorito==1)
		runline.options[2].selected = true;
	else if (parseInt(marcador1) < parseInt(marcador2) && favorito==2 && parseInt(difRes2)>parseFloat(vrunline))
		runline.options[2].selected = true;
	else if (parseInt(marcador1) > parseInt(marcador2) && favorito==1 && parseInt(difRes1)<parseFloat(vrunline))
		runline.options[2].selected = true;
	else if (parseInt(marcador1) > parseInt(marcador2) && favorito==1 && parseInt(difRes1)>parseFloat(vrunline))
		runline.options[1].selected = true;
	else if (parseInt(marcador1) < parseInt(marcador2) && favorito==2 && parseInt(difRes2)<parseFloat(vrunline))
		runline.options[1].selected = true;
	else if (parseInt(marcador1) == parseInt(marcador2) && favorito==1)
		runline.options[2].selected = true;
	else if (parseInt(marcador1) == parseInt(marcador2) && favorito==2)
		runline.options[1].selected = true;
	else
		runline.options[3].selected = true;
}

function calculaResFutbolAmericano() {
	var ganador = document.getElementById('sel_ganador');
	var favorito = document.getElementById('favorito').value;
	var runline = document.getElementById('sel_runline');
	var vrunline = document.getElementById('v_runline').value;
	var marcador1 = document.getElementById('marcador1').value;
	var marcador2 = document.getElementById('marcador2').value;
	var difRes1 = parseInt(marcador1) - parseInt(marcador2);
	var difRes2 = parseInt(marcador2) - parseInt(marcador1);
	
	if (vrunline == '') {
		jAlert('Debe seleccionar el encuentro', 'Información');
		return;
	}
	
	if (parseInt(marcador1) > parseInt(marcador2))
		ganador.options[1].selected = true;
	else if (parseInt(marcador2) > parseInt(marcador1))
		ganador.options[2].selected = true;
	else
		ganador.options[0].selected = true;
	
	if (parseInt(marcador1) > parseInt(marcador2) && favorito==2)
		runline.options[1].selected = true;	
	else if (parseInt(marcador1) < parseInt(marcador2) && favorito==1)
		runline.options[2].selected = true;
	else if (parseInt(marcador1) < parseInt(marcador2) && favorito==2 && parseInt(difRes2)>parseFloat(vrunline))
		runline.options[2].selected = true;
	else if (parseInt(marcador1) > parseInt(marcador2) && favorito==1 && parseInt(difRes1)<parseFloat(vrunline))
		runline.options[2].selected = true;
	else if (parseInt(marcador1) > parseInt(marcador2) && favorito==1 && parseInt(difRes1)>parseFloat(vrunline))
		runline.options[1].selected = true;
	else if (parseInt(marcador1) < parseInt(marcador2) && favorito==2 && parseInt(difRes2)<parseFloat(vrunline))
		runline.options[1].selected = true;
	else if (parseInt(marcador1) == parseInt(marcador2) && favorito==1)
		runline.options[2].selected = true;
	else if (parseInt(marcador1) == parseInt(marcador2) && favorito==2)
		runline.options[1].selected = true;
	else
		runline.options[3].selected = true;
}

function calculaResHockey() {
	var ganador = document.getElementById('sel_ganador');
	var favorito = document.getElementById('favorito').value;
	var runline = document.getElementById('sel_runline');
	var vrunline = document.getElementById('v_runline').value;
	var marcador1 = document.getElementById('marcador1').value;
	var marcador2 = document.getElementById('marcador2').value;
	var difRes1 = parseInt(marcador1) - parseInt(marcador2);
	var difRes2 = parseInt(marcador2) - parseInt(marcador1);
	
	if (vrunline == '') {
		jAlert('Debe seleccionar el encuentro', 'Información');
		return;
	}
	
	if (parseInt(marcador1) > parseInt(marcador2))
		ganador.options[1].selected = true;
	else if (parseInt(marcador2) > parseInt(marcador1))
		ganador.options[2].selected = true;
	else
		ganador.options[0].selected = true;
	
	if (parseInt(marcador1) > parseInt(marcador2) && favorito==2)
		runline.options[1].selected = true;	
	else if (parseInt(marcador1) < parseInt(marcador2) && favorito==1)
		runline.options[2].selected = true;
	else if (parseInt(marcador1) < parseInt(marcador2) && favorito==2 && parseInt(difRes2)>parseFloat(vrunline))
		runline.options[2].selected = true;
	else if (parseInt(marcador1) > parseInt(marcador2) && favorito==1 && parseInt(difRes1)<parseFloat(vrunline))
		runline.options[2].selected = true;
	else if (parseInt(marcador1) > parseInt(marcador2) && favorito==1 && parseInt(difRes1)>parseFloat(vrunline))
		runline.options[1].selected = true;
	else if (parseInt(marcador1) < parseInt(marcador2) && favorito==2 && parseInt(difRes2)<parseFloat(vrunline))
		runline.options[1].selected = true;
	else if (parseInt(marcador1) == parseInt(marcador2) && favorito==1)
		runline.options[2].selected = true;
	else if (parseInt(marcador1) == parseInt(marcador2) && favorito==2)
		runline.options[1].selected = true;
}