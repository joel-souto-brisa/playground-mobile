import 'package:flutter_application_1/repository/favorite_repository.dart';
import 'package:flutter_application_1/repository/films_repository.dart';
import 'package:flutter_application_1/repository/person_repository.dart';
import 'package:flutter_application_1/repository/planet_repository.dart';
import 'package:flutter_application_1/service/api_client.dart';
import 'package:flutter_application_1/service/auth_service.dart';
import 'package:flutter_application_1/service/favorite_service.dart';
import 'package:flutter_application_1/service/films_service.dart';
import 'package:flutter_application_1/service/person_service.dart';
import 'package:flutter_application_1/service/planet_service.dart';
import 'package:flutter_application_1/stores/auth_store.dart';
import 'package:flutter_application_1/stores/favorite_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('auth store registers, logs in, and logs out', () async {
    final store = AuthStore(AuthService());

    expect(await store.register('user@example.com', 'password'), isTrue);
    expect(await store.login('user@example.com', 'password'), isTrue);
    expect(store.isLoggedIn, isTrue);
    expect(await store.logout(), isTrue);
    expect(store.isLoggedIn, isFalse);
    expect(store.isLoading, isFalse);
  });

  test('auth store exposes expected errors for duplicate and invalid login', () async {
    final store = AuthStore(AuthService());

    expect(await store.register('user@example.com', 'password'), isTrue);
    expect(await store.register('user@example.com', 'password'), isFalse);
    expect(store.errorMessage, 'Este e-mail já está cadastrado');
    expect(await store.login('user@example.com', 'wrong'), isFalse);
    expect(store.errorMessage, 'E-mail ou senha inválidos.');
    expect(store.isLoggedIn, isFalse);
  });

  test('favorite store persists favorites independently for each user', () async {
    final authService = AuthService();
    await authService.doRegister('first@example.com', 'password');
    await authService.doLogin('first@example.com', 'password');

    final apiClient = ApiClient();
    final store = FavoriteStore(
      FavoriteRepository(
        FavoriteService(authService),
        PersonRepository(PersonService(apiClient)),
        PlanetRepository(PlanetService(apiClient)),
        FilmsRepository(FilmsService(apiClient)),
      ),
    );

    expect(await store.toggleFavorite('person:Leia'), isTrue);
    expect(await store.checkFavorite('person:Leia'), isTrue);

    await authService.doRegister('second@example.com', 'password');
    await authService.doLogin('second@example.com', 'password');
    expect(await store.checkFavorite('person:Leia'), isFalse);

    await authService.doLogin('first@example.com', 'password');
    expect(await store.checkFavorite('person:Leia'), isTrue);
    store.clear();
    expect(store.favoriteStatus, isEmpty);
    expect(store.favoritePeople, isEmpty);  
  });
}
