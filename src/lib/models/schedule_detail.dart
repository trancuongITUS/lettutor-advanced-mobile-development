class ScheduleDetailModel {
  final int startPeriodTimestamp;
  final int endPeriodTimestamp;
  final String id;
  final String scheduleId;
  final String startPeriod;
  final String endPeriod;
  final String createdAt;
  final String updatedAt;
  final List<dynamic> bookingInfo;
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
    return ScheduleDetailModel(
      startPeriodTimestamp: json['startPeriodTimestamp'] as int,
      endPeriodTimestamp: json['endPeriodTimestamp'] as int,
      id: json['id'] as String,
      scheduleId: json['scheduleId'] as String,
      startPeriod: json['startPeriod'] as String,
      endPeriod: json['endPeriod'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      bookingInfo: json['bookingInfo'] as List<dynamic>,
      isBooked: json['isBooked'] as bool,
    );
  }
}