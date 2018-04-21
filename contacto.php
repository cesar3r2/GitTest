<!DOCTYPE html>
<html lang="en">
<head>
    <?php include "cabeceras.php"; ?>
</head><!--/head-->
<body>
    <?php include "header.php"; ?>

    <section id="title" class="emerald">
        <div class="container">
            <div class="row">
                <div class="col-sm-6">
                    <h1>Contacto</h1>
                    <p>Ingrese sus datos de contacto para cualquier consulta adicional que requiera</p>
                </div>
                <div class="col-sm-6">
                    <ul class="breadcrumb pull-right">
                        <li><a href="index.php">Inicio</a></li>
                        <li class="active">Ayuda</li>
                        <li class="active">Contacto</li>
                    </ul>
                </div>
            </div>
        </div>
    </section><!--/#title-->    

    <section id="contact-page" class="container">
        <div class="row">
            <div class="col-sm-8">
                <h4>Formulario de Contacto</h4>
                <div class="status alert alert-success" style="display: none"></div>
                <form id="main-contact-form" class="contact-form" name="contact-form" method="post" action="sendemail.php" role="form">
                    <div class="row">
                        <div class="col-sm-5">
                            <div class="form-group">
                                <input type="text" class="form-control" required="required" placeholder="Nombre completo">
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" required="required" placeholder="Número telefónico">
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" required="required" placeholder="Correo electrónico">
                            </div>
                            <div class="form-group">
                                <button type="submit" class="btn btn-primary btn-lg">Enviar Mensaje</button>
                            </div>
                        </div>
                        <div class="col-sm-7">
                            <textarea name="message" id="message" required="required" class="form-control" rows="8" placeholder="Mensaje"></textarea>
                        </div>
                    </div>
                </form>
            </div><!--/.col-sm-8-->
        </div>
    </section><!--/#contact-page-->

    
     <?php include "bottom.php"; ?>

    <?php include "footer.php"; ?>

    <?php include "scripts.php"; ?>
</body>
</html>