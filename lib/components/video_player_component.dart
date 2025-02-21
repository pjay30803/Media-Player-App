import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerComponent extends StatefulWidget {
  const VideoPlayerComponent({super.key});

  @override
  State<VideoPlayerComponent> createState() => _VideoPlayerComponentState();
}

class _VideoPlayerComponentState extends State<VideoPlayerComponent> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"));

    loadVideo();
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: false);
    setState(() {});
  }

  Future<void> loadVideo() async {
    await videoPlayerController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AspectRatio(
        aspectRatio: videoPlayerController.value.aspectRatio,
        child: Chewie(controller: chewieController),
      ),
    );
  }
}
