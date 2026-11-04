import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/injection.dart';
import 'package:flutter_application_1/stores/planet_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PlanetView extends StatefulWidget {
  const PlanetView({super.key});

  @override
  State<PlanetView> createState() => _PlanetViewState();
}

class _PlanetViewState extends State<PlanetView> {
  late final PlanetStore _store;

  @override
  void initState() {
    super.initState();
    _store = getIt<PlanetStore>();
    _store.loadPlanets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Planetas de Star Wars')),
      body: Observer(
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
                    onPressed: _store.loadPlanets,
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          }

          if (_store.planets.isEmpty) {
            return const Center(child: Text('Nenhum planeta encontrado'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 260,
              mainAxisExtent: 180,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: _store.planets.length,
            itemBuilder: (context, index) {
              final planet = _store.planets[index];

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue.shade100,
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
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Clima: ${planet.climate}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'População: ${planet.population}',
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
          );
        },
      ),
    );
  }
}
