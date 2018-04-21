function cambiar_cuerpo(ruta, id, operacion)
{
	$(cuerpo).load(ruta, {operacion: operacion});
}

function actualizar_titulo(titulo) {
	var capa = document.getElementById('titulo');
	capa.innerHTML = titulo;
}