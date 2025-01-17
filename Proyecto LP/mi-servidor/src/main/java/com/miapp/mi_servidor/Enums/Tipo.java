package com.miapp.mi_servidor.Enums;


public enum Tipo {
    SEDAN("Sedan"),
    COUPE("Coupe"),
    CONVERTIBLE("Convertible"),
    HATCHBACK("Hatch-Back"),
    SUV("SUV"),
    PICK_UP("Pick-Up"),
    HIBRIDO("Hibrido"),
    LIMOSINA("Limosina"),
    ELECTRICO("Electrico");

    private final String displayName;

    Tipo(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }

}
