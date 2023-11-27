import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:get/get.dart';
import 'package:src/ui/home/time_range.dart';

class SearchTutor extends StatefulWidget {
  const SearchTutor({super.key});

  @override
  State<SearchTutor> createState() => _SearchTutorState();
}

List<Widget> generateWidgets(List<String> list) {
  List<Widget> widgets = [];
  Color backgroundColor = const Color.fromARGB(255, 232, 232, 232);

  for (int i = 0; i < list.length; i++) {
    widgets.add(TextButton(
        onPressed: () {},
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(40, 30)),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        child: Text(
          list[i],
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        )));
  }

  return widgets;
}

class _SearchTutorState extends State<SearchTutor> {
  DateTime selectDate = DateTime.now();
  final TextEditingController _textEditingDate = TextEditingController();
  final List<String> _items = [
    "Foreign Tutor",
    "Vietnamese Tutor",
    "Native English Tutor"
  ];
  List<String> selectedOptionList = [];
  var selectedOption = ''.obs;
  @override
  Widget build(BuildContext context) {
    List<String> listFilters = [
      "All",
      "English for kids",
      "English for Business",
      "Conversational",
      "STARTERS",
      "MOVERS",
      "FLYERS",
      "KET",
      "PET",
      "IELTS",
      "TOEFL",
      "TOEIC"
    ];
    List<Widget> generatedWidgets = generateWidgets(listFilters);
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      width: double.infinity,
      margin: const EdgeInsets.only(top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Find a tutor",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: -12, left: 5, right: 2),
                  border: InputBorder.none,
                  hintText: "Enter tutor name...",
                  hintStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w400)),
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: DropDownMultiSelect(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 15, right: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
              options: _items,
              whenEmpty: "Select tutor nationality",
              onChanged: (value) {
                selectedOptionList = value;
                selectedOption.value = "";
                for (var element in selectedOptionList) {
                  selectedOption.value = "${selectedOption.value}, $element";
                }
              },
              selectedValues: selectedOptionList,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Select available tutoring time:",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 40,
            width: 160,
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: _textEditingDate,
              onTap: () async {
                final DateTime? datetime = await showDatePicker(
                    context: context,
                    initialDate: selectDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(3000));
                if (datetime != null) {
                  setState(() {
                    _textEditingDate.text =
                        "${datetime.year}-${datetime.month}-${datetime.day}";
                    selectDate = datetime;
                  });
                }
              },
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 1, left: 13, right: 2),
                  border: InputBorder.none,
                  hintText: "Select a day",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                  suffixIcon: Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.black54,
                    size: 20,
                  )),
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
          const TimeRangeSelector(),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 0),
            child: Wrap(
              spacing: 5,
              children: generatedWidgets,
            ),
          ),
          TextButton(
              onPressed: () {},
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                  const BorderSide(
                    color: Colors.blueAccent,
                    width: 1.0,
                  ),
                ),
                minimumSize: MaterialStateProperty.all(const Size(40, 30)),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              child: const Text(
                "Reset Filters",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.blueAccent),
              )),
        ],
      ),
    );
  }
}
