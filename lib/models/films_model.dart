class Film {
  const Film({
    required this.title,
    required this.episodeId,
    required this.openingCrawl,
    required this.director,
    required this.producer,
    required this.releaseDate,
    required this.characters,
    required this.planets,
    required this.starships,
    required this.vehicles,
    required this.species,
  });

  final String title;
  final int episodeId;
  final String openingCrawl;
  final String director;
  final String producer;
  final String releaseDate;
  final List<String> characters;
  final List<String> planets;
  final List<String> starships;
  final List<String> vehicles;
  final List<String> species;

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      title: json['title'] as String,
      episodeId: json['episode_id'] as int,
      openingCrawl: json['opening_crawl'] as String,
      director: json['director'] as String,
      producer: json['producer'] as String,
      releaseDate: json['release_date'] as String,
      characters: List<String>.from(json['characters'] as List),
      planets: List<String>.from(json['planets'] as List),
      starships: List<String>.from(json['starships'] as List),
      vehicles: List<String>.from(json['vehicles'] as List),
      species: List<String>.from(json['species'] as List),
    );
  }
}