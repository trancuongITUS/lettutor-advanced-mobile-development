import 'package:src/models/booking_info.dart';

class ScheduleDetailModel {
  final int startPeriodTimestamp;
  final int endPeriodTimestamp;
  final String id;
  final String scheduleId;
  final String startPeriod;
  final String endPeriod;
  final String createdAt;
  final String updatedAt;
  final List<BookingInfoModel> bookingInfo;
  final bool isBooked;

  ScheduleDetailModel({
    required this.startPeriodTimestamp,
    required this.endPeriodTimestamp,
    required this.id,
    required this.scheduleId,
    required this.startPeriod,
    required this.endPeriod,
    required this.createdAt,
    required this.updatedAt,
    required this.bookingInfo,
    required this.isBooked,
  });

  factory ScheduleDetailModel.fromJson(Map<String, dynamic> json) {
    List<BookingInfoModel> bookingInfos = [];
    if (json['bookingInfo'] != null) {
      bookingInfos = (json['bookingInfo'] as List).map((bookingInfo) => BookingInfoModel.fromJson(bookingInfo)).toList();
    }

    return ScheduleDetailModel(
      startPeriodTimestamp: json['startPeriodTimestamp'] as int,
      endPeriodTimestamp: json['endPeriodTimestamp'] as int,
      id: json['id'] as String,
      scheduleId: json['scheduleId'] as String,
      startPeriod: json['startPeriod'] as String,
      endPeriod: json['endPeriod'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      bookingInfo: bookingInfos,
      isBooked: json['isBooked'] as bool,
    );
  }
}