package com.lideratec;

public class ProCotizacion {
    // Calcula el subtotal del producto
    public static double calcularSubtotal(double precio, int cantidad) {
        double subtotal = precio * cantidad;
        return Math.round(subtotal * 100.0) / 100.0;
}
    // Determina el porcentaje de descuento
    public static double calcularPorcentajeDescuento(int cantidad) {
        double descuento = 0;

        if (cantidad >= 20) {
            descuento = 10;
        } else if (cantidad >= 10) {
            descuento = 5;
        }

        return descuento;
    }

    // Calcula el importe del descuento
    public static double calcularDescuento(double subtotal, int cantidad) {
        double porcentaje = calcularPorcentajeDescuento(cantidad);
        double descuento = subtotal * porcentaje / 100;

        return Math.round(descuento * 100.0) / 100.0;
    }

    // Calcula el total después del descuento
    public static double calcularTotal(double subtotal, int cantidad) {
        double descuento = calcularDescuento(subtotal, cantidad);
        double total = subtotal - descuento;

        return Math.round(total * 100.0) / 100.0;
    }
}
