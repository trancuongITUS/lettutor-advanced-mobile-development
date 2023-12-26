import 'package:flutter/material.dart';

class TutorInfo {
  final String id;
  final String video;
  final String bio;
  final String education;
  final String experience;
  final String profession;
  final dynamic accent;
  final String targetStudent;
  final String interests;
  final String languages;
  final String specialties;
  final dynamic resume;
  final double rating;
  final bool isActivated;
  final bool isNative;
  final dynamic youtubeVideoId;

  TutorInfo({
    required this.id,
    required this.video,
    required this.bio,
    required this.education,
    required this.experience,
    required this.profession,
    required this.accent,
    required this.targetStudent,
    required this.interests,
    required this.languages,
    required this.specialties,
    required this.resume,
    required this.rating,
    required this.isActivated,
    required this.isNative,
    required this.youtubeVideoId,
  });

  factory TutorInfo.fromJson(Map<String, dynamic> json) {
    return TutorInfo(
      id: json['id'],
      video: json['video'],
      bio: json['bio'],
      education: json['education'],
      experience: json['experience'],
      profession: json['profession'],
      accent: json['accent'],
      targetStudent: json['targetStudent'],
      interests: json['interests'],
      languages: json['languages'],
      specialties: json['specialties'],
      resume: json['resume'],
      rating: json['rating'].toDouble(),
      isActivated: json['isActivated'],
      isNative: json['isNative'],
      youtubeVideoId: json['youtubeVideoId'],
    );
  }
}

class WalletInfo {
  final String amount;
  final bool isBlocked;
  final int bonus;

  WalletInfo({
    required this.amount,
    required this.isBlocked,
    required this.bonus,
  });

  factory WalletInfo.fromJson(Map<String, dynamic> json) {
    return WalletInfo(
      amount: json['amount'],
      isBlocked: json['isBlocked'],
      bonus: json['bonus'],
    );
  }
}

class ReferralPackInfo {
  final int earnPercent;

  ReferralPackInfo({
    required this.earnPercent,
  });

  factory ReferralPackInfo.fromJson(Map<String, dynamic> json) {
    return ReferralPackInfo(
      earnPercent: json['earnPercent'],
    );
  }
}

class ReferralInfo {
  final String referralCode;
  final ReferralPackInfo referralPackInfo;

  ReferralInfo({
    required this.referralCode,
    required this.referralPackInfo,
  });

  factory ReferralInfo.fromJson(Map<String, dynamic> json) {
    return ReferralInfo(
      referralCode: json['referralCode'],
      referralPackInfo: ReferralPackInfo.fromJson(json['referralPackInfo']),
    );
  }
}
class LearnTopic{
  final int id;
  final String key;
  final String name;
  LearnTopic({
    required this.id,
    required this.key,
    required this.name,
  });
  factory LearnTopic.fromJson(Map<String, dynamic> json) {
    return LearnTopic(
      id: json['id'],
      key: json['key'],
      name: json['name'],
    );
  }
}
class TestPreparation {
    final int id;
    final String key;
    final String name;

  TestPreparation({
    required this.id,
    required this.key,
    required this.name,
  });

  factory TestPreparation.fromJson(Map<String, dynamic> json) {
    return TestPreparation(
      id: json['id'],
      key: json['key'],
      name: json['name'],
    );
  }
}

class UserInfoModel extends ChangeNotifier {
  final String id;
  final String email;
  String name;
  String avatar;
  String country;
  String phone;
  final List<String> roles;
  final dynamic language;
  dynamic birthday;
  final bool isActivated;
  final TutorInfo tutorInfo;
  final WalletInfo walletInfo;
  final String requireNote;
  String level;
  final List<LearnTopic> learnTopics;
  final List<TestPreparation> testPreparations;
  final bool isPhoneActivated;
  final int timezone;
  final ReferralInfo referralInfo;
  String studySchedule;
  final bool canSendMessage;
  final dynamic studentGroup;
  final dynamic studentInfo;
  final double avgRating;

  UserInfoModel({
    required this.id,
    required this.email,
    required this.name,
    required this.avatar,
    required this.country,
    required this.phone,
    required this.roles,
    required this.language,
    required this.birthday,
    required this.isActivated,
    required this.tutorInfo,
    required this.walletInfo,
    required this.requireNote,
    required this.level,
    required this.learnTopics,
    required this.testPreparations,
    required this.isPhoneActivated,
    required this.timezone,
    required this.referralInfo,
    required this.studySchedule,
    required this.canSendMessage,
    required this.studentGroup,
    required this.studentInfo,
    required this.avgRating,
  });

  void updateData(UserInfoModel data) {
    name = data.name;
    country = data.country;
    birthday = data.birthday;
    level =data.level;
    studySchedule = data.studySchedule;
    notifyListeners();
  }

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      avatar: json['avatar'],
      country: json['country'],
      phone: json['phone'],
      roles: List<String>.from(json['roles']),
      language: json['language'],
      birthday: json['birthday'],
      isActivated: json['isActivated'],
      tutorInfo: TutorInfo.fromJson(json['tutorInfo']),
      walletInfo: WalletInfo.fromJson(json['walletInfo']),
      requireNote: json['requireNote'],
      level: json['level'],
      learnTopics: (json['learnTopics'] as List<dynamic>)
          .map((topicJson) => LearnTopic.fromJson(topicJson))
          .toList(),
      testPreparations: (json['testPreparations'] as List<dynamic>)
          .map((testJson) => TestPreparation.fromJson(testJson))
          .toList(),
      isPhoneActivated: json['isPhoneActivated'],
      timezone: json['timezone'],
      referralInfo: ReferralInfo.fromJson(json['referralInfo']),
      studySchedule: json['studySchedule'],
      canSendMessage: json['canSendMessage'],
      studentGroup: json['studentGroup'],
      studentInfo: json['studentInfo'],
      avgRating: json['avgRating'].toDouble(),
    );
  }
}