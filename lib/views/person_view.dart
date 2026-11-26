import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/injection.dart';
import 'package:flutter_application_1/stores/person_store.dart';
import 'package:flutter_application_1/widgets/favorite_button.dart';
import 'package:flutter_application_1/widgets/galactic_header.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_application_1/widgets/item_detail_sheet.dart';

class PersonView extends StatefulWidget {
  const PersonView({super.key});

  @override
  State<PersonView> createState() => _PersonViewState();
}

class _PersonViewState extends State<PersonView> {
  late final PersonStore _store;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _store = getIt<PersonStore>();
    _searchController = TextEditingController();
    _store.loadPerson();
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
                  onPressed: () => _store.loadPerson(refresh: true),
                  child: const Text('Tentar novamente'),
                ),
              ],
            ),
          );
        }

        if (_store.person.isEmpty) {
          return const Center(child: Text('Nenhum personagem encontrado'));
        }

        final items = _store.filteredPerson;

        return Column(
          children: [
            GalacticHeader(
              title: 'Personagens',
              subtitle: 'Heróis, vilões e habitantes da galáxia.',
              icon: Icons.people_alt_outlined,
              eyebrow: 'DOSSIÊ DE PERSONAGENS',
              totalCount: items.length,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
              child: TextField(
                controller: _searchController,
                onChanged: _store.setSearchQuery,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Buscar por nome, gênero ou nascimento...',
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
                      child: Text('Nenhum personagem corresponde à busca.'),
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
                        final person = items[index];

                        return Card(
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () => showPersonDetails(context, person),
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
                                        person.name.isNotEmpty
                                            ? person.name[0].toUpperCase()
                                            : '?',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        person.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                    ),
                                    FavoriteButton(
                                      key: ValueKey('person:${person.name}'),
                                      itemId: 'person:${person.name}',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Gênero: ${person.gender}',
                                  style: const TextStyle(color: Color(0xFFD0D8E2)),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Nascimento: ${person.birthYear}',
                                  style: const TextStyle(color: Color(0xFFD0D8E2)),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Spacer(),
                                const Align(
                                  alignment: Alignment.bottomRight,
                                  child: Icon(Icons.person),
                                ),
                              ],
                            ),
                          ),
                          ));
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}