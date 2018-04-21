function soloNumeros(e) {
	var code;
	var ctrlDown = e.ctrlKey||e.metaKey;
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;// EN CASO QUE EL NAVEGADOR SEA IE
	else if (e.which) code = e.which; //EN CASO QUE EL NAVEGADOR SEA MOZILLA FIREFOX
	return (code<=13 || code==127 || (code>=48 && code<=57) || code==46 || (code>=35 && code<=39) || (ctrlDown && code==99) || (ctrlDown && code==118) || (ctrlDown && code==67) || (ctrlDown && code==86));
}

function soloNumerosLogros(e) {
	var code;
	var ctrlDown = e.ctrlKey||e.metaKey;
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;// EN CASO QUE EL NAVEGADOR SEA IE
	else if (e.which) code = e.which; //EN CASO QUE EL NAVEGADOR SEA MOZILLA FIREFOX
	return (code<=13 || code==127 || (code>=48 && code<=57) || code==46 || (code>=35 && code<=39) || code==45 || (ctrlDown && code==99) || (ctrlDown && code==118) || (ctrlDown && code==67) || (ctrlDown && code==86));
}

function numeroDecimal(evt) {
	var ctrlDown = e.ctrlKey||e.metaKey;
	var nav4=window.Event?true:false;
	var key=nav4?evt.which:evt.keyCode;
	return (key<=13 || key==127 || (key>=48 && key<=57) || (key==46) || (key==44) || (ctrlDown && code==99) || (ctrlDown && code==118) || (ctrlDown && code==67) || (ctrlDown && code==86));
}

function soloCodigo(e) {
	var code;
	var ctrlDown = e.ctrlKey||e.metaKey;
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;// EN CASO QUE EL NAVEGADOR SEA IE
	else if (e.which) code = e.which; //EN CASO QUE EL NAVEGADOR SEA MOZILLA FIREFOX
	return(code<=13 || code==127 || (code>=48 && code<=57) || (code==45 ) || (code>=35 && code<=38) || (ctrlDown && code==99) || (ctrlDown && code==118));
}

function soloIp(e) {
	var code;
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;// EN CASO QUE EL NAVEGADOR SEA IE
	else if (e.which) code = e.which; //EN CASO QUE EL NAVEGADOR SEA MOZILLA FIREFOX
	return (code<=13 || code==127 || (code>=48 && code<=57) || code==46 || code==44 || (code>=35 && code<=39));
}

function validarEmail(valor,id) {
	if ((/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(valor)) || (valor=='')) {
		return (true)
	} else {
	alert("La dirección de email es incorrecta.");
	document.getElementById(id).value='';
	return (false);
	}
}

function esFecha(fecha) {
	if (fecha != undefined && fecha != "" ) {
		if (!/^\d{2}\/\d{2}\/\d{4}$/.test(fecha)) {
			return false;
		}
		var dia  =  parseInt(fecha.substring(0,2),10);
		var mes  =  parseInt(fecha.substring(3,5),10);
		var anio =  parseInt(fecha.substring(6),10);
		switch(mes) {
			case 1:
			case 3:
			case 5:
			case 7:
			case 8:
			case 10:
			case 12:
				numDias=31;
				break;
			case 4: case 6: case 9: case 11:
				numDias=30;
				break;
			case 2:
				if (comprobarSiBisisesto(anio)){ numDias=29 }else{ numDias=28};
				break;
			default:
				return false;
		}
		if (dia>numDias || dia==0) {
			return false;
		}
		return true;
	}
}

function comprobarSiBisisesto(anio) {
	if ( ( anio % 100 != 0) && ((anio % 4 == 0) || (anio % 400 == 0))) {
		return true;
	}
	else {
		return false;
	}
}

function soloFecha(fecha, id) {
	var fec = document.getElementById(id);
	if (fecha != undefined && fec.value != "" ) {
		if (!/^\d{2}\/\d{2}\/\d{4}$/.test(fec.value)) {
			//alert(fecha);
			jAlert("El formato de la fecha no es válido (Ej: dd/mm/aaaa)", 'información');
			fec.value = '';
			fec.focus();
			return false;
		}
		var dia  =  parseInt(fec.value.substring(0,2),10);
		var mes  =  parseInt(fec.value.substring(3,5),10);
		var anio =  parseInt(fec.value.substring(6),10);
		switch(mes) {
			case 1:
			case 3:
			case 5:
			case 7:
			case 8:
			case 10:
			case 12:
				numDias=31;
				break;
			case 4: case 6: case 9: case 11:
				numDias=30;
				break;
			case 2:
				if (comprobarSiBisisesto(anio)){ numDias=29 }else{ numDias=28};
				break;
			default:
				jAalert("La fecha introducida es errónea", 'información');
				fec.value = '';
				fec.focus();
				return false;
		}
		if (dia>numDias || dia==0) {
			jAlert("La fecha introducida es errónea", 'información');
			fec.value = '';
			fec.focus();
			return false;
		}
		return true;
	}
}

function soloHora(hora, id) {
	var id_hora = document.getElementById(id);
	if ((hora < 1) || (hora > 12)) {
		jAlert("La hora introducida es errónea", 'información');
		id_hora.value = '';
		id_hora.focus();
		return false;
	}
}

function formatoFecha(valor)
{
	//para cambiar el formato de la fecha aaaa-mm-dd por dd/mm/aaaa 
	if(valor!=null && valor!="")
	{
		var fechaArray= valor.split('-');
		var anio=fechaArray[0];
		var mes=fechaArray[1];
		var dia =fechaArray[2];
		var fecha=dia+'/'+mes+'/'+anio;
		return fecha;
	}
	else
		return null;
}

function buscarInfoEnter(e, operacion)
{
	var code;
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;// EN CASO QUE EL NAVEGADOR SEA IE
	else if (e.which) code = e.which; //EN CASO QUE EL NAVEGADOR SEA MOZILLA FIREFOX
	if (code == 13) {
		if(operacion=='buscarUsuario')
		{
			loguear_usuario();
		}
	}
	
}

function marcarTodos(chkbox)
{
	for (var i=0; i<document.forms[0].elements.length; i++)
	{
		var elemento = document.forms[0].elements[i];
		if (elemento.type == "checkbox")
		{
			elemento.checked = chkbox.checked
		}
	}
}

function loguear_usuario() {
	var usuario = document.getElementById('usuario');
	var clave = document.getElementById('clave');
	var tipo = document.getElementById('tipo_usr');
	var pcs = document.getElementById('nro_pcs');
	var mensaje = document.getElementById('mensaje');
	
	if (usuario.value == '') {
		mensaje.innerHTML = 'Debe introducir un usuario';
		mensaje.style.visibility = 'visible';
		usuario.focus();
		return;
	} else if (clave.value == '') {
		mensaje.innerHTML = 'Debe introducir la contraseña';
		mensaje.style.visibility = 'visible';
		clave.focus();
		return;
	} else if (usuario.value != "" && clave.value!="") {
		AjaxRequest.post
		(
			{'parameters':  {   'usuario':usuario.value,
								'clave':clave.value,
								'tipo':tipo.value,
								'nro_pcs':pcs.value,
								'accion':'loguearUsr'
							}
							,'onSuccess':function(req){resp_loguear_usuario(req)}
							,'url':'app/sistema/admon/transaccion/usr_trans.php'
							,'onError': function(req)
							{
								alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
							}
				}
		);
	}
}

function resp_loguear_usuario(req) {
	var usuario = document.getElementById('usuario');
	var clave = document.getElementById('clave');
	var mensaje = document.getElementById('mensaje');
	
	var resp = eval ("("+ req.responseText +")");

	if(resp == false) {
		mensaje.innerHTML = 'Datos de sesión incorrectos!';
		mensaje.style.visibility = 'visible';
		clave.value = '';
		usuario.focus();
		return;
	} else if(resp == true) {
		location.href='app/logueo.php?usuario='+usuario.value;
	}
}

function limpiar_logueo() {
	var usuario = document.getElementById('usuario');
	var clave = document.getElementById('clave');
	var mensaje = document.getElementById('mensaje');
	usuario.value = '';
	clave.value = '';
	mensaje.innerHTML = '';
	mensaje.style.visibility = 'hidden';
	usuario.focus();
}

function imprimir_ticket(nombre){
	var ficha = document.getElementById(nombre)
	var ventimp = window.open(' ', 'popimpr','width=10, height=10, TOOLBAR=NO, LOCATION=NO, MENUBAR=NO, SCROLLBARS=NO, RESIZABLE=NO')
	var estilo="<link href=\"../../estilos/estilos_ticket.css\" rel=\"stylesheet\" type=\"text/css\">"
	ventimp.document.write( estilo )
	ventimp.document.write( ficha.innerHTML )
	ventimp.document.close()
	ventimp.print()
	ventimp.close()
}

function imprimir(nombre){
	var ficha = document.getElementById(nombre)
	var ventimp = window.open(' ', 'popimpr','width=10, height=10, TOOLBAR=NO, LOCATION=NO, MENUBAR=NO, SCROLLBARS=NO, RESIZABLE=NO')
	var estilo="<link href=\"estilos/estilos_reportes.css\" rel=\"stylesheet\" type=\"text/css\">"
	ventimp.document.write( estilo )
	ventimp.document.write( ficha.innerHTML )
	ventimp.document.close()
	ventimp.print()
	ventimp.close()
}

function emitirPDF(ruta) {
	location.href = ruta;
}