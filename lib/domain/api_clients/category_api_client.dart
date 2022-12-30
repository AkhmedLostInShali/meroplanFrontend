import 'package:hacaton/domain/api_clients/general_api_client.dart';
import 'package:hacaton/domain/entities/categories/category_response.dart';

class CategoryApiClient extends ApiClient {
  Future<CategoryResponse> getCategories({int? parentsId}) async {
    final Map<String, dynamic> parameters = <String, dynamic>{};
    if (parentsId != null) parameters['parents_id'] = parentsId.toString();
    final json =
    await getJsonList('api/categories', parameters) as Map<String, dynamic>;
    final CategoryResponse response = CategoryResponse.fromJson(json);
    return response;
  }
}
