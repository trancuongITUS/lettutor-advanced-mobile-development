import 'package:json_annotation/json_annotation.dart';
import 'package:src/models/data/schedules/booking_info_data.dart';

@JsonSerializable()
class GetListBookingsResponse {
  String? message;
  BookingPagination? data;

  GetListBookingsResponse({
    this.message,
    this.data,
  });

  factory GetListBookingsResponse.fromJson(Map<String, dynamic> json) =>
      GetListBookingsResponse(
        message: json['message'] as String?,
        data: json['data'] == null
            ? null
            : BookingPagination.fromJson(json['data'] as Map<String, dynamic>),
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
    'message': message,
    'data': data,
  };
}


@JsonSerializable()
class BookingPagination {
  int? count;
  List<BookingInfoData>? rows;

  BookingPagination({
    this.count,
    this.rows,
  });

  factory BookingPagination.fromJson(Map<String, dynamic> json) =>
      BookingPagination(
        count: json['count'] as int?,
        rows: (json['rows'] as List<dynamic>?)
            ?.map((e) => BookingInfoData.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  Map<String, dynamic> toJson() =>  <String, dynamic>{
    'count': count,
    'rows': rows,
  };
}