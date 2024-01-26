import 'package:flutter/material.dart';
import 'package:src/common/loading.dart';
import 'package:src/models/data/courses/course_data.dart';
import 'package:src/ui/courses/course.dart';

class ListCourse extends StatefulWidget {
  const ListCourse(this.courses, this.groupedCourses, {super.key});
  final List<CourseData> courses;
  final Map<String, List<CourseData>> groupedCourses;

  @override
  State<ListCourse> createState() => _ListCourseState();
}

class _ListCourseState extends State<ListCourse> {

  @override
  Widget build(BuildContext context) {
    return widget.courses.isEmpty
      ? const Loading()
      : ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.groupedCourses.length,
        itemBuilder: (context, index) {
          String type = widget.groupedCourses.keys.elementAt(index);
          List<CourseData> coursesByType = widget.groupedCourses[type]!;

          return Container(
            margin: const EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                Column(
                  children: coursesByType.map((course) {
                    return Course(type: "Course", course: course);
                  }).toList(),
                )
              ],
            ),
          );
        },
      );
  }
}
