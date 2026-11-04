import 'package:flutter_application_1/models/planet_model.dart';
import 'package:flutter_application_1/service/planet_service.dart';

class PlanetRepository {
  PlanetRepository(this._planetService);

  final PlanetService _planetService;

  Future<List<Planet>> getPlanets(){
    return _planetService.getPlanets();
  }
}