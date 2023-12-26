import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/models/data/tutors/tutor_data.dart';
import 'package:src/repository/favorite_repository.dart';

class Tutor extends StatefulWidget {
  final TutorData tutor;
  final bool isFavorite;
  const Tutor(this.tutor, this.isFavorite, {super.key});

  @override
  State<Tutor> createState() => _TutorState();
}

List<Widget> generateWidgets(List<String> list) {
  List<Widget> widgets = [];
  Color backgroundColor = const Color.fromARGB(255, 221, 234, 255);

  for (int i = 0; i < list.length; i++) {
    widgets.add(TextButton(
        onPressed: () {},
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(40, 30)),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        child: Text(
          list[i],
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.blueAccent),
        )));
  }

  return widgets;
}

List<Widget> generateRatings(int rating) {
  int realRating = rating.round();
  List<Widget> widgets = [];

  for (int i = 1; i <=5; i++) {
    if(i <= realRating) {
      widgets.add(const Icon(
        Icons.star,
        size: 15,
        color: Colors.yellow,
      ));
    }
    else{
      widgets.add(Icon(
        Icons.star,
        size: 15,
        color: Colors.grey.shade300,
      ));
    }
  }

  return widgets;
}

class _TutorState extends State<Tutor> {
  @override
  Widget build(BuildContext context) {
    FavouriteRepository favouriteRepository = context.watch<FavouriteRepository>();
    var isInFavourite = favouriteRepository.itemIds.contains(widget.tutor.userId);
    List<Widget> generatedWidgets = generateWidgets(widget.tutor.specialties?.split(',') ?? []);
    
    return Container(
      padding: const EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(1, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => DetailTutor(widget.tutor)),
                    //   );
                    // },
                    child: Container(
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
                        child: Image.network(widget.tutor.avatar ?? "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1700296337596.jpg"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        // onTap: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => DetailTutor(widget.tutor)),
                        //   );
                        // },
                        child: Text(
                          widget.tutor.name ?? "",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                      ),
                      Text(
                        widget.tutor.country ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                          fontSize: 14
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:generateRatings((widget.tutor.rating ?? 0.0) as int)
                      )
                    ],
                  )
                ],
              ),
              IconButton(
                icon: Icon(
                  widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: widget.isFavorite ? Colors.red : Colors.blueAccent,
                ),
                onPressed: () {
                  // isInFavourite ? favouriteRepository.remove(widget.tutor.userId) : favouriteRepository.add(widget.tutor.userId);
                },
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 0),
            child: Wrap(
              spacing: 5,
              runSpacing: -10,
              children: generatedWidgets,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
                widget.tutor.bio ?? "",
                maxLines: 4,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
                overflow: TextOverflow.ellipsis),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      const BorderSide(
                        color: Colors.blueAccent,
                        width: 1.0,
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(const Size(40, 30)),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.fact_check_rounded,
                        color: Colors.blueAccent,
                        size: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Book",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.blueAccent),
                      ),
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
