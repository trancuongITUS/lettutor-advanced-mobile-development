import 'package:flutter/material.dart';

import 'package:src/ui/home/tutor.dart';
import 'package:src/models/tutor.dart';

class ListTutors extends StatefulWidget {
  final List<TutorModel> tutors;

  const ListTutors(this.tutors, {super.key});

  @override
  State<ListTutors> createState() => _ListTutorsState();
}

class _ListTutorsState extends State<ListTutors> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Recommended Tutors",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
            textAlign: TextAlign.left,
          ),
          ListView.builder (
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) { return Tutor(widget.tutors[index]); },
          ),
        ],
      ),
    );
  }
}
