import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hacaton/domain/api_clients/api_client_errors/basic_errors.dart';
import 'package:hacaton/domain/repositiries/auth_repository.dart';

class AuthViewModelState {
  final String errorMessage;
  final String phone;
  final String code;
  final bool isLoading;
  bool get canAct => !isLoading;

  AuthViewModelState({this.isLoading = false,
      this.errorMessage = '', this.phone = '', this.code = ''});

  AuthViewModelState copyWith({
    String? errorMessage,
    String? phone,
    String? accessToken,
    String? code,
    bool? isLoading,
  }) {
    return AuthViewModelState(
      errorMessage: errorMessage ?? this.errorMessage,
      phone: phone ?? this.phone,
      code: code ?? this.code,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  var _state = AuthViewModelState();
  AuthViewModelState get state => _state;
  bool get accessible {
    return _authRepository.accessible;
  }

  void changePhone(String value) {
    _state = _state.copyWith(phone: value);
    notifyListeners();
  }
  void changeCode(String value) {
    _state = _state.copyWith(code: value);
    notifyListeners();
  }

  Future<void> getAccessToken() async {
    final phone = _state.phone.
    replaceAll(RegExp(r'\('), '').
    replaceAll(RegExp(r'\)'), '').
    replaceAll(RegExp(r'\-'), '').
    replaceAll(RegExp(r'\+'), '').
    replaceAll(RegExp(r'\ '), '');
    if (phone.length != 11) {
      _state = _state.copyWith(errorMessage: 'Номер телефона\n введён не полностью');
      notifyListeners();
      return;
    }
    _state.copyWith(errorMessage: '', isLoading: true);
    notifyListeners();

    try {
      await _authRepository.getAccessToken(phone);
      _state = _state.copyWith(errorMessage: '', isLoading: false);
      notifyListeners();
    }
    on ApiClientError catch(e) {
      _state = _state.copyWith(errorMessage: e.getErrorMessage(), isLoading: false);
      notifyListeners();
    }
    catch(exception) {
      _state = _state.copyWith(errorMessage: 'Неизвестная ошибка', isLoading: false);
      notifyListeners();
    }
    notifyListeners();
  }

  Future<bool> makeAuthToken() async {
    final code = _state.code;
    if (code.length != 4) {
      _state = _state.copyWith(errorMessage: 'Код введён не полностью');
      notifyListeners();
      return false;
    }
    _state = _state.copyWith(errorMessage: '', isLoading: true);
    notifyListeners();
    try {
      await _authRepository.makeAuthToken(code);
      _state = _state.copyWith(errorMessage: '', isLoading: false);
      notifyListeners();
    }
    on ApiClientError catch(e) {
      _state = _state.copyWith(errorMessage: e.getErrorMessage(), isLoading: false);
      notifyListeners();
      return false;
    }
    catch(exception) {
      _state = _state.copyWith(errorMessage: 'Неизвестная ошибка', isLoading: false);
      notifyListeners();
      return false;
    }
    notifyListeners();
    return true;
  }
  // set errorMessage(String value) {
  //   _state = _state.copyWith(errorMessage: value);
  //   notifyListeners();
  // }
  // set isLoading(bool value) {
  //   _state = _state.copyWith(isLoading: value);
  //   notifyListeners();
  // }
}