import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:get/get.dart';
import 'package:src/ui/home/home_page.dart';

class SearchTutor extends StatefulWidget {
  final FilterCallback filterCallback;

  const SearchTutor(this.filterCallback, {super.key});

  @override
  State<SearchTutor> createState() => _SearchTutorState();
}

class _SearchTutorState extends State<SearchTutor> {
  DateTime selectDate = DateTime.now();
  // final TextEditingController _textEditingDate = TextEditingController();
  final TextEditingController _textName = TextEditingController();
  final List<String> _items = [
    "Foreign Tutor",
    "Vietnamese Tutor",
    "Native English Tutor"
  ];
  List<String> selectedOptionList = [];
  var selectedOption = ''.obs;
  String selectedButton = 'all';

  @override
  Widget build(BuildContext context) {
    List<String> listFilters = [
      "all",
      "english-for-kids",
      "english-for-business",
      "conversational",
      "starters",
      "movers",
      "flyers",
      "ket",
      "pet",
      "ielts",
      "toefl",
      "toeic"
    ];

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
            child: TextField(
              onSubmitted: (value) {
                widget.filterCallback(selectedButton, value, selectedOptionList);
              },
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: -12, left: 5, right: 2),
                  border: InputBorder.none,
                  hintText: "Enter tutor name...",
                  hintStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w400)),
              style: const TextStyle(
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
                if(selectedOptionList.isNotEmpty) {
                  widget.filterCallback(selectedButton, _textName.text, value);
                }
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
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 0),
            child: Wrap(
              spacing: 6,
              runSpacing: -5,
              children: List.generate(
                listFilters.length,
                (index) => TextButton(
                  onPressed: () {
                    setState(() {
                      selectedButton = listFilters[index];
                    });
                    widget.filterCallback(listFilters[index], _textName.text, selectedOptionList);
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(40, 30)),
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
                    backgroundColor: selectedButton == listFilters[index] ? MaterialStateProperty.all<Color>(Colors.blue.shade100) : MaterialStateProperty.all<Color>(const Color.fromRGBO(228, 230, 235, 1)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))
                  ),
                  child: Text(
                    listFilters[index],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: selectedButton == listFilters[index] ? Colors.blue.shade800 : const Color.fromARGB(100, 100, 100, 1)
                    ),
                  ),
              )),
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
