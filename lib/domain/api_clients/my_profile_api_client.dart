import 'package:hacaton/domain/api_clients/general_api_client.dart';
import 'package:hacaton/domain/entities/user/my_profile_response.dart';

class MyProfileApiClient extends ApiClient {
  Future<MyProfileResponse> getMyProfile() async {
    final Uri url = Uri.parse('${serverRootPath}api/my_profile');
    String? token = await authTokenProvider.getAuthToken();
    final request = await client.getUrl(url);
    request.headers.set('x-access-token', token!);
    final response = await request.close();
    final json = (await response.jsonDecode()) as Map<String, dynamic>;
    final MyProfileResponse myProfileResponse = MyProfileResponse.fromJson(json);
    return myProfileResponse;
  }

  Future<String?> putMyProfile([String? name]) async {
    final Uri url = Uri.parse('${serverRootPath}api/my_profile');
    final Map<String, dynamic> parameters = <String, dynamic>{
      'name': name
    };
    String? token = await authTokenProvider.getAuthToken();
    final request = await client.putUrl(url
        .replace(queryParameters: parameters));
    request.headers.set("Content-Type", "application/json; charset=utf-8");
    request.headers.set('x-access-token', token!);
    request.write(parameters);
    final response = await request.close();
    final json = (await response.jsonDecode()) as Map<String, dynamic>;
    return json['status_code'];
  }
}