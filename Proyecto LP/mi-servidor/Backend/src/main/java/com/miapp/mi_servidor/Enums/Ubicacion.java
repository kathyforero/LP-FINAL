package com.miapp.mi_servidor.Enums;

/**
 *
 * @author Kathy
 */
public enum Ubicacion {
    AZUAY("Azuay"),
    BOLIVAR("Bolivar"),
    CAÑAR("Cañar"),
    CARCHI("Carchi"),
    CHIMBORAZO("Chimborazo"),
    COTOPAXI("Cotopaxi"),
    EL_ORO("El Oro"),
    ESMERALDAS("Esmeraldas"),
    GALAPAGOS("Galapagos"),
    GUAYAS("Guayas"),
    IMBABURA("Imbabura"),
    LOJA("Loja"),
    LOS_RIOS("Los Rios"),
    MANABI("Manabi"),
    MORONA_SANTIAGO("Morona Santiago"),
    NAPO("Napo"),
    ORELLANA("Orellana"),
    PASTAZA("Pastaza"),
    PICHINCHA("Pichincha"),
    SANTA_ELENA("Santa Elena"),
    SANTO_DOMINGO_DE_LOS_TSACHILAS("Santo Domingo de los Tsachilas"),
    SUCUMBIOS("Sucumbios"),
    TUNGURAHUA("Tungurahua"),
    ZAMORA_CHINCHIPE("Zamora Chinchipe");

    private final String displayName;

    Ubicacion(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }

     // Método fromValue
     public static Ubicacion fromValue(String value) {
        for (Ubicacion ubicacion : Ubicacion.values()) {
            if (ubicacion.getDisplayName().equalsIgnoreCase(value)) {
                return ubicacion;
            }
        }
        throw new IllegalArgumentException("Valor inválido para el enum Ubicacion: " + value);
    }
}
