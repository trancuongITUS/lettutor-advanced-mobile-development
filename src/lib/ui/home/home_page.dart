import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:src/main.dart';
import 'package:src/models/tutor.dart';

import 'package:src/ui/courses/courses_page.dart';
import 'package:src/ui/home/list_tutors.dart';
import 'package:src/ui/home/search_tutor.dart';
import 'package:src/ui/history/history_page.dart';
import 'package:src/ui/schedule/schedule_page.dart';
import 'package:src/ui/video_call/video_call_page.dart';

typedef FilterCallback = void Function(String filter);
typedef FilterNationCallback = void Function(List<String> name);

class HomePage extends StatefulWidget {
  final SignInCallback signInCallback;
  const HomePage(this.signInCallback, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<TutorModel> tutorsResult = [];
  List<TutorModel> tutors = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      filterCallback("All");
    });
  }

  void filterCallback(String filter) {
    if (filter == "All") {
      setState(() {
        tutorsResult = tutors;
      });
    } else {
      setState(() {
        tutorsResult = tutors
            .where((tutor) => tutor.specialities.contains(filter))
            .toList();
      });
    }
  }

  void filterByNationCallback(List<String> nation) {
    List<TutorModel> temp=[];
    if(nation.isNotEmpty) {
      for (var element in nation) {
        if ("Foreign Tutor" == element) {
          temp = temp + tutors
            .where((tutor) => !tutor.country.contains("US") && !tutor.country.contains("England") && !tutor.country.contains("Vietnam"))
            .toList();
        } else if ("Vietnamese Tutor" == element) {
          temp = temp + tutors
            .where((tutor) => tutor.country.contains("Vietnam"))
            .toList();
        } else if (element=="Native English Tutor") {
          temp = temp + tutors
            .where((tutor) => tutor.country.contains("US") || tutor.country.contains("England"))
            .toList();
        }
      }
      setState(() {
        tutorsResult = temp;
      });
    }
  }

  void filterByNameCallback(String name) {
      setState(() {
        tutorsResult = tutors
          .where((tutor) => tutor.name.toLowerCase().contains(name.toLowerCase()))
          .toList();
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    tutors = context.watch<List<TutorModel>>();
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
                  MaterialPageRoute(builder: (context) => HomePage(widget.signInCallback)),
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
                  MaterialPageRoute(builder: (context) => Courses(widget.signInCallback)),
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
                  MaterialPageRoute(builder: (context) => Schedule(widget.signInCallback)),
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
                  MaterialPageRoute(builder: (context) => History(widget.signInCallback)),
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
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
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
          child: Column(children: [
        const UpcomingLesson(),
        SearchTutor(filterCallback, filterByNameCallback, filterByNationCallback),
        const Divider(
          color: Colors.grey,
          height: 10,
          thickness: 0.5,
          indent: 20,
          endIndent: 10,
        ),
        ListTutors(tutorsResult),
      ])),
    );
  }
}

class UpcomingLesson extends StatelessWidget {
  const UpcomingLesson({super.key});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color.fromARGB(255, 12, 61, 223);

    return Container(
      width: double.infinity,
      color: backgroundColor,
      padding: const EdgeInsets.only(top: 40, bottom: 30),
      child: Column(
        children: [
          const Text(
            "Upcoming lesson",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      "Thu, 26 Oct 23",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Text(
                      "03:30 - 03:55",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Text(
                      "(start in 100:02:43)",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.yellow),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VideoCall()),
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.slow_motion_video,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Enter lesson room",
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 14),
                        )
                      ],
                    )),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Total lesson time is 507 hours 55 minutes",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
