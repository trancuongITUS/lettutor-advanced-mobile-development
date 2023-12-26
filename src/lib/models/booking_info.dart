class BookingInfoModel {
  final int createdAtTimeStamp;
  final int updatedAtTimeStamp;
  final String id;
  final String userId;
  final String scheduleDetailId;
  final String tutorMeetingLink;
  final String studentMeetingLink;
  final dynamic googleMeetLink;
  final dynamic studentRequest;
  final dynamic tutorReview;
  final dynamic scoreByTutor;
  final String createdAt;
  final String updatedAt;
  final dynamic recordUrl;
  final dynamic cancelReasonId;
  final dynamic lessonPlanId;
  final dynamic cancelNote;
  final dynamic calendarId;
  final bool isDeleted;
  final bool isTrial;

  BookingInfoModel({
    required this.createdAtTimeStamp,
    required this.updatedAtTimeStamp,
    required this.id,
    required this.userId,
    required this.scheduleDetailId,
    required this.tutorMeetingLink,
    required this.studentMeetingLink,
    required this.googleMeetLink,
    required this.studentRequest,
    required this.tutorReview,
    required this.scoreByTutor,
    required this.createdAt,
    required this.updatedAt,
    required this.recordUrl,
    required this.cancelReasonId,
    required this.lessonPlanId,
    required this.cancelNote,
    required this.calendarId,
    required this.isDeleted,
    required this.isTrial,
  });

  factory BookingInfoModel.fromJson(Map<String, dynamic> json) {
    return BookingInfoModel(
      createdAtTimeStamp: json['createdAtTimeStamp'],
      updatedAtTimeStamp: json['updatedAtTimeStamp'],
      id: json['id'],
      userId: json['userId'],
      scheduleDetailId: json['scheduleDetailId'],
      tutorMeetingLink: json['tutorMeetingLink'],
      studentMeetingLink: json['studentMeetingLink'],
      googleMeetLink: json['googleMeetLink'],
      studentRequest: json['studentRequest'],
      tutorReview: json['tutorReview'],
      scoreByTutor: json['scoreByTutor'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      recordUrl: json['recordUrl'],
      cancelReasonId: json['cancelReasonId'],
      lessonPlanId: json['lessonPlanId'],
      cancelNote: json['cancelNote'],
      calendarId: json['calendarId'],
      isDeleted: json['isDeleted'],
      isTrial: json['isTrial'],
    );
  }
}