import 'package:json_annotation/json_annotation.dart';
import 'package:src/models/data/schedules/booking_info_data.dart';

@JsonSerializable()
class GetListBookingsInfoForHomePageResponse {
  String? message;
  List<BookingInfoData>? data;

  GetListBookingsInfoForHomePageResponse({
    this.message,
    this.data,
  });

  factory GetListBookingsInfoForHomePageResponse.fromJson(Map<String, dynamic> json) =>
    GetListBookingsInfoForHomePageResponse(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BookingInfoData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  Map<String, dynamic> toJson() =>  <String, dynamic>{
    'message': message,
    'data': data,
  };
}