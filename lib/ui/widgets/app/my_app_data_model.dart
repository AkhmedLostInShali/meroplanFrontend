import 'package:hacaton/domain/data_providers/auth_token_data_provider.dart';

class MyAppModel {
  final AuthTokenDataProvider _tokenDataProvider = AuthTokenDataProvider();
  bool _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    // _tokenDataProvider.setAuthToken(null);
    // _tokenDataProvider.setAuthToken("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1c2VyX2lkIjoiZlFiNjdzSUUiLCJ1c2VyX3NlY3JldCI6InBia2RmMjpzaGEyNTY6MjYwMDAwJFAxYnJtZkxWcFdET2cwM24kMjYyYzc1NzI0ZDNkZTc2NWVjNDJiYmRiMWJkYjM4NmI1NzY0ZWRhZDRjYjA0NTE5NDQyMjc5N2VkYmRiMzljYSIsInBob25lIjoiNzk4OTkzMjk4NTciLCJleHBpcmVzX2F0IjoiMjAyMy0xMi0wMVQyMDoxNjozMy4wMzg5NTkifQ.hBDBHTEmCUPMGmiKcjTf1vIm4kuGq1T1-CYYFuIe--xMaNiUUG7H1XMCdGbpl4Hot5MCbTvbSnnEgsX3qL3i3A");
    final authToken = await _tokenDataProvider.getAuthToken();
    // print(authToken);
    _isAuth = authToken != null;
  }
}