import 'package:flutter/cupertino.dart';
import 'package:src/models/data/tutors/tutor_feedback_data.dart';
import 'package:src/ui/detail_tutor/review.dart';

class ListReview extends StatelessWidget {
  final List<TutorFeedbackData> feedbacks;
  const ListReview(this.feedbacks, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Others review",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: feedbacks.length,
            itemBuilder: (context, index) {
              return Review(feedbacks[index]);
            },
          )
        ],
      ),
    );
  }
}
