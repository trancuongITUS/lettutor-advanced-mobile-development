import 'package:json_annotation/json_annotation.dart';
import 'package:src/models/data/tutors/tutor_info_data.dart';

@JsonSerializable()
class TutorTransferedData {
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
  String? studySchedule;
  bool? canSendMessage;
  bool? isPublicRecord;
  String? caredByStaffId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? studentGroupId;
  TutorInfoData? tutorInfo;

  TutorTransferedData({
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
    this.studySchedule,
    this.canSendMessage,
    this.isPublicRecord,
    this.caredByStaffId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.studentGroupId,
    this.tutorInfo
  });
  factory TutorTransferedData.fromJson(Map<String, dynamic> json) =>
      TutorTransferedData(
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
        studySchedule: json['studySchedule'] as String?,
        canSendMessage: json['canSendMessage'] as bool?,
        isPublicRecord: json['isPublicRecord'] as bool?,
        caredByStaffId: json['caredByStaffId'] as String?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        deletedAt: json['deletedAt'] as String?,
        studentGroupId: json['studentGroupId'] as String?,
        tutorInfo: json['tutorInfo'] == null
            ? null
            : TutorInfoData.fromJson(json['tutorInfo'] as Map<String, dynamic>),
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
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
    'studySchedule': studySchedule,
    'canSendMessage': canSendMessage,
    'isPublicRecord': isPublicRecord,
    'caredByStaffId': caredByStaffId,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'deletedAt': deletedAt,
    'studentGroupId': studentGroupId,
    'tutorInfo': tutorInfo,
  };
}