import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Lesson extends StatefulWidget {
  const Lesson({super.key, required this.title, required this.url});
  final String title;
  final String url;

  @override
  State<Lesson> createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

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
            title: Text(widget.title,
                style: const TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                )),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  size: 18,
                  color: Colors.blueAccent,
                  semanticLabel: 'Back Icon'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: SfPdfViewer.network(
          widget.url,
          key: _pdfViewerKey,
        ),
      ),
    );
  }
}
