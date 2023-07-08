class Character {
  int id;
  String name;
  String status;
  String species;
  String type;
  String gender;
  String imageUrl;

  Character(
      {required this.id,
      required this.name,
      required this.status,
      required this.species,
      required this.type,
      required this.gender,
      required this.imageUrl});

  factory Character.fromJson(Map<String, dynamic> data) {
    return Character(
        id: data["id"],
        name: data["name"],
        status: data["status"],
        species: data["species"],
        type: data["type"],
        gender: data["gender"],
        imageUrl: data["image"]);
  }
}
