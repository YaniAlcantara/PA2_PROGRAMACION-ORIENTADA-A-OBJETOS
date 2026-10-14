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

<% if (datosValidos) { %>
    <h1>BIENVENIDO, <%= razonsocial.toUpperCase() %></h1>
    <h2>¿Qué desea cotizar?</h2>
    <p>Indique la cantidad de cada producto (deje 0 si no lo necesita).</p>

    <form action="resultados.jsp" method="post" novalidate>
        <input type="hidden" name="ruc" value="<%= ruc %>">
        <input type="hidden" name="razonsocial" value="<%= razonsocial %>">
        <input type="hidden" name="telefono" value="<%= telefono %>">
        <input type="hidden" name="mail" value="<%= mail %>">

        <p>Laptop Core i5: <input type="text" name="cant1" value="0"></p>
        <p>Monitor 24 pulgadas: <input type="text" name="cant2" value="0"></p>
        <p>Teclado mecánico: <input type="text" name="cant3" value="0"></p>
        <p>Mouse inalámbrico: <input type="text" name="cant4" value="0"></p>
        <p><input type="submit" value="Cotizar"></p>
    </form>
<% } else { %>
    <h1>Revise los datos ingresados</h1>
    <% if (!msgRuc.equals("")) { %><p><%= msgRuc %></p><% } %>
    <% if (!msgRazon.equals("")) { %><p><%= msgRazon %></p><% } %>
    <% if (!msgTelefono.equals("")) { %><p><%= msgTelefono %></p><% } %>
    <% if (!msgMail.equals("")) { %><p><%= msgMail %></p><% } %>
    <p><a href="index.jsp">Volver</a></p>
<% } %>



</body>
</html>
