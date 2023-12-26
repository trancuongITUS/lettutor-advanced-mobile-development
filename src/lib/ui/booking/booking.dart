import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:src/models/schedule.dart';
import 'package:src/repository/schedule_student_repository.dart';
import 'package:src/ui/booking/booking_confirm_dialog.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});
  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  late Future<List<ScheduleModel>> _loadScheduleOfTuTorFuture;

  @override
  void initState() {
    super.initState();
    setState(() {
      _loadScheduleOfTuTorFuture = loadScheduleOfTutor();
    });
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
    ScheduleStudentRepository scheduleStudentRepository = context.watch<ScheduleStudentRepository>();
    List<TimeRegion> getTimeRegions(List<ScheduleModel> schedulesOfTutor) {
      final List<TimeRegion> regions = <TimeRegion>[];

      for (int i = 0; i < schedulesOfTutor.length; ++i) {
        int timestamp = schedulesOfTutor[i].startTimestamp;
        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
        DateTime date = DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute, dateTime.second);
        regions.add(TimeRegion(
          startTime: date,
          endTime: date.add(const Duration(minutes: 30)),
          enablePointerInteraction: true,
          color: Colors.grey.withOpacity(0.2),
          text: schedulesOfTutor[i].isBooked ? "Booked" : 'Book',
        ));
      }

      return regions;
    }

    return FutureBuilder<List<ScheduleModel>>(
      future: _loadScheduleOfTuTorFuture,
      builder: (BuildContext context, AsyncSnapshot<List<ScheduleModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          List<ScheduleModel> schedulesOfTutor = snapshot.data as List<ScheduleModel>;
          return SizedBox(
            height: 2520,
            child: SfCalendar(
              view: CalendarView.week,
              firstDayOfWeek: 1,
              showNavigationArrow: true,
              showCurrentTimeIndicator: false,
              timeSlotViewSettings: const TimeSlotViewSettings(
                timeInterval: Duration(minutes: 30), timeFormat: 'h:mm a',
                timeIntervalHeight: 50,
                dateFormat: 'd', dayFormat: 'EEE',
                startHour: 0,
                endHour: 24,
                numberOfDaysInView: 5,
              ),
              specialRegions: getTimeRegions(schedulesOfTutor),
              timeRegionBuilder: (BuildContext context, TimeRegionDetails details) {
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
                      child: const Text(
                        'Book',
                        style: TextStyle(color: Colors.white),
                      )
                    ),
                  );
                }
                else {
                  return Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Booked',
                      style: TextStyle(color: Colors.green),
                    ),
                  );
                }
              },
              onTap: (CalendarTapDetails details) async {
                if (details.targetElement == CalendarElement.calendarCell) {
                  DateTime tappedTime = details.date!;
                  List<TimeRegion> timeRegions = getTimeRegions(schedulesOfTutor);
                  for (int i = 0; i < timeRegions.length ; ++i) {
                    if (tappedTime.isAtSameMomentAs(timeRegions[i].startTime)
                        && tappedTime.isBefore(timeRegions[i].endTime) && !schedulesOfTutor[i].isBooked) {
                      DateTime timestart = DateTime.fromMillisecondsSinceEpoch(schedulesOfTutor[i].startTimestamp);
                      DateTime timeend = DateTime.fromMillisecondsSinceEpoch(schedulesOfTutor[i].endTimestamp);

                      String start = "${timestart.hour.toString().length==1 ? "0${timestart.hour}":timestart.hour.toString()} : ${timestart.minute.toString().length == 1 ? "0${timestart.minute}" : timestart.minute.toString()}";
                      String end = "${timeend.hour.toString().length==1 ? "0${timeend.hour}":timeend.hour.toString()} : ${timeend.minute.toString().length == 1 ? "0${timeend.minute}" : timeend.minute.toString()}";
                      String date = DateFormat.yMMMMEEEEd().format(DateTime.fromMillisecondsSinceEpoch(schedulesOfTutor[i].startTimestamp));
                      
                      final dialogResult = await showDialog(
                        context: context,
                        builder: (context) => BookingConfirmDialog(start: start, end: end, date: date),
                      );
                      if (dialogResult) {
                        scheduleStudentRepository.addSchedule(schedulesOfTutor[i]);
                        setState(() {
                          schedulesOfTutor[i].booking();
                        });
                      }
                    }
                  }
                }
              },
            ),
          );
        } else {
          return const Center(
            child: Text('Error loading data'),
          );
        }
      },
    );
  }
}