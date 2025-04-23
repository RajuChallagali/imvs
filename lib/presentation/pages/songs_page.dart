import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SongsPage extends StatelessWidget {
  const SongsPage({super.key});

  static const String routeName = "/SongsPage";

  final String title = 'దైవార్చన గీతాలు';
  final String link = 'https://sites.google.com/view/kalivela2/%E0%B0%AA%E0%B0%9C-%E0%B0%AA%E0%B0%9F%E0%B0%B2';

  Future<void> _launchURL(String url) async {
   final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.blue, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.center),
      ),
      child: Center(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.all(20),
          child: InkWell(
            onTap: () => _launchURL(link),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  const Icon(Icons.music_note, size: 40, color: Colors.deepPurple),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Icon(Icons.open_in_new, color: Colors.grey),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
