import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  String? valueLevel;
  String? valueCategory;
  String? valueSort;

  final MultiSelectController _controller = MultiSelectController();

  List<String> category = [
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
  List<String> sort = ["DESC", 'ASC'];
  List<String> level = [
    "Any level",
    "Beginer",
    "Upper-Beginer",
    "Pre-Intermedicate",
    "Intermedicate",
    "Upper-Intermedicate",
    "Pre-advanced",
    "Advanced",
    "Very advanced"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          MultiSelectDropDown(
            hint: "Select level",
            hintStyle: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
            showClearIcon: true,
            controller: _controller,
            onOptionSelected: (options) {
              debugPrint(options.toString());
            },
            padding: const EdgeInsets.only(left: 5),
            options: level
                .map((item) => ValueItem(label: item, value: item))
                .toList(),
            maxItems: level.length,
            selectionType: SelectionType.multi,
            chipConfig: const ChipConfig(
                wrapType: WrapType.wrap,
                runSpacing: 0,
                padding: EdgeInsets.only(left: 10, right: 0)),
            dropdownHeight: 300,
            optionTextStyle: const TextStyle(fontSize: 14),
            selectedOptionIcon: const Icon(Icons.check),
            borderRadius: 3,
          ),
          const SizedBox(
            height: 7,
          ),
          MultiSelectDropDown(
            hint: "Select category",
            hintStyle: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
            showClearIcon: true,
            controller: _controller,
            onOptionSelected: (options) {
              debugPrint(options.toString());
            },
            options: category
                .map((item) => ValueItem(label: item, value: item))
                .toList(),
            maxItems: category.length,
            selectionType: SelectionType.multi,
            chipConfig: const ChipConfig(
                wrapType: WrapType.wrap,
                runSpacing: 0,
                padding: EdgeInsets.only(left: 10, right: 0)),
            dropdownHeight: 300,
            optionTextStyle: const TextStyle(fontSize: 14),
            selectedOptionIcon: const Icon(Icons.check),
            borderRadius: 3,
            padding: const EdgeInsets.only(left: 5),
          ),
          Container(
            margin: const EdgeInsets.only(top: 7),
            height: 50,
            padding: const EdgeInsets.only(left: 10, right: 5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.circular(3)),
            child: DropdownButton(
                hint: const Text(
                  'Sort by level',
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.grey),
                ),
                isExpanded: true,
                underline: const SizedBox(),
                style: const TextStyle(fontSize: 14, color: Colors.black),
                onChanged: (newValue) {
                  setState(() {
                    valueSort = newValue;
                  });
                },
                items: sort.map((valueItem) {
                  return DropdownMenuItem(
                      value: valueItem,
                      child: Text(
                        valueItem,
                        style: const TextStyle(fontWeight: FontWeight.w400),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ));
                }).toList(),
                value: valueSort),
          ),
        ],
      ),
    );
  }
}
