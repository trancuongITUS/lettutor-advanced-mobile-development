import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:src/ui/detail_lesson/lesson.dart';

class DetailLesson extends StatefulWidget {
  const DetailLesson({super.key});

  @override
  State<DetailLesson> createState() => _DetailLessonState();
}

class _DetailLessonState extends State<DetailLesson> {
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
  int selectedItemIndex = 0;
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
              title: const Text("Lessons",
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
          padding:
              const EdgeInsets.only(bottom: 35, left: 10, right: 10, top: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: FittedBox(
                    fit: BoxFit.fill, child: Image.asset("img/course_img.png")),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 20, top: 20, right: 20, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Life in the Internet Age",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "Let's discuss how technology is changing the way we live",
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "List Topics",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: topics.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Lesson(
                                      title: topics[index],
                                      url:
                                          "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileThe%20Internet.pdf")),
                            );
                            setState(() {
                              selectedItemIndex = index;
                            });
                          },
                          child: Container(
                              margin: const EdgeInsets.only(top: 5),
                              padding: const EdgeInsets.only(left: 20, top: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: selectedItemIndex == index
                                    ? Colors.grey.shade300
                                    : Colors.white,
                              ),
                              height: 40,
                              child: Text("${index + 1}.    ${topics[index]}")),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        )));
  }
}
