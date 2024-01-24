import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pagination_flutter/pagination.dart';
import 'package:provider/provider.dart';
import 'package:src/common/loading.dart';
import 'package:src/models/data/schedules/booking_info_data.dart';
import 'package:src/provider/authentication_provider.dart';
import 'package:src/services/booking_api.dart';
import 'package:src/ui/home/home_page.dart';
import 'package:src/ui/session_widget/session.dart';

import '../courses/courses_page.dart';
import '../schedule/schedule_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistorypageState();
}

class _HistorypageState extends State<HistoryPage> {
  List<BookingInfoData> historyLessons = [];
  bool hasCalledAPI = false;
  bool isLoading = true;
  int _numPages = 1;
  int _currentPage = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AuthenticationProvider authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);

    if (!hasCalledAPI) {
      callAPIGetHistoryLessons(1, BookingAPI(), authenticationProvider);
    }
  }

  Future<void> refreshSchedule() async {
    setState(() {
      historyLessons = [];
      isLoading = true;
    });
    await Future.wait([
      callAPIGetHistoryLessons(1, BookingAPI(), Provider.of<AuthenticationProvider>(context, listen: false)),
    ]).whenComplete(() {
      setState(() {
        isLoading = false;
      });
      return Future<void>.delayed(const Duration(seconds: 0));
    });
  }

  Future<void> callAPIGetHistoryLessons(int page, BookingAPI bookingAPI, AuthenticationProvider authenticationProvider) async {
    await bookingAPI.getHistoryLesson(
        accessToken: authenticationProvider.token?.access?.token ?? "",
        page: page,
        perPage: 10,
        now: DateTime.now().millisecondsSinceEpoch.toString(),
        onSuccess: (response, total) async {
          historyLessons = [];
          for (var value in response) {
            if (value.isDeleted != true) {
              historyLessons.add(value);
            }
          }
          setState(() {
            _numPages = total;
            isLoading = false;
            hasCalledAPI = true;
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
    AuthenticationProvider authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);
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
                title: const Text('Logout',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
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
            await refreshSchedule();
          },
          child: isLoading ? const Loading() : SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(25),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SvgPicture.asset(
                      'img/history.svg',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "History",
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
                              "The following is a list of lessons you have attended",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                                "You can review the details of the lessons you have attended",
                                style: TextStyle(fontSize: 16)),
                          ]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: historyLessons.length,
                      itemBuilder: (context, index) {
                        return Session(schedule: historyLessons[index], typeSession: "History");
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: _numPages > 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: Pagination(
                          numOfPages: _numPages,
                          selectedPage: _currentPage,
                          pagesVisible: 3,
                          onPageChanged: (pageIndex) {
                            setState(() {
                              _currentPage = pageIndex;
                              isLoading = true;
                            });
                            callAPIGetHistoryLessons(pageIndex, BookingAPI(), authenticationProvider);
                          },
                          nextIcon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blue,
                            size: 14,
                          ),
                          previousIcon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.blue,
                            size: 14,
                          ),
                          activeTextStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                          activeBtnStyle: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                          inactiveBtnStyle: ButtonStyle(
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            )),
                          ),
                          inactiveTextStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ),
                    )
                  ]),
            ),
          )
        )
      );
  }
}
