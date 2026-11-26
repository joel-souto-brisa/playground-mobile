import 'package:flutter_application_1/repository/planet_repository.dart';
import 'package:flutter_application_1/service/planet_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test(
    'planet repository reuses cached data, persists to disk, and refreshes on request',
    () async {
      final service = _FakePlanetService();
      final repository = PlanetRepository(service);

      final firstLoad = await repository.getPlanets();
      expect(firstLoad.single.name, 'Tatooine');
      await repository.getPlanets();
      expect(service.calls, 1);

      // Nova instância do repositório deve ler do SharedPreferences sem chamar a API
      final newRepositoryInstance = PlanetRepository(service);
      final diskLoad = await newRepositoryInstance.getPlanets();
      expect(diskLoad.single.name, 'Tatooine');
      expect(service.calls, 1);

      // Refresh explícito deve ignorar o cache e buscar novamente na API
      await repository.getPlanets(refresh: true);
      expect(service.calls, 2);
    },
  );

  test('planet repository retries after a failed load', () async {
    final service = _FakePlanetService()..failFirstCall = true;
    final repository = PlanetRepository(service);

    await expectLater(repository.getPlanets(), throwsStateError);
    final retryLoad = await repository.getPlanets();

    expect(retryLoad.single.name, 'Tatooine');
    expect(service.calls, 2);
  });
}

class _FakePlanetService implements PlanetService {
  var calls = 0;
  var failFirstCall = false;

  @override
  Future<List<dynamic>> getPlanets() async {
    calls++;
    if (failFirstCall && calls == 1) {
      throw StateError('Load failed');
    }
    return [
      {
        'name': 'Tatooine',
        'rotation_period': '23',
        'orbital_period': '304',
        'diameter': '10465',
        'climate': 'arid',
        'gravity': '1 standard',
        'terrain': 'desert',
        'surface_water': '1',
        'population': '200000',
        'residents': <String>[],
        'films': <String>[],
      },
    ];
  }
}