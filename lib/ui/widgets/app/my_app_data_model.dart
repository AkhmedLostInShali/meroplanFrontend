import 'package:hacaton/domain/data_providers/auth_token_data_provider.dart';

class MyAppModel {
  final AuthTokenDataProvider _tokenDataProvider = AuthTokenDataProvider();
  bool _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    _tokenDataProvider.setAuthToken("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1c2VyX2lkIjoiM2pScmpiR2IiLCJ1c2VyX3NlY3JldCI6InBia2RmMjpzaGEyNTY6MjYwMDAwJDFQUWVET1pQTVAwTWJBSUQkNzczZjAxZmI1NzI0ZDk0Y2E1NDg1NWJkYWNlZGFjMDgxODcwM2ViODQ2N2I1OTE3NTZkMmMxMTU0YTlkYjg5NSIsInBob25lIjoiNzk4OTkzMjk4NTciLCJleHBpcmVzX2F0IjoiMjAyMy0wMS0yNlQwNToxMTowNS43OTkxNDUifQ.qungYjezE2fSI3cHyQP-2B6Uhk18JbdTj-Q75zFRUA0CTxfh34tje2Ng2jOFqLKw_ZsT_ZmX7a3n6PzBs-DBUQ");
    final authToken = await _tokenDataProvider.getAuthToken();
    print(authToken);
    _isAuth = authToken != null;
  }
}