import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/core/injection.dart';
import 'package:flutter_application_1/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await getIt.reset();
    setupDependencies();
  });

  testWidgets('shows the login screen when there is no session', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp(isLoggedIn: false));

    expect(find.text('Acesse a galáxia'), findsOneWidget);
  });
}
