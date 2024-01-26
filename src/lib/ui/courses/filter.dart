import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:src/ui/courses/courses_page.dart';

class Filter extends StatefulWidget {
  const Filter(this.filterCourseCallback, {super.key});
  final FilterCourseCallback filterCourseCallback;
  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  String? valueSort;
  List<String> levels = [];

  final MultiSelectController _controller = MultiSelectController();

  
  List<String> sort = ["DESC", 'ASC'];
  List<Map<String, String>> level = [
    {
      "value":"0",
      "label": "Any level"
    },
    {
      "value":"1",
      "label": "Beginer"
    },
    {
      "value":"2",
      "label": "Upper-Beginer"
    },
    {
      "value":"3",
      "label": "Pre-Intermedicate"
    },
    {
      "value":"4",
      "label": "Intermedicate"
    },
    {
      "value":"5",
      "label": "Upper-Intermedicate"
    },
    {
      "value":"6",
      "label": "Pre-advanced"
    },
    {
      "value":"7",
      "label": "Advanced"
    },
    {
      "value":"8",
      "label": "Very advanced"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          MultiSelectDropDown(
            hint: "Select category",
            hintStyle: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
            showClearIcon: true,
            controller: _controller,
            onOptionSelected: (options) {
              List<String> values = options.map((item) => item.value.toString()).toList();
              widget.filterCourseCallback(valueSort ?? "", values);
              setState(() {
                levels = values;
              });
            },
            options: level
                .map((item) => ValueItem(label: item['label']!, value: item['value']!))
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
                  widget.filterCourseCallback(newValue ?? "", levels);
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
