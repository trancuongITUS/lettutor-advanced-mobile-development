import 'package:src/models/data/tutors/tutor_data.dart';
import 'package:src/models/data/tutors/tutor_info_data.dart';
import 'package:src/models/data/tutors/tutor_pagination.dart';
import 'package:src/responses/get_list_tutors_response.dart';
import 'package:src/services/api_service.dart';
import 'package:src/services/base_api.dart';

class TutorAPI extends BaseAPI {
  static const String prefix = "tutor/";
  TutorAPI() : super(prefix);

  Future<void> becomeTutor({
    required Function() onSuccess,
  }) async {
    final response = await service.postFormUrlEncoded(
      url: "register",
      data: {},
    );
    await onSuccess();
  }

  Future<void> getListTutor({
    required String accessToken,
    required int perPage,
    required int page,
    required Function(GetListTutorsResponse) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url: "more?perPage=$perPage&page=$page",
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(GetListTutorsResponse.fromJson(response.response));
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  Future<void> writeReviewAfterClass({
    required Function() onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.post(
      url: "feedbackTutor",
    );

    await onSuccess();
  }

  Future<void> getTutorById({
    required String accessToken,
    required String tutorId,
    required Function(TutorInfoData) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url: tutorId,
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(TutorInfoData.fromJson(response.response));
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  Future<void> searchTutor({
    required String accessToken,
    required String searchKeys,
    required int page,
    required List<String> speciality,
    required Map<String, dynamic> nationality,
    required Function(List<TutorData>, int) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.post(url: "search", data: {
      "filters": {
        "specialties": speciality,
        "nationality": nationality,
        "date": null,
        "tutoringTimeAvailable": [null, null]
      },
      "search": searchKeys,
      "page": "$page",
      "perPage": 10
    }, headers: {
      "Authorization": "Bearer $accessToken"
    }) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        var result = TutorPaginationData.fromJson(response.response);
        onSuccess(result.rows ?? [], result.count ?? 0);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  Future<void> addTutorToFavorite({
    required Function() onSuccess,
  }) async {
    final response = await service.post(
      url: "manageFavoriteTutor",
    );

    await onSuccess();
  }
}