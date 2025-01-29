package com.miapp.mi_servidor.Enums;

public enum Motor {
    GASOLINA("Gasolina"),
    DIESEL("Diesel"),
    ELÉCTRICO("Electrico"),
    HÍBRIDO("Hibrido"),
    GAS("Gas");

    private final String displayName;

    Motor(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
    
    public static Motor fromValue(String value) {
        for (Motor motor : Motor.values()) {
            if (motor.getDisplayName().equalsIgnoreCase(value)) {
                return motor;
            }
        }
        throw new IllegalArgumentException("Valor inválido para el enum Motor: " + value);
    }
}
