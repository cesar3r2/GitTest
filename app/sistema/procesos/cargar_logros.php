<?php
	include "../../conexionConf.php";
	include "../../include/php/interfaz.php";
	
	$titulo = 'Cargar Logros';
?>

<TABLE align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<TD valign="top"><FONT class="txtForm"><?php echo $titulo;?></FONT></TD>
	</TR>
</TABLE>
<br><br><br>
<TABLE align="left" width="100%" border="0" cellpadding="20" cellspacing="1" style="border-color:#CCC; border-width:1px; border-style:solid">
	<TR>
    	<TD width="25%" align="center" style="cursor:pointer; background:#F3F3F3">
        <img src="imagenes/i_beisbol.png" border="0" onclick="cargarLogrosBeisbol();"><br>
        <a onclick="cargarLogrosBeisbol();">Béisbol</a>
        </TD>
        <TD width="25%" align="center" style="cursor:pointer; background:#F3F3F3">
        <img src="imagenes/i_basquetbol.png" border="0" onclick="cargarLogrosBasquetbol();"><br>
        <a onclick="cargarLogrosBasquetbol();" style="cursor:pointer;">Básquetbol</a>
        </TD>
    	<TD width="25%" align="center" style="cursor:pointer; background:#F3F3F3">
        <img src="imagenes/i_futbol.png" border="0" onclick="cargarLogrosFutbol();"><br>
        <a onclick="cargarLogrosFutbol();" style="cursor:pointer;">Fútbol</a>
        </TD>
    	<TD width="25%" align="center" style="cursor:pointer; background:#F3F3F3">
        <img src="imagenes/i_futbol_am.png" border="0" onclick="cargarLogrosFutbolAmericano();"><br>
        <a onclick="cargarLogrosFutbolAmericano();" style="cursor:pointer;">Fútbol Americano</a>
       	</TD>
    </TR>
    <TR>
    	<TD align="center" style="cursor:pointer; background:#F3F3F3">
        <img src="imagenes/i_hockey.png" border="0" onclick="cargarLogrosHockey();"><br>
        <a onclick="cargarLogrosHockey();" style="cursor:pointer;">Hockey</a>
        </TD>
        <TD align="center" style="cursor:pointer; background:#F3F3F3">
        <img src="imagenes/i_tennis.png" border="0" onclick="cargarLogrosTennis();"><br>
        <a onclick="cargarLogrosTennis();" style="cursor:pointer;">Tennis</a>
        </TD>
        <TD align="center" style="cursor:pointer; background:#F3F3F3">
        <img src="imagenes/i_boxeo.png" border="0" onclick="cargarLogrosBoxeo();"><br>
        <a onclick="cargarLogrosBoxeo();" style="cursor:pointer;">Boxeo</a>
        </TD>
        <TD align="center" style="cursor:pointer; background:#F3F3F3">
        <img src="imagenes/i_f1.png" border="0" onclick="cargarLogrosFormula1();"><br>
        <a onclick="cargarLogrosFormula1();" style="cursor:pointer;">Fórmula 1</a>
        </TD>
    </TR>
</TABLE>