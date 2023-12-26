import 'package:flutter/material.dart';
import 'package:src/models/feedback.dart';

class Review extends StatelessWidget {
  final FeedbackModel rate;
  const Review(this.rate, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey.shade300,
                width: 0.5,
              ),
            ),
            child: ClipOval(
              child: Image.network(rate.firstInfo.avatar, width: 50, height: 50,),
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
                  text: rate.firstInfo.name,
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                  children: <TextSpan>[
                    TextSpan(
                        text: " ${rate.updatedAt}",
                        style: TextStyle(color: Colors.grey.shade400)),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: generateWidgets(rate.rating),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(rate.content)
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
