import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:src/ui/history/history_page.dart';
import 'package:src/ui/session_widget/session.dart';

import '../courses/courses_page.dart';
import '../home/home.dart';

class Schedule extends StatelessWidget {
  const Schedule({super.key});

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
            padding: const EdgeInsets.all(25),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: Colors.blueAccent,
                    size: 130,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Schedule",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    decoration: const BoxDecoration(
                        border: Border(
                      left: BorderSide(
                        color: Colors.grey,
                        width: 2.5,
                      ),
                    )),
                    padding: const EdgeInsets.only(left: 10),
                    child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Here is a list of the sessions you have booked",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                              "You can track when the meeting starts, join the meeting with one click or can cancel the meeting before 2 hours",
                              style: TextStyle(fontSize: 16)),
                        ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: const [
                      Session(
                          typeSession: "Schedule", timeOrNumber: '1 lesson'),
                      Session(
                        typeSession: "Schedule",
                        timeOrNumber: "1 lesson",
                      ),
                    ],
                  ),
                ]),
          ),
        ));
  }
}
