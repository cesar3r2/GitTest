function repTicketsGanadores() {
	var agencia = document.getElementById('sel_agencia').value;
	var tipo = document.getElementById('estatus').value;
	var f_desde = document.getElementById('fecha_desde').value;
	var f_hasta = document.getElementById('fecha_hasta').value;
	var hoy = document.getElementById('hoy').value;
	var ayer = document.getElementById('ayer').value;
	var apuestas = obtenerRadioSeleccionado("apuestasReg", "apuestas").value;
	
	if (agencia != 0 && tipo != 0 && f_desde != '' && f_hasta != '') {
		if (apuestas == 'hoy') {
			if ((f_desde != hoy) || (f_hasta != hoy)) {
				jAlert('Las fechas no corresponden con el día actual', 'información');
				return;
			}
		}
		if (apuestas == 'ayer') {
			if ((f_desde != ayer) || (f_hasta != ayer)) {
				jAlert('Las fechas no corresponden con el día anterior', 'información');
				return;
			}
		}
		if (tipo != 'TODOS') {
			cambiar_contenido('sistema/reportes/r_apuestas_diarias.php?agencia='+agencia+'&tipo='+tipo+'&desde='+f_desde+'&hasta='+f_hasta, 'sub_contenido');
		} else {
			cambiar_contenido('sistema/reportes/r_apuestas_diarias.php?agencia='+agencia+'&tipo=TODOS&desde='+f_desde+'&hasta='+f_hasta, 'sub_contenido');
		}
	} else {
		jAlert('Ha dejado campos vacíos o sin seleccionar', 'información');
		return;
	}
}

function repMovCaja() {
	var agencia = document.getElementById('sel_agencia').value;
	var f_desde = document.getElementById('fecha_desde').value;
	var f_hasta = document.getElementById('fecha_hasta').value;
	var hoy = document.getElementById('hoy').value;
	var ayer = document.getElementById('ayer').value;
	var apuestas = obtenerRadioSeleccionado("movCaja", "apuestas").value;
	
	if (agencia != 0 && f_desde != '' && f_hasta != '') {
		if (apuestas == 'hoy') {
			if ((f_desde != hoy) || (f_hasta != hoy)) {
				jAlert('Las fechas no corresponden con el día actual', 'información');
				return;
			}
		}
		if (apuestas == 'ayer') {
			if ((f_desde != ayer) || (f_hasta != ayer)) {
				jAlert('Las fechas no corresponden con el día anterior', 'información');
				return;
			}
		}
		cambiar_contenido('sistema/reportes/r_movimientos_caja.php?agencia='+agencia+'&desde='+f_desde+'&hasta='+f_hasta, 'sub_contenido');
	} else {
		jAlert('Ha dejado campos vacíos o sin seleccionar', 'información');
	}
}

function repMovAgencias() {
	var banquero = document.getElementById('sel_banquero').value;
	var f_desde = document.getElementById('fecha_desde').value;
	var f_hasta = document.getElementById('fecha_hasta').value;
	var hoy = document.getElementById('hoy').value;
	var ayer = document.getElementById('ayer').value;
	var apuestas = obtenerRadioSeleccionado("movAgencias", "apuestas").value;
	
	if (banquero != 0 && f_desde != '' && f_hasta != '') {
		if (apuestas == 'hoy') {
			if ((f_desde != hoy) || (f_hasta != hoy)) {
				jAlert('Las fechas no corresponden con el día actual', 'información');
				return;
			}
		}
		if (apuestas == 'ayer') {
			if ((f_desde != ayer) || (f_hasta != ayer)) {
				jAlert('Las fechas no corresponden con el día anterior', 'información');
				return;
			}
		}
		cambiar_contenido('sistema/reportes/r_movimientos_agencias.php?banquero='+banquero+'&desde='+f_desde+'&hasta='+f_hasta, 'sub_contenido');
	} else {
		jAlert('Ha dejado campos vacíos o sin seleccionar', 'información');
	}
}

function repPorcentajesVentas() {
	var banquero = document.getElementById('sel_banquero').value;
	var f_desde = document.getElementById('fecha_desde').value;
	var f_hasta = document.getElementById('fecha_hasta').value;
	var hoy = document.getElementById('hoy').value;
	var ayer = document.getElementById('ayer').value;
	var apuestas = obtenerRadioSeleccionado("porcVentas", "apuestas").value;
	
	if (banquero != 0 && f_desde != '' && f_hasta != '') {
		if (apuestas == 'hoy') {
			if ((f_desde != hoy) || (f_hasta != hoy)) {
				jAlert('Las fechas no corresponden con el día actual', 'información');
				return;
			}
		}
		if (apuestas == 'ayer') {
			if ((f_desde != ayer) || (f_hasta != ayer)) {
				jAlert('Las fechas no corresponden con el día anterior', 'información');
				return;
			}
		}
		cambiar_contenido('sistema/reportes/r_porcentajes_ventas.php?banquero='+banquero+'&desde='+f_desde+'&hasta='+f_hasta, 'sub_contenido');
	} else {
		jAlert('Ha dejado campos vacíos o sin seleccionar', 'información');
	}
}

function repPorcentajesUtilidades() {
	var banquero = document.getElementById('sel_banquero').value;
	var f_desde = document.getElementById('fecha_desde').value;
	var f_hasta = document.getElementById('fecha_hasta').value;
	var hoy = document.getElementById('hoy').value;
	var ayer = document.getElementById('ayer').value;
	var apuestas = obtenerRadioSeleccionado("porcUtilidades", "apuestas").value;
	
	if (banquero != 0 && f_desde != '' && f_hasta != '') {
		if (apuestas == 'hoy') {
			if ((f_desde != hoy) || (f_hasta != hoy)) {
				jAlert('Las fechas no corresponden con el día actual', 'información');
				return;
			}
		}
		if (apuestas == 'ayer') {
			if ((f_desde != ayer) || (f_hasta != ayer)) {
				jAlert('Las fechas no corresponden con el día anterior', 'información');
				return;
			}
		}
		cambiar_contenido('sistema/reportes/r_porcentajes_utilidades.php?banquero='+banquero+'&desde='+f_desde+'&hasta='+f_hasta, 'sub_contenido');
	} else {
		jAlert('Ha dejado campos vacíos o sin seleccionar', 'información');
	}
}

function cambiar_fechas_reportes(apuestas) {
	var f_desde = document.getElementById('fecha_desde');
	var f_hasta = document.getElementById('fecha_hasta');
	var hoy = document.getElementById('hoy');
	var ayer = document.getElementById('ayer');
	
	if (apuestas == 'hoy') {
		f_desde.value = hoy.value;
		f_hasta.value = hoy.value;
	} else if (apuestas == 'ayer') {
		f_desde.value = ayer.value;
		f_hasta.value = ayer.value;
	}
}

function repMovGrupos() {
	var banquero = document.getElementById('sel_banquero').value;
	var grupo = document.getElementById('sel_grupo').value;
	var f_desde = document.getElementById('fecha_desde').value;
	var f_hasta = document.getElementById('fecha_hasta').value;
	var hoy = document.getElementById('hoy').value;
	var ayer = document.getElementById('ayer').value;
	var apuestas = obtenerRadioSeleccionado("movGrupos", "apuestas").value;
	
	if (banquero != 0 && grupo != -1 && f_desde != '' && f_hasta != '') {
		if (apuestas == 'hoy') {
			if ((f_desde != hoy) || (f_hasta != hoy)) {
				jAlert('Las fechas no corresponden con el día actual', 'información');
				return;
			}
		}
		if (apuestas == 'ayer') {
			if ((f_desde != ayer) || (f_hasta != ayer)) {
				jAlert('Las fechas no corresponden con el día anterior', 'información');
				return;
			}
		}
		cambiar_contenido('sistema/reportes/r_movimientos_grupos.php?banquero='+banquero+'&grupo='+grupo+'&desde='+f_desde+'&hasta='+f_hasta, 'sub_contenido');
	} else {
		jAlert('Ha dejado campos vacíos o sin seleccionar', 'información');
	}
}