import 'package:flutter/material.dart';

class Review extends StatelessWidget {
  final String avatar;
  final String username;
  final String time;
  final int rating;
  final String comment;
  const Review(
      {super.key,
      required this.avatar,
      required this.username,
      required this.time,
      required this.rating,
      required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey.shade300,
                width: 0.5,
              ),
            ),
            child: ClipOval(
              child: Image.asset(avatar),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: username,
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                  children: <TextSpan>[
                    TextSpan(
                        text: "   $time",
                        style: TextStyle(color: Colors.grey.shade400)),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: generateWidgets(rating),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(comment)
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> generateWidgets(int rating) {
    List<Widget> widgets = [];

    for (int i = 1; i <= 5; i++) {
      if (i <= rating) {
        widgets.add(Icon(
          Icons.star,
          size: 16,
          color: Colors.yellow.shade500,
        ));
      } else {
        widgets.add(Icon(
          Icons.star,
          size: 16,
          color: Colors.grey.shade300,
        ));
      }
    }

    return widgets;
  }
}
