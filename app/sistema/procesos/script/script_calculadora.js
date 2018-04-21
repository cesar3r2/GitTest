// JavaScript Document
function limpiarApuestaCalc()
{
	cambiar_contenido("sistema/procesos/calculadora.php", 'sub_contenido');
}

function calcularApuestaCalc()
{
	var monto = document.getElementById('monto').value;
	var montoTotal = document.getElementById('monto_total');
	var premio = document.getElementById('premio');
	var montoGanApu = document.getElementById('gan_apu');
	var cadenaLogros = contarLogrosCalc(0);
	var logro = cadenaLogros.split('||');
	var cantLogros = logro[0];
	var ganancia = 0;
	var apuesta = monto;
	
	if (monto == '') {
		jAlert("Debe introducir el monto de la apuesta", 'Notificación');
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
	var montoApuesta = parseFloat(monto);
	var montoGanancia = ganancia - montoApuesta;
	montoGanApu.innerHTML = montoGanancia.toFixed(2)+' + '+montoApuesta.toFixed(2);
	montoTotal.innerHTML = ganancia.toFixed(2)+' BsF';
}

function contarLogrosCalc(detalles) {
	var cajas = document.getElementsByTagName("input");
	var logro, cadena, listaLogros='';
	var totReg = cajas.length-1;
	
	if (detalles == 0) {
		for (var i=0; i<totReg; i++) {
			logro = cajas[i].value.split('||');
			listaLogros += '||'+logro[0];
		}
	}
	else if (detalles == 1) {
		for (var i=0; i<totReg; i++) {
			logro = cajas[i].value.split('||');
			listaLogros += '||'+logro[1];
		}
	}
	cadena = totReg+listaLogros;
	return cadena;
}

function buscarInfoEnterMontoCalc(e, operacion)
{
	var code;
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	if (code == 13) {
		if(operacion=='calcularApuesta')
		{
			calcularApuestaCalc();
		}
	}
}
