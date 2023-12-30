import 'package:flutter/material.dart';
import 'package:src/models/data/tutors/tutor_feedback_data.dart';

class Review extends StatelessWidget {
  final TutorFeedbackData rate;
  const Review(this.rate, {super.key});

  String formatTimeAgo(String apiTime) {
  DateTime currentTime = DateTime.now();
  DateTime apiDateTime = DateTime.parse(apiTime);
  Duration difference = currentTime.difference(apiDateTime);

  Map<String, int> timeUnits = {
    'year': 365,
    'month': 30,
    'day': 1
  };

  for (var unit in timeUnits.entries) {
    if (difference.inDays >= unit.value) {
      int quantity = (difference.inDays / unit.value).floor();
      String plural = quantity > 1 ? 's' : '';
      return '$quantity ${unit.key}$plural ago';
    }
  }

  if (difference.inHours > 0) {
    return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
  } else {
    return 'Just now';
  }
}

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
              child: Image.network(rate.firstInfo!.avatar!, width: 50, height: 50,),
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
                  text: rate.firstInfo!.name,
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                  children: <TextSpan>[
                    TextSpan(
                        text: " ${formatTimeAgo(rate.updatedAt!)}",
                        style: TextStyle(color: Colors.grey.shade400)),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: generateWidgets(rate.rating!),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(rate.content!)
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
