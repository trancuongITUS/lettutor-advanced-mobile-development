import 'package:src/models/first_info.dart';

class FeedbackModel {
  final dynamic id;
  final dynamic bookingId;
  final dynamic firstId;
  final dynamic secondId;
  final dynamic rating;
  final dynamic content;
  final String createdAt;
  final String updatedAt;
  final FirstInfoModel firstInfo;

  FeedbackModel({
    required this.id,
    required this.bookingId,
    required this.firstId,
    required this.secondId,
    required this.rating,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.firstInfo,
  });

  static String getTimeAgo(DateTime dateTime) {
    Duration difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 0) {
      if (difference.inDays >= 30) {
        int month = difference.inDays ~/ 30;
        if (month >= 12) {
          int year = month ~/ 12;
          return '$year years ago';
        }
        else {
          return '$month months ago';
        }
      }
      else {
        return '${difference.inDays} days ago';
      }
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  static String convertTimeToString(String inputString) {
    return getTimeAgo(DateTime.parse(inputString));
  }

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['id'],
      bookingId: json['bookingId'],
      firstId: json['firstId'],
      secondId: json['secondId'],
      rating: json['rating'],
      content: json['content'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt']!=null?convertTimeToString(json['updatedAt']):"",
      firstInfo: FirstInfoModel.fromJson(json['firstInfo']),
    );
  }
}