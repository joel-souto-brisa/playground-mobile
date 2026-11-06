import 'package:flutter_application_1/service/favorite_service.dart';

class FavoriteRepository {
  FavoriteRepository(this._favoriteService);

  final FavoriteService _favoriteService;

  Future<List<String>> getFavorites() async {
    return _favoriteService.getFavorites();
  }

  Future<bool> toggleFavorite(String itemId) {
    return _favoriteService.toggleFavorite(itemId);
  }
}
