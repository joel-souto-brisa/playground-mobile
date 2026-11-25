// import '../models/films_model.dart'; // model import removed
import 'api_client.dart';

class FilmsService {
  FilmsService(this._apiClient);

  final ApiClient _apiClient;

  Future<List<dynamic>> getFilms() async {
    final response = await _apiClient.dio.get<Map<String, dynamic>>(
      "films/",
    );

    final data = response.data;
    if (data == null || data["results"] is! List){
      throw const FormatException("Resposta inválida ao buscar filmes");
    }

    final results = data["results"] as List<dynamic>;

    return results;
  }
}
