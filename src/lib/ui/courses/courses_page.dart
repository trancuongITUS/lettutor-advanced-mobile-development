import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:src/main.dart';
import 'package:src/ui/courses/filter.dart';
import 'package:src/ui/home/home_page.dart';
import 'package:src/ui/history/history_page.dart';

import '../schedule/schedule_page.dart';
import 'content.dart';

class Courses extends StatelessWidget {
  final SignInCallback signInCallback;
  const Courses(this.signInCallback, {super.key});

  @override
  Widget build(BuildContext context) {
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
                    MaterialPageRoute(builder: (context) => HomePage(signInCallback)),
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
                    MaterialPageRoute(builder: (context) => Courses(signInCallback)),
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
                    MaterialPageRoute(builder: (context) => Schedule(signInCallback)),
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
                    MaterialPageRoute(builder: (context) => History(signInCallback)),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.blue.shade700,
                  size: 30,
                ),
                title: const Text('Logout',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
                onTap: () {},
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
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(30),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchCourse(),
              SizedBox(
                height: 15,
              ),
              Text(
                  "LiveTutor has built the most quality, methodical and scientific courses in the fields of life for those who are in need of improving their knowledge of the fields."),
              Filter(),
              Content()
            ],
          ),
        )));
  }
}

class SearchCourse extends StatefulWidget {
  const SearchCourse({super.key});

  @override
  State<SearchCourse> createState() => _SearchCourseState();
}

class _SearchCourseState extends State<SearchCourse> {
  final TextEditingController _textEditingDate = TextEditingController();
  bool isEmpty = true;

  void checkTextEmpty(String value) {
    setState(() {
      isEmpty = value.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'img/ScreenCourse.svg',
          width: 100,
          height: 100,
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Discover Courses",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 5,
                      child: Container(
                        height: 35,
                        padding: const EdgeInsets.only(left: 10, right: 0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          color: Colors.white,
                        ),
                        child: TextField(
                          controller: _textEditingDate,
                          onChanged: (value) => {checkTextEmpty(value)},
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(top: -4, left: 0),
                              border: InputBorder.none,
                              hintText: "Course",
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400),
                              suffixIcon: Visibility(
                                visible: !isEmpty,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.highlight_remove_outlined,
                                    color: Colors.black54,
                                    size: 16,
                                  ),
                                  onPressed: () {
                                    _textEditingDate.text = "";
                                  },
                                ),
                              )),
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          color: Colors.white,
                        ),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.search_rounded,
                              size: 25,
                              color: Colors.grey,
                            )),
                      ))
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
