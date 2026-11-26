// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planet_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlanetStore on _PlanetStore, Store {
  Computed<List<Planet>>? _$filteredPlanetsComputed;

  @override
  List<Planet> get filteredPlanets =>
      (_$filteredPlanetsComputed ??= Computed<List<Planet>>(
        () => super.filteredPlanets,
        name: '_PlanetStore.filteredPlanets',
      )).value;

  late final _$planetsAtom = Atom(
    name: '_PlanetStore.planets',
    context: context,
  );

  @override
  List<Planet> get planets {
    _$planetsAtom.reportRead();
    return super.planets;
  }

  @override
  set planets(List<Planet> value) {
    _$planetsAtom.reportWrite(value, super.planets, () {
      super.planets = value;
    });
  }

  late final _$searchQueryAtom = Atom(
    name: '_PlanetStore.searchQuery',
    context: context,
  );

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_PlanetStore.isLoading',
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
    name: '_PlanetStore.errorMessage',
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

  late final _$loadPlanetsAsyncAction = AsyncAction(
    '_PlanetStore.loadPlanets',
    context: context,
  );

  @override
  Future<void> loadPlanets({bool refresh = false}) {
    return _$loadPlanetsAsyncAction.run(
      () => super.loadPlanets(refresh: refresh),
    );
  }

  late final _$_PlanetStoreActionController = ActionController(
    name: '_PlanetStore',
    context: context,
  );

  @override
  void setSearchQuery(String value) {
    final _$actionInfo = _$_PlanetStoreActionController.startAction(
      name: '_PlanetStore.setSearchQuery',
    );
    try {
      return super.setSearchQuery(value);
    } finally {
      _$_PlanetStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
planets: ${planets},
searchQuery: ${searchQuery},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
filteredPlanets: ${filteredPlanets}
    ''';
  }
}
