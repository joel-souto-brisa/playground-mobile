import '../models/planet_model.dart';
import 'api_client.dart';

class PlanetService {
  PlanetService(this._apiClient);

  final ApiClient _apiClient;


  Future<List<Planet>> getPlanets() async {
    final response = await _apiClient.dio.get<Map<String, dynamic>>(
      "planets/",
      );

      final data = response.data;
      if (data == null || data["results"] is! List) {
        throw const FormatException('Resposta inválida ao buscar planetas.');
      }

      final results = data['results'] as List<dynamic>;

      return results.map((item) {
        if (item is! Map<String, dynamic>) {
          throw const FormatException("Planeta recebido em formato inválido.");
        }

        return Planet.fromJson(item);
      }).toList();
  }
}