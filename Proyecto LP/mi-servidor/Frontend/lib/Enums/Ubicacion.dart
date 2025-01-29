enum Ubicacion {
  azuay("Azuay", "AZUAY"),
  bolivar("Bolivar", "BOLIVAR"),
  canar("Cañar", "CAÑAR"),
  carchi("Carchi", "CARCHI"),
  chimborazo("Chimborazo", "CHIMBORAZO"),
  cotopaxi("Cotopaxi", "COTOPAXI"),
  elOro("El Oro", "EL_ORO"),
  esmeraldas("Esmeraldas", "ESMERALDAS"),
  galapagos("Galapagos", "GALAPAGOS"),
  guayas("Guayas", "GUAYAS"),
  imbabura("Imbabura", "IMBABURA"),
  loja("Loja", "LOJA"),
  losRios("Los Rios", "LOS_RIOS"),
  manabi("Manabi", "MANABI"),
  moronaSantiago("Morona Santiago", "MORONA_SANTIAGO"), 
  napo("Napo", "NAPO"),
  orellana("Orellana", "ORELLANA"),
  pastaza("Pastaza", "PASTAZA"),
  pichincha("Pichincha", "PICHINCHA"),
  santaElena("Santa Elena", "SANTA_ELENA"),
  santoDomingoDeLosTsachilas("Santo Domingo de los Tsachilas", "SANTO_DOMINGO_DE_LOS_TSACHILAS"),
  sucumbios("Sucumbios", "SUCUMBIOS"),
  tungurahua("Tungurahua", "TUNGURAHUA"),
  zamoraChinchipe("Zamora Chinchipe", "ZAMORA_CHINCHIPE");

  final String displayName;
  final String backendValue;

  const Ubicacion(this.displayName, this.backendValue);

  static String? getBackendValue(String? displayName) {
    return Ubicacion.values.firstWhere(
      (ubicacion) => ubicacion.displayName == displayName,
      orElse: () => throw Exception("Valor inválido para el enum Ubicacion: $displayName"),
    ).backendValue;
  }
}