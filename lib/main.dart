import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/films_view.dart';
import 'package:flutter_application_1/core/injection.dart';
import 'package:flutter_application_1/stores/favorite_store.dart';
import 'package:flutter_application_1/views/favorite_view.dart';
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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFD54F),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF080D17),
        textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: const Color(0xFFE7ECF2),
          displayColor: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF101722),
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
        listTileTheme: const ListTileThemeData(
          textColor: Color(0xFFF4F6F8),
          subtitleTextStyle: TextStyle(color: Color(0xFFD0D8E2)),
          iconColor: Color(0xFFFFD54F),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xFF101722),
          indicatorColor: const Color(0x33FFD54F),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return TextStyle(
              color: selected
                  ? const Color(0xFFFFD54F)
                  : const Color(0xFFD0D8E2),
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            );
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return IconThemeData(
              color: selected
                  ? const Color(0xFFFFD54F)
                  : const Color(0xFFD0D8E2),
            );
          }),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF121B28),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
          ),
        ),
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
  late final FavoriteStore _favoriteStore;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _favoriteStore = getIt<FavoriteStore>();
    _pages = [
      const PersonView(),
      const PlanetView(),
      const FilmsView(),
      FavoriteView(store: _favoriteStore),
    ];
  }

  void _selectTab(int index) {
    setState(() => _selectedIndex = index);
    if (index == 3) {
      unawaited(_favoriteStore.loadFavorites());
    }
  }

  Future<void> _handleLogout() async {
    final authService = getIt<AuthService>();
    await authService.logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.auto_awesome, color: Color(0xFFFFD54F), size: 20),
            SizedBox(width: 10),
            Text('STAR WARS WIKI'),
          ],
        ),
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
                        _handleLogout(); // Realiza o logout
                      },
                      child: const Text(
                        'Sair',
                        style: TextStyle(color: Colors.red),
                      ),
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
        onDestinationSelected: _selectTab,
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
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}
