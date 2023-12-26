import 'package:json_annotation/json_annotation.dart';
import 'package:src/models/data/tutors/tutor_transfered_data.dart';

@JsonSerializable()
class TutorFavoriteData {
  String? id;
  String? firstId;
  String? secondId;
  String? createdAt;
  String? updatedAt;
  TutorTransferedData? secondInfo;

  TutorFavoriteData({
    this.id,
    this.firstId,
    this.secondId,
    this.createdAt,
    this.updatedAt,
    this.secondInfo,
  });

  factory TutorFavoriteData.fromJson(Map<String, dynamic> json) => TutorFavoriteData(
        id: json['id'] as String?,
        firstId: json['firstId'] as String?,
        secondId: json['secondId'] as String?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        secondInfo: json['secondInfo'] == null
            ? null
            : TutorTransferedData.fromJson(
                json['secondInfo'] as Map<String, dynamic>),
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'firstId': firstId,
        'secondId': secondId,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'secondInfo': secondInfo,
      };
}