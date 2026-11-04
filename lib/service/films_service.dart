import '../models/films_model.dart';
import 'api_client.dart';

class FilmsService {
  FilmsService(this._apiClient);

  final ApiClient _apiClient;

  Future<List<Film>> getFilms() async {
    final response = await _apiClient.dio.get<Map<String, dynamic>>(
      "films/",
    );

    final data = response.data;
    if (data == null || data["results"] is! List){
      throw const FormatException("Resposta inválida ao buscar filmes");
    }

    final results = data["results"] as List<dynamic>;

    return results.map((item) {
      if (item is! Map<String, dynamic>){
        throw const FormatException("Filme recebido em formato inválido.");
      }

      return Film.fromJson(item);
    }).toList();
  }
}
