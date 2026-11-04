import 'package:flutter_application_1/models/person_model.dart';
import 'package:flutter_application_1/service/person_service.dart';

class PersonRepository {
  PersonRepository(this._personService);

  final PersonService _personService;

  Future<List<Person>> getPerson(){
    return _personService.getPerson();
  }
}