enum EstadoEnum {
  nuevo("Nuevo", "NUEVO"),
  usado("Usado", "USADO");

  final String displayName;
  final String backendValue;

  const EstadoEnum(this.displayName, this.backendValue);

  // Método para obtener el enum desde el displayName
  static EstadoEnum? fromDisplayName(String? displayName) {
    return EstadoEnum.values.firstWhere(
      (estado) => estado.displayName == displayName,
      orElse: () => throw Exception("Estado no válido: $displayName"),
    );
  }

  // Método para obtener el valor backend desde el displayName
  static String? getBackendValue(String? displayName) {
    try {
      return fromDisplayName(displayName)?.backendValue;
    } catch (_) {
      return null; // Retorna null si no encuentra un valor válido
    }
  }

  static String? getDisplayName(String? backendValue) {
  return EstadoEnum.values.firstWhere(
    (estado) => estado.backendValue == backendValue,
    orElse: () => throw Exception("Estado no válido: $backendValue"),
  ).displayName;
}
}
