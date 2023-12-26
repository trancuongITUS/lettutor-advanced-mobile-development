import 'package:flutter/material.dart';
import 'package:src/models/schedule.dart';


class ScheduleStudentRepository extends ChangeNotifier {
  List<ScheduleModel> scheduleStudent = [];

  void addSchedule(ScheduleModel schedule) {
    scheduleStudent.add(schedule);
    notifyListeners();
  }

}