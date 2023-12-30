import 'package:json_annotation/json_annotation.dart';
import 'package:src/models/data/schedules/booking_info_data.dart';
import 'package:src/models/data/schedules/schedule_data.dart';

@JsonSerializable()
class ScheduleDetailData {
  int? startPeriodTimestamp;
  int? endPeriodTimestamp;
  String? id;
  String? scheduleId;
  String? startPeriod;
  String? endPeriod;
  String? createdAt;
  String? updatedAt;
  List<BookingInfoData>? bookingInfo;
  bool? isBooked;
  ScheduleData? scheduleInfo;
  ScheduleDetailData({
    this.startPeriodTimestamp,
    this.endPeriodTimestamp,
    this.id,
    this.scheduleId,
    this.startPeriod,
    this.endPeriod,
    this.createdAt,
    this.updatedAt,
    this.bookingInfo,
    this.isBooked,
    this.scheduleInfo,
  });

  factory ScheduleDetailData.fromJson(Map<String, dynamic> json) =>
    ScheduleDetailData(
      startPeriodTimestamp: json['startPeriodTimestamp'] as int?,
      endPeriodTimestamp: json['endPeriodTimestamp'] as int?,
      id: json['id'] as String?,
      scheduleId: json['scheduleId'] as String?,
      startPeriod: json['startPeriod'] as String?,
      endPeriod: json['endPeriod'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      bookingInfo: (json['bookingInfo'] as List<dynamic>?)
          ?.map((e) => BookingInfoData.fromJson(e as Map<String, dynamic>))
          .toList(),
      isBooked: json['isBooked'] as bool?,
      scheduleInfo: json['scheduleInfo'] == null
          ? null
          : ScheduleData.fromJson(json['scheduleInfo'] as Map<String, dynamic>),
    );
}