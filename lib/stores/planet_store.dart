import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import 'package:flutter_application_1/models/planet_model.dart';
import 'package:flutter_application_1/repository/planet_repository.dart';

part 'planet_store.g.dart';

class PlanetStore = _PlanetStore with _$PlanetStore;

abstract class _PlanetStore with Store {
  _PlanetStore(this._planetRepository);

  final PlanetRepository _planetRepository;

  @observable
  List<Planet> planets = [];

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action 
  Future<void> loadPlanets() async {
    isLoading = true;
    errorMessage = null;
  
    try {
      planets = await _planetRepository.getPlanets();
    } on DioException catch (error) {
      errorMessage = error.message ?? "Erro ao consultar a API";
    } on FormatException catch (error) {
      errorMessage = error.message;
    } finally {
      isLoading = false;
    }
    }
}
