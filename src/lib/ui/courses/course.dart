import 'package:flutter/material.dart';
import 'package:src/ui/detail_courses/detail_courses.dart';
import 'package:src/ui/detail_lesson/detail_lesson.dart';

class Course extends StatefulWidget {
  final String type;
  final String image;
  final String title;
  final String description;
  final String level;
  final String numberLesson;

  const Course(
      {super.key,
      required this.type,
      required this.image,
      required this.title,
      required this.description,
      required this.level,
      required this.numberLesson});

  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.type == "Course") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DetailCourse()),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 3),
              blurRadius: 1,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 190,
              width: double.infinity,
              child: FittedBox(
                  fit: BoxFit.fill,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(widget.image))),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 20, top: 20, right: 20, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.description,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  widget.type == "DetailCourse"
                      ? Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.blueAccent.shade700,
                          ),
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DetailLesson()),
                                );
                              },
                              child: const Text(
                                "Discover",
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      : Row(
                          children: [
                            Text(widget.level),
                            Visibility(
                                visible: widget.type == "Course",
                                child:
                                    Text(" - ${widget.numberLesson} Lessons"))
                          ],
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
