import 'package:flutter_application_1/service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  FavoriteService(this._authService);

  final AuthService _authService;

  Future<String> _getFavoritesKey() async {
    final currentUser = await _authService.getCurrentUser();

    if (currentUser == null) {
      throw Exception('Nenhum usuário encontrado para acessar favoritos');
    }
    return 'favorites_$currentUser';
  }

  Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _getFavoritesKey();
    return prefs.getStringList(key) ?? [];
  }

  Future<bool> isFavorite(String itemId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _getFavoritesKey();
    final favorite = prefs.getStringList(key) ?? [];
    return favorite.contains(itemId);
  }

  Future<bool> toggleFavorite(String itemId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _getFavoritesKey();
    final favorites = prefs.getStringList(key) ?? [];

    final bool isNowFav;
    if (favorites.contains(itemId)) {
      favorites.remove(itemId);
      isNowFav = false;
    } else {
      favorites.add(itemId);
      isNowFav = true;
    }

    await prefs.setStringList(key, favorites);
    return isNowFav;
  }

  Future<void> removeFavorite(String itemId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _getFavoritesKey();
    final favorites = prefs.getStringList(key) ?? [];
    if (favorites.remove(itemId)) {
      await prefs.setStringList(key, favorites);
    }
  }
}