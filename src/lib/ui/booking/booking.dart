import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:src/models/schedule.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  List<ScheduleModel> listScheduleOfTutor = [];
  
  void initState() {
    loadScheduleOfTutor();
  }
  
  Future<void> loadScheduleOfTutor() async {
    // Đọc dữ liệu từ file JSON
    String jsonString = await rootBundle.loadString('data/schedule.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);

    // Lấy danh sách tutors từ dữ liệu JSON
    List<Map<String, dynamic>> schedules = [];

    if (jsonData['data'] != null && jsonData['data'] is List) {
      schedules = List<Map<String, dynamic>>.from(jsonData["data"]);
    }

    // Chuyển đổi thành danh sách các đối tượng Tutor'
    setState(() {
      listScheduleOfTutor = schedules.map((json) => ScheduleDTO.fromJson(json)).toList();
    });
    for (var schedule in schedules) {

      int secondId = schedule["startTimestamp"];
      print(secondId);
    }

  }
  @override

  @override
  Widget build(BuildContext context) {
    List<TimeRegion> _getTimeRegions() {
      final List<TimeRegion> regions = <TimeRegion>[];

      for (int i = 0; i < listScheduleOfTutor.length; i++) {
        int timestamp = listScheduleOfTutor[i].startTimestamp;
        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
        DateTime date = DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute, dateTime.second);
        regions.add(TimeRegion(
          startTime: date,
          endTime: date.add(Duration(minutes: 30)),
          enablePointerInteraction: true,
          color: Colors.grey.withOpacity(0.2),
          text: listScheduleOfTutor[i].isBooked?"Booked":'Book',
        ));

      }

      return regions;
    }

    return Container(
      height: 2520,
      child: SfCalendar(
        view: CalendarView.week,
        firstDayOfWeek: 1,
        showNavigationArrow: true,
        showCurrentTimeIndicator: false,
        timeSlotViewSettings: TimeSlotViewSettings(
          timeInterval: Duration(minutes: 30), timeFormat: 'h:mm a',
          timeIntervalHeight: 50,
          dateFormat: 'd', dayFormat: 'EEE',
          startHour: 0, // Set the start hour (24-hour format)
          endHour: 24, numberOfDaysInView: 5,
          // Set the end hour (24-hour format)
        ),
        specialRegions: _getTimeRegions(),
        timeRegionBuilder: (BuildContext context, TimeRegionDetails details) {
          if (details.region.text == 'Book')
            {
              return Container(
                alignment: Alignment.center,
                child: TextButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          Size(18, 18)), // Thay đổi width và height tùy ý
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 8, vertical: 3)),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Book',
                      style: TextStyle(color: Colors.white),
                    )),
              );
            }
          else{
            return Container(
              alignment: Alignment.center,
                  child: Text(
                    'Booked',
                    style: TextStyle(color: Colors.green),
                  ),
            );
          }

        },
        onTap: (CalendarTapDetails details) async {
          if (details.targetElement == CalendarElement.calendarCell) {
            // Check if the tap is within a time region
            DateTime tappedTime = details.date!;
            List<TimeRegion> timeRegions = _getTimeRegions();
            for (int i=0;i<timeRegions.length;i++) {
              if (tappedTime.isAtSameMomentAs(timeRegions[i].startTime) &&
                  tappedTime.isBefore(timeRegions[i].endTime) &&!listScheduleOfTutor[i].isBooked) {
                  DateTime timestart=DateTime.fromMillisecondsSinceEpoch(listScheduleOfTutor[i].startTimestamp);
                  DateTime timeend=DateTime.fromMillisecondsSinceEpoch(listScheduleOfTutor[i].endTimestamp);

                  String start="${timestart.hour.toString().length==1?"0"+timestart.hour.toString():timestart.hour.toString()}:${timestart.minute.toString().length==1?"0"+timestart.minute.toString():timestart.minute.toString()}";
                  String end="${timeend.hour.toString().length==1?"0"+timeend.hour.toString():timeend.hour.toString()}:${timeend.minute.toString().length==1?"0"+timeend.minute.toString():timeend.minute.toString()}";
                  String date=DateFormat.yMMMMEEEEd().format(DateTime.fromMillisecondsSinceEpoch(listScheduleOfTutor[i].startTimestamp!));
                  final dialogResult = await showDialog(
                  context: context,
                  builder: (context) => BookingConfirmDialog(start: start, end: end, date: date),
                );

                  if(dialogResult)
                    {
                      setState(() {
                        listScheduleOfTutor[i].booking();
                      });
                    }

                // Tap is within a time region, perform your action
              }
            }
          }
        },
      ),
    );
  }
}