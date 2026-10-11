<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bienvenido a Computec</title>
</head>
<body>
<%!
    // Revisa carácter por carácter que todos sean dígitos
    boolean soloNumeros(String texto) {
        for (int i = 0; i < texto.length(); i++) {
            char c = texto.charAt(i);
            if (c < '0' || c > '9') {
                return false;
            }
        }
        return true;
    }
%>
<%
    String ruc = request.getParameter("ruc");
    String razonsocial = request.getParameter("razonsocial");
    String telefono = request.getParameter("telefono");
    String mail = request.getParameter("mail");

    if (ruc == null) { ruc = ""; }
    if (razonsocial == null) { razonsocial = ""; }
    if (telefono == null) { telefono = ""; }
    if (mail == null) { mail = ""; }

    ruc = ruc.trim();
    razonsocial = razonsocial.trim();
    telefono = telefono.trim();
    mail = mail.trim().toLowerCase();

    String msgRuc = "";
    String msgRazon = "";
    String msgTelefono = "";
    String msgMail = "";


    if (ruc.equals("")) {
        msgRuc = "El RUC no puede estar vacío.";
    } else if (ruc.length() != 11 || !soloNumeros(ruc)) {
        msgRuc = "El RUC debe tener 11 dígitos numéricos.";
    }

    if (razonsocial.equals("")) {
        msgRazon = "La razón social no puede estar vacía.";
    }

    if (telefono.length() != 9 || !soloNumeros(telefono)) {
        msgTelefono = "El teléfono debe tener 9 dígitos numéricos.";
    }

    if (!mail.equals("")) {
        if (!(mail.contains("@") && mail.endsWith(".com"))) {
            msgMail = "El correo debe contener @ y terminar en .com.";
        }
    }
    boolean datosValidos = msgRuc.equals("") && msgRazon.equals("")
    && msgTelefono.equals("") && msgMail.equals("");

%>
       <h1>BIENVENIDO, <%= razonsocial.toUpperCase() %> </h1>
       <h2>¿Que desea cotizar?</h2>



</body>
</html>
