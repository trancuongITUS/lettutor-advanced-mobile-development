import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:src/models/data/courses/course_data.dart';
import 'package:src/ui/courses/course.dart';
import 'package:src/ui/detail_courses/overview.dart';

class DetailCourse extends StatefulWidget {
  final CourseData course;
  const DetailCourse({super.key, required this.course});

  @override
  State<DetailCourse> createState() => _DetailCourseState();
}

class _DetailCourseState extends State<DetailCourse> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.blueAccent, boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 0),
              )
            ]),
            child: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.black,
                statusBarIconBrightness: Brightness.light,
              ),
              title: const Text("Course Details",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  )),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                  color: Colors.blueAccent,
                ),
              ),
              centerTitle: true,
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 20, top: 10),
                child: Column(
                  children: [
                    Course(
                      type: "DetailCourse",
                      course: widget.course,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Overview(course: widget.course)
                  ],
                ))));
  }
}
