import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:src/models/data/schedules/schedule_data.dart';
import 'package:src/models/data/tutors/tutor_data.dart';
import 'package:src/models/schedule.dart';
import 'package:src/provider/authentication_provider.dart';
import 'package:src/services/booking_api.dart';
import 'package:src/services/schedule_api.dart';
import 'package:src/ui/booking/booking_confirm_dialog.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Booking extends StatefulWidget {
  const Booking({required this.tutor, super.key});
  final TutorData tutor;
  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  List<ScheduleData> schedulesByDate = [];
  late int startTime;
  late int endTime;

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    ScheduleAPI scheduleAPI = ScheduleAPI();
    final authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    int startTime = DateTime.now().millisecondsSinceEpoch;
    int endTime = startTime + const Duration(days: 4).inMilliseconds;

    await scheduleAPI.getScheduleById(
      accessToken: authenticationProvider.token?.access?.token ?? "",
      tutorId: widget.tutor.userId!,
      startTime: startTime,
      endTime: endTime,
      onSuccess: (response) {
        setState(() {
          schedulesByDate = response;
        });
      },
      onFail: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error when get schedule: $message'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      }
    );
  }

  Future<List<ScheduleModel>> loadScheduleOfTutor() async {
    String jsonString = await rootBundle.loadString('assets/data/dataSchedule.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);

    List<Map<String, dynamic>> schedules = [];
    if (jsonData['data'] != null && jsonData['data'] is List) {
      schedules = List<Map<String, dynamic>>.from(jsonData["data"]);
    }

    return schedules.map((schedule) => ScheduleModel.fromJson(schedule)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    ScheduleAPI scheduleAPI = ScheduleAPI();
    BookingAPI bookingAPI = BookingAPI();

    List<TimeRegion> getTimeRegions(String? idUser) {
      return schedulesByDate.map((schedule) {
        DateTime date = DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp!);
        return TimeRegion(
          startTime: date,
          endTime: date.add(const Duration(minutes: 30)),
          enablePointerInteraction: true,
        );
      }).toList();
    }

    return SizedBox(
      height: 2520,
      child: SfCalendar(
        view: CalendarView.week,
        firstDayOfWeek: 1,
        showNavigationArrow: true,
        showCurrentTimeIndicator: false,
        timeSlotViewSettings: const TimeSlotViewSettings(
          timeInterval: Duration(minutes: 30),
          timeFormat: 'HH:mm',
          timeIntervalHeight: 50,
          dateFormat: 'd',
          dayFormat: 'EEE',
          startHour: 0,
          endHour: 24,
          numberOfDaysInView: 5,
        ),
        onViewChanged: (ViewChangedDetails details) async {
          startTime = details.visibleDates[0].millisecondsSinceEpoch;
          endTime = details.visibleDates[details.visibleDates.length - 1]
              .millisecondsSinceEpoch;
          await scheduleAPI.getScheduleById(
              tutorId: widget.tutor.userId!,
              startTime: startTime,
              endTime: endTime,
              accessToken: authenticationProvider.token?.access?.token ?? "",
              onSuccess: (schedules) {
                setState(() {
                  schedulesByDate = schedules;
                });
              },
              onFail: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error when get schedule: $message'),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.red,
                  ),
                );
              });
        },
          specialRegions: getTimeRegions(authenticationProvider.currentUser?.id!),
        timeRegionBuilder:
            (BuildContext context, TimeRegionDetails details) {
          if (details.region.text == 'Book') {
            return Container(
              alignment: Alignment.center,
              child: TextButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(18, 18)),
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 8, vertical: 3)),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {},
                  child: const Text('Book', style: TextStyle(color: Colors.white),
                  )),
            );
          } else {
            return Container(
              alignment: Alignment.center,
              child: const Text('Booked', style: TextStyle(color: Colors.green),
              ),
            );
          }
        },
        onTap: (CalendarTapDetails details) async {
          if (details.targetElement == CalendarElement.calendarCell) {
            DateTime tappedTime = details.date!;
            List<TimeRegion> timeRegions =
            getTimeRegions(authenticationProvider.currentUser?.id!);
            for (int i = 0; i < timeRegions.length; i++) {
              if (tappedTime.isAtSameMomentAs(timeRegions[i].startTime)
                  && tappedTime.isBefore(timeRegions[i].endTime)
                  && !schedulesByDate[i].isBooked!) {
                DateTime timeStart = DateTime.fromMillisecondsSinceEpoch(schedulesByDate[i].startTimestamp!);
                DateTime timeEnd = DateTime.fromMillisecondsSinceEpoch(schedulesByDate[i].endTimestamp!);

                String start = "${timeStart.hour.toString().length == 1 ? "0${timeStart.hour}" : timeStart.hour.toString()}:${timeStart.minute.toString().length == 1 ? "0${timeStart.minute}" : timeStart.minute.toString()}";
                String end = "${timeEnd.hour.toString().length == 1 ? "0${timeEnd.hour}" : timeEnd.hour.toString()}:${timeEnd.minute.toString().length == 1 ? "0${timeEnd.minute}" : timeEnd.minute.toString()}";
                String date = DateFormat.yMMMMEEEEd().format(DateTime.fromMillisecondsSinceEpoch(schedulesByDate[i].startTimestamp!));
                
                final dialogResult = await showDialog(
                  context: context,
                  builder: (context) => BookingConfirmDialog(
                      start: start, end: end, date: date),
                );

                if (dialogResult[0]) {
                  try {
                    List<String> list = [];
                    list.add(schedulesByDate[i].scheduleDetails!.first.id!);
                    await bookingAPI.bookClass(
                      scheduleDetailIds: list,
                      notes: dialogResult[1],
                      accessToken:authenticationProvider.token?.access?.token ?? "",
                      onSuccess: (message) async {
                        await scheduleAPI.getScheduleById(
                            tutorId: widget.tutor.userId!,
                            startTime: startTime,
                            endTime:  endTime,
                            accessToken: authenticationProvider.token?.access?.token ?? " ",
                            onSuccess: (schedules) {
                              setState(() {
                                schedulesByDate = schedules;
                              });
                            }, onFail: (message) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                  Text('Error: $message'),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red,
                                ),
                              );
                            });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.green,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                    },onFail: (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(error),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  } finally {}
                }
              }
            }
          }
        },
      ),
    );
  }
}