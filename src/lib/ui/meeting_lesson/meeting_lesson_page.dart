import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:src/models/data/schedules/booking_info_data.dart';

class MeetingLessonPage extends StatefulWidget {
  const MeetingLessonPage({super.key, required this.upcomingClass});
  final BookingInfoData upcomingClass ;


  @override
  State<MeetingLessonPage> createState() => _MeetingLessonPageState();
}

class _MeetingLessonPageState extends State<MeetingLessonPage> {

  late BookingInfoData upcomingClass = widget.upcomingClass;
  late DateTime endTime;
  bool canJoinMeeting = false;

  @override
  void initState() {
    super.initState();
    endTime = DateTime.fromMillisecondsSinceEpoch(upcomingClass.scheduleDetailInfo!.startPeriodTimestamp!);
  }

  void onEnd() {
    setState(() {
      canJoinMeeting = true;
    });
  }
  void _joinMeeting() async {
    final String meetingToken = upcomingClass.studentMeetingLink?.split('token=')[1] ?? '';
    Map<String, dynamic> jwtDecoded = JwtDecoder.decode(meetingToken);
    final String room = jwtDecoded['room'];

    var options = JitsiMeetingOptions(
      roomNameOrUrl: room,
      serverUrl: "https://meet.lettutor.com",
      token: meetingToken,
      isAudioMuted: true,
      isAudioOnly: true,
      isVideoMuted: true,
    );

    await JitsiMeetWrapper.joinMeeting(
      options: options,
      listener: JitsiMeetingListener(
        onConferenceWillJoin: (url) => print("onConferenceWillJoin: url: $url"),
        onConferenceJoined: (url) => print("onConferenceJoined: url: $url"),
        onConferenceTerminated: (url, error) => print("onConferenceTerminated: url: $url, error: $error"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar:
        PreferredSize(
          preferredSize:
          const Size.fromHeight(50.0),
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
                statusBarIconBrightness:
                Brightness.light,
              ),
              title: const Text("Join Meeting",
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
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/video.jpg"),
              CountdownTimer(
                endTime: endTime.millisecondsSinceEpoch,
                textStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                endWidget: const Text(
                  "Go to meeting",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  _joinMeeting();
                },
                child: const Text("Join meeting"),
              ),
            ],
          ),
        ),
        );
  }
}