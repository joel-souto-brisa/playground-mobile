import 'package:flutter_application_1/service/auth_service.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  _AuthStore(this._authService);

  final AuthService _authService;

  @observable
  bool isLoading = false;

  @observable
  bool isLoggedIn = false;

  @observable
  String? errorMessage;

  @action
  Future<void> restoreSession() async {
    isLoading = true;
    errorMessage = null;
    try {
      isLoggedIn = await _authService.isUserLoggedIn();
    } on Exception catch (error) {
      errorMessage = _messageFrom(error);
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> login(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    try {
      await _authService.doLogin(email, password);
      isLoggedIn = true;
      return true;
    } on Exception catch (error) {
      errorMessage = _messageFrom(error);
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> register(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    try {
      await _authService.doRegister(email, password);
      return true;
    } on Exception catch (error) {
      errorMessage = _messageFrom(error);
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> logout() async {
    isLoading = true;
    errorMessage = null;
    try {
      await _authService.logout();
      isLoggedIn = false;
      return true;
    } on Exception catch (error) {
      errorMessage = _messageFrom(error);
      return false;
    } finally {
      isLoading = false;
    }
  }

  String _messageFrom(Exception error) =>
      error.toString().replaceFirst('Exception: ', '');
}
