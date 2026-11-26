import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class InMemoryCache<T extends Object> {
  InMemoryCache({
    required this.storageKey,
    required this.toJson,
    required this.fromJson,
    });

  final String storageKey;
  final Object? Function(T value) toJson;
  final T Function(Object? json) fromJson;

  T? _value;
  Future<T>? _pending;
  bool _hasValue = false;
  int _generation = 0;

  Future<T> get(Future<T> Function() load, {bool refresh = false}) async {
    if (refresh) {
      _generation++;
      _value = null;
      _hasValue = false;
      _pending = null;
    }

    if (!_hasValue && !refresh) {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(storageKey);
      if (jsonString != null) {
        try {
          final decoded = jsonDecode(jsonString);
          _value = fromJson(decoded);
          _hasValue = true;
        } catch (_) {
          await prefs.remove(storageKey);
        }
      }
    }

    if (_hasValue) return Future.value(_value as T);
    if (_pending != null) return _pending!;

    final int generation = _generation;
    late final Future<T> request;
    request = load().then((value) async {
      if (_generation == generation) {
        _value = value;
        _hasValue = true;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(storageKey, jsonEncode(toJson(value)));
      }
      return value;
    }).whenComplete(() {
      if (_generation == generation && identical(_pending, request)) {
        _pending = null;
      }
    });

    _pending = request;
    return request;
  }
}
