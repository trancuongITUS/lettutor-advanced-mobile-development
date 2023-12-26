class TopicModel {
  String id;
  String courseId;
  int orderCourse;
  String name;
  String nameFile;
  final dynamic beforeTheClassNotes;
  final dynamic afterTheClassNotes;
  final dynamic numberOfPages;
  final dynamic description;
  final dynamic videoUrl;
  final dynamic type;
  String createdAt;
  String updatedAt;

  TopicModel({
    required this.id,
    required this.courseId,
    required this.orderCourse,
    required this.name,
    required this.nameFile,
    required this.beforeTheClassNotes,
    required this.afterTheClassNotes,
    required this.numberOfPages,
    required this.description,
    required this.videoUrl,
    required this.type,
    required this.createdAt,
    required this.updatedAt
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      id: json['id'],
      courseId: json['courseId'],
      orderCourse: json['orderCourse'],
      name: json['name'],
      nameFile: json['nameFile'],
      beforeTheClassNotes: json['beforeTheClassNotes'],
      afterTheClassNotes: json['afterTheClassNotes'],
      numberOfPages: json['numberOfPages'],
      description: json['description'],
      videoUrl: json['videoUrl'],
      type: json['type'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt']
    );
  }
}