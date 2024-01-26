import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:src/common/loading.dart';
import 'package:src/models/data/courses/course_data.dart';
import 'package:src/provider/authentication_provider.dart';
import 'package:src/services/course_api.dart';
import 'package:src/ui/courses/content.dart';
import 'package:src/ui/courses/filter.dart';
import 'package:src/ui/courses/search_courses.dart';
import 'package:src/ui/home/home_page.dart';
import 'package:src/ui/history/history_page.dart';

import '../schedule/schedule_page.dart';

typedef FilterCourseCallback = void Function(String sort, List<String> levels);
typedef SearchCourseCallback = void Function(String keyword);

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  String keyword = "";
  String sort = "";
  List<String> levels = [];

  List<CourseData> courses = [];
  Map<String, List<CourseData>> groupedCourses = {};
  bool hasCallApi = false;
  bool isLoading = true;

  Future<void> callAPIGetCourses(
      int page,
      CourseAPI courseAPI,
      AuthenticationProvider authenticationProvider,
      String keyword,
      String sort,
      List<String> level) async {
    await courseAPI.getCourseListWithPagination(
      accessToken: authenticationProvider.token?.access?.token ?? "",
      search: keyword,
      sort: sort,
      levels: level,
      page: page,
      size: 100,
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
          groupedCourses = groupedCoursesTemp;
          hasCallApi = true;
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
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    var authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);

    if (!hasCallApi) {
      setState(() {
        isLoading = true;
      });

      await Future.wait([callAPIGetCourses(1, CourseAPI(), authenticationProvider, keyword, sort, levels)]).whenComplete(() {
        if (mounted) {
          setState(() {
            isLoading = false;
            hasCallApi = true;
          });
        }
      });
    }
  }

  Future<void> refreshHome(AuthenticationProvider authenticationProvider) async {
    setState(() {
      courses = [];
      groupedCourses = {};
      isLoading = true;
    });
    await Future.wait([
      callAPIGetCourses(1, CourseAPI(), authenticationProvider, keyword, sort, levels)]).whenComplete(() {
        setState(() {
          isLoading = false;
        });
      return Future<void>.delayed(const Duration(seconds: 0));
    });
  }

  @override
  Widget build(BuildContext context) {
    final authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);

    

    void filterCallback(String sort, List<String> levels) {
      String realSort = "";
      switch (sort) {
        case '':
          realSort = "";
          break;
        case "Level ascending":
          realSort = "ASC";
          break;
        case "Level decreasing":
          realSort = "DESC";
          break;
      }

      setState(() {
        sort = realSort;
        levels = levels;
      });
      callAPIGetCourses(1, CourseAPI(), authenticationProvider, keyword, sort, levels);
    }

    void searchCourseCallback(String keyword) {
      setState(() {
        keyword = keyword;
      });
      callAPIGetCourses(1, CourseAPI(), authenticationProvider, keyword, sort, levels);
    }


    return Scaffold(
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 125,
                child: DrawerHeader(
                  decoration:
                      const BoxDecoration(color: Colors.blue, border: null),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: const Icon(
                              Icons.close_outlined,
                              color: Colors.white,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          const Text(
                            "Menu",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          const Text(
                            "",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.people_alt,
                  color: Colors.blue.shade700,
                  size: 30,
                ),
                title: const Text(
                  'Tutors',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.school,
                  color: Colors.blue.shade700,
                  size: 30,
                ),
                title: const Text(
                  'Courses',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CoursesPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.calendar_month,
                  color: Colors.blue.shade700,
                  size: 30,
                ),
                title: const Text(
                  'Schedule',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SchedulePage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.history,
                  color: Colors.blue.shade700,
                  size: 30,
                ),
                title: const Text(
                  'History',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HistoryPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.blue.shade700,
                  size: 30,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
                onTap: () {
                  var authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);
                  authenticationProvider.clearUserInfo();
                },
              ),
            ],
          ),
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: AppBar(
                automaticallyImplyLeading: false,
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.black,
                  statusBarIconBrightness: Brightness.light,
                ),
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.school,
                          size: 45,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(width: 7),
                        Text(
                          "LetTutor",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            refreshHome(authenticationProvider);
          },
        child: isLoading ? const Loading() : SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchCourse(searchCourseCallback),
              const SizedBox(
                height: 15,
              ),
              const Text(
                  "LiveTutor has built the most quality, methodical and scientific courses in the fields of life for those who are in need of improving their knowledge of the fields."),
              Filter(filterCallback),
              const SizedBox(height: 20),
              Content(courses, groupedCourses),
              const SizedBox(height: 10),
            ],
          ),
        ))
        )
      );
  }
}
