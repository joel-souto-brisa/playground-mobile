import 'package:dio/dio.dart';
import 'package:flutter_application_1/models/films_model.dart';
import 'package:flutter_application_1/models/person_model.dart';
import 'package:flutter_application_1/models/planet_model.dart';
import 'package:flutter_application_1/repository/favorite_repository.dart';
import 'package:flutter_application_1/repository/films_repository.dart';
import 'package:flutter_application_1/repository/person_repository.dart';
import 'package:flutter_application_1/repository/planet_repository.dart';
import 'package:mobx/mobx.dart';

part 'favorite_store.g.dart';

class FavoriteStore = _FavoriteStore with _$FavoriteStore;

abstract class _FavoriteStore with Store {
  _FavoriteStore(
    this._favoriteRepository,
    this._personRepository,
    this._planetRepository,
    this._filmsRepository,
  );

  final FavoriteRepository _favoriteRepository;
  final PersonRepository _personRepository;
  final PlanetRepository _planetRepository;
  final FilmsRepository _filmsRepository;

  @observable
  List<Film> favoriteFilms = [];

  @observable
  List<Person> favoritePeople = [];

  @observable
  List<Planet> favoritePlanets = [];

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> loadFavorites() async {
    isLoading = true;
    errorMessage = null;

    try {
      final favoriteIds = await _favoriteRepository.getFavorites();
      final people = await _personRepository.getPerson();
      final planets = await _planetRepository.getPlanets();
      final films = await _filmsRepository.getFilms();

      favoritePeople = people
          .where((person) => favoriteIds.contains('person:${person.name}'))
          .toList();  
      favoritePlanets = planets
          .where((planet) => favoriteIds.contains('planet:${planet.name}'))
          .toList();
      favoriteFilms = films
          .where((film) => favoriteIds.contains('film:${film.episodeId}'))
          .toList();
    } on DioException catch (error) {
      errorMessage = error.message ?? 'Erro ao consultar a API.';
    } on FormatException catch (error) {
      errorMessage = error.message;
    } on Exception catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> removeFavorite(String itemId) async {
    errorMessage = null;

    try {
      await _favoriteRepository.toggleFavorite(itemId);
      favoritePeople = favoritePeople
          .where((person) => itemId != 'person:${person.name}')
          .toList();
      favoritePlanets = favoritePlanets
          .where((planet) => itemId != 'planet:${planet.name}')
          .toList();
      favoriteFilms = favoriteFilms
          .where((film) => itemId != 'film:${film.episodeId}')
          .toList();
    } on Exception catch (error) {
      errorMessage = error.toString();
    }
  }
}
