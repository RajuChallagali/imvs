import 'package:flutter/material.dart';
import 'package:imvs/presentation/pages/video_player_page.dart';
import 'package:imvs/services/api/youtube_api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePage extends StatelessWidget {
  const YouTubePage({super.key});
  static const String routeName = "/YouTubePage";
  static const String channelUrl = 'https://www.youtube.com/@NelloreDiocese';

  void _showVideoPlayer(BuildContext context, String videoId) {
    final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.red,
                ),
              ),
            ),
            // Subscribe Button
            Positioned(
              top: 10,
              right: 10,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                ),
                onPressed: () => launchUrl(Uri.parse(channelUrl)),
                icon: const Icon(Icons.subscriptions,
                    size: 18, color: Colors.white),
                label: const Text('Subscribe',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            // Share Button
            Positioned(
              bottom: 10,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {
                  final shareText =
                      'https://www.youtube.com/watch?v=$videoId\n🙏 Ide Mana Vishvasamu App';
                  Share.share(shareText);
                },
              ),
            ),
            // Close Button
            Positioned(
              bottom: 10,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  _controller.pause();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.redAccent, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: YouTubeService.fetchVideos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.error_outline, size: 48, color: Colors.red),
                  SizedBox(height: 8),
                  Text('వీడియోలను లోడ్ చేయలేకపోయాం',
                      style: TextStyle(fontSize: 16)),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('వీడియోలు లేవు'));
          }

          final videos = snapshot.data!;
          return ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              return Card(
                elevation: 4,
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            VideoPlayerScreen(videoId: video['videoId']),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16)),
                        child: CachedNetworkImage(
                          imageUrl: video['thumbnail'],
                          placeholder: (context, url) => Container(
                            height: 200,
                            width: double.infinity,
                            color: Colors.grey.shade300,
                            child: const Center(
                                child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) => Container(
                            height: 200,
                            width: double.infinity,
                            color: Colors.grey.shade200,
                            child: const Icon(Icons.error, size: 40),
                          ),
                          imageBuilder: (context, imageProvider) => Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              video['title'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "తేదీ: ${video['publishedAt'].toString().substring(0, 10)}",
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
