class FirstInfoModel {
  final dynamic level;
  final String email;
  final dynamic google;
  final dynamic facebook;
  final dynamic apple;
  final dynamic avatar;
  final String name;
  final dynamic country;
  final dynamic phone;
  final dynamic language;
  final dynamic birthday;
  final bool requestPassword;
  final bool isActivated;
  final bool isPhoneActivated;
  final dynamic requireNote;
  final int timezone;
  final dynamic phoneAuth;
  final bool isPhoneAuthActivated;
  final dynamic studySchedule;
  final bool canSendMessage;
  final bool isPublicRecord;
  final dynamic caredByStaffId;
  final dynamic zaloUserId;
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic deletedAt;
  final dynamic studentGroupId;

  FirstInfoModel({
    required this.level,
    required this.email,
    required this.google,
    required this.facebook,
    required this.apple,
    required this.avatar,
    required this.name,
    required this.country,
    required this.phone,
    required this.language,
    required this.birthday,
    required this.requestPassword,
    required this.isActivated,
    required this.isPhoneActivated,
    required this.requireNote,
    required this.timezone,
    required this.phoneAuth,
    required this.isPhoneAuthActivated,
    required this.studySchedule,
    required this.canSendMessage,
    required this.isPublicRecord,
    required this.caredByStaffId,
    required this.zaloUserId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.studentGroupId,
  });

  factory FirstInfoModel.fromJson(Map<String, dynamic> json) {
    return FirstInfoModel(
      level: json['level'],
      email: json['email'],
      google: json['google'],
      facebook: json['facebook'],
      apple: json['apple'],
      avatar: json['avatar'],
      name: json['name'],
      country: json['country'],
      phone: json['phone'],
      language: json['language'],
      birthday: json['birthday'],
      requestPassword: json['requestPassword'],
      isActivated: json['isActivated'],
      isPhoneActivated: json['isPhoneActivated'],
      requireNote: json['requireNote'],
      timezone: json['timezone'],
      phoneAuth: json['phoneAuth'],
      isPhoneAuthActivated: json['isPhoneAuthActivated'],
      studySchedule: json['studySchedule'],
      canSendMessage: json['canSendMessage'],
      isPublicRecord: json['isPublicRecord'],
      caredByStaffId: json['caredByStaffId'],
      zaloUserId: json['zaloUserId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      studentGroupId: json['studentGroupId'],
    );
  }
}