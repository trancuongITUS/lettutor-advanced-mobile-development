import 'package:src/models/data/users/user_data.dart';
import 'package:src/services/api_service.dart';
import 'package:src/services/base_api.dart';
import 'package:dio/dio.dart';

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

  Future<void> updateInfoUser({
    required String accessToken,
    required UserData input,
    required Function(UserData) onSuccess,
    required Function(String) onFail,
  }) async {
    var learnTopics = [];
    input.learnTopics?.forEach((element) {
      learnTopics.add(element.id);
    });
    var testPreparations = [];
    input.testPreparations?.forEach((element) {
      testPreparations.add(element.id);
    });
    final response = await service.put(url: 'info', headers: {
      "Authorization": "Bearer $accessToken"
    }, data: {
      "name": input.name,
      "country": input.country,
      "phone": input.phone,
      "birthday": input.birthday,
      "level": input.level,
      "learnTopics": learnTopics,
      "testPreparations": testPreparations,
      "studySchedule":input.studySchedule
    }) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        final user = UserData.fromJson(response.response['user']);
        await onSuccess(user);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  Future<void> uploadAvatar({
    required String accessToken,
    required String imagePath,
    required Function(UserData) onSuccess,
    required Function(String) onFail,
  }) async {
    final formDataImage = FormData.fromMap({
      'avatar': await MultipartFile.fromFile(
        imagePath,
      ),
    });
    final response = await service.postFormData(
        url: "uploadAvatar",
        headers: {"Authorization": "Bearer $accessToken"},
        data: formDataImage) as BoundResource;
    switch (response.statusCode) {
      case 200:
      case 201:
        final user = UserData.fromJson(response.response);
        await onSuccess(user);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }
  Future<void> resetPassword({
    required String email,
    required Function(String) result,
  }) async {
    var response = await service.post(url: "forgotPassword", headers: {
      "origin": "https://sandbox.app.lettutor.com",
      "referer": "https://sandbox.app.lettutor.com/",
    }, data: {
      "email": email
    }) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        result(response.response['message']);
        break;
      default:
        result(response.errorMsg.toString());
        break;
    }
  }
}