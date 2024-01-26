import 'package:src/models/data/tutors/tutor_feedback_data.dart';
import 'package:src/responses/get_list_feedbacks_response.dart';
import 'package:src/services/api_service.dart';
import 'package:src/services/base_api.dart';

class FeedbackAPI extends BaseAPI {
  static const String prefix = "feedback/v2/";

  FeedbackAPI() : super(prefix);

  Future<void> getFeedBackOfTutor({
    required String accessToken,
    required int page,
    required int perPage,
    required String tutorId,
    required Function(List<TutorFeedbackData>, int) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url:
        "$tutorId?page=$page&perPage=$perPage",
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
      var result = GetListFeedbacksResponse.fromJson(response.response).data;

      onSuccess(result?.rows ?? [], result?.count ?? 0);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }
}