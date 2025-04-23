import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:imvs/presentation/pages/verses_page.dart';
import 'package:imvs/services/api/prayer_api_service.dart';

class ChaptersPage extends StatefulWidget {
  final String bookName;

  const ChaptersPage({Key? key, required this.bookName}) : super(key: key);

  @override
  State<ChaptersPage> createState() => _ChaptersPageState();
}

class _ChaptersPageState extends State<ChaptersPage> {
  late Future<List<String>> chaptersFuture;
  final box = GetStorage();
  late String cacheKey;

  @override
  void initState() {
    super.initState();
    cacheKey = 'chapters_${widget.bookName}';
    chaptersFuture = _loadChaptersWithCache();
  }

  Future<List<String>> _loadChaptersWithCache() async {
    final cachedData = box.read<List>(cacheKey);
    if (cachedData != null && cachedData.isNotEmpty) {
      _updateCache(); // Async refresh
      return List<String>.from(cachedData);
    } else {
      return await _updateCache();
    }
  }

  Future<List<String>> _updateCache() async {
    try {
      final chapters = await ApiService.fetchChapters(widget.bookName);
      await box.write(cacheKey, chapters);
      return chapters;
    } catch (e) {
      debugPrint('Error fetching chapters: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bookName,
            style: const TextStyle(fontSize: 18, color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<String>>(
        future: chaptersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading chapters'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No chapters found'));
          }

          final chapters = snapshot.data!;
          return ListView.builder(
            itemCount: chapters.length,
            itemBuilder: (context, index) {
              final chapter = chapters[index];
              return ListTile(
                title: Text(chapter),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VersesPage(
                        book: widget.bookName,
                        chapter: chapter,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
