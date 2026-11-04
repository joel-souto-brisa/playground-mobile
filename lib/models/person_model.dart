class Person {
  const Person({
    required this.name,
    required this.height,
    required this.mass,
    required this.hairColor,
    required this.skinColor,
    required this.eyeColor,
    required this.birthYear,
    required this.gender,
    required this.homeWorld, 
    required this.films,
    required this.species,
    required this.vehicles,
    required this.starships
  });

  final String name;
  final String height;
  final String mass;
  final String hairColor;
  final String skinColor;
  final String eyeColor;
  final String birthYear;
  final String gender;
  final String homeWorld;
  final List<String> films;
  final List<String> species;
  final List<String> vehicles;
  final List<String> starships;


  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'] as String,
      height: json['height'] as String,
      mass: json['mass'] as String,
      hairColor: json['hair_color'] as String,
      skinColor: json['skin_color'] as String,
      eyeColor: json['eye_color'] as String,
      birthYear: json['birth_year'] as String,
      gender: json['gender'] as String,
      homeWorld: json["homeworld"] as String,
      films: List<String>.from(json["films"] as List),
      species: List<String>.from(json["species"] as List),
      vehicles: List<String>.from(json["vehicles"] as List),
      starships: List<String>.from(json["starships"] as List),
    );
  }
}
