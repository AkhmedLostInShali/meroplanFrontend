import 'dart:convert';
import 'dart:io';

import 'package:hacaton/domain/data_providers/auth_token_data_provider.dart';

String serverRootPath = 'https://ccad-46-39-51-44.ngrok-free.app/';

class ApiClient {
  final HttpClient client = HttpClient();
  final AuthTokenDataProvider authTokenProvider = AuthTokenDataProvider();
  static const apiKey = 'took_app_89';

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final Uri uri = Uri.parse('$serverRootPath$path');
    if (parameters != null) {
      final Uri newUri = uri.replace(queryParameters: parameters);
      return newUri;
    } else {
      return uri;
    }
  }

  Future<dynamic> getJsonList(String path, [Map<String, dynamic>? parameters, bool? tokenNeeded]) async {
    final Uri url = _makeUri(path, parameters);
    final request = await client.getUrl(url);
    String? token = await authTokenProvider.getAuthToken();
    if (tokenNeeded == true && token != null) {
      request.headers.set('x-access-token', token);
    }
    final response = await request.close();
    if (response.statusCode != 200) {
      throw HttpException(response.statusCode.toString(), uri: url);
    }
    final dynamic json = response.jsonDecode();
    return json;
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode () async {
    return transform(utf8.decoder).
    toList().
    then((value) => value.join()).
    then<dynamic>((v) => json.decode(v));
  }
}