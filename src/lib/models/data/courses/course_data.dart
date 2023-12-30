import 'package:json_annotation/json_annotation.dart';
import 'package:src/models/data/courses/course_category_data.dart';
import 'package:src/models/data/courses/course_topic_data.dart';

@JsonSerializable()
class CourseData {
  String? id;
  String? name;
  String? description;
  String? imageUrl;
  String? level;
  String? reason;
  String? purpose;
  String? otherDetails;
  int? defaultPrice;
  int? coursePrice;
  bool? visible;
  String? createdAt;
  String? updatedAt;
  List<CourseTopicData>? topics;
  List<CourseCategoryData>? categories;

  CourseData({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.level,
    this.reason,
    this.purpose,
    this.otherDetails,
    this.defaultPrice,
    this.coursePrice,
    this.visible,
    this.createdAt,
    this.updatedAt,
    this.topics,
    this.categories,
  });

  factory CourseData.fromJson(Map<String, dynamic> json) =>
    CourseData(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      level: json['level'] as String?,
      reason: json['reason'] as String?,
      purpose: json['purpose'] as String?,
      otherDetails: json['otherDetails'] as String?,
      defaultPrice: json['defaultPrice'] as int?,
      coursePrice: json['coursePrice'] as int?,
      visible: json['visible'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      topics: (json['topics'] as List<dynamic>?)
          ?.map((e) => CourseTopicData.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => CourseCategoryData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    'description': description,
    'imageUrl': imageUrl,
    'level': level,
    'reason': reason,
    'purpose': purpose,
    'otherDetails': otherDetails,
    'defaultPrice': defaultPrice,
    'coursePrice': coursePrice,
    'visible': visible,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'topics': topics,
    'categories': categories,
  };
}