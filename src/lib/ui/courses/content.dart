import 'package:flutter/material.dart';
import 'package:src/ui/courses/list_books.dart';
import 'package:src/ui/courses/list_courses.dart';

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  int isActived = 1;
  @override
  Widget build(BuildContext context) {
    // List<CourseModel> courses = context.watch<List<CourseModel>>();
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Container(
            height: 40,
            decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 0.5, color: Colors.grey))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: isActived == 1
                        ? const Border(
                            bottom: BorderSide(
                              color: Colors.blue,
                              width: 1,
                            ),
                          )
                        : null,
                  ),
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          isActived = 1;
                        });
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                        "Course",
                        style: TextStyle(
                            color: isActived == 1 ? Colors.blue : Colors.grey),
                      )),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    border: isActived == 2
                        ? const Border(
                            bottom: BorderSide(
                              color: Colors.blue,
                              width: 1,
                            ),
                          )
                        : null,
                  ),
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          isActived = 2;
                        });
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                        "E-Book",
                        style: TextStyle(
                            color: isActived == 2 ? Colors.blue : Colors.grey),
                      )),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    border: isActived == 3
                        ? const Border(
                            bottom: BorderSide(
                              color: Colors.blue,
                              width: 1,
                            ),
                          )
                        : null,
                  ),
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          isActived = 3;
                        });
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                        "Interactive E-book",
                        style: TextStyle(
                            color: isActived == 3 ? Colors.blue : Colors.grey),
                      )),
                )
              ],
            ),
          ),
          Visibility(visible: isActived == 2, child: const ListBook()),
          Visibility(visible: isActived == 1, child: const ListCourse())
        ],
      ),
    );
  }
}
