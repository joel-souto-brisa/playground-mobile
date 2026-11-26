import 'package:dio/dio.dart';
import 'package:flutter_application_1/models/films_model.dart';
import 'package:flutter_application_1/models/person_model.dart';
import 'package:flutter_application_1/models/planet_model.dart';
import 'package:flutter_application_1/repository/favorite_repository.dart';
import 'package:mobx/mobx.dart';

part 'favorite_store.g.dart';

class FavoriteStore = _FavoriteStore with _$FavoriteStore;

abstract class _FavoriteStore with Store {
  _FavoriteStore(this._favoriteRepository);

  final FavoriteRepository _favoriteRepository;

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

  @observable
  Map<String, bool> favoriteStatus = {};

  @action
  Future<void> loadFavorites() async {
    isLoading = true;
    errorMessage = null;

    try {
      final items = await _favoriteRepository.loadFavoriteItems();

      final statuses = {for (final id in favoriteStatus.keys) id: false}
        ..addEntries(items.ids.map((id) => MapEntry(id, true)));
      favoriteStatus = statuses;
      favoritePeople = items.people;
      favoritePlanets = items.planets;
      favoriteFilms = items.films;
    } on DioException catch (error) {
      errorMessage = error.message ?? 'Erro ao consultar a API.';
    } on FormatException catch (error) {
      errorMessage = error.message;
    } on Exception catch (error) {
      errorMessage = error.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool?> checkFavorite(String itemId) async {
    errorMessage = null;
    try {
      final isFavorite = await _favoriteRepository.isFavorite(itemId);
      favoriteStatus = {...favoriteStatus, itemId: isFavorite};
      return isFavorite;
    } on Exception catch (error) {
      errorMessage = error.toString().replaceFirst('Exception: ', '');
      return null;
    }
  }

  @action
  Future<bool?> toggleFavorite(String itemId) async {
    errorMessage = null;
    try {
      final isFavorite = await _favoriteRepository.toggleFavorite(itemId);
      favoriteStatus = {...favoriteStatus, itemId: isFavorite};
      return isFavorite;
    } on Exception catch (error) {
      errorMessage = error.toString().replaceFirst('Exception: ', '');
      return null;
    }
  }

  @action
  Future<bool> removeFavorite(String itemId) async {
    errorMessage = null;

    try {
      await _favoriteRepository.removeFavorite(itemId);
      favoriteStatus = {...favoriteStatus, itemId: false};
      favoritePeople = favoritePeople
          .where((person) => itemId != 'person:${person.name}')
          .toList();
      favoritePlanets = favoritePlanets
          .where((planet) => itemId != 'planet:${planet.name}')
          .toList();
      favoriteFilms = favoriteFilms
          .where((film) => itemId != 'film:${film.episodeId}')
          .toList();
      return true;
    } on Exception catch (error) {
      errorMessage = error.toString().replaceFirst('Exception: ', '');
      return false;
    }
  }

  @action
  void clear(){
    favoriteFilms = [];
    favoritePeople = [];
    favoritePlanets = [];
    favoriteStatus = {};
    errorMessage = null;
    isLoading = false;
  }
}
