import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class TestPreparationData {
  int? id;
  String? key;
  String? name;

  TestPreparationData({this.id, this.key, this.name});
  factory TestPreparationData.fromJson(Map<String, dynamic> json) =>
      TestPreparationData(
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