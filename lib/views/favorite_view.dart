import 'package:flutter/material.dart';
import 'package:flutter_application_1/stores/favorite_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key, required this.store});

  final FavoriteStore store;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (store.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (store.errorMessage != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(store.errorMessage!, textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: store.loadFavorites,
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            ),
          );
        }

        if (store.favoritePeople.isEmpty &&
            store.favoritePlanets.isEmpty &&
            store.favoriteFilms.isEmpty) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.favorite_border, size: 48),
                SizedBox(height: 8),
                Text('Você ainda não adicionou favoritos'),
              ],
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(12),
          children: [
            if (store.favoritePeople.isNotEmpty) ...[
              _sectionTitle(context, 'Personagens'),
              ...store.favoritePeople.map(
                (person) => Card(
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(person.name),
                    subtitle: Text('Gênero: ${person.gender}'),
                    trailing: IconButton(
                      tooltip: 'Remover dos favoritos',
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () =>
                          store.removeFavorite('person:${person.name}'),
                    ),
                  ),
                ),
              ),
            ],
            if (store.favoritePlanets.isNotEmpty) ...[
              _sectionTitle(context, 'Planetas'),
              ...store.favoritePlanets.map(
                (planet) => Card(
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.public)),
                    title: Text(planet.name),
                    subtitle: Text('Clima: ${planet.climate}'),
                    trailing: IconButton(
                      tooltip: 'Remover dos favoritos',
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () =>
                          store.removeFavorite('planet:${planet.name}'),
                    ),
                  ),
                ),
              ),
            ],
            if (store.favoriteFilms.isNotEmpty) ...[
              _sectionTitle(context, 'Filmes'),
              ...store.favoriteFilms.map(
                (film) => Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text('E${film.episodeId}')),
                    title: Text(film.title),
                    subtitle: Text('Diretor: ${film.director}'),
                    trailing: IconButton(
                      tooltip: 'Remover dos favoritos',
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () =>
                          store.removeFavorite('film:${film.episodeId}'),
                    ),
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 12, 4, 4),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}
