import 'package:flutter/material.dart';

class VideoPlayerView extends StatefulWidget {
  final int videoIndex;
  const VideoPlayerView({Key? key, required this.videoIndex}):super(key: key);

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
