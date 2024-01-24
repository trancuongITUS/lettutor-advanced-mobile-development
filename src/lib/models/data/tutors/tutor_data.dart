import 'package:json_annotation/json_annotation.dart';
import 'package:src/models/data/tutors/tutor_feedback_data.dart';
import 'package:src/models/data/tutors/tutor_info_data.dart';

@JsonSerializable()
class TutorData {
  String? level;
  String? email;
  String? google;
  String? facebook;
  String? apple;
  String? avatar;
  String? name;
  String? country;
  String? phone;
  String? language;
  String? birthday;
  bool? requestPassword;
  bool? isActivated;
  bool? isPhoneActivated;
  String? requireNote;
  int? timezone;
  String? phoneAuth;
  bool? isPhoneAuthActivated;
  bool? canSendMessage;
  bool? isPublicRecord;
  String? caredByStaffId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? studentGroupId;
  List<TutorFeedbackData>? feedbacks;
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
  String? resume;
  double? rating;
  bool? isNative;
  int? price;
  bool? isOnline;
  bool? isFavoriteTutor;
  TutorInfoData? tutorInfo;

  TutorData({
    this.level,
    this.email,
    this.google,
    this.facebook,
    this.apple,
    this.avatar,
    this.name,
    this.country,
    this.phone,
    this.language,
    this.birthday,
    this.requestPassword,
    this.isActivated,
    this.isPhoneActivated,
    this.requireNote,
    this.timezone,
    this.phoneAuth,
    this.isPhoneAuthActivated,
    this.canSendMessage,
    this.isPublicRecord,
    this.caredByStaffId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.studentGroupId,
    this.feedbacks,
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
    this.resume,
    this.rating,
    this.isNative,
    this.price,
    this.isOnline,
    this.isFavoriteTutor,
    this.tutorInfo
  });
  factory TutorData.fromJson(Map<String, dynamic> json) =>
      TutorData(
        level: json['level'] as String?,
        email: json['email'] as String?,
        google: json['google'] as String?,
        facebook: json['facebook'] as String?,
        apple: json['apple'] as String?,
        avatar: json['avatar'] as String?,
        name: json['name'] as String?,
        country: json['country'] as String?,
        phone: json['phone'] as String?,
        language: json['language'] as String?,
        birthday: json['birthday'] as String?,
        requestPassword: json['requestPassword'] as bool?,
        isActivated: json['isActivated'] as bool?,
        isPhoneActivated: json['isPhoneActivated'] as bool?,
        requireNote: json['requireNote'] as String?,
        timezone: json['timezone'] as int?,
        phoneAuth: json['phoneAuth'] as String?,
        isPhoneAuthActivated: json['isPhoneAuthActivated'] as bool?,
        canSendMessage: json['canSendMessage'] as bool?,
        isPublicRecord: json['isPublicRecord'] as bool?,
        caredByStaffId: json['caredByStaffId'] as String?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        deletedAt: json['deletedAt'] as String?,
        studentGroupId: json['studentGroupId'] as String?,
        feedbacks: (json['feedbacks'] as List<dynamic>?)
            ?.map((e) => TutorFeedbackData.fromJson(e as Map<String, dynamic>))
            .toList(),
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
        resume: json['resume'] as String?,
        rating: (json['rating'] as num?)?.toDouble(),
        isNative: json['isNative'] as bool?,
        price: json['price'] as int?,
        isOnline: json['isOnline'] as bool?,
        isFavoriteTutor: json['isFavoriteTutor'] as bool?,
        tutorInfo: json['tutorInfo'] == null
            ? null
            : TutorInfoData.fromJson(json['tutorInfo'] as Map<String, dynamic>),
      );
  Map<String, dynamic> toJson() =>  <String, dynamic>{
    'level': level,
    'email': email,
    'google': google,
    'facebook': facebook,
    'apple': apple,
    'avatar': avatar,
    'name': name,
    'country': country,
    'phone': phone,
    'language': language,
    'birthday': birthday,
    'requestPassword': requestPassword,
    'isActivated': isActivated,
    'isPhoneActivated': isPhoneActivated,
    'requireNote': requireNote,
    'timezone': timezone,
    'phoneAuth': phoneAuth,
    'isPhoneAuthActivated': isPhoneAuthActivated,
    'canSendMessage': canSendMessage,
    'isPublicRecord': isPublicRecord,
    'caredByStaffId': caredByStaffId,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'deletedAt': deletedAt,
    'studentGroupId': studentGroupId,
    'feedbacks': feedbacks,
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
    'resume': resume,
    'rating': rating,
    'isNative': isNative,
    'price': price,
    'isOnline': isOnline,
    'isFavoriteTutor': isFavoriteTutor,
    'tutorInfo': tutorInfo,
  };
}