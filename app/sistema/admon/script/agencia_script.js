// Documento JavaScript
var modificarAgencia = 0;
var paginaAgencia = 'agencias_list.php';

// ----------------------------------- | Registrar Agencia | --------------------------------- //

function guardarAgencia()
{
	var id = document.getElementById('id_agencia').value;
	var nombre = document.getElementById('txt_nombre').value;
	var rif = document.getElementById('txt_rif').value;
	var direccion = document.getElementById('txt_direccion').value;
	var telefono = document.getElementById('txt_telefono').value;
	var email = document.getElementById('txt_email').value;
	var estado = document.getElementById('sel_estado').value;
	var ciudad = document.getElementById('txt_ciudad').value;
	var por_venta = document.getElementById('txt_por_ventas').value;
	var por_derecho = document.getElementById('txt_por_derecho').value;
	var por_utilidad = document.getElementById('txt_por_utilidad').value;
	var monto_derecho = document.getElementById('txt_monto_derecho').value;
	var saldo = document.getElementById('txt_saldo').value;
	var premio_max = document.getElementById('premio_max').value;
	var monto_min = document.getElementById('monto_min').value;
	var monto_max = document.getElementById('monto_max').value;
	var banquero = document.getElementById('sel_banquero').value;
	var grupo = document.getElementById('sel_grupo').value;
	var estatus = document.getElementById('sel_estatus').value;
	var r;
	
	if(modificarAgencia == 0)
		mensajeGuardar='¿Desea guardar el registro de la agencia '+nombre+'?','si/no';
	else
		mensajeGuardar='¿Desea modificar el registro de la agencia '+nombre+'?','si/no';
	
	if(id != "" && nombre!="" && estado!=0 && saldo!="" && premio_max!="" && monto_max!="" && monto_derecho!="" && banquero!=0 && por_venta!="" && por_derecho!="" && estatus!=0 && grupo!=-1)
	{
		jConfirm(mensajeGuardar, 'Confirmación', function(r) {
			if(r)
			{
				AjaxRequest.post
									(
										{'parameters':{     'id':id,
															'nombre':nombre,
															'rif':rif,
															'direccion':direccion,
															'telefono':telefono,
															'email':email,
															'estado':estado,
															'ciudad':ciudad,
															'saldo':saldo,
															'por_venta':por_venta,
															'por_derecho':por_derecho,
															'por_utilidad':por_utilidad,
															'monto_derecho':monto_derecho,
															'monto_max':monto_max,
															'monto_min':monto_min,
															'premio_max':premio_max,
															'banquero':banquero,
															'grupo':grupo,
															'estatus':estatus,
															'modificarAgencia':modificarAgencia,
															'accion':'registrarAgencia'
															}
															,'onSuccess':function(req){verificarTransaccionAgencia(req,nombre)}
															,'url':'sistema/admon/transaccion/agencia_trans.php'
															,'onError': function(req)
															{
																alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
															}
											}
										);
			}
			modificarAgencia = 0;
		} );
	} else {
		jAlert('Ha dejado campos vacíos o sin seleccionar. Por favor verifique los datos', 'Información');
	}
}

function verificarTransaccionAgencia(req, nombre)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != false) {
		jAlert("La agencia "+nombre+" ha sido registrada con éxito", 'Notificación');
		cambiar_contenido('sistema/admon/agencias_list.php', 'sub_contenido');
	} else {
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}

function guardarMiAgencia()
{
	var id = document.getElementById('id_agencia').value;
	var nombre = document.getElementById('txt_nombre').value;
	var direccion = document.getElementById('txt_direccion').value;
	var telefono = document.getElementById('txt_telefono').value;
	var email = document.getElementById('txt_email').value;
	var monto_min = document.getElementById('monto_min').value;
	var monto_max = document.getElementById('monto_max').value;
	var monto_derecho = document.getElementById('txt_monto_derecho').value;
	var premio_max = document.getElementById('premio_max').value;
	var saldo = document.getElementById('txt_saldo').value;
	var r;
	mensajeGuardar='¿Desea modificar el registro de la agencia '+nombre+'?','si/no';
	
	if(nombre!="" && saldo!="" && premio_max!="" && monto_min!="" && monto_max!="" && monto_derecho!="")
	{
		jConfirm(mensajeGuardar, 'Confirmación', function(r) {
			if(r)
			{
				AjaxRequest.post
									(
										{'parameters':{     'id':id,
															'nombre':nombre,
															'direccion':direccion,
															'telefono':telefono,
															'email':email,
															'premio_max':premio_max,
															'monto_min':monto_min,
															'monto_max':monto_max,
															'monto_derecho':monto_derecho,
															'saldo':saldo,
															'accion':'registrarMiAgencia'
															}
															,'onSuccess':function(req){verificarTransaccionMiAgencia(req,nombre)}
															,'url':'sistema/admon/transaccion/agencia_trans.php'
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

function verificarTransaccionMiAgencia(req, nombre)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != false) {
		jAlert("La agencia "+nombre+" ha sido registrada con éxito", 'Notificación');
		cambiar_contenido('sistema/admon/mi_agencia.php', 'sub_contenido');
	} else {
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}

//------------------------------------ | Editar Agencia | ---------------------------------//

function validaEditarAgencia(formu) {
	var i, j=0;
	var seleccionado;
	var formulario = document.getElementById(formu);
	for (i=0; i<formulario.elements.length; i++) {
		var elemento = formulario.elements[i];
		if(elemento.type == "checkbox") {
			if(elemento.checked) {
				j=j+1;
				seleccionado = elemento.value;
			}
		}
	}
	if (j == 0) {
		jAlert('Debe seleccionar un registro de la lista para editarlo', 'Información');
	} else if (j > 1) {
		jAlert('Solo debe seleccionar un registro de la lista para editarlo', 'Información');
	} else {
		cambiar_contenido('sistema/admon/agencias_form.php?accion=edit', 'sub_contenido');
		mostrarInfoAgencia(seleccionado);
	}
}

function mostrarInfoAgencia(codigo)
{
	AjaxRequest.post
						(
							{'parameters':{'codigo':codigo,
												'accion':'mostrarInformacionAgencia'
												}
												,'onSuccess':respMostrarInfoAgencia
												,'url':'sistema/admon/transaccion/agencia_trans.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respMostrarInfoAgencia(req)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp != '')
	{
		modificarAgencia = 1; // para ser modificado
		document.getElementById('id_agencia').value=resp[0]['id'];
		document.getElementById('txt_nombre').value=resp[0]['nombre'];
		document.getElementById('txt_rif').value=resp[0]['ci_rif'];
		document.getElementById('txt_direccion').value=resp[0]['direccion'];
		document.getElementById('txt_telefono').value=resp[0]['telefono'];
		document.getElementById('txt_email').value=resp[0]['correo'];
		document.getElementById('sel_estado').value=resp[0]['id_estado'];
		document.getElementById('txt_ciudad').value=resp[0]['ciudad'];
		document.getElementById('txt_saldo').value=resp[0]['disponible'];
		document.getElementById('txt_por_ventas').value=resp[0]['porcentaje_venta'];
		document.getElementById('txt_por_derecho').value=resp[0]['porcentaje_derecho'];
		document.getElementById('txt_por_utilidad').value=resp[0]['porcentaje_utilidad'];
		document.getElementById('premio_max').value=resp[0]['premio_max'];
		document.getElementById('txt_monto_derecho').value=resp[0]['monto_derecho'];
		document.getElementById('monto_max').value=resp[0]['monto_max'];
		document.getElementById('monto_min').value=resp[0]['monto_min'];
		document.getElementById('sel_banquero').value=resp[0]['id_banquero'];
		cagarGrupos(resp[0]['id_banquero'], resp[0]['id_grupo'], 1);
		document.getElementById('sel_estatus').value=resp[0]['estatus'];
	}
}

//-------------------------------------- | Eliminar Agencias | -----------------------------------//

function validaEliminarAgencias(formu) {
	var i, j=0, k=0;
	var seleccionados=[];
	var formulario = document.getElementById(formu);
	for (i=0; i<formulario.elements.length; i++) {
		var elemento = formulario.elements[i];
		if(elemento.type == "checkbox") {
			if(elemento.checked) {
				j=j+1;
				seleccionados[k] = elemento.value;
				k++;
			}
		}
	}
	if (j == 0) {
		jAlert('Debe seleccionar por lo menos un registro de la lista para eliminar', 'Información');
	} else {
		jConfirm('¿Confirma que desea eliminar el (los) registro(s) seleccionado(s)?', 'Confirmación', function(r) {
			if(r) {
				eliminarAgencias(seleccionados);
			}
		} );
	}
}

function eliminarAgencias(seleccionados)
{
	AjaxRequest.post
						 (
							{'parameters':{   'codigos': seleccionados
											  ,'accion': 'eliminarAgencia'}
											  ,'onSuccess': function(req) {respEliminarAgencia(req,seleccionados)}
											  ,'url': 'sistema/admon/transaccion/agencia_trans.php'
											  ,'onError': function(req) {
													alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respEliminarAgencia(req,seleccionados)
{
	var resp = eval ("("+ req.responseText +")");
	if(resp!=false)
	{
		jAlert("La(s) agencia(s) ha(n) sido eliminada(s) con éxito", 'Notificación');
		cambiar_contenido('sistema/admon/agencias_list.php', 'sub_contenido');
	}
	else
	{
		jAlert('Error! Por favor verifique los datos suministrados', 'Error');
	}
}

// -------------------------------------- | Validar Agencia | -----------------------------------//

function validarAgencia() {
	var codigo = document.getElementById('txt_codigo');
	var contenido_codigo = abrirAjax();
	
	contenido_codigo.open("GET", "sistema/admon/agencias_procesos.php?accion=1&codigo="+codigo.value, true);
   contenido_codigo.onreadystatechange=function()
	{
		if (contenido_codigo.readyState==4)
		{
			var arregloDatos;
			arregloDatos = contenido_codigo.responseText;
			if (arregloDatos != 0) {
				jAlert('El número de cédula o rif de la agencia se encuentra registrado', 'Información');
				codigo.value = '';
				codigo.focus();
				return;
			}
		}
	}
	contenido_codigo.send(null);
}

// -------------------------------------- | Buscar Agencias | -----------------------------------//

function filtro_agencia(e, busqueda) {
	var tecla = 0;
	tecla = e ? e.keyCode : event.keyCode;
	if(tecla == 13)
	{
		if(busqueda != '')
		{
			busqueda_agencias(busqueda);
		}
	}
}

function busqueda_agencias(busqueda) {
	if (busqueda != '') {
		cambiar_contenido('sistema/admon/agencias_list.php?buscar='+busqueda, 'sub_contenido');
	}
}

function busqueda_agencias_2() {
	var busqueda = document.getElementById('filtro_agencias');
	if (busqueda.value != '') {
		cambiar_contenido('sistema/admon/agencias_list.php?buscar='+busqueda.value, 'sub_contenido');
	}
}