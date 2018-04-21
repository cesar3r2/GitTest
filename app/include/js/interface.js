function abrirAjax()
{
	var xmlhttp=false;
	try
	{
		xmlhttp=new ActiveXObject("Msxml2.XMLHTTP");
	}
	catch(e)
	{
		try
		{
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		catch(E)
		{
			if (!xmlhttp && typeof XMLHttpRequest!='undefined') xmlhttp=new XMLHttpRequest();
		}
	}
	return xmlhttp;
}

function cambiar_contenido(valor, tabla)
{
	var contenido = document.getElementById(tabla);
	var contenido_modulos = abrirAjax();
	
	contenido_modulos.open("POST", valor, true);
    contenido_modulos.onreadystatechange=function()
	{
		if (contenido_modulos.readyState==1)
		{
			contenido.innerHTML="";
			contenido.innerHTML="<DIV align=\"center\"><IMG src=\"imagenes/cargando.gif\" align=\"center\" border=\"0\"><BR>Cargando</DIV>";
		}
		if (contenido_modulos.readyState==4)
		{
			contenido.innerHTML="";
			contenido.innerHTML=contenido_modulos.responseText;
		}
	}
	contenido_modulos.send(null);
}