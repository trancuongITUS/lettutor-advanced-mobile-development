import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_pagination/flutter_pagination.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:src/common/loading.dart';
import 'package:src/models/data/schedules/booking_info_data.dart';
import 'package:src/models/data/tutors/tutor_data.dart';
import 'package:src/provider/authentication_provider.dart';
import 'package:src/responses/get_list_tutors_response.dart';
import 'package:src/services/booking_api.dart';
import 'package:src/services/tutor_api.dart';
import 'package:src/styles/style.dart';

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
  int currentPage = 1;
  int maxPage = 1;

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
          callAPIGetTutorList(1, TutorAPI(), authenticationProvider),
          callAPIGetScheduleList(BookingAPI(), authenticationProvider)
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

  void handleSchedulesFromAPI(List<BookingInfoData> response) {
    for (var value in response) {
      if (value.isDeleted != true) {
        _lessons.insert(0, value);
      }
    }

    DateTime totalTime = DateTime.now();
    DateTime nowTime = DateTime.now();
    for (var element in _lessons) {
      DateTime startTime = DateTime.fromMillisecondsSinceEpoch(element.scheduleDetailInfo?.startPeriodTimestamp ?? 0);
      DateTime endTime = DateTime.fromMillisecondsSinceEpoch(element.scheduleDetailInfo?.endPeriodTimestamp ?? 0);

      var learningTime = endTime.difference(startTime);
      totalTime = totalTime.add(learningTime);
    }

    Duration learningDuration = totalTime.difference(nowTime);
    if (_lessons.isNotEmpty) {
      upcomingLesson = _lessons.first;
      totalLessonTime = getStringDuration(learningDuration);
    }
  }

  String getStringDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  int getShowPagesBasedOnPages(int pages) {
    if (pages > 2) {
      return 2;
    } else if (pages == 2) {
      return 1;
    } else if (pages <= 1) {
      return 0;
    } else {
      return 0;
    }
  }

  Future<void> searchTutor(int pageIndex, TutorAPI tutorAPI, AuthenticationProvider authenticationProvider, String filter, String name, Map<String, dynamic> nationality) async {
    await tutorAPI.searchTutor(
      accessToken: authenticationProvider.token?.access?.token ?? "",
      searchKeys: name,
      page: pageIndex,
      speciality: [filter],
      nationality: nationality,
      onSuccess: (response, total) async {
        _tutors = [];
        _tutors.addAll(response);
        setState(() {
          isLoading = false;
          currentPage = pageIndex;
          maxPage = (total / 10).ceil();
        });
      },
      onFail: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${error.toString()}')),
        );
      }
    );
  }

  bool isFavoriteTutor(TutorData tutorData) {
    for (var element in _favoriteTutorIds) {
      if (element == tutorData.userId) {
        return true;
      }
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
        callAPIGetTutorList(1, TutorAPI(), authenticationProvider),
        callAPIGetScheduleList(BookingAPI(), authenticationProvider)
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

      searchTutor(currentPage, TutorAPI(), authenticationProvider, "all" == filter ? "" : filter, nameTutor, nationality);
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
                  paginateButtonStyles: paginationStyle(context),
                  prevButtonStyles: prevButtonStyles(context),
                  nextButtonStyles: nextButtonStyles(context),
                  onPageChange: (pageIndex) {
                    setState(() {
                      isLoading = true;
                      currentPage = pageIndex;
                    });
                    searchTutor(pageIndex, TutorAPI(), authenticationProvider, specialties, nameTutor, national);
                  },
                  useGroup: false,
                  totalPage: maxPage,
                  show: maxPage - 1,
                  currentPage: currentPage,
                ),
              )
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
