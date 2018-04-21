<!DOCTYPE html>
<html lang="en">
<head>
    <?php include "cabeceras.php"; ?>
    <script src='https://www.google.com/recaptcha/api.js'></script>
</head>
<body>
    <?php include "header.php"; ?>

    <section id="title" class="emerald">
        <div class="container">
            <div class="row">
                <div class="col-sm-6">
                    <h1>Regístrate</h1>
                    <p>Ingresa los datos solicitados, crea tu cuenta gratis, recarga saldo y empieza a apostar</p>
                </div>
                <div class="col-sm-6">
                    <ul class="breadcrumb pull-right">
                        <li><a href="index.php">Inicio</a></li>
                        <li class="active">Regístrate</li>
                    </ul>
                </div>
            </div>
        </div>
    </section><!--/#title-->     

    <section id="registration" class="container">
        <h4>Formulario de Registro de Usuario</h4>
        <div class="row">
            <div class="col-sm-8">
                <form class="center" role="form">
                    <div class="row">
                        <div class="col-sm-5">
                            <div class="form-group">
                                <input type="text" id="nombres" name="nombres" placeholder="Nombres" class="form-control">
                            </div>
                            <div class="form-group">
                                <input type="text" id="apellidos" name="apellidos" placeholder="Apellidos" class="form-control">
                            </div>
                            <div class="form-group">
                                <input type="text" id="username" name="username" placeholder="Nombre de usuario" class="form-control">
                            </div>
                            <div class="form-group">
                                <input type="text" id="email" name="email" placeholder="Correo electrónico" class="form-control">
                            </div>
                            <div class="form-group">
                                <input type="text" id="fecha_nac" name="fecha_nac" placeholder="Fecha de nacimiento" class="form-control">
                            </div>
                            <div class="form-group">
                                <input type="password" id="password" name="password" placeholder="Password" class="form-control">
                            </div>
                            <div class="form-group">
                                <input type="password" id="password_confirm" name="password_confirm" placeholder="Password (Confirmar)" class="form-control">
                            </div>
                            <div class="form-group">
                                <button class="btn btn-warning btn-md btn-block">Crear mi cuenta</button>
                            </div>
                        </div>
                        <div class="col-sm-7">
                            <div class="form-group">
                                <textarea name="message" id="message" required="required" class="form-control" rows="8" placeholder="Mensaje" readonly="true">CONDICIONES DE USO</textarea>
                            </div>
                            <div class="form-group">
                                <input type="checkbox" name="condiciones"> Acepto todos los términos y condiciones de uso
                            </div>
                            <div class="form-group">
                                <div class="g-recaptcha" align="center" data-sitekey="6LcP-CYTAAAAAJD-nUPEt1c_p_5nZ0FTLbMouidA"></div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </section>
    <!--6LcP-CYTAAAAAGxYvpOgyO6RU4qHZeb_iscSg-H7-->
    <?php include "bottom.php"; ?>

    <?php include "footer.php"; ?>

    <?php include "scripts.php"; ?>
</body>
</html>