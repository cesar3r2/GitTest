<?php
	include "../../conexionConf.php";
	include "../../include/php/common.php";
	include "../../clases/class.liga.php";
	
	$estatusLogro = 'ACTIVO';
	$estatusLiga = 'ACTIVA';
	$fecha = date('Y-m-d');
	//$horaApueta = date("H:i:s", strtotime("-20 minutes"));
	$horaApueta = date("H:i:s", strtotime("+5 minutes"));
	
	$objLigaBe = new liga();
	$fLigaBe = $objLigaBe->buscar_ligas('1', $estatusLiga);
	$activasBe = count($fLigaBe);
	
	$objLigaBa = new liga();
	$fLigaBa = $objLigaBa->buscar_ligas('2', $estatusLiga);
	$activasBa = count($fLigaBa);

	$objLigaFu = new liga();
	$fLigaFu = $objLigaFu->buscar_ligas('3', $estatusLiga);
	$activasFu = count($fLigaFu);
	
	$objLigaFa = new liga();
	$fLigaFa = $objLigaFa->buscar_ligas('4', $estatusLiga);
	$activasFa = count($fLigaFa);
	
	$objLigaHo = new liga();
	$fLigaHo = $objLigaHo->buscar_ligas('5', $estatusLiga);
	$activasHo = count($fLigaHo);
	
	$objLigaTe = new liga();
	$fLigaTe = $objLigaTe->buscar_ligas('6', $estatusLiga);
	$activasTe = count($fLigaTe);

	$objLigaBo = new liga();
	$fLigaBo = $objLigaBo->buscar_ligas('7', $estatusLiga);
	$activasBo = count($fLigaBo);

	$objLigaF1 = new liga();
	$fLigaF1 = $objLigaF1->buscar_ligas('8', $estatusLiga);
	$activasF1 = count($fLigaF1);
	
	$colorDeporte = '#E46F29';
?>

<DIV><strong><?php echo fecha_letras();?></strong> | Haga click en los logros que desea apostar</DIV>
<br>
<table width="100%" border="0" cellpadding="1" cellspacing="1" style="border-color:#CCC; border-width:1px; border-style:solid">
	<tr bgcolor="#328AA4" align="center" style="color:#FFF; cursor:pointer;" height="50px">
        
    	<td width="10%" onClick="filtroLogros('todos')" onmouseover="cambiacolor_over(this)" onmouseout="cambiacolor_out(this)">
        <strong>Todos</strong></td>
        <?php if ($activasBe > 0) { ?>
    	<td width="10%" onClick="filtroLogros('be')" onmouseover="cambiacolor_over(this)" onmouseout="cambiacolor_out(this)"><img src="imagenes/ico_beisbol.png" border="0"><br>Béisbol</td>
        <?php } else { ?>
        <td width="10%" onmouseover="cambiacolor_over_inactivo(this)" onmouseout="cambiacolor_out(this)"><img src="imagenes/ico_beisbol.png" border="0"><br>Béisbol</td>
        <?php } ?>
        <?php if ($activasBa > 0) { ?>
        <td width="13%" onClick="filtroLogros('ba')" onmouseover="cambiacolor_over(this)" onmouseout="cambiacolor_out(this)"><img src="imagenes/ico_basquetbol.png" border="0"><br>Básquetbol</td>
        <?php } else { ?>
        <td width="13%" onmouseover="cambiacolor_over_inactivo(this)" onmouseout="cambiacolor_out(this)"><img src="imagenes/ico_basquetbol.png" border="0"><br>Básquetbol</td>
        <?php } ?>
        <?php if ($activasFu > 0) { ?>
        <td width="10%" onClick="filtroLogros('fu')" onmouseover="cambiacolor_over(this)" onmouseout="cambiacolor_out(this)"><img src="imagenes/ico_futbol.png" border="0"><br>Fútbol</td>
        <?php } else { ?>
        <td width="10%" onmouseover="cambiacolor_over_inactivo(this)" onmouseout="cambiacolor_out(this)"><img src="imagenes/ico_futbol.png" border="0"><br>Fútbol</td>
        <?php } ?>
        <?php if ($activasFa > 0) { ?>
        <td width="15%" onClick="filtroLogros('fa')" onmouseover="cambiacolor_over(this)" onmouseout="cambiacolor_out(this)"><img src="imagenes/ico_futbol_am.png" border="0"><br>F. Americano</td>
        <?php } else { ?>
        <td width="15%" onmouseover="cambiacolor_over_inactivo(this)" onmouseout="cambiacolor_out(this)"><img src="imagenes/ico_futbol_am.png" border="0"><br>F. Americano</td>
        <?php } ?>
        <?php if ($activasHo > 0) { ?>
        <td width="10%" onClick="filtroLogros('ho')" onmouseover="cambiacolor_over(this)" onmouseout="cambiacolor_out(this)"><img src="imagenes/ico_hockey.png" border="0"><br>Hockey</td>
        <?php } else { ?>
        <td width="10%" onmouseover="cambiacolor_over_inactivo(this)" onmouseout="cambiacolor_out(this)"><img src="imagenes/ico_hockey.png" border="0"><br>Hockey</td>
        <?php } ?>
        <?php if ($activasTe > 0) { ?>
        <td width="10%" onClick="filtroLogros('te')" onmouseover="cambiacolor_over(this)" onmouseout="cambiacolor_out(this)"><img src="imagenes/ico_tennis.png" border="0"><br>Tennis</td>
        <?php } else { ?>
        <td width="10%" onmouseover="cambiacolor_over_inactivo(this)" onmouseout="cambiacolor_out(this)"><img src="imagenes/ico_tennis.png" border="0"><br>Tennis</td>
        <?php } ?>
        <?php if ($activasBo > 0) { ?>
        <td width="10%" onClick="filtroLogros('bo')" onmouseover="cambiacolor_over(this)" onmouseout="cambiacolor_out(this)"><img src="imagenes/ico_boxeo.png" border="0"><br>Boxeo</td>
        <?php } else { ?>
        <td width="10%" onmouseover="cambiacolor_over_inactivo(this)" onmouseout="cambiacolor_out(this)"><img src="imagenes/ico_boxeo.png" border="0"><br>Boxeo</td>
        <?php } ?>
        <?php if ($activasF1 > 0) { ?>
        <td width="12%" onClick="filtroLogros('f1')" onmouseover="cambiacolor_over(this)" onmouseout="cambiacolor_out(this)"><img src="imagenes/ico_f1.png" border="0"><br>Fórmula 1</td>
        <?php } else { ?>
        <td width="12%" onmouseover="cambiacolor_over_inactivo(this)" onmouseout="cambiacolor_out(this)"><img src="imagenes/ico_f1.png" border="0"><br>Fórmula 1</td>
        <?php } ?>
    </tr>
</table>
<BR>
<table width="100%" style="border-color:#CCC; border-width:1px; border-style:solid" cellpadding="0" cellspacing="0"><tr><td>
<FORM name="fLogros" id="fLogros">
	<div id="logrosBe">
	<?php if ($activasBe > 0) { ?>
    <TABLE width="100%" border="0" cellpadding="1" cellspacing="1">
        <TR bgcolor="<?php echo $colorDeporte; ?>">
        	<TD align="center" width="25"><img src="imagenes/ico_beisbol.png" border="0"></TD>
            <TD align="left" style="color:#FFFFFF">&nbsp;&nbsp;<strong>BÉISBOL</strong></TD>
        </TR>
    </TABLE>
    <?php include_once('beisbol.php'); ?>
    <?php } ?>
    </div>
    
	<div id="logrosBa">
	<?php if ($activasBa > 0) { ?>
    <TABLE width="100%" border="0" cellpadding="1" cellspacing="1">
        <TR bgcolor="<?php echo $colorDeporte; ?>">
        	<TD align="center" width="25"><img src="imagenes/ico_basquetbol.png" border="0"></TD>
            <TD align="left" style="color:#FFFFFF">&nbsp;&nbsp;<strong>BÁSQUETBOL</strong></TD>
        </TR>
    </TABLE>
    <?php include_once('basquetbol.php'); ?>
    <?php } ?>
    </div>
    
	<div id="logrosFu">
	<?php if ($activasFu > 0) { ?>
    <TABLE width="100%" border="0" cellpadding="1" cellspacing="1">
        <TR bgcolor="<?php echo $colorDeporte; ?>">
	        <TD align="center" width="25"><img width="16" height="16" src="imagenes/ico_futbol.png" border="0"></TD>
            <TD align="left" style="color:#FFFFFF">&nbsp;&nbsp;<strong>FÚTBOL</strong></TD>
        </TR>
    </TABLE>
    <?php include_once('futbol.php'); ?>
    <?php } ?>
    </div>
	
    <div id="logrosFa">
	<?php if ($activasFa > 0) { ?>
    <TABLE width="100%" border="0" cellpadding="1" cellspacing="1">
        <TR bgcolor="<?php echo $colorDeporte; ?>">
        	<TD align="center" width="25"><img src="imagenes/ico_futbol_am.png" border="0"></TD>
            <TD align="left" style="color:#FFFFFF">&nbsp;&nbsp;<strong>FÚTBOL AMERICANO</strong></TD>
        </TR>
    </TABLE>
    <?php include_once('futbol_americano.php'); ?>
    <?php } ?>
    </div>
    
    <div id="logrosHo">
	<?php if ($activasHo > 0) { ?>
    <TABLE width="100%" border="0" cellpadding="1" cellspacing="1">
        <TR bgcolor="<?php echo $colorDeporte; ?>">
	        <TD align="center" width="25"><img src="imagenes/ico_hockey.png" border="0"></TD>
            <TD align="left" style="color:#FFFFFF">&nbsp;&nbsp;<strong>HOCKEY</strong></TD>
        </TR>
    </TABLE>
    <?php include_once('hockey.php'); ?>
    <?php } ?>
    </div>
    
    <div id="logrosTe">
	<?php if ($activasTe > 0) { ?>
    <TABLE width="100%" border="0" cellpadding="1" cellspacing="1">
        <TR bgcolor="<?php echo $colorDeporte; ?>">
        	<TD align="center" width="25"><img src="imagenes/ico_tennis.png" border="0"></TD>
            <TD align="left" style="color:#FFFFFF">&nbsp;&nbsp;<strong>TENNIS</strong></TD>
        </TR>
    </TABLE>
    <?php include_once('tennis.php'); ?>
    <?php } ?>
    </div>
    
    <div id="logrosBo">
	<?php if ($activasBo > 0) { ?>
    <TABLE width="100%" border="0" cellpadding="1" cellspacing="1">
        <TR bgcolor="<?php echo $colorDeporte; ?>">
        	<TD align="center" width="25"><img src="imagenes/ico_boxeo.png" border="0"></TD>
            <TD align="left" style="color:#FFFFFF">&nbsp;&nbsp;<strong>BOXEO</strong></TD>
        </TR>
    </TABLE>
    <?php include_once('boxeo.php'); ?>
    <?php } ?>
    </div>
    
    <div id="logrosF1">
	<?php if ($activasF1 > 0) { ?>
    <TABLE width="100%" border="0" cellpadding="1" cellspacing="1">
        <TR bgcolor="<?php echo $colorDeporte; ?>">
        	<TD align="center" width="25"><img src="imagenes/ico_f1.png" border="0"></TD>
            <TD align="left" style="color:#FFFFFF">&nbsp;&nbsp;<strong>FÓRMULA 1</strong></TD>
        </TR>
    </TABLE>
    <?php include_once('formula1.php'); ?>
    <?php } ?>
    </div>
	<input type="hidden" id="hora_actual" value="<?php echo date('H:i:s'); ?>">
</FORM>
</td></tr></table>