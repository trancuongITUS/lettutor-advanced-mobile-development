import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:src/ui/courses/courses_page.dart';
import 'package:src/ui/home/list_tutors.dart';
import 'package:src/ui/home/search_tutor.dart';
import 'package:src/ui/history/history_page.dart';
import 'package:src/ui/schedule/schedule_page.dart';
import 'package:src/ui/video_call/video_call_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
                  MaterialPageRoute(builder: (context) => const Home()),
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
                  MaterialPageRoute(builder: (context) => const Courses()),
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
                  MaterialPageRoute(builder: (context) => const Schedule()),
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
                  MaterialPageRoute(builder: (context) => const History()),
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
      body: const SingleChildScrollView(
          child: Column(children: [
        UpcomingLesson(),
        SearchTutor(),
        Divider(
          color: Colors.grey,
          height: 10,
          thickness: 0.5,
          indent: 20,
          endIndent: 10,
        ),
        ListTutors(),
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
