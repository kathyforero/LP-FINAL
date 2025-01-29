enum Transmision {
  manual("Manual", "MANUAL"),
  automatica("Automatica", "AUTOMATICA"),
  cvt("Continuamente Variable", "CVT"),
  dsg("Doble Embrague", "DSG"),
  amt("Manual Automatizada", "AMT"),
  manualSecuencial("Manual Secuencial", "MANUAL_SECUENCIAL"),
  evt("Electronica Variable", "EVT"),
  hidraulica("Hidraulica", "HIDRAULICA");

  final String displayName;
  final String backendValue;

  const Transmision(this.displayName, this.backendValue);

  static String? getBackendValue(String? displayName) {
    return Transmision.values.firstWhere(
      (transmision) => transmision.displayName == displayName,
      orElse: () => throw Exception("Valor inválido para el enum Transmision: $displayName"),
    ).backendValue;
  }
  
  static String? getDisplayName(String? backendValue) {
    return Transmision.values.firstWhere(
      (transmision) => transmision.backendValue == backendValue,
      orElse: () => throw Exception("Transmisión no válida: $backendValue"),
    ).displayName;
  }
}