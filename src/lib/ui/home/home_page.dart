import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:src/models/data/tutors/tutor_data.dart';
import 'package:src/models/schedule.dart';
import 'package:src/provider/authentication_provider.dart';
import 'package:src/repository/schedule_student_repository.dart';
import 'package:src/responses/get_list_tutors_response.dart';
import 'package:src/services/tutor_api.dart';

import 'package:src/ui/courses/courses_page.dart';
import 'package:src/ui/home/list_tutors.dart';
import 'package:src/ui/home/search_tutor.dart';
import 'package:src/ui/history/history_page.dart';
import 'package:src/ui/schedule/schedule_page.dart';
import 'package:src/ui/video_call/video_call_page.dart';

typedef FilterCallback = void Function(String filter, String nameTutor, List<String> nations);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  List<TutorData> _tutors = [];
  List<String> _favoriteTutorIds = [];
  bool isLoading = true;
  bool hasCalledAPI = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    var authenticationProvider = Provider.of<AuthenticationProvider>(context);

    if (hasCalledAPI) {
      await Future.wait([callAPIGetTutorList(1, TutorAPI(), authenticationProvider)]).whenComplete(() => {
        if (mounted) {
          setState(() {
            hasCalledAPI = true;
            isLoading = false;
          })
        }
      });
    }
  }

  Future<void> callAPIGetTutorList(int pageIndex, TutorAPI tutorAPI, AuthenticationProvider authenticationProvider) async {
    await tutorAPI.getListTutor(
      accessToken: authenticationProvider.token?.access?.token ?? "",
      perPage: 10,
      page: pageIndex,
      onSuccess: (response) async {
        handleTutorsFromAPI(response);
      },
      onFail: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${error.toString()}')),
        );
      }
    );
  }

  void handleTutorsFromAPI(GetListTutorsResponse response) {
    response.favoriteTutor?.forEach((element) {
      if (element.secondId != null) {
        _favoriteTutorIds.add(element.secondId!);
      }
    });

    List<TutorData> noneFavoriteTutors = [];
    List<TutorData> favoriteTutors = [];
    response.tutors?.rows?.forEach((element) {
      if (isFavoriteTutor(element)) {
        favoriteTutors.add(element);
      } else {
        noneFavoriteTutors.add(element);
      }
    });

    favoriteTutors.sort((b, a) => (a.rating ?? 0).compareTo((b.rating ?? 0)));
    noneFavoriteTutors.sort((b, a) => (a.rating ?? 0).compareTo((b.rating ?? 0)));

    _tutors.addAll(favoriteTutors);
    _tutors.addAll(noneFavoriteTutors);
  }

  bool isFavoriteTutor(TutorData tutorData) {
    for (var element in _favoriteTutorIds) {
      if (element == tutorData.userId) {
        return true;
      }
    }

    return false;
  }

  void filterCallback(String filter, String nameTutor, List<String> nations) {
    
  }

  Future<void> refreshHomePage(AuthenticationProvider authenticationProvider) async {
    setState(() {
      _tutors = [];
      _favoriteTutorIds = [];
      isLoading = true;
    });

    await Future.wait([callAPIGetTutorList(1, TutorAPI(), authenticationProvider)]).whenComplete(() {
      setState(() {
        isLoading = false;
      });

      return Future<void>.delayed(const Duration(seconds: 0));
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var authenticationProvider = Provider.of<AuthenticationProvider>(context);
    
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
          refreshHomePage(authenticationProvider);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchTutor(filterCallback),
              const Divider(
                color: Colors.grey,
                height: 10,
                thickness: 0.5,
                indent: 20,
                endIndent: 10,
              ),
              ListTutors(_tutors, _favoriteTutorIds),
            ],
          ),
        ),
      ),
    );
  }
}

class UpcomingLesson extends StatefulWidget {
  final ScheduleStudentRepository scheduleStudentRepository;
  const UpcomingLesson({required this.scheduleStudentRepository, super.key});

  @override
  State<UpcomingLesson> createState() => _UpcomingLessonState();
}

class _UpcomingLessonState extends State<UpcomingLesson> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  int? timestamp;
  int? endstamp;
  late DateTime targetTime;
  late Timer countdownTimer;
  late Duration remainingTime = Duration.zero;

  ScheduleModel? upcomingLesson;

  bool compareTime(int time1, int time2) {
    DateTime dateTime1 = DateTime.fromMillisecondsSinceEpoch(time1);
    DateTime dateTime2 = DateTime.fromMillisecondsSinceEpoch(time2);

    DateTime now = DateTime.now();

    Duration difference1 = dateTime1.difference(now).abs();
    Duration difference2 = dateTime2.difference(now).abs();

    if (difference1 < difference2) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.scheduleStudentRepository.scheduleStudent.isNotEmpty) {
      upcomingLesson = widget.scheduleStudentRepository.scheduleStudent.reduce(
        (current, schedule) =>
          compareTime(schedule.startTimestamp, current.startTimestamp)
            ? schedule
            : current);
      timestamp = upcomingLesson?.startTimestamp;
      endstamp = upcomingLesson?.endTimestamp;
      targetTime = DateTime.fromMillisecondsSinceEpoch(timestamp!);

      DateTime now = DateTime.now();
      remainingTime =
          targetTime.isAfter(now) ? targetTime.difference(now) : Duration.zero;
      
      countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        updateRemainingTime();
        if (remainingTime <= Duration.zero) {
          timer.cancel();
        }
      });
    }
  }

  void updateRemainingTime() {
    DateTime now = DateTime.now();
    setState(() {
      remainingTime =
          targetTime.isAfter(now) ? targetTime.difference(now) : Duration.zero;
    });
  }

  void startCountdown() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        updateRemainingTime();
      });

      if (remainingTime <= Duration.zero) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    countdownTimer.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Color backgroundColor = const Color.fromARGB(255, 12, 61, 223);
    int hours = 0;
    int minutes = 0;
    int seconds = 0;

    if (widget.scheduleStudentRepository.scheduleStudent.isNotEmpty) {
      hours = remainingTime.inHours;
      minutes = (remainingTime.inMinutes % 60);
      seconds = (remainingTime.inSeconds % 60);
    }

    String convertTimeToString(int time1, int time2) {
      DateTime timeStart = DateTime.fromMillisecondsSinceEpoch(time1);
      DateTime timeEnd = DateTime.fromMillisecondsSinceEpoch(time2);

      String start = "${timeStart.hour.toString().length == 1 ? "0${timeStart.hour}" : timeStart.hour.toString()} : ${timeStart.minute.toString().length == 1 ? "0${timeStart.minute}" : timeStart.minute.toString()}";
      String end = "${timeEnd.hour.toString().length == 1 ? "0${timeEnd.hour}" : timeEnd.hour.toString()}:${timeEnd.minute.toString().length == 1 ? "0${timeEnd.minute}" : timeEnd.minute.toString()}";

      return "$start - $end";
    }

    return Container(
      width: double.infinity,
      color: backgroundColor,
      padding: const EdgeInsets.only(top: 40, bottom: 30),
      child: Column(
        children: [
          Text(
            widget.scheduleStudentRepository.scheduleStudent.isEmpty
                ? "You have no upcoming lesson."
                : "Upcoming lesson",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, color: Colors.white),
          ),
          SizedBox(
            height: widget.scheduleStudentRepository.scheduleStudent.isEmpty ? 20 : 0,
          ),
          Visibility(
            visible: widget.scheduleStudentRepository.scheduleStudent.isNotEmpty,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(
                        DateFormat('EEEE, MMMM d').format(DateTime.fromMillisecondsSinceEpoch(timestamp != null ? timestamp! : 0)),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        convertTimeToString(timestamp != null ? timestamp! : 0, endstamp != null ? endstamp! : 0),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        "Start in ($hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')})",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14, color: Colors.yellow),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const VideoCall())
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.slow_motion_video,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(width: 5,),
                        Text(
                          "Enter lesson room",
                          style: TextStyle(
                            color: Colors.blueAccent, fontSize: 14
                          )
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Total lesson time is 12 hours 12 minutes",
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
