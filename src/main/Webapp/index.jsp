<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Computec</title>
</head>

<body>
    <h1>Bienvenido a Computec</h1>
     <p>
     Complete el siguiente formulario para registrar
     los datos de su empresa y solicitar una cotizacion.
     </p>

    <form action="cotizacion.jsp" method="post">
        <h2>Datos de la empresa</h2>
        <p>
            <label for="ruc">RUC:</label>
            <input type="text" name="ruc" required>
        </p>
        <p>
            <label for="razonSocial">Razon social:</label>
            <input type="text" name="razonsocial" required>
        </p>
        <p>
            <label for="telefono">Telefono:</label>
            <input type="tel" name="telefono" maxlength="9" required>
        </p>
        <p>
            <label for="mail">Correo:</label>
            <input type="email" name="mail" required>
        </p>
        <p>
            <input type="submit" value="Siguiente">
        </p>
    </form>
</body>
</html>
</html>