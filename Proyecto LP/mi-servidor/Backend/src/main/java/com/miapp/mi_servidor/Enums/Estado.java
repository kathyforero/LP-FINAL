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
}
