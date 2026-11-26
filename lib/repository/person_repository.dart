import 'package:flutter_application_1/models/person_model.dart';
import 'package:flutter_application_1/service/person_service.dart';

import 'in_memory_cache.dart';

class PersonRepository {
  PersonRepository(this._personService);

  final PersonService _personService;
  final _cache = InMemoryCache<List<Person>>(
    storageKey: 'person_cache',
    toJson: (people) => people.map((p) => p.toJson()).toList(),
    fromJson: (json) => (json as List<dynamic>)
        .map((item) => Person.fromJson(item as Map<String, dynamic>))
        .toList(),
  );

  Future<List<Person>> getPerson({bool refresh = false}) {
    return _cache.get(() async {
      final raw = await _personService.getPerson();
      return raw
          .map((item) => Person.fromJson(item as Map<String, dynamic>))
          .toList();
    }, refresh: refresh);
  }
}