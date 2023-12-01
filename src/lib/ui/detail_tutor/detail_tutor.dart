import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:src/models/tutor.dart';
import 'package:src/ui/detail_tutor/info_detail.dart';
import 'package:src/ui/detail_tutor/list_reviews.dart';
import 'package:src/ui/detail_tutor/video_intro.dart';

class DetailTutor extends StatefulWidget {
  final TutorModel tutor;
  const DetailTutor(this.tutor, {super.key});

  @override
  State<DetailTutor> createState() => _DetailTutorState();
}

class _DetailTutorState extends State<DetailTutor> {
  bool isFavorite = false;
  List<Widget> generateRatings(double rating) {
    int realRating=rating.toInt();
    List<Widget> widgets = [];

    for (int i = 1; i <=5; i++) {
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
    FavouriteRepository favouriteRepository = context.watch<FavouriteRepository>();
    var isInFavourite = favouriteRepository.itemIds.contains(widget.tutor.userId);

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
                    child: Image.network(widget.tutor.avatar),
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
                      widget.tutor.name,
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
                          widget.tutor.country,
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
              widget.tutor.bio,
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
                          isInFavourite ? favouriteRepository.remove(widget.tutor.userId) : favouriteRepository.add(widget.tutor.userId);
                        },
                        icon: Icon(
                          isInFavourite ? Icons.favorite : Icons.favorite_border,
                          color: isInFavourite ? Colors.red : Colors.blueAccent,
                          size: 25,
                        )),
                    Text(
                      "Favorite",
                      style: TextStyle(color: isInFavourite ? Colors.red : Colors.blueAccent),
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
            ChewieDemo(linkVideo: widget.tutor.video,),
            const VideoIntro(),
            const InfoDetail(widget.tutor),
            const SizedBox(height: 20),
            const ListReview(widget.tutor.feedbacks),
            SizedBox(height: 20),
            Booking()
          ]))));
  }
}
