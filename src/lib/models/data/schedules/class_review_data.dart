import 'package:json_annotation/json_annotation.dart';
import 'package:src/models/data/schedules/lesson_status_data.dart';

@JsonSerializable()
class ClassReviewData {
  final String? bookingId;
  final int? lessonStatusId;
  final String? book;
  final String? unit;
  final String? lesson;
  final dynamic page;
  final String? lessonProgress;
  final int? behaviorRating;
  final String? behaviorComment;
  final int? listeningRating;
  final String? listeningComment;
  final int? speakingRating;
  final String? speakingComment;
  final int? vocabularyRating;
  final String? vocabularyComment;
  final String? homeworkComment;
  final String? overallComment;
  final LessonStatusData? lessonStatus;

  ClassReviewData({
    this.bookingId,
    this.lessonStatusId,
    this.book,
    this.unit,
    this.lesson,
    this.page,
    this.lessonProgress,
    this.behaviorRating,
    this.behaviorComment,
    this.listeningRating,
    this.listeningComment,
    this.speakingRating,
    this.speakingComment,
    this.vocabularyRating,
    this.vocabularyComment,
    this.homeworkComment,
    this.overallComment,
    this.lessonStatus,
  });

  factory ClassReviewData.fromJson(Map<String, dynamic> json) =>
    ClassReviewData(
      bookingId: json['bookingId'] as String?,
      lessonStatusId: json['lessonStatusId'] as int?,
      book: json['book'] as String?,
      unit: json['unit'] as String?,
      lesson: json['lesson'] as String?,
      page: json['page'],
      lessonProgress: json['lessonProgress'] as String?,
      behaviorRating: json['behaviorRating'] as int?,
      behaviorComment: json['behaviorComment'] as String?,
      listeningRating: json['listeningRating'] as int?,
      listeningComment: json['listeningComment'] as String?,
      speakingRating: json['speakingRating'] as int?,
      speakingComment: json['speakingComment'] as String?,
      vocabularyRating: json['vocabularyRating'] as int?,
      vocabularyComment: json['vocabularyComment'] as String?,
      homeworkComment: json['homeworkComment'] as String?,
      overallComment: json['overallComment'] as String?,
      lessonStatus: json['lessonStatus'] == null
          ? null
          : LessonStatusData.fromJson(json['lessonStatus'] as Map<String, dynamic>),
    );
  Map<String, dynamic> toJson() => <String, dynamic>{
    'bookingId': bookingId,
    'lessonStatusId': lessonStatusId,
    'book': book,
    'unit': unit,
    'lesson': lesson,
    'page': page,
    'lessonProgress': lessonProgress,
    'behaviorRating': behaviorRating,
    'behaviorComment': behaviorComment,
    'listeningRating': listeningRating,
    'listeningComment': listeningComment,
    'speakingRating': speakingRating,
    'speakingComment': speakingComment,
    'vocabularyRating': vocabularyRating,
    'vocabularyComment': vocabularyComment,
    'homeworkComment': homeworkComment,
    'overallComment': overallComment,
    'lessonStatus': lessonStatus,
  };
}