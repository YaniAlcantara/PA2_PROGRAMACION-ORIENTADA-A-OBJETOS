package com.lideratec;

public class ProValidacion {

    // Revisa carácter por carácter que todos sean dígitos.
    // Si el texto es null o vacío, devuelve false (no hay nada que validar).
    public static boolean soloNumeros(String texto) {
        if (texto == null || texto.length() == 0) {
            return false;
        }
        for (int i = 0; i < texto.length(); i++) {
            char c = texto.charAt(i);
            if (c < '0' || c > '9') {
                return false;
            }
        }
        return true;
    }

    // El RUC debe tener exactamente 11 dígitos numéricos
    public static boolean esRucValido(String ruc) {
        if (ruc == null) {
            return false;
        }
        String rucLimpio = ruc.trim(); // trim quita espacios al inicio y al final
        return rucLimpio.length() == 11 && soloNumeros(rucLimpio);
    }

    // El teléfono debe tener 9 dígitos numéricos y empezar con 9 (celular)
    public static boolean esTelefonoValido(String telefono) {
        if (telefono == null) {
            return false;
        }
        String telefonoLimpio = telefono.trim();
        return telefonoLimpio.length() == 9
                && soloNumeros(telefonoLimpio)
                && telefonoLimpio.startsWith("9");
    }

    // Valida el formato del correo sin exigir una terminación específica,
    // para aceptar tanto .com como .com.pe, .pe, etc.
    // Nota: la página decide si el correo es opcional (vacío) o no.
    public static boolean esCorreoValido(String correo) {
        if (correo == null) {
            return false;
        }
        String correoLimpio = correo.trim();
        if (correoLimpio.length() == 0 || correoLimpio.contains(" ")) {
            return false;
        }
        int posArroba = correoLimpio.indexOf("@");
        int ultimoPunto = correoLimpio.lastIndexOf(".");

        // Debe haber exactamente un @ y no puede estar al inicio
        if (posArroba < 1 || posArroba != correoLimpio.lastIndexOf("@")) {
            return false;
        }
        // Debe haber un punto después del @, con al menos un carácter entre ambos,
        // y el punto no puede ser el último carácter
        return ultimoPunto > posArroba + 1 && ultimoPunto < correoLimpio.length() - 1;
    }

    // La razón social debe tener al menos 3 caracteres (sin contar espacios de los bordes)
    public static boolean esRazonSocialValida(String razonSocial) {
        if (razonSocial == null) {
            return false;
        }
        return razonSocial.trim().length() >= 3;
    }

    // Deja la razón social en mayúsculas, sin espacios en los bordes
    // y sin espacios dobles entre palabras
    public static String formatearRazonSocial(String razonSocial) {
        if (razonSocial == null) {
            return "";
        }
        String resultado = razonSocial.trim().toUpperCase();
        while (resultado.contains("  ")) {
            resultado = resultado.replace("  ", " ");
        }
        return resultado;
    }

    // Genera un código de cliente: 3 primeras letras de la razón social + últimos 4 dígitos del RUC
    // Ejemplo: "Tecno Perú SAC" y "20123456789" -> "TEC-6789"
    public static String generarCodigoCliente(String razonSocial, String ruc) {
        String nombre = formatearRazonSocial(razonSocial).replace(" ", "");
        String letras;
        if (nombre.length() >= 3) {
            letras = nombre.substring(0, 3);
        } else {
            letras = nombre;
        }

        String digitos = "";
        if (ruc != null && ruc.trim().length() >= 4) {
            String rucLimpio = ruc.trim();
            digitos = rucLimpio.substring(rucLimpio.length() - 4);
        }
        return letras + "-" + digitos;
    }
}
