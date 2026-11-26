import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/injection.dart';
import 'package:flutter_application_1/stores/films_store.dart';
import 'package:flutter_application_1/widgets/favorite_button.dart';
import 'package:flutter_application_1/widgets/galactic_header.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_application_1/widgets/item_detail_sheet.dart';

class FilmsView extends StatefulWidget {
  const FilmsView({super.key});

  @override
  State<FilmsView> createState() => _FilmsViewState();
}

class _FilmsViewState extends State<FilmsView> {
  late final FilmsStore _store;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _store = getIt<FilmsStore>();
    _searchController = TextEditingController();
    _store.loadFilms();
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
                  onPressed: () => _store.loadFilms(refresh: true),
                  child: const Text('Tentar novamente'),
                ),
              ],
            ),
          );
        }

        if (_store.films.isEmpty) {
          return const Center(child: Text('Nenhum filme encontrado'));
        }

        final items = _store.filteredFilms;

        return Column(
          children: [
            GalacticHeader(
              title: 'Filmes',
              subtitle: 'Reviva as sagas que marcaram a galáxia.',
              icon: Icons.movie_outlined,
              eyebrow: 'HOLOCRON CINEMATOGRÁFICO',
              totalCount: items.length,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
              child: TextField(
                controller: _searchController,
                onChanged: _store.setSearchQuery,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Buscar por título, diretor ou ano...',
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
                      child: Text('Nenhum filme corresponde à busca.'),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(12),
                      itemCount: items.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final film = items[index];

                        return Card(
                          clipBehavior: Clip.antiAlias,
                          child: ListTile(
                            onTap: () => showFilmDetails(context, film),
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
                    ),
            ),
          ],
        );
      },
    );
  }
}