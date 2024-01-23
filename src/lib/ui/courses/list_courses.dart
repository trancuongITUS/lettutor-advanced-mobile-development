import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/common/loading.dart';
import 'package:src/models/course.dart';
import 'package:src/models/data/courses/course_data.dart';
import 'package:src/provider/authentication_provider.dart';
import 'package:src/provider/course_provider.dart';
import 'package:src/services/course_api.dart';
import 'package:src/ui/courses/course.dart';

class ListCourse extends StatefulWidget {
  const ListCourse({super.key});

  @override
  State<ListCourse> createState() => _ListCourseState();
}

class _ListCourseState extends State<ListCourse> {
  List<CourseModel> courses = [];

  bool hasCalledAPI = false;
  bool isLoading = false;

  int currentPage = 1;
  int maxPage = 1;
  int numberOfShowPages = 0;

  List<CourseData> coursesData = [];
  Map<String, List<CourseData>> groupedCoursesData = {};

  Future<void> callAPIGetCourses(int page, CourseAPI courseAPI, CourseProvider courseProvider, AuthenticationProvider authenticationProvider) async {
    await courseAPI.getCourseListWithPagination(
        accessToken: authenticationProvider.token?.access?.token ?? "",
        search: courseProvider.search,
        page: page,
        size: 10,
        onSuccess: (response, total) async {
          Map<String, List<CourseData>> groupedCoursesTemp = {};

          for (CourseData course in response) {
            if (groupedCoursesTemp.containsKey(course.categories![0].title)) {
              groupedCoursesTemp[course.categories![0].title]!.add(course);
            } else {
              groupedCoursesTemp[course.categories![0].title!] = [course];
            }
          }
          setState(() {
            groupedCoursesData = groupedCoursesTemp;
            coursesData = response;
            hasCalledAPI = true;
            currentPage = page;
            isLoading = false;
          });
        },
        onFail: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final authenticationProvider = Provider.of<AuthenticationProvider>(context);
    final courseProvider = Provider.of<CourseProvider>(context);

    if (!hasCalledAPI) {
      callAPIGetCourses(1, CourseAPI(), courseProvider, authenticationProvider);
    }

  return !hasCalledAPI
    ? const Loading()
    : ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: groupedCoursesData.length,
      itemBuilder: (context, index) {
        String type = groupedCoursesData.keys.elementAt(index);
        List<CourseData> coursesByType = groupedCoursesData[type]!;

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
