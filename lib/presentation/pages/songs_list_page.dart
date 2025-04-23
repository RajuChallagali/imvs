import 'package:flutter/material.dart';
import 'song_lyrics_page.dart';

class SongsListPage extends StatelessWidget {
  final String category;

  SongsListPage({Key? key, required this.category}) : super(key: key);

  // Mock data for songs in categories
  final Map<String, List<Map<String, String>>> songsByCategory = {
    'ఆదివారం పాటలు': [
      {'title': 'ఆదివారం గీతం 1', 'lyrics': 'ఆదివారం గీతం 1 సాహిత్యం...'},
      {'title': 'ఆదివారం గీతం 2', 'lyrics': 'ఆదివారం గీతం 2 సాహిత్యం...'},
    ],
    'పూజ పాటలు': [
      {'title': 'పూజ పాట 1', 'lyrics': 'పూజ పాట 1 సాహిత్యం...'},
      {'title': 'పూజ పాట 2', 'lyrics': 'పూజ పాట 2 సాహిత్యం...'},
    ],
    'ఆరాధనా పాటలు': [
      {'title': 'ఆరాధనా పాట 1', 'lyrics': 'ఆరాధనా పాట 1 సాహిత్యం...'},
    ],
    'ఆశీర్వాద గీతాలు': [
      {'title': 'ఆశీర్వాద గీతం 1', 'lyrics': 'ప్రభువా ఆశీర్వాదించు...'},
    ],
    'క్రిస్మస్ పాటలు': [
      {'title': 'క్రిస్మస్ గీతం 1', 'lyrics': 'క్రిస్మస్ శుభాకాంక్షలు...'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> songs = songsByCategory[category] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        backgroundColor: Colors.deepPurple,
      ),
      body: songs.isEmpty
          ? const Center(child: Text('పాటలు లేవు!', style: TextStyle(fontSize: 18)))
          : ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final song = songs[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: const Icon(Icons.music_note, color: Colors.deepPurple),
                    title: Text(song['title']!, style: const TextStyle(fontSize: 18)),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SongLyricsPage(
                            title: song['title']!,
                            lyrics: song['lyrics']!,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
