import 'package:flutter_application_1/repository/films_repository.dart';
import 'package:flutter_application_1/repository/person_repository.dart';
import 'package:flutter_application_1/repository/planet_repository.dart';
import 'package:flutter_application_1/service/api_client.dart';
import 'package:flutter_application_1/service/auth_service.dart';
import 'package:flutter_application_1/service/films_service.dart';
import 'package:flutter_application_1/service/person_service.dart';
import 'package:flutter_application_1/service/planet_service.dart';
import 'package:flutter_application_1/stores/films_store.dart';
import 'package:flutter_application_1/stores/person_store.dart';
import 'package:flutter_application_1/stores/planet_store.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());

  getIt.registerLazySingleton<FilmsService>(() => FilmsService(getIt<ApiClient>()));
  getIt.registerLazySingleton<FilmsRepository>(() => FilmsRepository(getIt<FilmsService>()));
  getIt.registerFactory<FilmsStore>(() => FilmsStore(getIt<FilmsRepository>()));

  getIt.registerLazySingleton<PersonService>(() => PersonService(getIt<ApiClient>()));
  getIt.registerLazySingleton<PersonRepository>(() => PersonRepository(getIt<PersonService>()));
  getIt.registerFactory<PersonStore>(() => PersonStore(getIt<PersonRepository>()));

  getIt.registerLazySingleton<PlanetService>(() => PlanetService(getIt<ApiClient>()));
  getIt.registerLazySingleton<PlanetRepository>(() => PlanetRepository(getIt<PlanetService>()));
  getIt.registerFactory<PlanetStore>(() => PlanetStore(getIt<PlanetRepository>()));

  getIt.registerLazySingleton<AuthService>(() => AuthService());
}