import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/injection.dart';
import 'package:flutter_application_1/stores/favorite_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FavoriteButton extends StatefulWidget {
  final String itemId;

  const FavoriteButton({super.key, required this.itemId});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  final _favoriteStore = getIt<FavoriteStore>();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    unawaited(_checkStatus());
  }

  Future<void> _checkStatus() async {
    final status = await _favoriteStore.checkFavorite(widget.itemId);
    if (mounted) {
      setState(() => _isLoading = false);
      if (status == null) {
        _showError();
      }
    }
  }

  Future<void> _toggle() async {
    setState(() => _isLoading = true);
    final status = await _favoriteStore.toggleFavorite(widget.itemId);
    if (mounted) {
      setState(() => _isLoading = false);
      if (status == null) {
        _showError();
      }
    }
  }

  void _showError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _favoriteStore.errorMessage ??
              'Não foi possível atualizar o favorito.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final isFavorite =
            _favoriteStore.favoriteStatus[widget.itemId] ?? false;
        return IconButton(
          icon: _isLoading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite
                      ? const Color(0xFFFFD54F)
                      : const Color(0xFFB8C2D0),
                ),
          tooltip: isFavorite ? 'Remover dos favoritos' : 'Favoritar',
          onPressed: _isLoading ? null : _toggle,
        );
      },
    );
  }
}
