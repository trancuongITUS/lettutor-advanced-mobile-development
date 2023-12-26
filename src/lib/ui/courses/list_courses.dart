import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/models/course.dart';
import 'package:src/ui/courses/course.dart';

class ListCourse extends StatefulWidget {
  const ListCourse({super.key});

  @override
  State<ListCourse> createState() => _ListCourseState();
}

class _ListCourseState extends State<ListCourse> {
  List<CourseModel> courses = [];

  @override
  Widget build(BuildContext context) {
    courses = context.watch<List<CourseModel>>();
    Map<String, List<CourseModel>> groupedCourses = {};

    for (CourseModel course in courses) {
      if (groupedCourses.containsKey(course.categories[0].title)) {
        groupedCourses[course.categories[0].title]!.add(course);
      } else {
        groupedCourses[course.categories[0].title] = [course];
      }
    }

    return Container(
      //child: Column(
        // children: listTypeCourses.map((valueItem) {
        //   return Container(
        //     margin: EdgeInsets.only(top:30),
        //     child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children:[
        //       Text(valueItem,style: TextStyle(
        //         fontSize: 22,
        //         fontWeight: FontWeight.w500
        //       ),),
        //       ListView(
        //         physics: NeverScrollableScrollPhysics(),
        //         shrinkWrap: true,
        //         children:[
        //           Course(type: "Course",image: "images/AvatarCourse.png",title: "Life in the Internet Age",description: "Let's discuss how technology is changing the way we live",level: "Intermediate",numberLesson: "9",),
        //           Course(type: "Course",image: "images/AvatarCourse.png",title: "Life in the Internet Age",description: "Let's discuss how technology is changing the way we live",level: "Intermediate",numberLesson: "9",),
        //           Course(type: "Course",image: "images/AvatarCourse.png",title: "Life in the Internet Age",description: "Let's discuss how technology is changing the way we live",level: "Intermediate",numberLesson: "9",),
        //         ]
        //
        //
        //       ),
        //     ]
        //     ),
        //   );}
        // ).toList()
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: groupedCourses.length,
        itemBuilder: (context, index) {
          String type = groupedCourses.keys.elementAt(index);
          List<CourseModel> typeCourses = groupedCourses[type]!;
          return Container(
            margin: const EdgeInsets.only(top:30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text(type,style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500
                ),),
                Column(
                  children: typeCourses.map((course){
                    return Course(type: "Course",course: course,);
                  }).toList(),
                ),
              ]
            ),
          );
        }
      ),
    );
  }
}
