enum Motor {
  gasolina("Gasolina", "GASOLINA"),
  diesel("Diesel", "DIESEL"),
  electrico("Electrico", "ELECTRICO"),
  hibrido("Hibrido", "HIBRIDO"),
  gas("Gas", "GAS");

  final String displayName;
  final String backendValue;

  const Motor(this.displayName, this.backendValue);

  static String? getBackendValue(String? displayName) {
    return Motor.values.firstWhere(
      (motor) => motor.displayName == displayName,
      orElse: () => throw Exception("Valor inválido para el enum Motor: $displayName"),
    ).backendValue;
  }

  static String? getDisplayName(String? backendValue) {
    return Motor.values.firstWhere(
      (motor) => motor.backendValue == backendValue,
      orElse: () => throw Exception("Motor no válido: $backendValue"),
    ).displayName;
  }
}