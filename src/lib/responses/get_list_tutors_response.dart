import 'package:json_annotation/json_annotation.dart';
import 'package:src/models/data/tutors/tutor_favorite_data.dart';
import 'package:src/models/data/tutors/tutor_pagination.dart';

@JsonSerializable()
class GetListTutorsResponse {
  TutorPaginationData? tutors;
  List<TutorFavoriteData>? favoriteTutor;

  GetListTutorsResponse({
    this.tutors,
    this.favoriteTutor
  });

  factory GetListTutorsResponse.fromJson(Map<String, dynamic> json) =>
      GetListTutorsResponse(
        tutors: json['tutors'] == null
            ? null
            : TutorPaginationData.fromJson(json['tutors'] as Map<String, dynamic>),
        favoriteTutor: (json['favoriteTutor'] as List<dynamic>?)
            ?.map((e) => TutorFavoriteData.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
    'tutors': tutors,
    'favoriteTutor': favoriteTutor,
  };
}