<!DOCTYPE html>
<html lang="en">
<head>
    <?php include "cabeceras.php"; ?>
</head>
<body>
    <?php include "header.php"; ?>

    <section id="title" class="emerald">
        <div class="container">
            <div class="row">
                <div class="col-sm-6">
                    <h1>Inicia Sesión</h1>
                    <p>Ingresa los datos solicitados de tu cuenta para ingresar al sistema</p>
                </div>
                <div class="col-sm-6">
                    <ul class="breadcrumb pull-right">
                        <li><a href="index.php">Inicio</a></li>
                        <li class="active">Inicia Sesión</li>
                    </ul>
                </div>
            </div>
        </div>
    </section><!--/#title-->     

    <section id="registration" class="container">
        <div class="center">
            <h4>Formulario de Inicio de Sesión</h4>
            <fieldset class="registration-form">
                <div class="form-group">
                    <input type="text" id="usuario" name="username" placeholder="Nombre de usuario" class="form-control">
                </div>
                <div class="form-group">
                    <input type="password" id="clave" name="password" placeholder="Password" class="form-control">
                </div>
                <div class="form-group">
                    <button class="btn btn-success btn-md btn-block" onclick="loguear_usuario();">Ingresar</button>
                </div>
                <div>
                    <input type="hidden" id="tipo_usr" value="0"><input type="hidden" id="nro_pcs" value="0">
                </div>
            </fieldset>
            <div class="status center" id="mensaje" ></div>
        </div>
    </section><!--/#registration-->
    

    <?php include "bottom.php"; ?>

    <?php include "footer.php"; ?>
    <script type="text/javascript" src="app/include/js/AjaxRequest.js"></script>
    <?php include "scripts.php"; ?>
</body>
</html>