<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.lideratec.ProValidacion" %>
<%@ page import="com.lideratec.ProCotizacion" %>
<%!
    // Convierte el texto de una cantidad en número.
    // Devuelve 0 si viene vacío y -1 si no es válido (letras, signos o más de 4 dígitos).
    // Se valida con soloNumeros ANTES de convertir, para evitar errores al convertir.
    int leerCantidad(String texto) {
        if (texto == null) {
            return 0;
        }
        texto = texto.trim();
        if (texto.length() == 0) {
            return 0;
        }
        if (!ProValidacion.soloNumeros(texto) || texto.length() > 4) {
            return -1;
        }
        return Integer.parseInt(texto);
    }
    // Muestra un monto con 2 decimales, por ejemplo: S/ 569.05
    String dinero(double valor) {
        return "S/ " + String.format(java.util.Locale.US, "%.2f", valor);
    }
%>
<%
    // La codificación debe fijarse antes de leer cualquier parámetro
    request.setCharacterEncoding("UTF-8");
    // ===== 1. Datos del cliente (llegan desde cotizacion.jsp como campos ocultos) =====
    String ruc = request.getParameter("ruc");
    String razonsocial = request.getParameter("razonsocial");
    String telefono = request.getParameter("telefono");
    String mail = request.getParameter("mail");
    if (ruc == null) { ruc = ""; }
    if (razonsocial == null) { razonsocial = ""; }
    if (telefono == null) { telefono = ""; }
    if (mail == null) { mail = ""; }
    ruc = ruc.trim();
    telefono = telefono.trim();
    mail = mail.trim().toLowerCase();
    // ===== 2. Catálogo de productos (precios de ejemplo) =====
    String nombre1 = "Laptop Core i5";       double precio1 = 2499.00;
    String nombre2 = "Monitor 24 pulgadas";  double precio2 = 549.00;
    String nombre3 = "Teclado mecánico";     double precio3 = 189.90;
    String nombre4 = "Mouse inalámbrico";    double precio4 = 59.90;
    // ===== 3. Cantidades solicitadas =====
    int cant1 = leerCantidad(request.getParameter("cant1"));
    int cant2 = leerCantidad(request.getParameter("cant2"));
    int cant3 = leerCantidad(request.getParameter("cant3"));
    int cant4 = leerCantidad(request.getParameter("cant4"));
    boolean cantidadesValidas = cant1 >= 0 && cant2 >= 0 && cant3 >= 0 && cant4 >= 0;
    int totalUnidades = 0; // acumulador de unidades de todos los productos
    if (cantidadesValidas) {
        totalUnidades = cant1 + cant2 + cant3 + cant4;
    }
    // ===== 4. Validaciones =====
    boolean clienteValido = ProValidacion.esRucValido(ruc)
            && ProValidacion.esRazonSocialValida(razonsocial)
            && ProValidacion.esTelefonoValido(telefono)
            && (mail.equals("") || ProValidacion.esCorreoValido(mail));
    String error = "";
    if (!clienteValido) {
        error = "Los datos de la empresa no son válidos. Regrese y complételos nuevamente.";
    } else if (!cantidadesValidas) {
        error = "Las cantidades deben ser números enteros positivos de hasta 4 dígitos.";
    } else if (totalUnidades == 0) {
        error = "Debe indicar la cantidad de al menos un producto.";
    }
    // ===== 5. Cálculos (solo si no hay errores) =====
    double subtotal1 = 0, subtotal2 = 0, subtotal3 = 0, subtotal4 = 0;
    double subtotal = 0, descuento = 0, total = 0, porcentaje = 0;
    String codigoCliente = "";
    if (error.equals("")) {
        subtotal1 = ProCotizacion.calcularSubtotal(precio1, cant1);
        subtotal2 = ProCotizacion.calcularSubtotal(precio2, cant2);
        subtotal3 = ProCotizacion.calcularSubtotal(precio3, cant3);
        subtotal4 = ProCotizacion.calcularSubtotal(precio4, cant4);
        subtotal = subtotal1 + subtotal2 + subtotal3 + subtotal4;
        subtotal = Math.round(subtotal * 100.0) / 100.0; // evita residuos de decimales
        porcentaje = ProCotizacion.calcularPorcentajeDescuento(totalUnidades);
        descuento = ProCotizacion.calcularDescuento(subtotal, totalUnidades);
        total = ProCotizacion.calcularTotal(subtotal, totalUnidades);
        codigoCliente = ProValidacion.generarCodigoCliente(razonsocial, ruc);
        razonsocial = ProValidacion.formatearRazonSocial(razonsocial);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Resultado de la cotización - Computec</title>
</head>
<body>
<% if (!error.equals("")) { %>

    <h1>No se pudo generar la cotización</h1>
    <p><%= error %></p>
    <p><a href="index.jsp">Volver al inicio</a></p>

<% } else { %>

    <h1>Cotización Computec</h1>
    <p>Cliente: <b><%= razonsocial %></b> (código <%= codigoCliente %>)</p>
    <p>RUC: <%= ruc %> | Teléfono: <%= telefono %><% if (!mail.equals("")) { %> | Correo: <%= mail %><% } %></p>

    <table border="1" cellpadding="6" cellspacing="0">
        <tr>
            <th>Producto</th><th>Cantidad</th><th>Precio unitario</th><th>Subtotal</th>
        </tr>
        <% if (cant1 > 0) { %>
        <tr><td><%= nombre1 %></td><td><%= cant1 %></td><td><%= dinero(precio1) %></td><td><%= dinero(subtotal1) %></td></tr>
        <% } %>
        <% if (cant2 > 0) { %>
        <tr><td><%= nombre2 %></td><td><%= cant2 %></td><td><%= dinero(precio2) %></td><td><%= dinero(subtotal2) %></td></tr>
        <% } %>
        <% if (cant3 > 0) { %>
        <tr><td><%= nombre3 %></td><td><%= cant3 %></td><td><%= dinero(precio3) %></td><td><%= dinero(subtotal3) %></td></tr>
        <% } %>
        <% if (cant4 > 0) { %>
        <tr><td><%= nombre4 %></td><td><%= cant4 %></td><td><%= dinero(precio4) %></td><td><%= dinero(subtotal4) %></td></tr>
        <% } %>
    </table>

    <p>Total de unidades: <b><%= totalUnidades %></b></p>
    <p>Subtotal: <%= dinero(subtotal) %></p>

    <% if (porcentaje > 0) { %>
        <p>Descuento por volumen (<%= (int) porcentaje %>%): -<%= dinero(descuento) %></p>
    <% } else { %>
        <p>Sin descuento (se aplica desde 10 unidades en total).</p>
    <% } %>

    <h2>Total a pagar: <%= dinero(total) %></h2>
    <p><a href="index.jsp">Nueva cotización</a></p>

<% } %>
</body>
</html>
