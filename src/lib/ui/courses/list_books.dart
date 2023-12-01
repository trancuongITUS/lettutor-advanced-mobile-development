import 'package:flutter/cupertino.dart';
import 'package:src/ui/courses/course.dart';

class ListBook extends StatefulWidget {
  const ListBook({super.key});

  @override
  State<ListBook> createState() => _ListBookState();
}

class _ListBookState extends State<ListBook> {
  List<String> listTypeCourses = [
    "English For Traveling",
    "English For Beginners",
    "Business English",
    "English For Kid"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: const [
            Course(
              type: "Book",
              image: "img/book.png",
              title: "What a world 1",
              description:
                  "For teenagers who have an excellent vocabulary background and brilliant communication skills.",
              level: "Beginner",
              numberLesson: "",
            ),
            Course(
              type: "Book",
              image: "img/book.png",
              title: "What a world 1",
              description:
                  "For teenagers who have an excellent vocabulary background and brilliant communication skills.",
              level: "Beginner",
              numberLesson: "",
            ),
            Course(
              type: "Book",
              image: "img/book.png",
              title: "What a world 1",
              description:
                  "For teenagers who have an excellent vocabulary background and brilliant communication skills.",
              level: "Beginner",
              numberLesson: "",
            ),
          ]),
    );
  }
}
