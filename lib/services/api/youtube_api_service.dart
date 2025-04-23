import 'dart:convert';
import 'package:http/http.dart' as http;

class YouTubeService {
  static const String apiKey = 'AIzaSyA0PWt_-Gp8whoeqVAjkCESJuJBYRDkh34';
  static const String channelId = 'UCPFElILgi54QXR-dwQ4I3aw';

  static Future<List<Map<String, dynamic>>> fetchVideos() async {
  final url =
      'https://www.googleapis.com/youtube/v3/search?key=$apiKey&channelId=$channelId&part=snippet,id&order=date&maxResults=10';

  final res = await http.get(Uri.parse(url));
  final data = json.decode(res.body);

  final List<Map<String, dynamic>> videos = [];

  for (var item in data['items']) {
    // Skip non-video items
    if (item['id']['kind'] != 'youtube#video') continue;

    videos.add({
      'title': item['snippet']['title'] ?? 'No Title',
      'thumbnail': item['snippet']['thumbnails']['high']['url'] ?? '',
      'videoId': item['id']['videoId'] ?? '',
      'publishedAt': item['snippet']['publishedAt'] ?? '',
    });
  }

  return videos;
}

}
