function guardarApuesta()
{
	var r, mensajeGuardar;
	var tipo = document.getElementById('tipo').value;
	var monto = document.getElementById('monto').value;
	var montos_max = document.getElementById('premio_max').value;
	var premio = document.getElementById('premio').value;
	var cadenaLogros = contarLogros(0);
	var logro = cadenaLogros.split('||');
	var cantLogros = logro[0];
	var detallesLogros = contarLogros(1);
	var	totalPagar = calcularApuestaGuardar();
	
	var maxi = montos_max.split('||');
	var premio_max = maxi[0];
	var montoMaxParley = maxi[1];
	var montoMaxDerecho = maxi[2];
	var montoMin = maxi[3];
	
	if (parseInt(cantLogros) > 8) {
		jAlert("Ha superado el límite de la apuesta. Máximo 8 logros", 'Notificación');
		return;
	}
	if (monto < parseInt(montoMin)) {
		jAlert("El monto mínimo de la apuesta es de "+montoMin+" BsF.", 'Notificación');
		return;
	}
	if ((parseInt(cantLogros) < 1) && (tipo == 'POR DERECHO')) {
		jAlert("Debe seleccionar por lo menos un (1) logro para registrar la apuesta por derecho", 'Notificación');
		return;
	}
	if ((parseInt(cantLogros) > 1) && (tipo == 'POR DERECHO')) {
		jAlert("Debe seleccionar sólo una (1) jugada para registrar la apuesta por derecho", 'Notificación');
		return;
	}
	if ((parseInt(cantLogros) < 3) && (tipo == 'PARLEY')) {
		jAlert("Debe seleccionar por lo menos tres (3) logros para registrar la apuesta", 'Notificación');
		return;
	}
	if (parseFloat(totalPagar) != parseFloat(premio))
	{
		jAlert("Debe generar el total a pagar para continuar", 'Notificación');
		return;
	}
	if ((tipo == 'PARLEY') && (parseFloat(monto) > parseFloat(montoMaxParley)) && (parseFloat(montoMaxParley) != 0)) {
		jAlert("El monto máximo de la apuesta tipo parley es de "+montoMaxParley+" BsF.", 'Notificación');
		return;
	}
	if ((tipo == 'POR DERECHO') && (parseFloat(monto) > parseFloat(montoMaxDerecho)) && (parseFloat(montoMaxDerecho) != 0)) {
		jAlert("El monto máximo de la apuesta por derecho es de "+montoMaxDerecho+" BsF.", 'Notificación');
		return;
	}
	
	mensajeGuardar = '¿Desea confirmar el registro de la apuesta?','si/no';
	
	if(monto!="" && premio!="")
	{
		jConfirm(mensajeGuardar, 'Confirmación', function(r){
		if(r)
		{
				AjaxRequest.post(
									{'parameters': {'tipo':tipo,
													'monto':monto,
													'premio':premio,
													'cadenaLogros':cadenaLogros,
													'detallesLogros':detallesLogros,
													'accion':'registrarApuesta'
												   	}
													,'onSuccess':function(req){verificarTransaccionApuesta(req)}
													,'url':'sistema/apuestas/transaccion/trans_apuestas.php'
													,'onError': function(req)
													{
														alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
													}
									}
								);
			}
		} );
	} else {
		jAlert('Debe introducir y calcular el monto de la apuesta. Por favor verifique antes de continuar', 'Información');
	}
}

function verificarTransaccionApuesta(req)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != false)
	{
		limpiarApuesta();
		openMyModal('sistema/apuestas/ticket.php?id='+resp[0]['id']);
	}
	else
	{
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}

function limpiarApuesta()
{
	num = 0;
	cambiar_contenido("sistema/apuestas/apuestas.php", 'contenido');
	
}

function buscarInfoEnterMonto(e, operacion)
{
	var code;
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	if (code == 13) {
		if(operacion=='calcularApuesta')
		{
			calcularApuesta();
		}
	}
}

function calcularApuesta()
{
	var monto = document.getElementById('monto').value;
	var montoTotal = document.getElementById('monto_total');
	var premio = document.getElementById('premio');
	var montos_max = document.getElementById('premio_max').value;
	var montoGanApu = document.getElementById('gan_apu');
	var tipoApu = document.getElementById('tipo').value;
	var cadenaLogros = contarLogros(0);
	var logro = cadenaLogros.split('||');
	var cantLogros = logro[0];
	var ganancia = 0;
	var apuesta = monto;
	
	var maxi = montos_max.split('||');
	var premio_max = maxi[0];
	var montoMaxParley = maxi[1];
	var montoMaxDerecho = maxi[2];
	var montoMin = maxi[3];
	
	/*if (monto == '') {
		jAlert("Debe introducir el monto de la apuesta", 'Notificación');
		return;
	}
	if (monto < parseInt(montoMin)) {
		jAlert("El monto mínimo de la apuesta es de "+montoMin+" BsF.", 'Notificación');
		return;
	}*/
	
	if (parseInt(cantLogros) > 8)
	{
		jAlert("Ha superado el límite de la apuesta. Máximo 8 logros", 'Notificación');
		return;
	}
	
	if ((tipoApu == 'PARLEY') && (parseFloat(monto) > parseFloat(montoMaxParley)) && (parseFloat(montoMaxParley) != 0)) {
		jAlert("El monto máximo de la apuesta tipo parley es de "+montoMaxParley+" BsF.", 'Notificación');
		return;
	}
	
	if ((tipoApu == 'POR DERECHO') && (parseFloat(monto) > parseFloat(montoMaxDerecho)) && (parseFloat(montoMaxDerecho) != 0)) {
		jAlert("El monto máximo de la apuesta por derecho es de "+montoMaxDerecho+" BsF.", 'Notificación');
		return;
	}
	
	for(var i=1; i<=cantLogros; i++)
	{
		if (parseFloat(logro[i]) < 0)
		{
			ganancia = parseFloat(apuesta) - (parseFloat(apuesta) * (100/parseFloat(logro[i])));
		}
		else if (parseFloat(logro[i]) > 0)
		{
			ganancia = parseFloat(apuesta) + (parseFloat(apuesta) * (parseFloat(logro[i]))/100);
		}
		apuesta = ganancia;
	}
	if (ganancia > parseFloat(premio_max) && (parseFloat(premio_max) != 0)) {
		ganancia = parseFloat(premio_max);
		//jAlert("Ha superado el monto máximo del premio ("+premio_max+" BsF)\nSe recomienda apostar menos dinero", 'Notificación');
	}
	var montoApuesta = parseFloat(monto);
	var montoGanancia = ganancia - montoApuesta;
	montoGanApu.innerHTML = montoGanancia.toFixed(2)+' + '+montoApuesta.toFixed(2);
	montoTotal.innerHTML = ganancia.toFixed(2)+' BsF';
	premio.value = ganancia.toFixed(2);
}

function contarLogros(detalles) {
	var fBoleto = document.getElementById('listaLogros');
	var logro, cadena, listaLogros='';
	var totReg = fBoleto.elements.length;
	
	if (detalles == 0) {
		for (var i=0; i<totReg; i++) {
			logro = fBoleto.elements[i].value.split('||');
			listaLogros += '||'+logro[0];
		}
	}
	else if (detalles == 1) {
		for (var i=0; i<totReg; i++) {
			logro = fBoleto.elements[i].value.split('||');
			listaLogros += '||'+logro[1];
		}
	}
	cadena = totReg+listaLogros;
	return cadena;
}

function cantidadApu() {
	var fBoleto = document.getElementById('listaLogros');
	var totReg = fBoleto.elements.length;
	
	return parseInt(totReg)+1;
}

function calcularApuestaGuardar()
{
	var monto = document.getElementById('monto').value;
	var montos_max = document.getElementById('premio_max').value;
	var cadenaLogros = contarLogros(0);
	var logro = cadenaLogros.split('||');
	var cantLogros = logro[0];
	var ganancia = 0;
	var apuesta = monto;
	
	var maxi = montos_max.split('||');
	var premio_max = maxi[0];
	
	for(var i=1; i<=cantLogros; i++)
	{
		if (parseFloat(logro[i]) < 0)
		{
			ganancia = parseFloat(apuesta) - (parseFloat(apuesta) * (100/parseFloat(logro[i])));
		}
		else if (parseFloat(logro[i]) > 0)
		{
			ganancia = parseFloat(apuesta) + (parseFloat(apuesta) * (parseFloat(logro[i]))/100);
		}
		apuesta = ganancia;
	}
	if (ganancia > parseFloat(premio_max) && (parseFloat(premio_max) != 0))
		ganancia = parseFloat(premio_max);
	return ganancia.toFixed(2);
}

function hora_servidor()
{	
	AjaxRequest.post({	'parameters': {
							'accion':'actualizarHora'
						},			
						'onSuccess': function(req){verificarHoraServidor(req)},
						'url': 'sistema/apuestas/transaccion/trans_apuestas.php',
						'onError': function(req){
							alert('Error!\nStatusText=' + req.statusText + '\nContents=' + req.responseText);
		}
	});
}

function verificarHoraServidor(req) {
	var resp = eval ("("+ req.responseText +")");
	var hora_actual = document.getElementById('hora_actual');
	hora_actual.value = resp;
}

function verificarJugadasCargadas(id_deporte, id_logro, campo_logro) {
	var fBoleto = document.getElementById('listaLogros');
	var logro, cadena, valor, detalle, listaDetalle='', listaLogros='';
	var logroCargar = id_deporte+'.'+id_logro+'.'+campo_logro;
	var totReg = fBoleto.elements.length;
	
	logroCargar = logroCargar.substring(0, logroCargar.length-1);
	
	for (var i=0; i<totReg; i++) {
		logro = fBoleto[i].value.split('||');
		listaLogros += '||'+logro[1];
	}
	
	cadena = totReg+listaLogros;
	valor = cadena.split('||');
	
	for(var i=1; i<=valor[0]; i++) {
		detalle = valor[i].split('.');
		listaDetalle += detalle[0]+'.'+detalle[1]+'.'+detalle[2]+'||';
	}
	
	var combinacion = true;
	var jugada = campo_logro.substring(0, campo_logro.length-1);
	
	switch(id_deporte) {
		case '1':
			var cadJugada = id_deporte+'.'+id_logro+'.';
			var combNoPermi;
			var apuNoPermi;
			
			if (jugada == 'ganador') {
				combNoPermi = cadJugada+'runline||'+cadJugada+'g_mediojuego||'+cadJugada+'ab_mediojuego||'+cadJugada+'srunline||'+cadJugada+'runlinem||';
			}
			if (jugada == 'runline') {
				combNoPermi = cadJugada+'ganador||'+cadJugada+'g_mediojuego||'+cadJugada+'srunline||'+cadJugada+'runlinem||'+cadJugada+'ab_mediojuego||';
			}
			if (jugada == 'srunline') {
				combNoPermi = cadJugada+'ganador||'+cadJugada+'g_mediojuego||'+cadJugada+'runline||'+cadJugada+'runlinem||'+cadJugada+'ab_mediojuego||';
			}
			if (jugada == 'altabaja') {
				combNoPermi = cadJugada+'g_mediojuego||'+cadJugada+'ab_mediojuego||'+cadJugada+'p_inning||'+cadJugada+'runlinem||';
			}
			if (jugada == 'g_mediojuego') {
				combNoPermi = cadJugada+'ganador||'+cadJugada+'runline||'+cadJugada+'srunline||'+cadJugada+'runlinem||'+cadJugada+'altabaja||';
			}
			if (jugada == 'runlinem') {
				combNoPermi = cadJugada+'ganador||'+cadJugada+'g_mediojuego||'+cadJugada+'runline||'+cadJugada+'srunline||'+cadJugada+'altabaja||'+cadJugada+'ab_mediojuego||';
			}
			if (jugada == 'ab_mediojuego') {
				combNoPermi = cadJugada+'ganador||'+cadJugada+'altabaja||'+cadJugada+'p_inning||'+cadJugada+'srunline||'+cadJugada+'runline||';
			}
			if (jugada == 'p_inning') {
				combNoPermi = cadJugada+'altabaja||'+cadJugada+'ab_mediojuego||';
			}
			if (jugada == 'p_anotar') {
				combNoPermi = '';
			}
			
			apuNoPermi = combNoPermi.split('||');
			
			for (var i=0; i<apuNoPermi.length-1; i++) {
				if (listaDetalle.indexOf(apuNoPermi[i]) != -1) {
					combinacion = false;
				}
			}
		break;
		
		case '2':
			var cadJugada = id_deporte+'.'+id_logro+'.';
			var combNoPermi;
			var apuNoPermi;
			
			if (jugada == 'ganador') {
				combNoPermi = cadJugada+'runline||'+cadJugada+'ganadorm||'+cadJugada+'runlinem||';
			}
			if (jugada == 'runline') {
				combNoPermi = cadJugada+'ganador||'+cadJugada+'ganadorm||'+cadJugada+'runlinem||';
			}
			if (jugada == 'altabaja') {
				combNoPermi = cadJugada+'altabam||';
			}
			if (jugada == 'ganadorm') {
				combNoPermi = cadJugada+'runline||'+cadJugada+'ganador||'+cadJugada+'runlinem||';
			}
			if (jugada == 'runlinem') {
				combNoPermi = cadJugada+'ganador||'+cadJugada+'runline||'+cadJugada+'ganadorm||';
			}
			if (jugada == 'altabajam') {
				combNoPermi = cadJugada+'altaba||';
			}
			
			apuNoPermi = combNoPermi.split('||');
			
			for (var i=0; i<apuNoPermi.length-1; i++) {
				if (listaDetalle.indexOf(apuNoPermi[i]) != -1) {
					combinacion = false;
				}
			}
		break;
		
		case '3':
			var cadJugada = id_deporte+'.'+id_logro+'.';
			var combNoPermi;
			var apuNoPermi;
			
			if (jugada == 'ganador') {
				combNoPermi = cadJugada+'runline||'+cadJugada+'empate||';
			}
			if (jugada == 'empat') {
				combNoPermi = cadJugada+'ganador||'+cadJugada+'runline||';
			}
			if (jugada == 'runline') {
				combNoPermi = cadJugada+'ganador||'+cadJugada+'empate||';
			}
			if (jugada == 'altabaja') {
				combNoPermi = '';
			}
			
			apuNoPermi = combNoPermi.split('||');
			
			for (var i=0; i<apuNoPermi.length-1; i++) {
				if (listaDetalle.indexOf(apuNoPermi[i]) != -1) {
					combinacion = false;
				}
			}
		break;
		
		case '4':
			var cadJugada = id_deporte+'.'+id_logro+'.';
			var combNoPermi;
			var apuNoPermi;
			
			if (jugada == 'ganador') {
				combNoPermi = cadJugada+'runline||';
			}
			if (jugada == 'runline') {
				combNoPermi = cadJugada+'ganador||';
			}
			if (jugada == 'altabaja') {
				combNoPermi = '';
			}
			
			apuNoPermi = combNoPermi.split('||');
			
			for (var i=0; i<apuNoPermi.length-1; i++) {
				if (listaDetalle.indexOf(apuNoPermi[i]) != -1) {
					combinacion = false;
				}
			}
		break;
		
		case '5':
			var cadJugada = id_deporte+'.'+id_logro+'.';
			var combNoPermi;
			var apuNoPermi;
			
			if (jugada == 'ganador') {
				combNoPermi = cadJugada+'runline||';
			}
			if (jugada == 'runline') {
				combNoPermi = cadJugada+'ganador||';
			}
			if (jugada == 'altabaja') {
				combNoPermi = '';
			}
			
			apuNoPermi = combNoPermi.split('||');
			
			for (var i=0; i<apuNoPermi.length-1; i++) {
				if (listaDetalle.indexOf(apuNoPermi[i]) != -1) {
					combinacion = false;
				}
			}
		break;
	}
	
	if (listaDetalle.indexOf(logroCargar) != -1)
	{
		jAlert("La jugada seleccionada no es válida", 'Notificación');
		return;
	}
	else if (combinacion == false && parseInt(totReg) > 0)
	{
		jAlert("La combinación no está permitida", 'Notificación');
		return;
	}
	else if (combinacion == true)
	{
		return true;
	}
}

//------------------------------------ | Cargar Logros | ---------------------------------//
var num = 0;

function cargar_logro(equipo, descripcion, logro, id_deporte, id_logro, campo_logro, id_act, id_des, i)
{
	hora_servidor();
	var hora_actual = document.getElementById('hora_actual').value;
	var hora_logro = document.getElementById('hora_logro'+i).value;
	var colorApu = '#FF3';
	var fondoApu = '#6FA144';
	
	if(hora_actual >= hora_logro) {
		jAlert("El encuentro ha iniciado. No puede seleccionar la jugada", 'Notificación');
		return;
	}
	
	var jugadaValida = verificarJugadasCargadas(id_deporte, id_logro, campo_logro);

	if (jugadaValida) {
		var montoTotal  = document.getElementById('monto_total');
		var montoGanApu = document.getElementById('gan_apu');
		var premio = document.getElementById('premio');
		montoGanApu.innerHTML = '<br>';
		montoTotal.innerHTML = '';
		premio.value = '';
		num++;
		
		if (parseInt(cantidadApu()) > 8) {
			jAlert("Ha superado el límite de la apuesta. Máximo 8 logros", 'Notificación');
			calcularApuesta();
			return;
		}
		
		var linkDes = document.getElementById(id_des);
		linkDes.style.color = colorApu;
		linkDes.style.backgroundColor = fondoApu;
		
		fi = document.getElementById('lista_apuestas');
		contenedor = document.createElement('tr');
		contenedor.id = 'tr'+num;
		fi.appendChild(contenedor);
		
		contenedor = document.createElement('td');
		contenedor.id = 'td1'+num;
		contenedor.innerHTML = equipo;
		contenedor.setAttribute('class', 'fondoFila');
		fi.appendChild(contenedor);
				
		contenedor = document.createElement('td');
		contenedor.id = 'td2'+num;
		contenedor.innerHTML = descripcion;
		contenedor.setAttribute('class', 'fondoFila');
		fi.appendChild(contenedor);
		
		contenedor = document.createElement('td');
		contenedor.id = 'td3'+num;
		contenedor.innerHTML = logro;
		contenedor.setAttribute('class', 'fondoFila');
		contenedor.setAttribute('align', 'center');
		fi.appendChild(contenedor);
		
		contenedor = document.createElement('td');
		contenedor.id = 'td4'+num;
		contenedor.setAttribute('align', 'center');
		contenedor.setAttribute('valign', 'middle');
		contenedor.setAttribute('class', 'fondoFila');
		fi.appendChild(contenedor);

		ele = document.createElement('input');
		ele.type = 'hidden';
		ele.name = 'logro'+num;
		ele.id = 'logro'+num;
		ele.value = logro+'||'+id_deporte+'.'+id_logro+'.'+campo_logro+'.'+equipo+'.'+descripcion+'.'+i;
		contenedor.appendChild(ele);
				
		ele = document.createElement('img');
		ele.src = 'imagenes/borrar.png';
		ele.id = 'borrar'+num;
		ele.name = num;
		ele.setAttribute('title', 'Eliminar Logro');
		ele.setAttribute('align', 'center');
		ele.setAttribute('style', 'cursor: pointer');
		ele.setAttribute('onClick', 'borrar_logro(this.name); desmarcar_apuesta("'+id_act+'", "'+id_des+'");');
		contenedor.setAttribute('class', 'fondoFila');
		contenedor.appendChild(ele);
		
		calcularApuesta();
	}
}

function borrar_logro(num)
{
	var montoTotal  = document.getElementById('monto_total');
	var montoGanApu = document.getElementById('gan_apu');
	var premio = parent.document.getElementById('premio');
	montoGanApu.innerHTML = '<br>';
	montoTotal.innerHTML = '';
	premio.value = '';
	
	var elem1 = document.getElementById('tr'+num);
	var elem2 = document.getElementById('td1'+num);
	var elem3 = document.getElementById('td2'+num);
	var elem4 = document.getElementById('td3'+num);
	var elem5 = document.getElementById('logro'+num);
	var elem6 = document.getElementById('td4'+num);
	var elem7 = document.getElementById('borrar'+num);
	elem7.parentNode.removeChild(elem7);
	elem6.parentNode.removeChild(elem6);
	elem5.parentNode.removeChild(elem5);
	elem4.parentNode.removeChild(elem4);
	elem3.parentNode.removeChild(elem3);
	elem2.parentNode.removeChild(elem2);
	elem1.parentNode.removeChild(elem1);
	num--;
	
	calcularApuesta();
}

function desmarcar_apuesta(id_act, id_des) {
	var linkAct = document.getElementById(id_act);
	var linkDes = document.getElementById(id_des);
	
	linkDes.style.color = '';
	linkAct.style.color = '';
	linkDes.style.backgroundColor = '';
	linkAct.style.backgroundColor = '';			
}

function filtroLogros(deporte)
{
	var logrosBe = document.getElementById('logrosBe');
	var logrosBa = document.getElementById('logrosBa');
	var logrosFu = document.getElementById('logrosFu');
	var logrosFa = document.getElementById('logrosFa');
	var logrosHo = document.getElementById('logrosHo');
	var logrosTe = document.getElementById('logrosTe');
	var logrosBo = document.getElementById('logrosBo');
	var logrosF1 = document.getElementById('logrosF1');
	
	
	switch(deporte) {
		case 'todos':
			logrosBe.style.display = 'block';
			logrosBa.style.display = 'block';
			logrosFu.style.display = 'block';
			logrosFa.style.display = 'block';
			logrosHo.style.display = 'block';
			logrosTe.style.display = 'block';
			logrosBo.style.display = 'block';
			logrosF1.style.display = 'block';
		break;
		
		case 'be':
			logrosBe.style.display = 'block';
			logrosBa.style.display = 'none';
			logrosFu.style.display = 'none';
			logrosFa.style.display = 'none';
			logrosHo.style.display = 'none';
			logrosTe.style.display = 'none';
			logrosBo.style.display = 'none';
			logrosF1.style.display = 'none';
		break;
		
		case 'ba':
			logrosBe.style.display = 'none';
			logrosBa.style.display = 'block';
			logrosFu.style.display = 'none';
			logrosFa.style.display = 'none';
			logrosHo.style.display = 'none';
			logrosTe.style.display = 'none';
			logrosBo.style.display = 'none';
			logrosF1.style.display = 'none';
		break;
		
		case 'fu':
			logrosBe.style.display = 'none';
			logrosBa.style.display = 'none';
			logrosFu.style.display = 'block';
			logrosFa.style.display = 'none';
			logrosHo.style.display = 'none';
			logrosTe.style.display = 'none';
			logrosBo.style.display = 'none';
			logrosF1.style.display = 'none';
		break;

		case 'fa':
			logrosBe.style.display = 'none';
			logrosBa.style.display = 'none';
			logrosFu.style.display = 'none';
			logrosFa.style.display = 'block';
			logrosHo.style.display = 'none';
			logrosTe.style.display = 'none';
			logrosBo.style.display = 'none';
			logrosF1.style.display = 'none';
		break;
		
		case 'ho':
			logrosBe.style.display = 'none';
			logrosBa.style.display = 'none';
			logrosFu.style.display = 'none';
			logrosFa.style.display = 'none';
			logrosHo.style.display = 'block';
			logrosTe.style.display = 'none';
			logrosBo.style.display = 'none';
			logrosF1.style.display = 'none';
		break;
		
		case 'te':
			logrosBe.style.display = 'none';
			logrosBa.style.display = 'none';
			logrosFu.style.display = 'none';
			logrosFa.style.display = 'none';
			logrosHo.style.display = 'none';
			logrosTe.style.display = 'block';
			logrosBo.style.display = 'none';
			logrosF1.style.display = 'none';
		break;
		
		case 'bo':
			logrosBe.style.display = 'none';
			logrosBa.style.display = 'none';
			logrosFu.style.display = 'none';
			logrosFa.style.display = 'none';
			logrosHo.style.display = 'none';
			logrosTe.style.display = 'none';
			logrosBo.style.display = 'block';
			logrosF1.style.display = 'none';
		break;
		
		case 'f1':
			logrosBe.style.display = 'none';
			logrosBa.style.display = 'none';
			logrosFu.style.display = 'none';
			logrosFa.style.display = 'none';
			logrosHo.style.display = 'none';
			logrosTe.style.display = 'none';
			logrosBo.style.display = 'none';
			logrosF1.style.display = 'block';
		break;
	}
}

function cambiacolor_over(celda) {
	celda.style.backgroundColor="#E46F29";
}

function cambiacolor_out(celda) {
	celda.style.backgroundColor="#328AA4";
}

function cambiacolor_over_inactivo(celda) {
	celda.style.backgroundColor="#CCC";
}


function fila_sobre(celda) {
	celda.style.backgroundColor="#D7F1BC";
}

function fila_quita(celda) {
	celda.style.backgroundColor="";
}