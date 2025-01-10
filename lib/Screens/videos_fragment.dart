import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class VideosFragment extends StatelessWidget {
  // Ganti URL di bawah ini dengan daftar video Anda
  final List<Map<String, String>> videoUrls = [
    {
      "title": "M.I.A.",
      "url": "https://youtu.be/VBev7fC_2WI?si=H_IC-RuXy9rGlSE-",
    },
    {
      "title": "Avenged Sevenfold - I Won't See You Tonight Part 1",
      "url": "https://youtu.be/oAdQzCq53XE?si=vxHzwKsJ6JusSBSG",
    },
    {
      "title": "Avenged Sevenfold - Unholy Confessions (Official Music Video)",
      "url": "https://youtu.be/vSaBveD7zvA?si=pRrvO15HOWZrs0qt",
    },
    {
      "title": "Avenged Sevenfold - Afterlife [Official Music Video]",
      "url": "https://youtu.be/HIRNdveLnJI?si=xjv2Ud-4aRAOuU4a",
    },
    {
      "title": "Avenged Sevenfold - A Little Piece Of Heaven [Official Music Video]",
      "url": "https://youtu.be/KVjBCT2Lc94?si=_0UY543UhExVsBkN",
    },
    {
      "title": "Avenged Sevenfold - Nightmare [Official Music Video]",
      "url": "https://youtu.be/94bGzWyHbu0?si=15OuY5H3ye8rDlZ3",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: videoUrls.length,
      itemBuilder: (context, index) {
        final video = videoUrls[index];
        final videoId = YoutubePlayer.convertUrlToId(video["url"]!);

        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            leading: Image.network(
              'https://img.youtube.com/vi/$videoId/0.jpg',
              width: 100,
              fit: BoxFit.cover,
            ),
            title: Text(video["title"]!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(videoUrl: video["url"]!),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;

  VideoPlayerScreen({required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    final videoId = YoutubePlayer.convertUrlToId(videoUrl)!;
    final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(autoPlay: true),
    );

    return Scaffold(
      appBar: AppBar(title: Text("Play Video")),
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
        ),
      ),
    );
  }
}
