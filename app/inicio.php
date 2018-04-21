<?php
	session_start();
	ob_start();
	include "include/php/common.php";
	include "conexionConf.php";
	include "clases/class.agencia.php";
	
	$id_agencia = $_SESSION['AGENCIA'];
	$obj = new agencia();
	$fila = $obj->datos_agencia($id_agencia);
?>
	<div class="row">
        <div class="col-md-9">
				<div id="content"> <!-- start content -->
					<div class="post">
						<h2 class="title"><i class="fa fa-home 3x" style="color:#5F9929"></i>&nbsp;inicio</h2>
						<div class="entry">
							<p align="justify">Bienvenido a BetCES. Un parley es una combinación de dos o más opciones de juego. El apostador debe acertar correctamente todas las opciones que escoja. Mientras más opciones se escojan, mayor será el monto que ganará, por cuanto el premio de la primera apuesta será el monto a apostar de la siguiente y así sucesivamente. Con BetCES Parley usted puede registrar todas las apuestas deportivas de sus clientes de una manera rápida, sencilla y segura.</p>
						</div>
					</div>
					<div class="post">
						<h2 class="title"><i class="fa fa-money 3x" style="color:#5F9929"></i>&nbsp;apuestas deportivas</h2>
						<div class="entry">
                            <TABLE align="left" width="100%" border="0" cellpadding="1" cellspacing="1">
                                <TR class="titForm" height="18px">
                                    <TD width="50%" align="center"><strong>Deportes y Ligas</strong></TD>
                                    <TD width="50%" align="center"><strong>Tipos de Apuestas</strong></TD>
                                </TR>
                                <TR>
                                    <TD valign="top" class="objForm">
                                    	<ol>
                                            <li>Béisbol: MLB, LVBP, Serie del Caribe.</li>
                                            <li>Básquetbol: NBA, NCAABK, LPB.</li>
                                            <li>Fútbol: LFP, Calcio, Premier League, Bundesliga, Champions, Eliminatorias, Copas.</li>
                                            <li>Fútbol Americano: NFL.</li>
                                            <li>Hockey: NHL.</li>
                                            <li>Tennis: Grand Slam, Masters 1000.</li>
                                            <li>Boxeo: WBO.</li>
                                            <li>Fórmula 1: Todos los GP del campeonato mundial.</li>
										</ol>
                            		</TD>
                                    <TD valign="top" class="objForm">
                                    	<ol>
                                            <li>Ganador a juego completo o medio juego.</li>
                                            <li>Run Line.</li>
                                            <li>Altas y Bajas a juego completo o medio juego.</li>
                                            <li>Si o No al primer inning.</li>
                                            <li>Anota primero.</li>
										</ol>
                                    </TD>
                                </TR>
                                <TR><TD class="titForm" height="12px"></TD><TD class="titForm"></TD></TR>
                            </TABLE>
						</div>
					</div> <!-- end content -->
				</div>
		</div>
		<div class="col-md-3">
				<div id="sidebar"> <!-- start sidebar -->
					<ul>
						<li>
							<h2><b>menú</b> inicio</h2>
							<ul style="font-size:14px; line-height: 28px">
								<li><i class="fa fa-info-circle" style="color: #069"></i>&nbsp;&nbsp;<a title="Click para ver los créditos de la aplicación" href="acerca.php" target="_blank" onclick="openMyModal('acerca.php'); return false;"><FONT class="txt-verde">Acerca de..</FONT></a></li>
								<li><i class="fa fa-calendar-o" style="color: #069"></i>&nbsp;&nbsp;<?php echo fecha_letras();?></li>
                                <li><i class="fa fa-building-o" style="color: #069"></i>&nbsp;&nbsp;<strong>Agencia: </strong><?php echo $fila[0]['nombre']; ?></li>
                                <li><i class="fa fa-user" style="color: #069"></i>&nbsp;&nbsp;<strong>Usuario: </strong><?php echo $_SESSION["NOMBRE_USUARIO"]; ?></li>
								<li><i class="fa fa-power-off" style="color: #069"></i>&nbsp;&nbsp;<a title="Click para cerrar sesión del usuario"  href="logout.php"><FONT class="txt-verde"><strong>Cerrar Sesión</strong> [<?php echo $_SESSION["USUARIO"];?>]</FONT></a></li>
							</ul>
						</li>
					</ul>
				</div> <!-- end sidebar -->
		</div>
	</div>		