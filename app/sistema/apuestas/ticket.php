<?php
	session_start();
	ob_start();
	include "../../conexionConf.php";
	include "../../clases/class.apuesta.php";
	include "../../include/php/common.php";
	include "../../include/php/interfaz.php";
	include "../../clases/class.agencia.php";
	
	$nroTicket = $_GET['id'];
	
	$objApuesta = new apuesta();
	$objDetalle = new apuesta();
	
	$fApuesta = $objApuesta->ver_apuesta($nroTicket);
	$fDetalle = $objDetalle->ver_apuesta_detalle($nroTicket);
	
	$id_agencia = $_SESSION['AGENCIA'];
	$obj = new agencia();
	$fila = $obj->datos_agencia($id_agencia);
	$agencia = strtoupper($fila[0]['nombre']);
?>
<HTML>
<HEAD><TITLE></TITLE>
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
<link type="text/css" rel="stylesheet" href="../../estilos/estilos_ticket.css"/>
<script type="text/javascript" src="../../include/js/funciones.js"></script>
</HEAD>
<BODY>
<TABLE align="left" width="320" border="0" cellpadding="0" cellspacing="0">
	<TR align="right">
	    <TD width="235"></TD>
		<TD align="center" style="cursor: pointer; font-size:11px; font-family: Tahoma, Geneva, sans-serif;">
        <a onClick="imprimir_ticket('impresion');"><IMG src="../../imagenes/imprimir.png" border="0"><br>Imprimir</a>
        </TD>
	</TR>
</TABLE>
<BR>
<DIV id="impresion">
<TABLE align="left" cellpadding="0" cellspacing="0" width="300pt" border="0">
	<TR>
    	<TD>
            <TABLE align="center"  width="100%" cellpadding="1pt" cellspacing="0" border="0">
                <TR class="txtR10">
                    <TD align="center"><strong>Parley360</strong></TD>
                </TR>
                <TR class="txtR10">
                    <TD align="center"><strong>AG. <?php echo $agencia;?></strong></TD>
                </TR>
                <TR class="txtR10">
                    <TD align="center"><?php echo fecha($fApuesta[0]['fecha']).' | '.$fApuesta[0]['hora']; ?></TD>
                </TR>
                <TR class="txtR10">
                    <TD align="center">Ticket Nro. <?php echo $nroTicket?></TD>
                </TR>
                <TR class="txtR10">
                    <TD align="center"># <?php echo $fApuesta[0]['id_seguridad']; ?> #</TD>
                </TR>
                <TR class="txtR10" height="50pt">
                    <TD align="center"><strong>JUGADA <?php echo strtoupper($fApuesta[0]['tipo']); ?> REALIZADA</strong></TD>
                </TR>
            </TABLE>
		</TD>
	</TR>
	<TR>
    	<TD>
            <TABLE align="center" cellpadding="2pt" cellspacing="0" border="0">
                <TR class="txtR10">
                    <TD width="135pt"><strong>EQUIPO(S)</strong></TD>
                    <TD width="130pt"><strong>APUESTA</strong></TD>
                    <TD width="35pt" align="right"><strong>LOGRO</strong></TD>
                </TR>
                <TR>
                    <TD colspan="3" style=" line-height:0pt; border-top: dashed; border-top-width: thin;">&nbsp;</TD>
                </TR>
            <?php for($i=0; $i<count($fDetalle); $i++) { ?> 
                <TR  class="txtR10">
                    <TD><?php echo $fDetalle[$i]['equipo'];?></TD>
                    <TD><?php echo $fDetalle[$i]['descripcion_logro'];?></TD>
                    <TD align="right"><?php echo $fDetalle[$i]['nro_logro'];?></TD>
                </TR>
            <?php }?>
                <TR>
                    <TD colspan="3" style="border-top: dashed; border-top-width: thin;">&nbsp;</TD>
                </TR>
                <TR class="txtR10" height="20pt">
                	<TD align="center" colspan="3"><strong>Nro. de Jugadas: (<?php echo count($fDetalle); ?>)</strong></TD>
                </TR>
                <TR class="txtR10" height="20pt">
                    <TD colspan="3" align="center"><strong>Monto Jugado: <?php echo number_format($fApuesta[0]['monto'], 2, ',', '.'); ?> BsF</strong></TD>
                </TR>
                <TR class="txtR10" height="20pt">
                    <TD colspan="3" align="center"><strong>Monto Ganancia: <?php echo number_format($fApuesta[0]['premio']-$fApuesta[0]['monto'], 2, ',', '.'); ?> BsF</strong></TD>
                <TR class="txtR10" height="20pt">
                    <TD colspan="3" align="center"><strong>TOTAL A COBRAR: <?php echo number_format($fApuesta[0]['premio'], 2, ',', '.'); ?> BsF</strong></TD>
                </TR>
                <TR>
                    <TD colspan="3" height="15pt"></TD>
                </TR>
                <TR class="txtR9">
                    <TD colspan="3" align="center"># TICKET VALIDO POR 5 DIAS #</TD>
                </TR>
                <TR class="txtR9">
                    <TD colspan="3" align="center">
                    	<FONT>
                            SIN TICKET NO SE PAGA
                        </FONT>
                    </TD>
                </TR>
                <TR>
                    <TD colspan="3" height="100pt">&nbsp;</TD>
                </TR>
        	</TABLE>
		</TD>
    </TR>
</TABLE>
</DIV>
</BODY>
</HTML>