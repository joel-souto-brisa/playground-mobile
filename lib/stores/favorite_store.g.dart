// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoriteStore on _FavoriteStore, Store {
  late final _$favoriteFilmsAtom = Atom(
    name: '_FavoriteStore.favoriteFilms',
    context: context,
  );

  @override
  List<Film> get favoriteFilms {
    _$favoriteFilmsAtom.reportRead();
    return super.favoriteFilms;
  }

  @override
  set favoriteFilms(List<Film> value) {
    _$favoriteFilmsAtom.reportWrite(value, super.favoriteFilms, () {
      super.favoriteFilms = value;
    });
  }

  late final _$favoritePeopleAtom = Atom(
    name: '_FavoriteStore.favoritePeople',
    context: context,
  );

  @override
  List<Person> get favoritePeople {
    _$favoritePeopleAtom.reportRead();
    return super.favoritePeople;
  }

  @override
  set favoritePeople(List<Person> value) {
    _$favoritePeopleAtom.reportWrite(value, super.favoritePeople, () {
      super.favoritePeople = value;
    });
  }

  late final _$favoritePlanetsAtom = Atom(
    name: '_FavoriteStore.favoritePlanets',
    context: context,
  );

  @override
  List<Planet> get favoritePlanets {
    _$favoritePlanetsAtom.reportRead();
    return super.favoritePlanets;
  }

  @override
  set favoritePlanets(List<Planet> value) {
    _$favoritePlanetsAtom.reportWrite(value, super.favoritePlanets, () {
      super.favoritePlanets = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_FavoriteStore.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_FavoriteStore.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$loadFavoritesAsyncAction = AsyncAction(
    '_FavoriteStore.loadFavorites',
    context: context,
  );

  @override
  Future<void> loadFavorites() {
    return _$loadFavoritesAsyncAction.run(() => super.loadFavorites());
  }

  late final _$removeFavoriteAsyncAction = AsyncAction(
    '_FavoriteStore.removeFavorite',
    context: context,
  );

  @override
  Future<void> removeFavorite(String itemId) {
    return _$removeFavoriteAsyncAction.run(() => super.removeFavorite(itemId));
  }

  @override
  String toString() {
    return '''
favoriteFilms: ${favoriteFilms},
favoritePeople: ${favoritePeople},
favoritePlanets: ${favoritePlanets},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
