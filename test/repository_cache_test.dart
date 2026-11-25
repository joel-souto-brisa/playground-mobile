import 'package:flutter_application_1/models/planet_model.dart';
import 'package:flutter_application_1/repository/planet_repository.dart';
import 'package:flutter_application_1/service/planet_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'planet repository reuses cached data and refreshes on request',
    () async {
      final service = _FakePlanetService();
      final repository = PlanetRepository(service);

      await repository.getPlanets();
      await repository.getPlanets();
      expect(service.calls, 1);

      await repository.getPlanets(refresh: true);
      expect(service.calls, 2);
    },
  );

  test('planet repository retries after a failed load', () async {
    final service = _FakePlanetService()..failFirstCall = true;
    final repository = PlanetRepository(service);

    await expectLater(repository.getPlanets(), throwsStateError);
    await repository.getPlanets();

    expect(service.calls, 2);
  });
}

class _FakePlanetService implements PlanetService {
  var calls = 0;
  var failFirstCall = false;

  @override
  Future<List<Planet>> getPlanets() async {
    calls++;
    if (failFirstCall && calls == 1) {
      throw StateError('Load failed');
    }
    return [];
  }
}
