import 'package:flutter_application_1/models/person_model.dart';
import 'package:flutter_application_1/service/api_client.dart';

class PersonService {
  PersonService(this._apiClient);

  final ApiClient _apiClient;

  
  Future<List<Person>> getPerson() async {
    final response = await _apiClient.dio.get<Map<String, dynamic>>(
      "people/"
    );

    final data = response.data;
    if (data == null || data["results"] is! List){
      throw const FormatException("Resposta inválida ao buscar pessoas");
    }

    final result = data["results"] as List<dynamic>;

    return result.map((item) {
      if (item is! Map<String, dynamic>){
        throw const FormatException("Pessoa recebida em formato inválido.");
      }

      return Person.fromJson(item);
    }).toList();
  }
}