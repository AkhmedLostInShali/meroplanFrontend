import 'dart:convert';
import 'dart:io';

import 'package:hacaton/domain/api_clients/api_client_errors/auth_errors.dart';
import 'package:hacaton/domain/api_clients/general_api_client.dart';
import 'package:hacaton/domain/entities/auth_entities/auth_code_response.dart';
import 'package:hacaton/domain/entities/auth_entities/auth_log_in_response.dart';

class AuthApiClient extends ApiClient {
  static const apiKey = 'took_app_89';

  Future<AuthCodeResponse> makeAccessToken({required String phone}) async {
    final Uri url = Uri.parse('${serverRootPath}api/auth/get_code');
    final Map<String, dynamic> parameters = <String, dynamic>{
      'phone': phone
    };
    final request = await client.postUrl(url
        .replace(queryParameters: parameters));
    request.headers.contentType = ContentType.json;
    // request.write(jsonEncode(parameters));
    final response = await request.close();
    // if (response.statusCode != 200 && response.statusCode != 403) {
    //   throw HttpException(response.statusCode.toString(), uri: url);
    // }
    final json = (await response.jsonDecode()) as Map<String, dynamic>;
    final AuthCodeResponse authCodeResponse = AuthCodeResponse.
    fromJson(json);
    if (response.statusCode == 403) {
      throw AuthIncorrectPhoneApiClientError(authCodeResponse.message.toString(), uri: url);
    }
    final String? accessToken = authCodeResponse.accessToken;
    if (accessToken == null) {
      throw AuthEmptyTokenApiClientError(authCodeResponse.message.toString(), uri: url);
    }
    return authCodeResponse;
  }

  Future<AuthLogInResponse> makeAuthToken({required String code, required String accessToken}) async {
    final Uri url = Uri.parse('${serverRootPath}api/auth/log_in');
    final Map<String, dynamic> parameters = <String, dynamic>{
      'code': code
    };
    final request = await client.postUrl(url
        .replace(queryParameters: parameters));
    request.headers.set('x-access-token', accessToken);
    // request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parameters));
    final response = await request.close();
    // if (response.statusCode != 200) {
    //   throw HttpException(response.statusCode.toString(), uri: url);
    // }
    final json = (await response.jsonDecode()) as Map<String, dynamic>;
    final AuthLogInResponse authLogInResponse = AuthLogInResponse.
    fromJson(json);
    final String? authToken = authLogInResponse.authToken;
    if (authToken == null) {
      throw AuthEmptyTokenApiClientError(authLogInResponse.message.toString(), uri: url);
    }
    return authLogInResponse;
  }
}