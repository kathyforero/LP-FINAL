package com.miapp.mi_servidor.Enums;

public enum Motor {
    GASOLINA("Gasolina"),
    DIESEL("Diésel"),
    ELÉCTRICO("Eléctrico"),
    HÍBRIDO("Híbrido"),
    GAS("Gas");

    private final String displayName;

    Motor(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
