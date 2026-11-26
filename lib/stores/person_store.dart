import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import 'package:flutter_application_1/models/person_model.dart';
import 'package:flutter_application_1/repository/person_repository.dart';

part 'person_store.g.dart';

class PersonStore = _PersonStore with _$PersonStore;

abstract class _PersonStore with Store {
  _PersonStore(this._personRepository);

  final PersonRepository _personRepository;

  @observable
  List<Person> person = [];

  @observable
  String searchQuery = '';

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @computed
  List<Person> get filteredPerson {
    final query = searchQuery.trim().toLowerCase();
    if (query.isEmpty) return person;

    return person.where((item) {
      return item.name.toLowerCase().contains(query) ||
          item.gender.toLowerCase().contains(query) ||
          item.birthYear.toLowerCase().contains(query);
    }).toList();
  }

  @action
  void setSearchQuery(String value) {
    searchQuery = value;
  }

  @action
  Future<void> loadPerson({bool refresh = false}) async {
    isLoading = true;
    errorMessage = null;

    try {
      person = await _personRepository.getPerson(refresh: refresh);
    } on DioException catch (error) {
      errorMessage = error.message ?? 'Erro ao consultar API.';
    } on FormatException catch (error) {
      errorMessage = error.message;
    } finally {
      isLoading = false;
    }
  }
}