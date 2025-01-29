enum MarcaDeAutoEnum {
  audi("Audi", ["A1", "A3", "A4", "Q3", "Q5", "Q7"]),
  bmw("BMW", ["Series 1", "Series 3", "Series 5", "X1", "X3", "X5"]),
  chevrolet("Chevrolet", ["Spark", "Aveo", "Cruze", "Sail", "Captiva", "Tracker"]),
  ferrari("Ferrari", ["488", "F8", "Roma", "Portofino", "SF90"]),
  ford("Ford", ["F-150", "Ranger", "Explorer", "Escape", "Mustang"]),
  honda("Honda", ["Civic", "CR-V", "HR-V", "Accord", "Pilot"]),
  hyundai("Hyundai", ["Elantra", "Tucson", "Santa Fe", "Kona", "Accent"]),
  jeep("Jeep", ["Wrangler", "Cherokee", "Grand Cherokee", "Compass", "Renegade"]),
  kia("Kia", ["Rio", "Sportage", "Sorento", "Seltos", "Picanto"]),
  maserati("Maserati", ["Ghibli", "Levante", "Quattroporte", "GranTurismo", "GranCabrio"]),
  mazda("Mazda", ["Mazda2", "Mazda3", "Mazda6", "CX-3", "CX-5", "CX-9"]),
  nissan("Nissan", ["Versa", "Sentra", "Altima", "Maxima", "Pathfinder", "Frontier"]),
  peugeot("Peugeot", ["208", "308", "3008", "5008"]),
  renault("Renault", ["Kwid", "Duster", "Captur", "Logan", "Sandero"]),
  soueast("Soueast", ["DX3", "DX7", "V5"]),
  toyota("Toyota", ["Corolla", "Hilux", "Fortuner", "Yaris", "Prado"]),
  volkswagen("Volkswagen", ["Polo", "Golf", "Passat", "Tiguan", "Touareg"]),
  volvo("Volvo", ["S60", "S90", "XC40", "XC60", "XC90"]);

  final String displayName;
  final List<String> models;

  const MarcaDeAutoEnum(this.displayName, this.models);

  // Método para obtener el enum desde el displayName
  static MarcaDeAutoEnum? fromDisplayName(String? displayName) {
    return MarcaDeAutoEnum.values.firstWhere(
      (marca) => marca.displayName == displayName,
      orElse: () => throw Exception("Marca no válida: $displayName"),
    );
  }


  
}
