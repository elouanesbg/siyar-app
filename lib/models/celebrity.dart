class Celebrity {
  final int id;
  final String name;
  final String biography;
  final String normalizeName;

  Celebrity(
      {required this.id,
      required this.name,
      required this.biography,
      required this.normalizeName});

  factory Celebrity.fromJson(Map<String, dynamic> data) {
    return Celebrity(
        id: data["id"],
        name: data["name"],
        biography: data["biography"],
        normalizeName: data["normalize_name"]);
  }
}
