import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LessonStatusData {
  final int? id;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LessonStatusData({
    this.id,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory LessonStatusData.fromJson(Map<String, dynamic> json) =>
    LessonStatusData(
      id: json['id'] as int?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );
  Map<String, dynamic> toJson() =><String, dynamic>{
    'id': id,
    'status': status,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
}