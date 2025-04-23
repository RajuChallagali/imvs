import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;
  const VideoPlayerScreen({super.key, required this.videoId});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    );
  }

  void _shareVideo() {
    final shareText = 'https://www.youtube.com/watch?v=${widget.videoId}\n🙏 Ide Mana Vishvasamu App';
    Share.share(shareText);
  }

  void _subscribe() async {
    const channelUrl = 'https://www.youtube.com/@NelloreDiocese';
    if (await canLaunchUrl(Uri.parse(channelUrl))) {
      launchUrl(Uri.parse(channelUrl), mode: LaunchMode.externalApplication);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text("Watch Video"),
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: _shareVideo),
          IconButton(icon: const Icon(Icons.subscriptions), onPressed: _subscribe),
        ],
      ),
      body: YoutubePlayerBuilder(
        player: YoutubePlayer(controller: _controller),
        builder: (context, player) {
          return Stack(
            alignment: Alignment.center,
            children: [
              player,
              // ⏪ Back 10s Button
              Positioned(
                left: 30,
                child: IconButton(
                  icon: const Icon(Icons.replay_10, color: Colors.white, size: 40),
                  onPressed: () {
                    final current = _controller.value.position;
                    _controller.seekTo(current - const Duration(seconds: 10));
                  },
                ),
              ),
              // ⏩ Forward 10s Button
              Positioned(
                right: 30,
                child: IconButton(
                  icon: const Icon(Icons.forward_10, color: Colors.white, size: 40),
                  onPressed: () {
                    final current = _controller.value.position;
                    _controller.seekTo(current + const Duration(seconds: 10));
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
