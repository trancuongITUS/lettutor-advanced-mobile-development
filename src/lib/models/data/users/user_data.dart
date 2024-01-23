import 'package:json_annotation/json_annotation.dart';
import 'package:src/models/data/users/learn_topic_data.dart';
import 'package:src/models/data/users/test_preparation_data.dart';
import 'package:src/models/data/users/wallet_data.dart';

@JsonSerializable()
class UserData {
  String? id;
  String? email;
  String? name;
  String? avatar;
  String? country;
  String? phone;
  List<String>? roles;
  String? language;
  String? birthday;
  bool? isActivated;
  WalletData? walletInfo;
  List<String>? coursesId;
  String? requireNote;
  String? level;
  List<LearnTopicData>? learnTopics;
  List<TestPreparationData>? testPreparations;
  bool? isPhoneActivated;
  int? timezone;
  String? studySchedule;
  bool? canSendMessage;

  UserData({
    this.id,
    this.email,
    this.name,
    this.avatar,
    this.country,
    this.phone,
    this.roles,
    this.language,
    this.birthday,
    this.isActivated,
    this.walletInfo,
    this.coursesId,
    this.requireNote,
    this.level,
    this.learnTopics,
    this.testPreparations,
    this.isPhoneActivated,
    this.timezone,
    this.studySchedule,
    this.canSendMessage,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      UserData(
        id: json['id'] as String?,
        email: json['email'] as String?,
        name: json['name'] as String?,
        avatar: json['avatar'] as String?,
        country: json['country'] as String?,
        phone: json['phone'] as String?,
        roles:
        (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
        language: json['language'] as String?,
        birthday: json['birthday'] as String?,
        isActivated: json['isActivated'] as bool?,
        walletInfo: json['walletInfo'] == null
            ? null
            : WalletData.fromJson(json['walletInfo'] as Map<String, dynamic>),
        coursesId: (json['coursesId'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        requireNote: json['requireNote'] as String?,
        level: json['level'] as String?,
        learnTopics: (json['learnTopics'] as List<dynamic>?)
            ?.map((e) => LearnTopicData.fromJson(e as Map<String, dynamic>))
            .toList(),
        testPreparations: (json['testPreparations'] as List<dynamic>?)
            ?.map((e) => TestPreparationData.fromJson(e as Map<String, dynamic>))
            .toList(),
        isPhoneActivated: json['isPhoneActivated'] as bool?,
        timezone: json['timezone'] as int?,
        studySchedule: json['studySchedule'] as String?,
        canSendMessage: json['canSendMessage'] as bool?,
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'email': email,
    'name': name,
    'avatar': avatar,
    'country': country,
    'phone': phone,
    'roles': roles,
    'language': language,
    'birthday': birthday,
    'isActivated': isActivated,
    'walletInfo': walletInfo,
    'coursesId': coursesId,
    'requireNote': requireNote,
    'level': level,
    'learnTopics': learnTopics,
    'testPreparations': testPreparations,
    'isPhoneActivated': isPhoneActivated,
    'timezone': timezone,
    'studySchedule': studySchedule,
    'canSendMessage': canSendMessage,
  };
}