// import 'package:flutter_application_1/models/person_model.dart'; // model import removed
import 'package:flutter_application_1/service/api_client.dart';

class PersonService {
  PersonService(this._apiClient);

  final ApiClient _apiClient;

  
  Future<List<dynamic>> getPerson() async {
    final response = await _apiClient.dio.get<Map<String, dynamic>>(
      "people/"
    );

    final data = response.data;
    if (data == null || data["results"] is! List){
      throw const FormatException("Resposta inválida ao buscar pessoas");
    }

    final results = data["results"] as List<dynamic>;

    return results;
  }
}