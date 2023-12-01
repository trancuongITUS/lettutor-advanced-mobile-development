import 'package:flutter/material.dart';

class TimeRangeSelector extends StatefulWidget {
  const TimeRangeSelector({Key? key}) : super(key: key);

  @override
  _TimeRangeSelectorState createState() => _TimeRangeSelectorState();
}

class _TimeRangeSelectorState extends State<TimeRangeSelector> {
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime ? _startTime : _endTime,
    );
    if (selectedTime != null) {
      setState(() {
        if (isStartTime) {
          _startTime = selectedTime;
        } else {
          _endTime = selectedTime;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 40,
      width: 300,
      padding: const EdgeInsets.only(left: 13, right: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              readOnly: true,
              onTap: () => _selectTime(context, true),
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.blueAccent),
                ),
                hintText: "Start time",
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              ),
              controller:
                  TextEditingController(text: _startTime.format(context)),
            ),
          ),
          const Icon(Icons.arrow_forward),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.left,
              readOnly: true,
              onTap: () => _selectTime(context, false),
              decoration: const InputDecoration(
                hintText: 'End Time',
                isDense: true,
                border: InputBorder.none,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.blueAccent),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              ),
              controller: TextEditingController(text: _endTime.format(context)),
            ),
          ),
          const Icon(
            Icons.access_time,
            color: Colors.grey,
            size: 20,
          ),
        ],
      ),
    );
  }
}
