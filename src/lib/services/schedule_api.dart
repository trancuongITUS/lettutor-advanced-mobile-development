import 'package:src/models/data/schedules/schedule_data.dart';
import 'package:src/responses/get_list_schedule_of_tutor_response.dart';
import 'package:src/services/api_service.dart';
import 'package:src/services/base_api.dart';

class ScheduleAPI extends BaseAPI {
  static const String prefix = "schedule";

  ScheduleAPI() : super(prefix);

  Future<void> getScheduleById({
    required String accessToken,
    required String tutorId,
    required int startTime,
    required int endTime,
    required Function(List<ScheduleData>) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url: "?tutorId=$tutorId&startTimestamp=$startTime&endTimestamp=$endTime&=",
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(GetListScheduleOfTutorResponse.fromJson(response.response).scheduleOfTutor ?? []);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  Future<void> getOwnSchedule({
    required String accessToken,
    required Function(List<ScheduleData>) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.post(
      url: "",
      headers: {
        "Authorization":"Bearer $accessToken"
      }) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(GetListScheduleOfTutorResponse.fromJson(response.response).scheduleOfTutor??[]);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }
}