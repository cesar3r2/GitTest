// JavaScript Document
function conApuestasDetalladas() {
	var agencia = document.getElementById('sel_agencia').value;
	var tipo = document.getElementById('estatus').value;
	var f_desde = document.getElementById('fecha_desde').value;
	var f_hasta = document.getElementById('fecha_hasta').value;
	var hoy = document.getElementById('hoy').value;
	var ayer = document.getElementById('ayer').value;
	
	var apuestas = obtenerRadioSeleccionado("apuestasDet", "apuestas").value;
	
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
			cambiar_contenido('sistema/consultas/c_apuestas_detalladas.php?agencia='+agencia+'&tipo='+tipo+'&desde='+f_desde+'&hasta='+f_hasta, 'sub_contenido');
		} else {
			cambiar_contenido('sistema/consultas/c_apuestas_detalladas.php?agencia='+agencia+'&tipo=TODOS&desde='+f_desde+'&hasta='+f_hasta, 'sub_contenido');
		}
	}
	else {
		jAlert('Ha dejado campos vacíos o sin seleccionar', 'información');
		return;
	}
}

function cambiar_fechas(apuestas) {
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

function obtenerRadioSeleccionado(formulario, nombre){
     elementos = document.getElementById(formulario).elements;
     longitud = document.getElementById(formulario).length;
     for (var i = 0; i < longitud; i++){
         if(elementos[i].name == nombre && elementos[i].type == "radio" && elementos[i].checked == true){
             return elementos[i];
         }
     }
     return false;
}

function conApuestasRegistradas() {
	var agencia = document.getElementById('sel_agencia').value;
	var tipo = document.getElementById('estatus').value;
	var f_desde = document.getElementById('fecha_desde').value;
	var f_hasta = document.getElementById('fecha_hasta').value;
	var hoy = document.getElementById('hoy').value;
	var ayer = document.getElementById('ayer').value;
	
	var apuestas = obtenerRadioSeleccionado("apuestasDet", "apuestas").value;
	
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
			cambiar_contenido('sistema/consultas/c_apuestas_registradas.php?agencia='+agencia+'&tipo='+tipo+'&desde='+f_desde+'&hasta='+f_hasta, 'sub_contenido');
		} else {
			cambiar_contenido('sistema/consultas/c_apuestas_registradas.php?agencia='+agencia+'&tipo=TODOS&desde='+f_desde+'&hasta='+f_hasta, 'sub_contenido');
		}
	}
	else {
		jAlert('Ha dejado campos vacíos o sin seleccionar', 'información');
		return;
	}
}