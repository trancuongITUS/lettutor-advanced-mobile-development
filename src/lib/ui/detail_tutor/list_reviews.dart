import 'package:flutter/cupertino.dart';
import 'package:src/ui/detail_tutor/review.dart';

class ListReview extends StatelessWidget {
  const ListReview({super.key});

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
          ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: const [
              Review(
                  avatar: "avatarUser.jpg",
                  username: "Bao Bao",
                  time: "3 days ago",
                  rating: 3,
                  comment: "good"),
              Review(
                  avatar: "avatarUser.jpg",
                  username: "Bao Bao",
                  time: "2 days ago",
                  rating: 5,
                  comment: "abcde"),
              Review(
                  avatar: "avatarUser.jpg",
                  username: "Bao Bao",
                  time: "3 days ago",
                  rating: 1,
                  comment: "đsfsd"),
              Review(
                  avatar: "avatarUser.jpg",
                  username: "Bao Bao",
                  time: "1 days ago",
                  rating: 2,
                  comment: "123")
            ],
          )
        ],
      ),
    );
  }
}
