import 'package:json_annotation/json_annotation.dart';
import 'package:src/models/data/courses/course_data.dart';

@JsonSerializable()
class GetListCoursesResponse {
  String? message;
  CoursePagination? data;

  GetListCoursesResponse({
    this.message,
    this.data,
  });

  factory GetListCoursesResponse.fromJson(Map<String, dynamic> json) =>
    GetListCoursesResponse(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : CoursePagination.fromJson(json['data'] as Map<String, dynamic>),
    );
  Map<String, dynamic> toJson() =><String, dynamic>{
    'message': message,
    'data': data,
  };
}


@JsonSerializable()
class CoursePagination {
  int? count;
  List<CourseData>? rows;

  CoursePagination({
    this.count,
    this.rows,
  });

  factory CoursePagination.fromJson(Map<String, dynamic> json) =>
    CoursePagination(
      count: json['count'] as int?,
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) => CourseData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  Map<String, dynamic> toJson() => <String, dynamic>{
    'count': count,
    'rows': rows,
  };
}