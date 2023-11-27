import 'package:flutter/material.dart';
import 'package:src/ui/courses/course.dart';

class ListCourse extends StatefulWidget {
  const ListCourse({super.key});

  @override
  State<ListCourse> createState() => _ListCourseState();
}

class _ListCourseState extends State<ListCourse> {
  List<String> listTypeCourses = [
    "English For Traveling",
    "English For Beginners",
    "Business English",
    "English For Kid"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
        children: listTypeCourses.map((valueItem) {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            valueItem,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: const [
                Course(
                  type: "Course",
                  image: "img/course_img.png",
                  title: "Life in the Internet Age",
                  description:
                      "Let's discuss how technology is changing the way we live",
                  level: "Intermediate",
                  numberLesson: "9",
                ),
                Course(
                  type: "Course",
                  image: "img/course_img.png",
                  title: "Life in the Internet Age",
                  description:
                      "Let's discuss how technology is changing the way we live",
                  level: "Intermediate",
                  numberLesson: "9",
                ),
                Course(
                  type: "Course",
                  image: "img/course_img.png",
                  title: "Life in the Internet Age",
                  description:
                      "Let's discuss how technology is changing the way we live",
                  level: "Intermediate",
                  numberLesson: "9",
                ),
              ]),
        ]),
      );
    }).toList());
  }
}
