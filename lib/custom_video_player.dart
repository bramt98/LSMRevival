import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
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
  late VideoPlayerController _videoPlayerController;
  late FlickManager _flickManager;
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  @override
  void didUpdateWidget(CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      _disposeControllers();
      _initController();
    }
  }

  void _initController() {
    if (widget.videoUrl.contains('youtube.com')) {
      _initYoutubeController();
    } else {
      _initFlickManager();
    }
  }

  void _initYoutubeController() {
    try {
      final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl)!;
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    } catch (e) {
      print('Error initializing YouTube controller: $e');
    }
  }

  void _initFlickManager() {
    if (widget.videoUrl.startsWith('asset')) {
      _videoPlayerController = VideoPlayerController.asset(widget.videoUrl);
    } else {
      _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    }

    _flickManager = FlickManager(
      videoPlayerController: _videoPlayerController,
    );

    _videoPlayerController.initialize().then((value) {
      setState(() {});
    });
  }

  void _disposeControllers() {
    if (_youtubeController != null) {
      _youtubeController.dispose();
    }
    if (_videoPlayerController != null) {
      _videoPlayerController.dispose();
      _flickManager.dispose();
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
        aspectRatio: 16 / 9, // Set aspect ratio here
      );
    } else {
      return ClipRect(
        child: AspectRatio(
          aspectRatio: 16 / 9, // Set maximum aspect ratio here
          child: FlickVideoPlayer(
            flickManager: _flickManager,
            key: widget.key,
          ),
        ),
      );
    }
  }
}