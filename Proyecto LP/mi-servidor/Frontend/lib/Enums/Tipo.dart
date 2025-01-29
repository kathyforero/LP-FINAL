enum Tipo {
  sedan("Sedan", "SEDAN"),
  coupe("Coupe", "COUPE"),
  convertible("Convertible", "CONVERTIBLE"),
  hatchback("Hatch-Back", "HATCHBACK"),
  suv("SUV", "SUV"),
  pickUp("Pick-Up", "PICK_UP"),
  hibrido("Hibrido", "HIBRIDO"),
  limosina("Limosina", "LIMOSINA"),
  electrico("Electrico", "ELECTRICO");

  final String displayName;
  final String backendValue;

  const Tipo(this.displayName, this.backendValue);

  static String? getBackendValue(String? displayName) {
    return Tipo.values.firstWhere(
      (tipo) => tipo.displayName == displayName,
      orElse: () => throw Exception("Valor inválido para el enum Tipo: $displayName"),
    ).backendValue;
  }

  static String? getDisplayName(String? backendValue) {
    return Tipo.values.firstWhere(
      (tipo) => tipo.backendValue == backendValue,
      orElse: () => throw Exception("Tipo no válido: $backendValue"),
    ).displayName;
  }
}