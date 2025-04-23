import 'package:flutter/material.dart';
import 'package:imvs/presentation/widgets/audioPlayer.dart';

import 'package:just_audio/just_audio.dart';

class SongLyricsPage extends StatelessWidget {
  final String title;
  final String lyrics;

  const SongLyricsPage({Key? key, required this.title, required this.lyrics})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        AudioPlayerWidget(
           audioUrl: 'nmm',
        ),
      ],
      appBar: AppBar(
     
        title: Text(title),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            child: Text(
              lyrics,
              style: const TextStyle(
                fontSize: 18,
                height: 1.6,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
