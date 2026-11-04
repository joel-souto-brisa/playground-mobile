import 'package:flutter_application_1/models/films_model.dart';
import 'package:flutter_application_1/service/films_service.dart';

class FilmsRepository {
  FilmsRepository(this._filmsService);
  
  final FilmsService _filmsService;

  Future<List<Film>> getFilms(){
    return _filmsService.getFilms();
  }
}