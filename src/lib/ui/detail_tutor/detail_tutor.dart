import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:src/ui/detail_tutor/info_detail.dart';
import 'package:src/ui/detail_tutor/list_reviews.dart';
import 'package:src/ui/detail_tutor/video_intro.dart';

class DetailTutor extends StatefulWidget {
  const DetailTutor({super.key});

  @override
  State<DetailTutor> createState() => _DetailTutorState();
}

class _DetailTutorState extends State<DetailTutor> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.blueAccent, boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 0),
              )
            ]),
            child: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.black,
                statusBarIconBrightness: Brightness.light,
              ),
              title: const Text("Tutor Details",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  )),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                  color: Colors.blueAccent,
                ),
              ),
              centerTitle: true,
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(25),
                child: Column(children: [
                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.blue,
                            width: 1,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset('img/login_bg.png'),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Keegan",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 22),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.yellow,
                              ),
                              const Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.yellow,
                              ),
                              const Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.yellow,
                              ),
                              const Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.grey.shade300,
                              ),
                              Text(
                                "(127)",
                                style: TextStyle(color: Colors.grey.shade700),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'img/Vietnam.svg',
                                width: 16,
                                height: 16,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              const Text(
                                "Vietnam",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ExpandableText(
                    "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.",
                    expandText: 'More',
                    collapseText: 'Less',
                    maxLines: 2,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                    textAlign: TextAlign.left,
                    linkColor: Colors.blueAccent,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  isFavorite = !isFavorite;
                                });
                              },
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color:
                                    isFavorite ? Colors.red : Colors.blueAccent,
                                size: 25,
                              )),
                          Text(
                            "Favorite",
                            style: TextStyle(
                                color: isFavorite
                                    ? Colors.red
                                    : Colors.blueAccent),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 120,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.report_gmailerrorred_outlined,
                                color: Colors.blueAccent,
                                size: 25,
                              )),
                          const Text(
                            "Report",
                            style: TextStyle(color: Colors.blueAccent),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  const VideoIntro(),
                  const InfoDetail(),
                  const SizedBox(height: 20),
                  const ListReview()
                ]))));
  }
}
