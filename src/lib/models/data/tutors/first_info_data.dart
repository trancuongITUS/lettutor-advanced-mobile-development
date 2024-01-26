import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class FirstInfoData {
  String? name;
  String? avatar;


  FirstInfoData({
    this.name,
    this.avatar,

  });

  factory FirstInfoData.fromJson(Map<String, dynamic> json) =>
      FirstInfoData(
        name: json['name'] as String?,
        avatar: json['avatar'] as String?,
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'avatar': avatar
  };
}