import 'package:json_annotation/json_annotation.dart';
import 'package:src/models/data/users/learn_topic_data.dart';
import 'package:src/models/data/users/test_preparation_data.dart';
import 'package:src/models/data/users/wallet_data.dart';

part 'user_model.g.dart';

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
      _$UserDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}