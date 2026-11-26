import 'package:flutter_application_1/models/films_model.dart';
import 'package:flutter_application_1/service/films_service.dart';

import 'in_memory_cache.dart';

class FilmsRepository {
  FilmsRepository(this._filmsService);

  final FilmsService _filmsService;
  final _cache = InMemoryCache<List<Film>>(
    storageKey: 'films_cache',
    toJson: (films) => films.map((f) => f.toJson()).toList(),
    fromJson: (json) => (json as List<dynamic>)
        .map((item) => Film.fromJson(item as Map<String, dynamic>))
        .toList(),
  );

  Future<List<Film>> getFilms({bool refresh = false}) {
    return _cache.get(() async {
      final raw = await _filmsService.getFilms();
      return raw
          .map((item) => Film.fromJson(item as Map<String, dynamic>))
          .toList();
    }, refresh: refresh);
  }
}