import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/injection.dart';
import 'package:flutter_application_1/service/favorite_service.dart';

class FavoriteButton extends StatefulWidget {
  final String itemId;

  const FavoriteButton({super.key, required this.itemId});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  final _favoritesService = getIt<FavoriteService>();
  bool _isFav = false;

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    final status = await _favoritesService.isFavorite(widget.itemId);
    if (mounted) {
      setState(() => _isFav = status);
    }
  }

  Future<void> _toggle() async {
    final newStatus = await _favoritesService.toggleFavorite(widget.itemId);
    if (mounted) {
      setState(() => _isFav = newStatus);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isFav ? Icons.favorite : Icons.favorite_border,
        color: _isFav ? Colors.red : Colors.grey,
      ),
      tooltip: _isFav ? 'Remover dos favoritos' : 'Favoritar',
      onPressed: _toggle,
    );
  }
}