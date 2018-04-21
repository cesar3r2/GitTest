// JavaScript Document
function logrosDiarios() {
	var deporte = document.getElementById('deporte').value;
	var fecha = document.getElementById('fecha').value;
	var hoy = document.getElementById('hoy').value;
	var manana = document.getElementById('manana').value;
	var apuestas = obtenerRadioSeleccionado("logrosDiarios", "apuestas").value;
	
	if (deporte != 0 && fecha != '') {
		if (apuestas == 'hoy') {
			if (fecha != hoy) {
				jAlert('La fecha no corresponde con el día actual', 'información');
				return;
			}
		}	
		
		if (apuestas == 'manana') {
			if (fecha != manana) {
				jAlert('La fecha no corresponde con el día siguiente', 'información');
				return;
			}
		}
		
		switch(deporte) {
			case '1':
				cambiar_contenido('sistema/consultas/c_logros_beisbol.php?fecha='+fecha, 'sub_contenido');
			break;
			
			case '2':
				cambiar_contenido('sistema/consultas/c_logros_basquetbol.php?fecha='+fecha, 'sub_contenido');
			break;
			
			case '3':
				cambiar_contenido('sistema/consultas/c_logros_futbol.php?fecha='+fecha, 'sub_contenido');
			break;
			
			case '4':
				cambiar_contenido('sistema/consultas/c_logros_futbol_americano.php?fecha='+fecha, 'sub_contenido');
			break;
			
			case '5':
				cambiar_contenido('sistema/consultas/c_logros_hockey.php?fecha='+fecha, 'sub_contenido');
			break;
			
			case '6':
				cambiar_contenido('sistema/consultas/c_logros_tennis.php?fecha='+fecha, 'sub_contenido');
			break;
			
			case '7':
				cambiar_contenido('sistema/consultas/c_logros_boxeo.php?fecha='+fecha, 'sub_contenido');
			break;
			
			case '8':
				cambiar_contenido('sistema/consultas/c_logros_formula1.php?fecha='+fecha, 'sub_contenido');
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

function cambiar_fechas_logros(apuestas) {
	var fecha = document.getElementById('fecha');
	var hoy = document.getElementById('hoy');
	var manana = document.getElementById('manana');
	
	if (apuestas == 'hoy') {
		fecha.value = hoy.value;
	} else if (apuestas == 'manana') {
		fecha.value = manana.value;
	}
}
