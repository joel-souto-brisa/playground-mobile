import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/injection.dart';
import 'package:flutter_application_1/stores/planet_store.dart';
import 'package:flutter_application_1/widgets/favorite_button.dart';
import 'package:flutter_application_1/widgets/galactic_header.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PlanetView extends StatefulWidget {
  const PlanetView({super.key});

  @override
  State<PlanetView> createState() => _PlanetViewState();
}

class _PlanetViewState extends State<PlanetView> {
  late final PlanetStore _store;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _store = getIt<PlanetStore>();
    _searchController = TextEditingController();
    _store.loadPlanets();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (_store.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_store.errorMessage != null) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_store.errorMessage!),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => _store.loadPlanets(refresh: true),
                  child: const Text('Tentar novamente'),
                ),
              ],
            ),
          );
        }

        if (_store.planets.isEmpty) {
          return const Center(child: Text('Nenhum planeta encontrado'));
        }

        final items = _store.filteredPlanets;

        return Column(
          children: [
            GalacticHeader(
              title: 'Planetas',
              subtitle: 'Descubra mundos de todos os cantos do universo.',
              icon: Icons.public,
              eyebrow: 'MAPA DA GALÁXIA',
              totalCount: items.length,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
              child: TextField(
                controller: _searchController,
                onChanged: _store.setSearchQuery,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Buscar por planeta, clima ou terreno...',
                  hintStyle: const TextStyle(color: Color(0xFF9AA7B8)),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFFFFD54F)),
                  suffixIcon: _store.searchQuery.isNotEmpty
                      ? IconButton(
                          tooltip: 'Limpar busca',
                          icon: const Icon(Icons.clear, color: Color(0xFFB8C2D0)),
                          onPressed: () {
                            _searchController.clear();
                            _store.setSearchQuery('');
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: const Color(0xFF121B28),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xFFFFD54F)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: items.isEmpty
                  ? const Center(
                      child: Text('Nenhum planeta corresponde à busca.'),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 260,
                        mainAxisExtent: 180,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final planet = items[index];

                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: const Color(0xFF303A49),
                                      foregroundColor: const Color(0xFFFFD54F),
                                      child: Text(
                                        planet.name.isNotEmpty
                                            ? planet.name[0].toUpperCase()
                                            : '?',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        planet.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                    ),
                                    FavoriteButton(
                                      key: ValueKey('planet:${planet.name}'),
                                      itemId: 'planet:${planet.name}',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Clima: ${planet.climate}',
                                  style: const TextStyle(color: Color(0xFFD0D8E2)),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'População: ${planet.population}',
                                  style: const TextStyle(color: Color(0xFFD0D8E2)),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Spacer(),
                                const Align(
                                  alignment: Alignment.bottomRight,
                                  child: Icon(Icons.public),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}