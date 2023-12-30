import 'package:src/models/data/courses/course_data.dart';
import 'package:src/responses/get_list_courses_response.dart';
import 'package:src/services/api_service.dart';
import 'package:src/services/base_api.dart';

class CourseAPI extends BaseAPI {
  static const String prefix = "";

  CourseAPI() : super(prefix);

  Future<void> getCourseListWithPagination({
    required String accessToken,
    required int size,
    required int page,
    required String search,
    required Function(List<CourseData>, int) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url: "course?page=$page&size=$size&q=$search",
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        var result = GetListCoursesResponse.fromJson(response.response).data;
        onSuccess(result?.rows ?? [], result?.count ?? 0);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }
}