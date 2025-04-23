import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl; // Pass the audio file URL or asset path

  const AudioPlayerWidget({super.key, required this.audioUrl});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _audioPlayer;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    _init();

    // Listen to position changes
    _audioPlayer.positionStream.listen((pos) {
      setState(() {
        _position = pos;
      });
    });

    // Listen to duration changes
    _audioPlayer.durationStream.listen((dur) {
      setState(() {
        _duration = dur ?? Duration.zero;
      });
    });

    // Listen to player state changes
    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.completed) {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
      setState(() {
        _isPlaying = isPlaying;
      });
    });
  }

  Future<void> _init() async {
    try {
      await _audioPlayer.setUrl(widget.audioUrl);
    } catch (e) {
      print('Error loading audio source: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              iconSize: 48,
              icon: Icon(
                _isPlaying
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_filled,
                color: Colors.deepPurple,
              ),
              onPressed: () {
                if (_isPlaying) {
                  _audioPlayer.pause();
                } else {
                  _audioPlayer.play();
                }
              },
            ),
            // Slider

            Slider(
              activeColor: Colors.deepPurple,
              inactiveColor: Colors.grey.shade300,
              min: 0,
              max: _duration.inSeconds.toDouble(),
              value:
                  _position.inSeconds.clamp(0, _duration.inSeconds).toDouble(),
              onChanged: (value) {
                final position = Duration(seconds: value.toInt());
                _audioPlayer.seek(position);
              },
            ),
            // Time display
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatDuration(_position)),
                Text(_formatDuration(_duration)),
              ],
            ),

            const SizedBox(height: 2),

            // Play/Pause button
          ],
        ),
      ),
    );
  }
}
