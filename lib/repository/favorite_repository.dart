import 'package:flutter_application_1/models/favorite_items.dart';
import 'package:flutter_application_1/repository/films_repository.dart';
import 'package:flutter_application_1/repository/person_repository.dart';
import 'package:flutter_application_1/repository/planet_repository.dart';
import 'package:flutter_application_1/service/favorite_service.dart';

class FavoriteRepository {
  FavoriteRepository(
    this._favoriteService,
    this._personRepository,
    this._planetRepository,
    this._filmsRepository,
  );

  final FavoriteService _favoriteService;
  final PersonRepository _personRepository;
  final PlanetRepository _planetRepository;
  final FilmsRepository _filmsRepository;

  Future<List<String>> getFavorites() async {
    return _favoriteService.getFavorites();
  }

  Future<FavoriteItems> loadFavoriteItems() async {
    final favoriteIds = (await _favoriteService.getFavorites()).toSet();
    final people = await _personRepository.getPerson();
    final planets = await _planetRepository.getPlanets();
    final films = await _filmsRepository.getFilms();

    return FavoriteItems(
      ids: favoriteIds,
      people: people
          .where((person) => favoriteIds.contains('person:${person.name}'))
          .toList(),
      planets: planets
          .where((planet) => favoriteIds.contains('planet:${planet.name}'))
          .toList(),
      films: films
          .where((film) => favoriteIds.contains('film:${film.episodeId}'))
          .toList(),
    );
  }

  Future<bool> toggleFavorite(String itemId) {
    return _favoriteService.toggleFavorite(itemId);
  }

  Future<bool> isFavorite(String itemId) {
    return _favoriteService.isFavorite(itemId);
  }

  Future<void> removeFavorite(String itemId) {
    return _favoriteService.removeFavorite(itemId);
  }
}
