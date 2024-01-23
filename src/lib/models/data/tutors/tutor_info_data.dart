import 'package:json_annotation/json_annotation.dart';
import 'package:src/models/data/users/user_data.dart';

@JsonSerializable()
class TutorInfoData {
  String? id;
  String? userId;
  String? video;
  String? bio;
  String? education;
  String? experience;
  String? profession;
  String? accent;
  String? targetStudent;
  String? interests;
  String? languages;
  String? specialties;
  double? rating;
  bool? isNative;
  UserData? user;
  bool? isFavorite;
  num? avgRating;
  int? totalFeedback;

  TutorInfoData({
    this.id,
    this.userId,
    this.video,
    this.bio,
    this.education,
    this.experience,
    this.profession,
    this.accent,
    this.targetStudent,
    this.interests,
    this.languages,
    this.specialties,
    this.rating,
    this.isNative,
    this.user,
    this.isFavorite,
    this.avgRating,
    this.totalFeedback,
  });

  factory TutorInfoData.fromJson(Map<String, dynamic> json) =>
      TutorInfoData(
        id: json['id'] as String?,
        userId: json['userId'] as String?,
        video: json['video'] as String?,
        bio: json['bio'] as String?,
        education: json['education'] as String?,
        experience: json['experience'] as String?,
        profession: json['profession'] as String?,
        accent: json['accent'] as String?,
        targetStudent: json['targetStudent'] as String?,
        interests: json['interests'] as String?,
        languages: json['languages'] as String?,
        specialties: json['specialties'] as String?,
        rating: (json['rating'] as num?)?.toDouble(),
        isNative: json['isNative'] as bool?,
        user: json['user'] == null
            ? null
            : UserData.fromJson(json['user'] as Map<String, dynamic>),
        isFavorite: json['isFavorite'] as bool?,
        avgRating: json['avgRating'] as num?,
        totalFeedback: json['totalFeedback'] as int?,
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'userId': userId,
    'video': video,
    'bio': bio,
    'education': education,
    'experience': experience,
    'profession': profession,
    'accent': accent,
    'targetStudent': targetStudent,
    'interests': interests,
    'languages': languages,
    'specialties': specialties,
    'rating': rating,
    'isNative': isNative,
    'user': user,
    'isFavorite':isFavorite,
    'avgRating': avgRating,
    'totalFeedback': totalFeedback,
  };
}