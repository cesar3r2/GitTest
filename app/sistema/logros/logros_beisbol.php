<?php
	session_start();
	ob_start();
	
	include_once ("config.php");
	include ("lib/inc/jqgrid_dist.php");
	include ("../../include/php/common.php");
	
	if ($_SESSION["ESTATUS_USUARIO"] != "AUTENTICADO") {
		$url = "../../login.php";
		echo "<script language=\"JavaScript\" type=\"text/javascript\">location.href=\"".$url."\"</script>";
	}
	
	$db_conf = array(     
                    "type"       => PHPGRID_DBTYPE, 
                    "server"     => PHPGRID_DBHOST,
                    "user"       => PHPGRID_DBUSER,
                    "password"   => PHPGRID_DBPASS,
                    "database"   => PHPGRID_DBNAME
                ); 
	
	$g = new jqgrid($db_conf);
	echo $g->con->ErrorMsg();
	
	// set few params
	$grid["caption"] = "Logros Béisbol";
	$grid["rowNum"] = 15;
	
	$grid["altRows"] = true; 
	$grid["altclass"] = "myAltRowClass";  
	$grid["rowactions"] = true;
	$grid["export"] = array("format"=>"pdf", "filename"=>"my-file", "sheetname"=>"test"); 

	$g->set_options($grid);
	
	// SQL query to display data
	$g->select_command = "SELECT id, encuentro, favorito, 
       hora, ganador1, ganador2, runline1, runline2, srunline1, srunline2,
       altabaja1, altabaja2, v_altabaja, p_inning1, p_inning2, g_mediojuego1, 
       g_mediojuego2, runline_m1, runline_m2, ab_mediojuego1, ab_mediojuego2, v_ab_mediojuego, 
       p_anotar1, p_anotar2, estatus FROM logro_beisbol WHERE fecha='".date('Y-m-d')."'"; 
	
	// set database table for CRUD operations
	$g->table = "logro_beisbol";
	
	$g->set_columns($cols);
	
	// render grid
	$out = $g->render("list1");
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
  <head>
    <title>Parley360 - Logros Béisbol</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <link rel="icon" type="image/x-icon" href="../../imagenes/icono_logo.png">
    <link type="text/css" rel="stylesheet" href="../../estilos/estilos.css"/>
    <link rel="stylesheet" type="text/css" media="screen" href="lib/js/themes/redmond/jquery-ui.custom.css"></link>
    <link rel="stylesheet" type="text/css" media="screen" href="lib/js/jqgrid/css/ui.jqgrid.css"></link>
     <!-- bootstrap3 + jqgrid compatibility css -->
    <link rel="stylesheet" type="text/css" media="screen" href="lib/js/jqgrid/css/ui.jqgrid.bs.css">
    <link href="bootstrap/css/bootstrap3.min.css" rel="stylesheet">
    <link href="../../../css/font-awesome.min.css" rel="stylesheet">
    <link href="../../../css/bootstrap.min.css" rel="stylesheet">
    <link href="../../../css/main.css" rel="stylesheet" />

    <script src="lib/js/jquery.min.js" type="text/javascript"></script>
    <script src="lib/js/jqgrid/js/i18n/grid.locale-es.js" type="text/javascript"></script>
    <script src="lib/js/jqgrid/js/jquery.jqGrid.min.js" type="text/javascript"></script>    
    <script src="lib/js/themes/jquery-ui.custom.min.js" type="text/javascript"></script>
  </head>
  <body>
    <header class="navbar navbar-inverse navbar-fixed-top wet-asphalt" role="banner">
        <div class="container">
            <div class="navbar-header">
                <img class="navbar-brand" src="../../imagenes/logo.png" alt="logo">
            </div>
        </div>
    </header>
                
    <div align="center" style="color: #2B58A5; font-size:14px; margin-bottom: 20px"><strong>Logros Béisbol</strong> | <?php echo fecha_letras();?></div>
    <div align="center" style="margin-bottom: 50px"><?php echo $out?></div>
    <div align="center" style="margin-bottom: 20px">
        <FIELDSET>
            <form name="formu" enctype="multipart/form-data" method="post" id="formu" action="upload.php?accion=beisbol"/>
            <table width="100%" border="0" cellpadding="1" cellspacing="2">
                <tr><td align="left" colspan="2" style="color: #2B58A5; font-size:13px"><strong>Subir Logros desde Archivo TXT</strong></td></tr>
                <TR>
                    <TD>
                        <input type="file" size="40" accept="application/txt" name="archivo" id="archivo">
                        <input type="hidden" name="action" id="action" value="simple" />
                    </TD>
                    <TD style="padding:10px">
                    <button type="submit" class="btn btn-success btn-xd">Subir Archivo</button>
                    </TD>
                    <TD>
                    <a href="../../index.php" title="Ir al inicio" class="btn btn-danger btn-xd" style="color:#fff">Regresar</a>
                    </TD>
                </TR>
            </table>
            </form>
        </FIELDSET>
    </div>
    
    <div align="center" style="margin-bottom: 50px"></div>
    
	<footer id="footer2" class="midnight-blue">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    &copy; 2016. <a href="#">Parley360</a>. Todos los derechos reservados.
                </div>
            </div>
        </div>
	</footer>   
   </body>
</html>