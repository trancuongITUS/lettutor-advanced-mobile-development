import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CourseTopicData {
  String? id;
  String? courseId;
  int? orderCourse;
  String? name;
  String? nameFile;
  String? description;
  String? videoUrl;
  String? createdAt;
  String? updatedAt;

  CourseTopicData({
    this.id,
    this.courseId,
    this.orderCourse,
    this.name,
    this.nameFile,
    this.description,
    this.videoUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory CourseTopicData.fromJson(Map<String, dynamic> json) =>
    CourseTopicData(
      id: json['id'] as String?,
      courseId: json['courseId'] as String?,
      orderCourse: json['orderCourse'] as int?,
      name: json['name'] as String?,
      nameFile: json['nameFile'] as String?,
      description: json['description'] as String?,
      videoUrl: json['videoUrl'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id':id,
    'courseId': courseId,
    'orderCourse': orderCourse,
    'name': name,
    'nameFile': nameFile,
    'description': description,
    'videoUrl': videoUrl,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}