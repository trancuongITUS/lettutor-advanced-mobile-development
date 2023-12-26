import 'package:flutter/material.dart';
import 'package:src/models/schedule_detail.dart';

class ScheduleModel extends ChangeNotifier {
  final String id;
  final String tutorId;
  final String startTime;
  final String endTime;
  final int startTimestamp;
  final int endTimestamp;
  String createdAt;
  bool isBooked;
  final List<ScheduleDetailModel> scheduleDetails;

  void booking() {
    isBooked = true;
  }

  ScheduleModel({
    required this.id,
    required this.tutorId,
    required this.startTime,
    required this.endTime,
    required this.startTimestamp,
    required this.endTimestamp,
    required this.createdAt,
    required this.isBooked,
    required this.scheduleDetails,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    List<ScheduleDetailModel> scheduleDetails = [];
    if (json['scheduleDetails'] != null) {
      scheduleDetails = (json['scheduleDetails'] as List).map((scheduleDetail) => ScheduleDetailModel.fromJson(scheduleDetail)).toList();
    }

    return ScheduleModel(
      id: json['id'] as String,
      tutorId: json['tutorId'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      startTimestamp: json['startTimestamp'] as int,
      endTimestamp: json['endTimestamp'] as int,
      createdAt: json['createdAt'] as String,
      isBooked: json['isBooked'] as bool,
      scheduleDetails: scheduleDetails,
    );
  }
}