// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'films_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FilmsStore on _FilmsStore, Store {
  Computed<List<Film>>? _$filteredFilmsComputed;

  @override
  List<Film> get filteredFilms =>
      (_$filteredFilmsComputed ??= Computed<List<Film>>(
        () => super.filteredFilms,
        name: '_FilmsStore.filteredFilms',
      )).value;

  late final _$filmsAtom = Atom(name: '_FilmsStore.films', context: context);

  @override
  List<Film> get films {
    _$filmsAtom.reportRead();
    return super.films;
  }

  @override
  set films(List<Film> value) {
    _$filmsAtom.reportWrite(value, super.films, () {
      super.films = value;
    });
  }

  late final _$searchQueryAtom = Atom(
    name: '_FilmsStore.searchQuery',
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
    name: '_FilmsStore.isLoading',
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
    name: '_FilmsStore.errorMessage',
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

  late final _$loadFilmsAsyncAction = AsyncAction(
    '_FilmsStore.loadFilms',
    context: context,
  );

  @override
  Future<void> loadFilms({bool refresh = false}) {
    return _$loadFilmsAsyncAction.run(() => super.loadFilms(refresh: refresh));
  }

  late final _$_FilmsStoreActionController = ActionController(
    name: '_FilmsStore',
    context: context,
  );

  @override
  void setSearchQuery(String value) {
    final _$actionInfo = _$_FilmsStoreActionController.startAction(
      name: '_FilmsStore.setSearchQuery',
    );
    try {
      return super.setSearchQuery(value);
    } finally {
      _$_FilmsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
films: ${films},
searchQuery: ${searchQuery},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
filteredFilms: ${filteredFilms}
    ''';
  }
}
