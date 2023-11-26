// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rating_dialog/rating_dialog.dart';

class Session extends StatefulWidget {
  final String typeSession;
  final String timeOrNumber;
  const Session(
      {super.key, required this.typeSession, required this.timeOrNumber});

  @override
  State<Session> createState() => _SessionState();
}

class _SessionState extends State<Session> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 241, 241, 241),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Thu, 26 Oct 23",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Text(widget.timeOrNumber),
          Container(
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(3)),
            child: Row(
              children: [
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blue,
                      width: 1,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset('login_bg.png'),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Keegan",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'Tunisia.svg',
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        const Text(
                          "Tunisia",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.message_outlined,
                          size: 18,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          "Direct Message",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.blueAccent,
                              fontSize: 14),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(3)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.typeSession == "Schedule"
                          ? "03:30 - 03:55"
                          : "Lesson Time: 03:30 - 03:55",
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Visibility(
                      visible: widget.typeSession == "Schedule",
                      child: TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(
                              const BorderSide(
                                color: Colors.red,
                                width: 1.0,
                              ),
                            ),
                            minimumSize:
                                MaterialStateProperty.all(const Size(40, 30)),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 13, vertical: 5)),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.cancel,
                                color: Colors.red,
                                size: 17,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Cancel",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red),
                              ),
                            ],
                          )),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: Colors.grey, width: 0.5)),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Request for lesson",
                            style: TextStyle(fontSize: 16),
                          ),
                          Visibility(
                            visible: widget.typeSession == "Schedule",
                            child: const Text(
                              "Edit",
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                          )
                        ],
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      children: [
                        Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                                border: Border(
                              top: BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            )),
                            child: const Text(
                              "Hello word",
                              style: TextStyle(fontSize: 14),
                            ))
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.typeSession == "History",
                  child: Container(
                    margin: const EdgeInsets.only(top: 0, bottom: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.grey, width: 0.5)),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Review from tutor",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        children: [
                          Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                  border: Border(
                                top: BorderSide(
                                  color: Colors.grey,
                                  width: 0.5,
                                ),
                              )),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Session 1: 03:30 - 03:55",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    "Lesson status: Completed - Page 40",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    "Lesson progress: Completed",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                        "Behavior (",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Text(
                                        "): ",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        "good",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                        "Listening (",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Text(
                                        "): ",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        "good",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                        "Speaking (",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Text(
                                        "): ",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        "good",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                        "Vocalbulary (",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Text(
                                        "): ",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        "good",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Overall comment: We finished this lesson",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.typeSession == "History",
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 20, top: 15, bottom: 15, right: 10),
                    margin: const EdgeInsets.only(top: 0, bottom: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.grey, width: 0.5)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                _showReviewModal();
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(0),
                                child: Text(
                                  "Add a rating",
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              ),
                            ),
                          ),
                          Wrap(
                            spacing: 15,
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    _showReviewModal();
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Text(
                                      "Edit",
                                      style:
                                          TextStyle(color: Colors.blueAccent),
                                    ),
                                  ),
                                ),
                              ),
                              const Text(
                                "Report",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.blueAccent),
                              ),
                            ],
                          )
                        ]),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showReviewModal() {
    final dialog = RatingDialog(
      initialRating: 5.0,
      title: const Text(
        'What is your rating for Keegan?',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      message: null,
      image: Column(children: [
        Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.blue,
              width: 1,
            ),
          ),
          child: ClipOval(
            child: Image.asset('login_bg.png'),
          ),
        ),
        const Text(
          'Keegan',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          'Lesson Time',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
        ),
        const SizedBox(
          height: 3,
        ),
        const Text(
          'Sat, 28 Oct 23, 15:30 - 15:55',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 0.5,
          color: Colors.grey.shade400,
        )
      ]),
      starSize: 30,
      starColor: Colors.yellow.shade700,
      submitButtonText: 'Submit',
      submitButtonTextStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
      commentHint: 'Content review',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');
        if (response.rating < 3.0) {
        } else {}
      },
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => dialog,
    );
  }
}
