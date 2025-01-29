enum Ubicacion {
  azuay("Azuay"),
  bolivar("Bolivar"),
  canar("Cañar"),
  carchi("Carchi"),
  chimborazo("Chimborazo"),
  cotopaxi("Cotopaxi"),
  elOro("El Oro"),
  esmeraldas("Esmeraldas"),
  galapagos("Galapagos"),
  guayas("Guayas"),
  imbabura("Imbabura"),
  loja("Loja"),
  losRios("Los Rios"),
  manabi("Manabi"),
  moronaSantiago("Morona Santiago"),
  napo("Napo"),
  orellana("Orellana"),
  pastaza("Pastaza"),
  pichincha("Pichincha"),
  santaElena("Santa Elena"),
  santoDomingoDeLosTsachilas("Santo Domingo de los Tsachilas"),
  sucumbios("Sucumbios"),
  tungurahua("Tungurahua"),
  zamoraChinchipe("Zamora Chinchipe");

  final String displayName;

  const Ubicacion(this.displayName);

  // Método para obtener el valor del backend desde el displayName
  static String? getBackendValue(String? displayName) {
    return Ubicacion.values.firstWhere(
      (ubicacion) => ubicacion.displayName == displayName,
      orElse: () => throw Exception("Valor inválido para el enum Ubicacion: $displayName"),
    ).name; // Devuelve el nombre del enum para el backend
  }
}
