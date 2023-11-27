import 'package:flutter/material.dart';

class Overview extends StatelessWidget {
  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> topics = [
      "The Internet",
      "Artifical Intelligence (AI)",
      "Social Media",
      "Internet Privacy",
      "Live Streaming",
      "Coding",
      "Technology Transforming Healthcare",
      "Smart Home Technology",
      "Remote Work - A Dream Job?"
    ];
    return Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                height: 0.5,
                color: Colors.grey.shade300,
              ),
            ),
            const SizedBox(width: 5.0),
            const Text(
              "Overview",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            const SizedBox(width: 4.0),
            Expanded(
              flex: 8,
              child: Container(
                height: 0.5,
                color: Colors.grey.shade300,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 2, color: Colors.red)),
                child: const Icon(
                  Icons.question_mark_outlined,
                  color: Colors.red,
                  size: 20,
                )),
            const SizedBox(
              width: 8,
            ),
            const Text(
              "Why take this course",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            "Our world is rapidly changing thanks to new technology, and the vocabulary needed to discuss modern life is evolving almost daily. In this course you will learn the most up-to-date terminology from expertly crafted lessons as well from your native-speaking tutor.",
            style: TextStyle(color: Colors.grey.shade700),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 2, color: Colors.red)),
                child: const Icon(
                  Icons.question_mark_outlined,
                  color: Colors.red,
                  size: 20,
                )),
            const SizedBox(
              width: 8,
            ),
            const Text(
              "What will you be able to do",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            "You will learn vocabulary related to timely topics like remote work, artificial intelligence, online privacy, and more. In addition to discussion questions, you will practice intermediate level speaking tasks such as using data to describe trends.",
            style: TextStyle(color: Colors.grey.shade700),
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                height: 0.5,
                color: Colors.grey.shade300,
              ),
            ),
            const SizedBox(width: 6.0),
            const Expanded(
                flex: 3,
                child: Text(
                  "Experience",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                )),
            const SizedBox(width: 4.0),
            Expanded(
              flex: 7,
              child: Container(
                height: 0.5,
                color: Colors.grey.shade300,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Icon(
              Icons.group_add_outlined,
              color: Colors.blue.shade900,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "Intermedicate",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            )
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                height: 0.5,
                color: Colors.grey.shade300,
              ),
            ),
            const SizedBox(width: 5.0),
            const Text(
              "Course Length",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            const SizedBox(width: 4.0),
            Expanded(
              flex: 6,
              child: Container(
                height: 0.5,
                color: Colors.grey.shade300,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Icon(
              Icons.book_outlined,
              color: Colors.blue.shade900,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "9 topics",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            )
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                height: 0.5,
                color: Colors.grey.shade300,
              ),
            ),
            const SizedBox(width: 5.0),
            const Text(
              "List Topics",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            const SizedBox(width: 4.0),
            Expanded(
              flex: 7,
              child: Container(
                height: 0.5,
                color: Colors.grey.shade300,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: generateWidgets(topics)),
        const SizedBox(height: 15),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                height: 0.5,
                color: Colors.grey.shade300,
              ),
            ),
            const SizedBox(width: 5.0),
            const Text(
              "Suggested Tutors",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            const SizedBox(width: 4.0),
            Expanded(
              flex: 6,
              child: Container(
                height: 0.5,
                color: Colors.grey.shade300,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            const Text(
              "Keegan",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "More info",
              style: TextStyle(color: Colors.blue.shade800),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  List<Widget> generateWidgets(List<String> list) {
    List<Widget> widgets = [];

    for (int i = 0; i < list.length; i++) {
      widgets.add(Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 0.5, color: Colors.grey.shade300)),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${i + 1}."),
            Text(list[i]),
          ],
        ),
      ));
    }

    return widgets;
  }
}
