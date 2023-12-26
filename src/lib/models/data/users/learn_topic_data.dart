import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LearnTopicData {
  int? id;
  String? key;
  String? name;

  LearnTopicData({this.id, this.key, this.name});

  factory LearnTopicData.fromJson(Map<String, dynamic> json) =>
      LearnTopicData(
        id: json['id'] as int?,
        key: json['key'] as String?,
        name: json['name'] as String?,
      );
      
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'key': key,
    'name': name,
  };
}