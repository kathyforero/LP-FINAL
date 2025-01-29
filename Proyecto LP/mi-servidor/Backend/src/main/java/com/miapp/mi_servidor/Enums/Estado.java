package com.miapp.mi_servidor.Enums;

public enum Estado {
    NUEVO("Nuevo"),
    USADO("Usado");

    private final String displayName;

    Estado(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }

    // Método fromValue
    public static Estado fromValue(String value) {
        for (Estado estado : Estado.values()) {
            if (estado.getDisplayName().equalsIgnoreCase(value)) {
                return estado;
            }
        }
        throw new IllegalArgumentException("Valor inválido para el enum Estado: " + value);
    }
}