function cagarGrupos(banquero, grupo, marcar)
{
	AjaxRequest.post
						(
							{'parameters':{		'id_banquero':banquero,
												'accion':'cargarGrupos'
												}
												,'onSuccess': function(req) {respCargarGrupos(req, grupo, marcar) }
												,'url':'sistema/admon/transaccion/grupo_trans.php'
												,'onError': function(req)
												{
													 alert('Error!\nStatusText='+req.statusText+'\nContents='+req.responseText);
												}
							}
						);
}

function respCargarGrupos(req, grupo, marcar)
{
	var resp = eval ("("+ req.responseText +")");
	if (resp !="") {
		document.getElementById('sel_grupo').options.length = 0;
		document.getElementById('sel_grupo').options[0] = new Option('Seleccione..');
		document.getElementById('sel_grupo').options[0].value = '-1';
		document.getElementById('sel_grupo').options[0].selected = true;
		
		for(var i=1,j=0; i<=resp.length; i++,j++)
		{
			document.getElementById('sel_grupo').options[i] = new Option('('+resp[j]['id']+') '+resp[j]['nombre']);
			document.getElementById('sel_grupo').options[i].value = resp[j]['id'];
			document.getElementById('sel_grupo').options[i].title = "Id Banquero: "+resp[j]['id_banquero'];
			if (document.getElementById('sel_grupo').options[i].value == grupo && marcar == 1)
			{
				document.getElementById('sel_grupo').options[i].selected = true;
			}
		}
	} else {
		jAlert('No existen grupos registrados para el banquero seleccionado', 'Información');
		return;
	}
}