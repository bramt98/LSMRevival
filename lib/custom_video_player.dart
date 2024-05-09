import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final Key? key;

  CustomVideoPlayer({required this.videoUrl, this.key});

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  @override
  void didUpdateWidget(CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl!= widget.videoUrl) {
      _disposeControllers();
      _initController();
    }
  }

  void _initController() {
    if (widget.videoUrl.contains('youtube.com')) {
      _initYoutubeController();
    } else if (widget.videoUrl.startsWith('assets/')) {
      _initAssetController();
    } else {
      _initNetworkController();
    }
  }

  void _initYoutubeController() {
    try {
      _youtubeController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl)!,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    } catch (e) {
      print('Error initializing YouTube controller: $e');
    }
  }

  void _initAssetController() {
    try {
      _controller = VideoPlayerController.asset(widget.videoUrl);
      _controller.initialize().then((_) {
        setState(() {});
      });
    } catch (e) {
      print('Error initializing asset controller: $e');
    }
  }

  void _initNetworkController() {
    try {
      _controller = VideoPlayerController.network(widget.videoUrl);
      _controller.initialize().then((_) {
        setState(() {});
      });
    } catch (e) {
      print('Error initializing network controller: $e');
    }
  }

  void _disposeControllers() {
    if (_youtubeController!= null) {
      _youtubeController.dispose();
    }
    if (_controller!= null) {
      _controller.dispose();
    }
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.videoUrl.contains('youtube.com')) {
      return YoutubePlayer(
        controller: _youtubeController,
        key: widget.key,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.black,
      );
    } else {
      return _controller.value.isInitialized
          ? AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      )
          : Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}