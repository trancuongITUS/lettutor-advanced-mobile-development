import 'package:src/services/api_service.dart';
import 'package:src/services/base_api.dart';

class UserAPI extends BaseAPI {
  static const String prefix = "user/";

  UserAPI() : super(prefix);

  Future<void> favoriteTutor({
    required String accessToken,
    required String tutorId,
    required Function(String, bool) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.post(
        url: "manageFavoriteTutor",
        data: {"tutorId": tutorId},
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(
            response.response['message'], response.response['result'] == 1);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }


}