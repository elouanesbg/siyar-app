class Celebrity {
  final int id;
  final String name;
  final String biography;

  Celebrity({required this.id, required this.name, required this.biography});

  factory Celebrity.fromJson(Map<String, dynamic> data) {
    return Celebrity(
        id: data["id"], name: data["name"], biography: data["biography"]);
  }
}
