import 'package:flutter_application_1/models/films_model.dart';
import 'package:flutter_application_1/models/person_model.dart';
import 'package:flutter_application_1/models/planet_model.dart';

class FavoriteItems {
  const FavoriteItems({
    required this.ids,
    required this.people,
    required this.planets,
    required this.films,
  });

  final Set<String> ids;
  final List<Person> people;
  final List<Planet> planets;
  final List<Film> films;
}
