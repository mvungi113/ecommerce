import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  bool _isGuest = false;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  bool get isGuest => _isGuest;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null || _isGuest;

  AuthProvider() {
    _init();
  }

  Future<void> _init() async {
    _isGuest = await _authService.isGuest();
    _authService.authStateChanges.listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<bool> signInWithEmailPassword(String email, String password) async {
    _setLoading(true);
    _clearError();
    try {
      await _authService.signInWithEmailPassword(email, password);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  Future<bool> signUpWithEmailPassword(
    String email,
    String password,
    String name,
  ) async {
    _setLoading(true);
    _clearError();
    try {
      await _authService.signUpWithEmailPassword(email, password, name);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    _setLoading(true);
    _clearError();
    try {
      final result = await _authService.signInWithGoogle();
      _setLoading(false);
      return result != null;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  Future<void> continueAsGuest() async {
    _setLoading(true);
    _clearError();
    try {
      await _authService.continueAsGuest();
      _isGuest = true;
      _setLoading(false);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
    }
  }

  Future<bool> convertGuestToUser(
    String email,
    String password,
    String name,
  ) async {
    _setLoading(true);
    _clearError();
    try {
      await _authService.convertGuestToUser(email, password, name);
      _isGuest = false;
      _setLoading(false);
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _authService.signOut();
      _isGuest = false;
      _user = null;
      _setLoading(false);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
    }
  }

  Future<bool> resetPassword(String email) async {
    _setLoading(true);
    _clearError();
    try {
      await _authService.resetPassword(email);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }

  bool canMakeOrder() {
    return !_isGuest && _user != null;
  }
}
