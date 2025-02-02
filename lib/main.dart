import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const ComingSoonApp());
}

class ComingSoonApp extends StatefulWidget {
  const ComingSoonApp({super.key});

  @override
  _ComingSoonAppState createState() => _ComingSoonAppState();
}

class _ComingSoonAppState extends State<ComingSoonApp> {
  late VideoPlayerController _controller;
  bool _videoLoaded = false;

@override
void initState() {
  super.initState();
  _controller = VideoPlayerController.asset("assets/images/snail_2.mp4")
    ..initialize().then((_) {
      setState(() {
        _videoLoaded = true;
      });
      _controller.setLooping(true);
      _controller.setVolume(0.0); // Mute the video for autoplay
      _controller.play();
    }).catchError((error) {
      debugPrint("Error loading video: $error");
    });
}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // Fullscreen Video
            Positioned.fill(
              child: _videoLoaded
                  ? FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller.value.size.width,
                        height: _controller.value.size.height,
                        child: VideoPlayer(_controller),
                      ),
                    )
                  : const Center(child: Text("Loading video...", style: TextStyle(color: Colors.white))),
            ),

            // Thought Bubble
            Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.2,
              right: MediaQuery.of(context).size.width * 0.2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: const Text(
                  "We Are Coming Soon!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
