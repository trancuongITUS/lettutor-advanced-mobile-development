import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:src/ui/detail_courses/detail_courses.dart';

class InfoDetail extends StatelessWidget {
  const InfoDetail({super.key});
  @override
  Widget build(BuildContext context) {
    List<String> listSpecialties = [
      "English for Business",
      "Conversational",
      "English for kids",
      "IELTS",
      "STARTERS"
    ];
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Education",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: Text("BA",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Languages",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(20)),
            child: Text("English",
                style: TextStyle(color: Colors.blue.shade800, fontSize: 16)),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Specialties",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: generateWidgets(listSpecialties)),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Suggested courses",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: RichText(
              text: TextSpan(
                text: 'Basic Conversation Topics: ',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
                children: [
                  TextSpan(
                      text: 'Link',
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.normal),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DetailCourse()),
                          );
                        }),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: RichText(
              text: TextSpan(
                text: 'Life in the Internet Age: ',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
                children: [
                  TextSpan(
                      text: 'Link',
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.normal),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DetailCourse()),
                          );
                        }),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Interests",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
                "I loved the weather, the scenery and the laid-back lifestyle of the locals.",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Teaching experience",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
                "I have more than 10 years of teaching english experience.",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
          ),
        ],
      ),
    );
  }

  List<Widget> generateWidgets(List<String> list) {
    List<Widget> widgets = [];

    for (int i = 0; i < list.length; i++) {
      widgets.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(20)),
          child: Text(list[i],
              style: TextStyle(color: Colors.blue.shade800, fontSize: 16)),
        ),
      );
    }

    return widgets;
  }
}
