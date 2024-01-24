import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:pagination_flutter/pagination.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:src/common/loading.dart';
import 'package:src/models/data/schedules/booking_info_data.dart';
import 'package:src/models/data/tutors/tutor_data.dart';
import 'package:src/provider/authentication_provider.dart';
import 'package:src/services/booking_api.dart';
import 'package:src/services/call_api.dart';
import 'package:src/services/tutor_api.dart';

import 'package:src/ui/courses/courses_page.dart';
import 'package:src/ui/history/history_page.dart';
import 'package:src/ui/home/list_tutors.dart';
import 'package:src/ui/home/search_tutor.dart';
import 'package:src/ui/schedule/schedule_page.dart';
import 'package:src/ui/video_call/video_call_page.dart';

typedef FilterCallback = void Function(String filter, String nameTutor, List<String> nations);
typedef ChangeFavoriteCallback = void Function(String tutorId);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  List<TutorData> _tutors = [];
  List<BookingInfoData> _lessons = [];
  List<String> _favoriteTutorIds = [];
  bool isLoading = true;
  bool hasCalledAPI = false;
  int _numPages = 6;
  int _currentPage = 1;

  String totalLessonTime = "";
  BookingInfoData upcomingLesson = BookingInfoData();

  String specialties = "all";
  String nameTutor = "";
  Map<String, dynamic> national = {};

  @override
  bool get wantKeepAlive => true;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    var authenticationProvider = Provider.of<AuthenticationProvider>(context);

    if (hasCalledAPI) {
      await Future.wait([
          searchTutor(1, TutorAPI(), authenticationProvider, specialties == "all" ? "" : specialties, nameTutor, national),
          callAPIGetScheduleList(BookingAPI(), authenticationProvider),
          callAPIGetTotalLessonTimes(CallAPI(), authenticationProvider),
        ]).whenComplete(() => {
        if (mounted) {
          setState(() {
            hasCalledAPI = true;
            isLoading = false;
          })
        }
      });
    }
  }

  Future<void> callAPIGetScheduleList(BookingAPI bookingAPI, AuthenticationProvider authenticationProvider) async {
    await bookingAPI.getUpcomingClass(
      accessToken: authenticationProvider.token?.access?.token ?? "",
      now: DateTime.now().millisecondsSinceEpoch.toString(),
      page: 1,
      perPage: 100000,
      onSuccess: (response, total) async {
        handleSchedulesFromAPI(response);
      },
      onFail: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${error.toString()}')),
        );
      }
    );
  }

  void handleSchedulesFromAPI(List<BookingInfoData> response) {
    for (var value in response) {
      if (value.isDeleted != true) {
        _lessons.insert(0, value);
      }
    }

    if (_lessons.isNotEmpty) {
      upcomingLesson = _lessons.first;
    }
  }

  Future<void> searchTutor(int pageIndex, TutorAPI tutorAPI, AuthenticationProvider authenticationProvider, String filter, String name, Map<String, dynamic> nationality) async {
    await tutorAPI.searchTutor(
      accessToken: authenticationProvider.token?.access?.token ?? "",
      searchKeys: name,
      page: pageIndex,
      speciality: filter != "all" ? [filter] : [],
      nationality: nationality,
      onSuccess: (response, total) async {
        _favoriteTutorIds = [];
        List<TutorData> notFavoreds = [];
        List<TutorData> favoreds = [];
        for (var element in response) {
          if (isFavoriteTutor(element)) {
            favoreds.add(element);
            _favoriteTutorIds.add(element.userId ?? "");
          } else {
            notFavoreds.add(element);
          }
        }

        favoreds.sort((b, a) => (a.rating ?? 0).compareTo((b.rating ?? 0)));
        notFavoreds.sort((b, a) => (a.rating ?? 0).compareTo((b.rating ?? 0)));

        _tutors = [];
        _tutors.addAll(favoreds);
        _tutors.addAll(notFavoreds);
        setState(() {
          isLoading = false;
          _numPages = (total / 10).ceil();
        });
      },
      onFail: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${error.toString()}')),
        );
      }
    );
  }

  Future<void> callAPIGetTotalLessonTimes(CallAPI callAPI, AuthenticationProvider authenticationProvider) async {
    await callAPI.getTotalLessonTime(
      accessToken: authenticationProvider.token?.access?.token ?? "",
      onSuccess: (int total) async {
        if (total > 0) {
          int hours = total ~/ 60;
          int minutes = total % 60;
          if (hours >= 1) {
            String timeString = "$hours hours $minutes minutes";
            totalLessonTime = timeString;
          } else {
            String timeString = "$minutes minutes";
            totalLessonTime = timeString;
          }
        }
      },
      onFail: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${error.toString()}')),
        );
      });
  }

  bool isFavoriteTutor(TutorData tutorData) {
    if (tutorData.isFavoriteTutor != null && tutorData.isFavoriteTutor == true) {
      return true;
    }

    return false;
  }

  Future<void> refreshHomePage(AuthenticationProvider authenticationProvider) async {
    setState(() {
      _tutors = [];
      _favoriteTutorIds = [];
      _lessons = [];
      isLoading = true;
    });

    await Future.wait([
        searchTutor(1, TutorAPI(), authenticationProvider, specialties == "all" ? "" : specialties, nameTutor, national),
        callAPIGetScheduleList(BookingAPI(), authenticationProvider),
        callAPIGetTotalLessonTimes(CallAPI(), authenticationProvider),
      ]).whenComplete(() {
      setState(() {
        isLoading = false;
      });

      return Future<void>.delayed(const Duration(seconds: 0));
    });
  }

  void changeFavoriteCallback(String tutorId) {
    List<String> favorites = _favoriteTutorIds;
    if (favorites.contains(tutorId)) {
      favorites.remove(tutorId);
    } else {
      favorites.add(tutorId);
      favorites = favorites.toSet().toList();
    }
    
    setState(() {
      _favoriteTutorIds = favorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var authenticationProvider = Provider.of<AuthenticationProvider>(context);

    void filterCallback(String filter, String tutorName, List<String> nations) {
      Map<String, dynamic> nationality = {
        "isVietnamese": false,
        "isNative": false,
      };

      if (nations.isEmpty || 3 == nations.length) {
        nationality = {};
      } else {
        for (var nation in nations) {
          switch (nation) {
            case "Vietnamese Tutor":
              nationality["isVietnamese"] = true;
              break;
            case "Native English Tutor":
              nationality["isNative"] = true;
              break;
          }
        }
      }
      nationality.removeWhere((key, value) => true == value);

      setState(() {
        specialties = filter;
        nameTutor = tutorName;
        national = nationality;
      });

      searchTutor(1, TutorAPI(), authenticationProvider, "all" == filter ? "" : filter, nameTutor, nationality);
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
        child: isLoading ? const Loading() : SingleChildScrollView(
          child: Column(
            children: [
              (upcomingLesson != null) ? UpcomingLesson(upcomingLesson: upcomingLesson, totalLessonTime: totalLessonTime) : const SizedBox(),
              SearchTutor(filterCallback),
              const Divider(
                color: Colors.grey,
                height: 10,
                thickness: 0.5,
                indent: 20,
                endIndent: 10,
              ),
              ListTutors(_tutors, _favoriteTutorIds, changeFavoriteCallback),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: Pagination(
                  numOfPages: _numPages,
                  selectedPage: _currentPage,
                  pagesVisible: 4,
                  onPageChanged: (pageIndex) {
                    setState(() {
                      isLoading = true;
                      _currentPage = pageIndex;
                    });
                    searchTutor(pageIndex, TutorAPI(), authenticationProvider, specialties == "all" ? "" : specialties, nameTutor, national);
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
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                  ),
                  inactiveBtnStyle: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                  ),
                  inactiveTextStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpcomingLesson extends StatefulWidget {
  final BookingInfoData upcomingLesson;
  final String totalLessonTime;
  const UpcomingLesson({required this.upcomingLesson, required this.totalLessonTime, super.key});

  @override
  State<UpcomingLesson> createState() => _UpcomingLessonState();
}

class _UpcomingLessonState extends State<UpcomingLesson>{
  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color.fromARGB(255, 12, 61, 223);
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
            widget.upcomingLesson.id == null
                ? "You have no upcoming lesson."
                : "Upcoming lesson",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, color: Colors.white),
          ),
          SizedBox(
            height: widget.upcomingLesson.id != null ? 20 : 0,
          ),
          Visibility(
            visible: widget.upcomingLesson.id != null,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      (widget.upcomingLesson.scheduleDetailInfo != null) ?
                      Text(
                        DateFormat('EEEE, MMMM d').format(DateTime.fromMillisecondsSinceEpoch(widget.upcomingLesson.scheduleDetailInfo!.startPeriodTimestamp!)),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ) : const SizedBox(),
                      Text(
                        convertTimeToString(widget.upcomingLesson.scheduleDetailInfo!.startPeriodTimestamp != null ? widget.upcomingLesson.scheduleDetailInfo!.startPeriodTimestamp! : 0, widget.upcomingLesson.scheduleDetailInfo!.endPeriodTimestamp != null ? widget.upcomingLesson.scheduleDetailInfo!.endPeriodTimestamp! : 0),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      (widget.upcomingLesson.scheduleDetailInfo!=null)?
                      CountdownTimer(
                        endTime: widget.upcomingLesson.scheduleDetailInfo!.startPeriodTimestamp!,
                        textStyle: const TextStyle(color: Colors.yellow),
                      ) : const SizedBox(),
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
          Visibility(
            visible: widget.totalLessonTime != null,
            child: 
              Text(
                widget.totalLessonTime.isEmpty ? "Total lesson time is 0" : "Total lesson time is: ${widget.totalLessonTime}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
          )
        ],
      ),
    );
  }
}
