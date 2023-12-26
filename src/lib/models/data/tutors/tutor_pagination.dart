import 'package:json_annotation/json_annotation.dart';
import 'package:src/models/data/tutors/tutor_data.dart';

@JsonSerializable()
class TutorPaginationData {
  int? count;
  List<TutorData>? rows;

  TutorPaginationData({
    this.count,
    this.rows,
  });

  factory TutorPaginationData.fromJson(Map<String, dynamic> json) =>
      TutorPaginationData(
        count: json['count'] as int?,
        rows: (json['rows'] as List<dynamic>?)
            ?.map((e) => TutorData.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
    'count': count,
    'rows': rows,
  };
}