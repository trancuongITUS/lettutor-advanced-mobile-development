import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BirthdaySelect extends StatefulWidget {
  const BirthdaySelect({Key? key, this.dateTimeData, required this.onBirthDayChanged}) : super(key: key);
  final DateTime? dateTimeData;
  final ValueChanged<String> onBirthDayChanged;


  @override
  State<BirthdaySelect> createState() => _BirthdaySelectState();
}

class _BirthdaySelectState extends State<BirthdaySelect> {
  TextEditingController dateController = TextEditingController();
  DateTime? selectedDate;
  bool isInitValue = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;

    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = "${picked.toLocal()}".split(' ')[0];
        widget.onBirthDayChanged(selectedDate.toString());

      });
    }
  }

  @override
  Widget build(BuildContext context) {

    if(!isInitValue){
      dateController.text = DateFormat('yyyy-MM-dd').format(widget.dateTimeData!);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 42,
          child: TextField(
            controller: dateController,
            decoration: InputDecoration(
              isDense: true, // Added this
              hintText: "Choose your birthday",
              hintStyle: TextStyle(
                  fontSize: 14, color: Colors.grey.shade400),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: IconButton(
                onPressed: () => _selectDate(context),
                icon: const Icon(Icons.calendar_today),
              ),
            ),
            readOnly: true,
          ),
        ),
      ],
    );
  }
}