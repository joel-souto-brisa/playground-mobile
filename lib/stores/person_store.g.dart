// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PersonStore on _PersonStore, Store {
  Computed<List<Person>>? _$filteredPersonComputed;

  @override
  List<Person> get filteredPerson =>
      (_$filteredPersonComputed ??= Computed<List<Person>>(
        () => super.filteredPerson,
        name: '_PersonStore.filteredPerson',
      )).value;

  late final _$personAtom = Atom(name: '_PersonStore.person', context: context);

  @override
  List<Person> get person {
    _$personAtom.reportRead();
    return super.person;
  }

  @override
  set person(List<Person> value) {
    _$personAtom.reportWrite(value, super.person, () {
      super.person = value;
    });
  }

  late final _$searchQueryAtom = Atom(
    name: '_PersonStore.searchQuery',
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
    name: '_PersonStore.isLoading',
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
    name: '_PersonStore.errorMessage',
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

  late final _$loadPersonAsyncAction = AsyncAction(
    '_PersonStore.loadPerson',
    context: context,
  );

  @override
  Future<void> loadPerson({bool refresh = false}) {
    return _$loadPersonAsyncAction.run(
      () => super.loadPerson(refresh: refresh),
    );
  }

  late final _$_PersonStoreActionController = ActionController(
    name: '_PersonStore',
    context: context,
  );

  @override
  void setSearchQuery(String value) {
    final _$actionInfo = _$_PersonStoreActionController.startAction(
      name: '_PersonStore.setSearchQuery',
    );
    try {
      return super.setSearchQuery(value);
    } finally {
      _$_PersonStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
person: ${person},
searchQuery: ${searchQuery},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
filteredPerson: ${filteredPerson}
    ''';
  }
}
