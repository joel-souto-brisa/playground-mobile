import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/injection.dart';
import 'package:flutter_application_1/stores/films_store.dart';
import 'package:flutter_application_1/widgets/favorite_button.dart';
import 'package:flutter_application_1/widgets/galactic_header.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FilmsView extends StatefulWidget {
  const FilmsView({super.key});

  @override
  State<FilmsView> createState() => _FilmsViewState();
}

class _FilmsViewState extends State<FilmsView> {
  late final FilmsStore _store;

  @override
  void initState() {
    super.initState();
    _store = getIt<FilmsStore>();
    _store.loadFilms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filmes de Star Wars')),
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
                    onPressed: _store.loadFilms,
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          }

          if (_store.films.isEmpty) {
            return const Center(child: Text('Nenhum filme encontrado'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: _store.films.length + 1,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              if (index == 0) {
                return const GalacticHeader(
                  title: 'Filmes',
                  subtitle: 'Reviva as sagas que marcaram a galáxia.',
                  icon: Icons.movie_outlined,
                  eyebrow: 'HOLOCRON CINEMATOGRÁFICO',
                );
              }

              final film = _store.films[index - 1];

              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0x1AFFD54F),
                    foregroundColor: const Color(0xFFFFD54F),
                    child: Text(
                      'E${film.episodeId}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(
                    film.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    'Diretor: ${film.director}\nLançamento: ${film.releaseDate}',
                    style: const TextStyle(color: Color(0xFFD0D8E2)),
                  ),
                  isThreeLine: true,
                  trailing: FavoriteButton(
                    key: ValueKey('film:${film.episodeId}'),
                    itemId: 'film:${film.episodeId}',
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
