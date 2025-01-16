package com.miapp.mi_servidor.Enums;


public enum Tipo {
    SEDAN("Sedán"),
    COUPE("Coupé"),
    CONVERTIBLE("Convertible"),
    HATCHBACK("Hatch-Back"),
    SUV("SUV"),
    PICK_UP("Pick-Up"),
    HIBRIDO("Híbrido"),
    LIMOSINA("Limosina"),
    ELECTRICO("Eléctrico");

    private final String displayName;

    Tipo(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }

}
