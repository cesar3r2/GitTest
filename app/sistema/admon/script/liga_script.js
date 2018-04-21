// JavaScript Document

function activarLigas()
{
	var cadena, activar, desactivar, mensajeGuardar, r;
	var ligas = verificar_liga_marcada("fLigas");
	
	cadena = ligas.split('||');
	activar = cadena[0];
	desactivar = cadena[1];

	mensajeGuardar = '¿Confirma que desea activar las ligas seleccionadas?','si/no';
	jConfirm(mensajeGuardar, 'Confirmación', function(r){
	if(r)
	{
					AjaxRequest.post
										(
											{'parameters':{		'activar':activar,
																'desactivar':desactivar,
																'accion':'activarLigas'
																}
																,'onSuccess':function(req){verificarTransaccionLigas(req)}
																,'url':'sistema/admon/transaccion/ligas_trans.php'
																,'onError': function(req)
																{
																	alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
																}
												}
											);
			}
		} );
}

function verificarTransaccionLigas(req)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != false)
	{
		jAlert("Las ligas seleccionadas se han activado correctamente", 'Notificación');
		cambiar_contenido('sistema/admon/ligas_activas.php', 'sub_contenido');
	}
	else
	{
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}

function verificar_liga_marcada(nombreFormu) {
	var i, j=0, k=0;
	var activar=[], desactivar=[];
	var formulario = document.getElementById(nombreFormu);
	for (i=0; i<formulario.elements.length; i++) {
		var elemento = formulario.elements[i];
		if(elemento.type == "checkbox") {
			if(elemento.checked) {
				activar[j] = elemento.value;
				j++;
			} else {
				desactivar[k] = elemento.value;
				k++;
			}
			
		}
	}
	return activar+'||'+desactivar;
}