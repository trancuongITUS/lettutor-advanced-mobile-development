import 'package:json_annotation/json_annotation.dart';
import 'package:src/models/data/tutors/tutor_feedback_data.dart';

@JsonSerializable()
class GetListFeedbacksResponse {
  String? message;
  FeedbackPagination? data;

  GetListFeedbacksResponse({
    this.message,
    this.data,
  });

  factory GetListFeedbacksResponse.fromJson(Map<String, dynamic> json) =>
      GetListFeedbacksResponse(
        message: json['message'] as String?,
        data: json['data'] == null
            ? null
            : FeedbackPagination.fromJson(json['data'] as Map<String, dynamic>),
      );
  Map<String, dynamic> toJson() =><String, dynamic>{
    'message': message,
    'data': data,
  };
}


@JsonSerializable()
class FeedbackPagination {
  int? count;
  List<TutorFeedbackData>? rows;

  FeedbackPagination({
    this.count,
    this.rows,
  });

  factory FeedbackPagination.fromJson(Map<String, dynamic> json) =>
      FeedbackPagination(
        count: json['count'] as int?,
        rows: (json['rows'] as List<dynamic>?)
            ?.map((e) => TutorFeedbackData.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
    'count': count,
    'rows': rows,
  };
}