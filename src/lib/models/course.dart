import 'package:src/models/category.dart';
import 'package:src/models/topic.dart';

class CourseModel {
  String id;
  String name;
  String description;
  String imageUrl;
  String level;
  String reason;
  String purpose;
  String otherDetails;
  int defaultPrice;
  int coursePrice;
  final dynamic courseType;
  final dynamic sectionType;
  final dynamic visible;
  final dynamic displayOrder;
  String createdAt;
  String updatedAt;

  List<TopicModel> topics;
  List<CategoryModel> categories;

  CourseModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.level,
    required this.reason,
    required this.purpose,
    required this.otherDetails,
    required this.defaultPrice,
    required this.coursePrice,
    required this.courseType,
    required this.sectionType,
    required this.visible,
    required this.displayOrder,
    required this.createdAt,
    required this.updatedAt,
    required this.topics,
    required this.categories,
  });

  static String convertLevelToString(String level) {
    Map<String, String> keywordToLabel = {
      '0': 'Any Level',
      '1': 'Beginner',
      '4':'Intermediate',
    };
   
    return keywordToLabel[level] ?? level;
  }

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      level: convertLevelToString(json['level']),
      reason: json['reason'],
      purpose: json['purpose'],
      otherDetails: json['other_details'],
      defaultPrice: json['default_price'],
      coursePrice: json['course_price'],
      courseType: json['courseType'],
      sectionType: json['sectionType'],
      visible: json['visible'],
      displayOrder: json['displayOrder'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      topics: (json['topics'] as List<dynamic>)
          .map((topicJson) => TopicModel.fromJson(topicJson))
          .toList(),
      categories: (json['categories'] as List<dynamic>)
          .map((categoryJson) => CategoryModel.fromJson(categoryJson))
          .toList(),
    );
  }
}