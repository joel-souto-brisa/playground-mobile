import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import 'package:flutter_application_1/models/films_model.dart';
import 'package:flutter_application_1/repository/films_repository.dart';

part 'films_store.g.dart';

class FilmsStore = _FilmsStore with _$FilmsStore;

abstract class _FilmsStore with Store {
    _FilmsStore(this._filmsRepository);
    final FilmsRepository _filmsRepository;

    @observable
    List<Film> films = [];

    @observable
    bool isLoading = false;

    @observable
    String? errorMessage;

    @action
    Future<void> loadFilms() async{
      isLoading = true;
      errorMessage = null;

      try {
        films = await _filmsRepository.getFilms();
      } on DioException catch (error) {
        errorMessage = error.message ?? "Erro ao consultar a API.";
      } on FormatException catch (error) {
        errorMessage = error.message;
      } finally {
        isLoading = false;
      }
    }
}