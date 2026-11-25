// import '../models/planet_model.dart'; // model import removed
import 'api_client.dart';

class PlanetService {
  PlanetService(this._apiClient);

  final ApiClient _apiClient;


  Future<List<dynamic>> getPlanets() async {
    final response = await _apiClient.dio.get<Map<String, dynamic>>(
      "planets/",
      );

      final data = response.data;
      if (data == null || data["results"] is! List) {
        throw const FormatException('Resposta inválida ao buscar planetas.');
      }

      final results = data['results'] as List<dynamic>;

      return results;
  }
}