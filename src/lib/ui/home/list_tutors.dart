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
      margin: const EdgeInsets.only(top: 15, bottom: 30),
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
          Visibility(
            visible: widget.tutors.isNotEmpty,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.tutors.length,
              itemBuilder: (context, index) {
                return Tutor(widget.tutors[index]);
              },
            ),
          ),
          Visibility(
            visible: widget.tutors.isEmpty,
            child: Container(
              margin: const EdgeInsets.only(top: 20,bottom: 20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.hourglass_empty,
                    color: Colors.grey.shade300,
                    size: 50,
                  ),
                  const SizedBox(height: 15,),
                  const Text("Sorry we can't find any tutor with this keywords", textAlign:TextAlign.center,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
