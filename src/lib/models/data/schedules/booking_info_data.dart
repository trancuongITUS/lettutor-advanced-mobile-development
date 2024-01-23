import 'package:json_annotation/json_annotation.dart';
import 'package:src/models/data/schedules/class_review_data.dart';
import 'package:src/models/data/schedules/schedule_detail_data.dart';
import 'package:src/models/data/tutors/tutor_feedback_data.dart';

@JsonSerializable()
class BookingInfoData {
  int? createdAtTimeStamp;
  int? updatedAtTimeStamp;
  String? id;
  String? userId;
  String? scheduleDetailId;
  String? tutorMeetingLink;
  String? studentMeetingLink;
  String? studentRequest;
  String? tutorReview;
  int? scoreByTutor;
  String? createdAt;
  String? updatedAt;
  String? recordUrl;
  bool? isDeleted;
  ScheduleDetailData? scheduleDetailInfo;
  ClassReviewData? classReview;
  int? cancelReasonId;
  String? lessonPlanId;
  String? cancelNote;
  String? calendarId;
  bool? showRecordUrl;
  List<TutorFeedbackData>? feedbacks;

  BookingInfoData({
    this.createdAtTimeStamp,
    this.updatedAtTimeStamp,
    this.id,
    this.userId,
    this.scheduleDetailId,
    this.tutorMeetingLink,
    this.studentMeetingLink,
    this.studentRequest,
    this.tutorReview,
    this.scoreByTutor,
    this.createdAt,
    this.updatedAt,
    this.recordUrl,
    this.isDeleted,
    this.scheduleDetailInfo,
    this.classReview,
    this.cancelReasonId,
    this.lessonPlanId,
    this.cancelNote,
    this.calendarId,
    this.showRecordUrl,
    this.feedbacks,
  });

  factory BookingInfoData.fromJson(Map<String, dynamic> json) =>
    BookingInfoData(
      createdAtTimeStamp: json['createdAtTimeStamp'] as int?,
      updatedAtTimeStamp: json['updatedAtTimeStamp'] as int?,
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      scheduleDetailId: json['scheduleDetailId'] as String?,
      tutorMeetingLink: json['tutorMeetingLink'] as String?,
      studentMeetingLink: json['studentMeetingLink'] as String?,
      studentRequest: json['studentRequest'] as String?,
      tutorReview: json['tutorReview'] as String?,
      scoreByTutor: json['scoreByTutor'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      recordUrl: json['recordUrl'] as String?,
      isDeleted: json['isDeleted'] as bool?,
      scheduleDetailInfo: json['scheduleDetailInfo'] == null
          ? null
          : ScheduleDetailData.fromJson(
          json['scheduleDetailInfo'] as Map<String, dynamic>),
      classReview: json['classReview'] == null
          ? null
          : ClassReviewData.fromJson(json['classReview'] as Map<String, dynamic>),
      cancelReasonId: json['cancelReasonId'] as int?,
      lessonPlanId: json['lessonPlanId'] as String?,
      cancelNote: json['cancelNote'] as String?,
      calendarId: json['calendarId'] as String?,
      showRecordUrl: json['showRecordUrl'] as bool?,
      feedbacks: (json['feedbacks'] as List<dynamic>?)
          ?.map((e) => TutorFeedbackData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    
  Map<String, dynamic> toJson() => <String, dynamic>{
    'createdAtTimeStamp': createdAtTimeStamp,
    'updatedAtTimeStamp': updatedAtTimeStamp,
    'id': id,
    'userId': userId,
    'scheduleDetailId': scheduleDetailId,
    'tutorMeetingLink': tutorMeetingLink,
    'studentMeetingLink':studentMeetingLink,
    'studentRequest': studentRequest,
    'tutorReview': tutorReview,
    'scoreByTutor': scoreByTutor,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'recordUrl': recordUrl,
    'isDeleted': isDeleted,
    'scheduleDetailInfo': scheduleDetailInfo,
    'classReview': classReview,
    'cancelReasonId': cancelReasonId,
    'lessonPlanId': lessonPlanId,
    'cancelNote': cancelNote,
    'calendarId': calendarId,
    'showRecordUrl': showRecordUrl,
    'feedbacks': feedbacks,
  };
}