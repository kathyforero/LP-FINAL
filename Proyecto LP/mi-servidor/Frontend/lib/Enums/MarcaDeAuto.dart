enum MarcaDeAutoEnum {
  audi("Audi"),
  bmw("BMW"),
  chevrolet("Chevrolet"),
  ferrari("Ferrari"),
  ford("Ford"),
  honda("Honda"),
  hyundai("Hyundai"),
  jeep("Jeep"),
  kia("Kia"),
  maserati("Maserati"),
  mazda("Mazda"),
  nissan("Nissan"),
  peugeot("Peugeot"),
  renault("Renault"),
  soueast("Soueast"),
  toyota("Toyota"),
  volkswagen("Volkswagen"),
  volvo("Volvo");

  final String displayName;

  const MarcaDeAutoEnum(this.displayName);

  // Método para obtener el enum desde el displayName
  static MarcaDeAutoEnum? fromDisplayName(String? displayName) {
    return MarcaDeAutoEnum.values.firstWhere(
      (marca) => marca.displayName == displayName,
      orElse: () => throw Exception("Marca no válida: $displayName"),
    );
  }

  // Método para obtener el nombre en mayúsculas para el backend
  static String? getBackendValue(String? displayName) {
    return fromDisplayName(displayName)?.name.toUpperCase();
  }

  static String? getDisplayName(String? backendValue) {
  return MarcaDeAutoEnum.values.firstWhere(
    (marca) => marca.name.toUpperCase() == backendValue,
    orElse: () => throw Exception("Marca no válida: $backendValue"),
  ).displayName;
}
}

