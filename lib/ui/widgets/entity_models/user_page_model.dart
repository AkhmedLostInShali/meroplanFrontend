import 'package:flutter/material.dart';
import 'package:hacaton/domain/api_clients/my_profile_api_client.dart';
import 'package:hacaton/domain/data_providers/auth_token_data_provider.dart';
import 'package:hacaton/domain/entities/user/my_profile.dart';
import 'package:hacaton/domain/entities/user/my_profile_response.dart';
class UserPageModel extends ChangeNotifier{
  final MyProfileApiClient _apiClient = MyProfileApiClient();
  MyProfile? myProfile;
  bool _isLoading = false;
  bool get isLoaded => !_isLoading;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> setupData() async {
    if (myProfile == null) {
      final MyProfileResponse myProfileResponse = await _apiClient.getMyProfile();
      if (myProfileResponse.statusCode == 200) {
        myProfile = myProfileResponse.myProfile;
      } else {
        _errorMessage = '${myProfileResponse.statusCode}';
      }
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logOut(BuildContext context) async {
    AuthTokenDataProvider().setAuthToken(null);
    Navigator.of(context).pushReplacementNamed('auth');
  }

  Future<void> changeName(BuildContext context, String name) async {
    final String? statusCode = await _apiClient.putMyProfile(name=name);
    if (statusCode == '200') {
      _isLoading = true;
      notifyListeners();
      myProfile = null;
      setupData();
    }
  }

}