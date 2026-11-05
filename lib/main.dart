import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/films_view.dart';
import 'package:flutter_application_1/core/injection.dart';
import 'package:flutter_application_1/views/person_view.dart';
import 'package:flutter_application_1/views/planet_view.dart';
import 'views/login_view.dart';
import 'service/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();

  final authService = getIt<AuthService>(); 
  final bool isLoggedIn = await authService.isUserLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Star Wars",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const MainNavigation() : const LoginView(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [PersonView(), PlanetView(), FilmsView()];

  Future<void> _handleLogout() async {
    final authService = getIt<AuthService>();
    await authService.logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context, 
      MaterialPageRoute(
        builder: (context) => const LoginView()),
        (route) => false
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Star Wars Wiki'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () {
              // Diálogo de confirmação opcional
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Sair da conta'),
                  content: const Text('Deseja realmente encerrar a sessão?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Fecha o modal
                        _handleLogout();        // Realiza o logout
                      },
                      child: const Text('Sair', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Personagens',
          ),
          NavigationDestination(
            icon: Icon(Icons.public_outlined),
            selectedIcon: Icon(Icons.public),
            label: 'Planetas',
          ),
          NavigationDestination(
            icon: Icon(Icons.movie_outlined),
            selectedIcon: Icon(Icons.movie),
            label: 'Filmes',
          ),
        ],
      ),
    );
  }
}
