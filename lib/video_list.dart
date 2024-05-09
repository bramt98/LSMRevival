import 'package:flutter/material.dart';

class VideoList extends StatelessWidget {
  final ValueChanged<String> onSelect;
  final bool isVideoPlaying;
  final VoidCallback onVideoPlayingChanged;

  VideoList({required this.onSelect, required this.isVideoPlaying, required this.onVideoPlayingChanged});

  final List<Map<String, String>> videos = [
    {'title': 'Locatie Dordrecht', 'url': 'assets/locatie_dordrecht.mp4'},
    {'title': 'Locatie Roermond', 'url': 'assets/locatie_roermond.mp4'},
    {'title': 'Locatie Zoetermeer', 'url': 'assets/locatie_zoetermeer.mp4'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: videos.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(videos[index]['title']!),
          onTap: () {
            onSelect(videos[index]['url']!);
            onVideoPlayingChanged();
          },
          trailing: isVideoPlaying
              ? const Icon(Icons.play_circle_filled, color: Colors.red)
              : const Icon(Icons.play_circle_outline),
          leading: videos[index]['url']!.startsWith('assets') // Add this condition
              ? IconButton(
            icon: const Icon(Icons.local_play),
            onPressed: () {
              onSelect(videos[index]['url']!);
              onVideoPlayingChanged();
            },
          )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}