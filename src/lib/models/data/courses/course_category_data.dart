import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CourseCategoryData {
  String? id;
  String? title;
  String? description;
  String? key;
  String? createdAt;
  String? updatedAt;

  CourseCategoryData({
    this.id,
    this.title,
    this.description,
    this.key,
    this.createdAt,
    this.updatedAt,
  });

  factory CourseCategoryData.fromJson(Map<String, dynamic> json) =>
    CourseCategoryData(
      id: json['id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      key: json['key'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'title': title,
    'description': description,
    'key': key,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}