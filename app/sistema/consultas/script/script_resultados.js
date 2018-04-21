// JavaScript Document
function resultadosDiarios() {
	var deporte = document.getElementById('deporte').value;
	var fecha = document.getElementById('fecha').value;
	var hoy = document.getElementById('hoy').value;
	var ayer = document.getElementById('ayer').value;
	var apuestas = obtenerRadioSeleccionado("resultadosDiarios", "apuestas").value;
	
	if (deporte != 0 && fecha != '') {
		if (apuestas == 'hoy') {
			if (fecha != hoy) {
				jAlert('La fecha no corresponde con el día actual', 'información');
				return;
			}
		}	
		
		if (apuestas == 'ayer') {
			if (fecha != ayer) {
				jAlert('La fecha no corresponde con el día anterior', 'información');
				return;
			}
		}
		
		switch(deporte) {
			case '1':
				cambiar_contenido('sistema/consultas/c_resultados_beisbol.php?fecha='+fecha, 'sub_contenido');
			break;
			
			case '2':
				cambiar_contenido('sistema/consultas/c_resultados_basquetbol.php?fecha='+fecha, 'sub_contenido');
			break;
			
			case '3':
				cambiar_contenido('sistema/consultas/c_resultados_futbol.php?fecha='+fecha, 'sub_contenido');
			break;
			
			case '4':
				cambiar_contenido('sistema/consultas/c_resultados_futbol_americano.php?fecha='+fecha, 'sub_contenido');
			break;
			
			case '5':
				cambiar_contenido('sistema/consultas/c_resultados_hockey.php?fecha='+fecha, 'sub_contenido');
			break;
			
			case '6':
				cambiar_contenido('sistema/consultas/c_resultados_tennis.php?fecha='+fecha, 'sub_contenido');
			break;
			
			case '7':
				cambiar_contenido('sistema/consultas/c_resultados_boxeo.php?fecha='+fecha, 'sub_contenido');
			break;
			
			case '8':
				cambiar_contenido('sistema/consultas/c_resultados_formula1.php?fecha='+fecha, 'sub_contenido');
			break;
			
			default:
			break;
		}
	}
	else {
		jAlert('Ha dejado campos vacíos o sin seleccionar', 'información');
		return;
	}
}

function cambiar_fechas_resultados(apuestas) {
	var fecha = document.getElementById('fecha');
	var hoy = document.getElementById('hoy');
	var ayer = document.getElementById('ayer');
	
	if (apuestas == 'hoy') {
		fecha.value = hoy.value;
	} else if (apuestas == 'ayer') {
		fecha.value = ayer.value;
	}
}