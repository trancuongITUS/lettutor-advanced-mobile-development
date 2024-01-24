import 'package:src/services/api_service.dart';
import 'package:src/services/base_api.dart';

class CallAPI extends BaseAPI {
  static const String prefix = "call/";

  CallAPI() : super(prefix);

  Future<void> getTotalLessonTime({
    required String accessToken,
    required Function(int) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url:
        "total",
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(response.response['total']??0);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }
}