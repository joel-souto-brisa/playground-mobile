import 'package:flutter_application_1/models/planet_model.dart';
import 'package:flutter_application_1/service/planet_service.dart';

import 'in_memory_cache.dart';

class PlanetRepository {
  PlanetRepository(this._planetService);

  final PlanetService _planetService;
  final _cache = InMemoryCache<List<Planet>>(
    storageKey: 'planet_cache',
    toJson: (planets) => planets.map((p) => p.toJson()).toList(),
    fromJson: (json) => (json as List<dynamic>)
        .map((item) => Planet.fromJson(item as Map<String, dynamic>))
        .toList(),
  );

  Future<List<Planet>> getPlanets({bool refresh = false}) {
    return _cache.get(() async {
      final raw = await _planetService.getPlanets();
      return raw
          .map((item) => Planet.fromJson(item as Map<String, dynamic>))
          .toList();
    }, refresh: refresh);
  }
}