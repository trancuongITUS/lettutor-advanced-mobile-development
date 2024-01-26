import 'package:flutter/material.dart';

class VideoCall extends StatefulWidget {
  const VideoCall({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  bool isOpenCamera = true;
  bool isOpenMicro = true;
  bool isCallActive = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 320,
            height: 240,
            color: Colors.black,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(isOpenMicro ? Icons.mic : Icons.mic_off),
                onPressed: () {
                  setState(() {
                    isOpenMicro = !isOpenMicro;
                  });
                },
                color: isOpenMicro ? Colors.blue : Colors.red,
                iconSize: 48,
              ),
              const SizedBox(width: 20),
              IconButton(
                icon:
                    Icon(isOpenCamera ? Icons.videocam : Icons.videocam_off),
                onPressed: () {
                  setState(() {
                    isOpenCamera = !isOpenCamera;
                  });
                },
                color: isOpenCamera ? Colors.blue : Colors.red,
                iconSize: 48,
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isCallActive = !isCallActive;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isCallActive ? Colors.red : Colors.green,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                isCallActive ? 'END' : 'START',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: VideoCall(),
  ));
}