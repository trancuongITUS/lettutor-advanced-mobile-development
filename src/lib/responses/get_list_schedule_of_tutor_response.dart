import 'package:json_annotation/json_annotation.dart';
import 'package:src/models/data/schedules/schedule_data.dart';

@JsonSerializable()
class GetListScheduleOfTutorResponse {
  String? message;
  List<ScheduleData>? scheduleOfTutor;

  GetListScheduleOfTutorResponse({
    this.message,
    this.scheduleOfTutor,
  });

  factory GetListScheduleOfTutorResponse.fromJson(Map<String, dynamic> json) =>
    GetListScheduleOfTutorResponse(
      message: json['message'] as String?,
      scheduleOfTutor: (json['scheduleOfTutor'] as List<dynamic>?)
        ?.map((e) => ScheduleData.fromJson(e as Map<String, dynamic>))
        .toList(),
    );
}