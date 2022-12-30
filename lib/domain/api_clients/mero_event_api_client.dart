import 'package:hacaton/domain/api_clients/general_api_client.dart';
import 'package:hacaton/domain/entities/general/basic_response.dart';
import 'package:hacaton/domain/entities/mero_events/mero_event_response.dart';

class MeroEventApiClient extends ApiClient {
  Future<MeroEventResponse> getEvents({int? categoryId, String? searchQuery, required int page}) async {
    final Map<String, dynamic> parameters = <String, dynamic>{
      'page': page.toString()
    };
    if (categoryId != null) parameters['category_id'] = categoryId.toString();
    if (searchQuery != null) parameters['search_query'] = searchQuery;
    final json =
    await getJsonList('api/events', parameters, true) as Map<String, dynamic>;
    final MeroEventResponse response = MeroEventResponse.fromJson(json);
    return response;
  }

  Future<BasicResponse> memberEvent({required String eventsID, required bool isMembered}) async {
    final Uri url = Uri.parse('${serverRootPath}api/member/$eventsID');
    final request = await (isMembered ? client.putUrl(url) : client.deleteUrl(url));
    String? token = await authTokenProvider.getAuthToken();
    if (token != null) {
      request.headers.set('x-access-token', token);
    }
    // request.headers.contentType = ContentType.json;
    final response = await request.close();
    final json = (await response.jsonDecode()) as Map<String, dynamic>;
    final BasicResponse basicResponse = BasicResponse.fromJson(json);
    return basicResponse;
  }

  // Future<EventtDetailsResponse> getProduct({required int productID}) async {
  //   final json =
  //   await getJsonList('api/products/$productID') as Map<String, dynamic>;
  //   final ProductDetailsResponse response = ProductDetailsResponse.fromJson(json);
  //   return response;
  // }

}