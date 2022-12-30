import 'package:flutter/material.dart';
import 'package:hacaton/domain/api_clients/auth_api_client.dart';
import 'package:hacaton/domain/data_providers/auth_token_data_provider.dart';

class AuthRepository {
  final AuthTokenDataProvider _tokenDataProvider = AuthTokenDataProvider();
  final AuthApiClient _apiClient = AuthApiClient();
  String? _accessToken;
  bool get accessible => _accessToken != null;

  Future<void> getAccessToken(String phone) async {
    _accessToken = (await _apiClient.makeAccessToken(phone: phone)).accessToken;
  }

  Future<bool> makeAuthToken(String code) async {
    final String? authToken = (await _apiClient.makeAuthToken(code: code, accessToken: _accessToken!)).authToken;
    _tokenDataProvider.setAuthToken(authToken);
    return true;
  }
}