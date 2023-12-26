import 'package:json_annotation/json_annotation.dart';
import 'package:src/models/data/tutors/tutor_transfered_data.dart';

@JsonSerializable()
class TutorFeedbackData {
  String? id;
  String? bookingId;
  String? firstId;
  String? secondId;
  int? rating;
  String? content;
  String? createdAt;
  String? updatedAt;
  TutorTransferedData? firstInfo;

  TutorFeedbackData({
    this.id,
    this.bookingId,
    this.firstId,
    this.secondId,
    this.rating,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.firstInfo,
  });

  factory TutorFeedbackData.fromJson(Map<String, dynamic> json) =>
      TutorFeedbackData(
        id: json['id'] as String?,
        bookingId: json['bookingId'] as String?,
        firstId: json['firstId'] as String?,
        secondId: json['secondId'] as String?,
        rating: json['rating'] as int?,
        content: json['content'] as String?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        firstInfo: json['firstInfo'] == null
            ? null
            : TutorTransferedData.fromJson(
            json['firstInfo'] as Map<String, dynamic>),
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'bookingId': bookingId,
    'firstId': firstId,
    'secondId': secondId,
    'rating': rating,
    'content': content,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'firstInfo': firstInfo,
  };
}