import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:src/common/loading.dart';
import 'package:src/models/data/tutors/tutor_data.dart';
import 'package:src/models/data/tutors/tutor_feedback_data.dart';
import 'package:src/models/data/tutors/tutor_info_data.dart';
import 'package:src/provider/authentication_provider.dart';
import 'package:src/services/feedback_api.dart';
import 'package:src/services/tutor_api.dart';
import 'package:src/services/user_api.dart';
import 'package:src/ui/booking/booking.dart';
import 'package:src/ui/detail_tutor/info_detail.dart';
import 'package:src/ui/detail_tutor/list_reviews.dart';
import 'package:src/ui/detail_tutor/video_intro.dart';

class DetailTutor extends StatefulWidget {
  final TutorData tutor;
  const DetailTutor(this.tutor, {super.key});

  @override
  State<DetailTutor> createState() => _DetailTutorState();
}

class _DetailTutorState extends State<DetailTutor> {

  late List<TutorFeedbackData> feedbacks = [];
  late TutorInfoData tutorInfo;
  bool isFavorite = false;
  bool isLoading = true;

  @override
  void initState() {
    setState(() {
      isFavorite = widget.tutor.isFavoriteTutor!;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await Future.wait([callAPIGetTutorById(TutorAPI(), Provider.of<AuthenticationProvider>(context, listen: false), widget.tutor.userId!)]).whenComplete(() {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  Future<void> callAPIGetTutorById(TutorAPI tutorAPI, AuthenticationProvider authenticationProvider, String userId) async {
    await tutorAPI.getTutorById(
      accessToken: authenticationProvider.token?.access?.token ?? "",
      tutorId: userId,
      onSuccess: (response) async {
        setState(() {
          tutorInfo = response;
          isLoading = false;
        });
      },
      onFail: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${error.toString()}')),
        );
      });
  }

  Future<void> callAPIGetFeedbackOfTutor(FeedbackAPI feedbackAPI, AuthenticationProvider authenticationProvider, String? userId) async {
    await feedbackAPI.getFeedBackOfTutor(
      accessToken: authenticationProvider.token?.access?.token ?? "",
      page: 1,
      perPage: 20,
      tutorId: userId ?? "",
      onSuccess: (response, total) async {
        setState(() {
          feedbacks = response;
        });
      },
      onFail: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${error.toString()}')),
        );
      });
  }

  Future<void> callApiManageFavoriteTutor(String tutorID, AuthenticationProvider authenticationProvider) async {
    UserAPI userAPI = UserAPI();

    await userAPI.favoriteTutor(
        accessToken: authenticationProvider.token?.access?.token ?? "",
        tutorId: tutorID,
        onSuccess: (message, unfavored) async {
          setState(() {
            isFavorite = isFavorite;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "Update favorite tutor successful",
                style: TextStyle(color: Colors.white),
              ),
              duration: Duration(seconds: 1),
            ),
          );
        },
        onFail: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        });
  }

  Future<void> refreshHome() async {
    setState(() {
      isLoading = true;
    });
    await Future.wait([
      callAPIGetTutorById(TutorAPI(), Provider.of<AuthenticationProvider>(context, listen: false), widget.tutor.userId!),
    ]).whenComplete(() {
      setState(() {
        isLoading = false;
      });

      return Future<void>.delayed(const Duration(seconds: 0));
    });
  }

  List<Widget> generateRatings(double rating) {
    int realRating = rating.toInt();
    List<Widget> widgets = [];

    for (int i = 1; i <= 5; ++i) {
      if (i <= realRating) {
        widgets.add(const Icon(
          Icons.star,
          size: 20,
          color: Colors.yellow,
        ));
      }
      else {
        widgets.add(Icon(
          Icons.star,
          size: 20,
          color: Colors.grey.shade300,
        ));
      }
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
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
      body: RefreshIndicator(
        onRefresh: () async {
          await refreshHome();
        },
        child: (isLoading) ? const Loading() : SingleChildScrollView(
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
                    child: Image.network(widget.tutor.avatar!),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.tutor.name!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 22),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: generateRatings(widget.tutor.rating ?? 0.0)
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SvgPicture.network("https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/${widget.tutor.country.toString().toLowerCase()}.svg",
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          widget.tutor.country!,
                          style: const TextStyle(
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
              widget.tutor.bio!,
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
                          callApiManageFavoriteTutor(widget.tutor.userId!, authProvider);
                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.blueAccent,
                          size: 25,
                        )),
                    Text(
                      "Favorite",
                      style: TextStyle(color: isFavorite ? Colors.red : Colors.blueAccent),
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
            ChewieDemo(linkVideo: tutorInfo.video!,),
            InfoDetail(tutorInfo),
            const SizedBox(height: 20),
            ListReview(feedbacks),
            const SizedBox(height: 20),
            Booking(tutor: widget.tutor)
          ]
        )
      )
    ),
    )
    );
  }
}
