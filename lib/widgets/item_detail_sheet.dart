import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/films_model.dart';
import 'package:flutter_application_1/models/person_model.dart';
import 'package:flutter_application_1/models/planet_model.dart';
import 'package:flutter_application_1/widgets/favorite_button.dart';

void showPersonDetails(BuildContext context, Person person) {
  _showGalacticSheet(
    context: context,
    eyebrow: 'DOSSIÊ DE PERSONAGEM',
    title: person.name,
    icon: Icons.person,
    favoriteId: 'person:${person.name}',
    specs: [
      _SpecItem('Altura', _formatMetric(person.height, 'cm')),
      _SpecItem('Massa', _formatMetric(person.mass, 'kg')),
      _SpecItem('Nascimento', person.birthYear),
      _SpecItem('Gênero', person.gender),
      _SpecItem('Cor do cabelo', person.hairColor),
      _SpecItem('Cor da pele', person.skinColor),
      _SpecItem('Cor dos olhos', person.eyeColor),
    ],
    counters: [
      _CounterBadge('Filmes', person.films.length, Icons.movie_outlined),
      _CounterBadge('Espécies', person.species.length, Icons.biotech_outlined),
      _CounterBadge(
        'Veículos',
        person.vehicles.length,
        Icons.directions_car_outlined,
      ),
      _CounterBadge(
        'Naves',
        person.starships.length,
        Icons.rocket_launch_outlined,
      ),
    ],
  );
}

void showPlanetDetails(BuildContext context, Planet planet) {
  _showGalacticSheet(
    context: context,
    eyebrow: 'REGISTRO PLANETÁRIO',
    title: planet.name,
    icon: Icons.public,
    favoriteId: 'planet:${planet.name}',
    specs: [
      _SpecItem('Clima', planet.climate),
      _SpecItem('Terreno', planet.terrain),
      _SpecItem('Gravidade', planet.gravity),
      _SpecItem('População', planet.population),
      _SpecItem('Diâmetro', _formatMetric(planet.diameter, 'km')),
      _SpecItem('Rotação', _formatMetric(planet.rotationPeriod, 'h')),
      _SpecItem('Órbita', _formatMetric(planet.orbitalPeriod, 'dias')),
      _SpecItem('Água superficial', _formatMetric(planet.surfaceWater, '%')),
    ],
    counters: [
      _CounterBadge(
        'Residentes',
        planet.residents.length,
        Icons.people_outline,
      ),
      _CounterBadge('Filmes', planet.films.length, Icons.movie_outlined),
    ],
  );
}

void showFilmDetails(BuildContext context, Film film) {
  final cleanCrawl = film.openingCrawl
      .replaceAll('\r\n', '\n')
      .replaceAll(RegExp(r'\n{2,}'), '\n\n')
      .trim();

  _showGalacticSheet(
    context: context,
    eyebrow: 'EPISÓDIO ${film.episodeId}',
    title: film.title,
    icon: Icons.movie,
    favoriteId: 'film:${film.episodeId}',
    openingCrawl: cleanCrawl,
    specs: [
      _SpecItem('Diretor', film.director),
      _SpecItem('Produtor(es)', film.producer),
      _SpecItem('Lançamento', film.releaseDate),
    ],
    counters: [
      _CounterBadge(
        'Personagens',
        film.characters.length,
        Icons.people_outline,
      ),
      _CounterBadge('Planetas', film.planets.length, Icons.public_outlined),
      _CounterBadge(
        'Naves',
        film.starships.length,
        Icons.rocket_launch_outlined,
      ),
      _CounterBadge(
        'Veículos',
        film.vehicles.length,
        Icons.directions_car_outlined,
      ),
      _CounterBadge('Espécies', film.species.length, Icons.biotech_outlined),
    ],
  );
}

String _formatMetric(String value, String unit) {
  final normalized = value.trim().toLowerCase();
  if (normalized.isEmpty || normalized == 'unknown' || normalized == 'n/a') {
    return value;
  }
  return '$value $unit';
}

void _showGalacticSheet({
  required BuildContext context,
  required String eyebrow,
  required String title,
  required IconData icon,
  required String favoriteId,
  required List<_SpecItem> specs,
  required List<_CounterBadge> counters,
  String? openingCrawl,
}) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) {
      return DraggableScrollableSheet(
        initialChildSize: openingCrawl != null ? 0.82 : 0.68,
        minChildSize: 0.45,
        maxChildSize: 0.94,
        expand: false,
        builder: (_, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFF0E1521),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
              border: Border.all(color: const Color(0x33FFD54F)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 12, 12),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0x1AFFD54F),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          icon,
                          color: const Color(0xFFFFD54F),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              eyebrow,
                              style: const TextStyle(
                                color: Color(0xFFFFD54F),
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.8,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              title,
                              style: Theme.of(sheetContext)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      FavoriteButton(
                        key: ValueKey('detail_$favoriteId'),
                        itemId: favoriteId,
                      ),
                      IconButton(
                        tooltip: 'Fechar',
                        icon: const Icon(
                          Icons.close,
                          color: Color(0xFFB8C2D0),
                        ),
                        onPressed: () => Navigator.pop(sheetContext),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: Color(0x1FFFFFFF)),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(20),
                    children: [
                      if (openingCrawl != null) ...[
                        const Text(
                          'ABERTURA CLÁSSICA',
                          style: TextStyle(
                            color: Color(0xFFFFD54F),
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: const Color(0xFF080D17),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0x33FFD54F),
                            ),
                          ),
                          child: Text(
                            openingCrawl,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFFFFE082),
                              height: 1.6,
                              fontStyle: FontStyle.italic,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 22),
                      ],
                      const Text(
                        'ESPECIFICAÇÕES DO ARQUIVO',
                        style: TextStyle(
                          color: Color(0xFFFFD54F),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: specs
                            .map(
                              (spec) => Container(
                                width: 165,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF141E2E),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.07),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      spec.label.toUpperCase(),
                                      style: const TextStyle(
                                        color: Color(0xFF9AA7B8),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      spec.value,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 22),
                      const Text(
                        'CONEXÕES NA GALÁXIA',
                        style: TextStyle(
                          color: Color(0xFFFFD54F),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: counters
                            .map(
                              (counter) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0x1AFFD54F),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(0x33FFD54F),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      counter.icon,
                                      size: 16,
                                      color: const Color(0xFFFFD54F),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      '${counter.label}: ${counter.count}',
                                      style: const TextStyle(
                                        color: Color(0xFFE7ECF2),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

class _SpecItem {
  const _SpecItem(this.label, this.value);
  final String label;
  final String value;
}

class _CounterBadge {
  const _CounterBadge(this.label, this.count, this.icon);
  final String label;
  final int count;
  final IconData icon;
}