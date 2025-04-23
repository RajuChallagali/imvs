import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:imvs/services/api/prayer_api_service.dart';

class VersesPage extends StatefulWidget {
  final String book;
  final String chapter;

  const VersesPage({
    Key? key,
    required this.book,
    required this.chapter,
  }) : super(key: key);

  @override
  State<VersesPage> createState() => _VersesPageState();
}

class _VersesPageState extends State<VersesPage> {
  late Future<List<Map<String, dynamic>>> versesFuture;
  final box = GetStorage();
  late String cacheKey;

  @override
  void initState() {
    super.initState();
    cacheKey = 'verses_${widget.book}_${widget.chapter}';
    versesFuture = _loadVersesWithCache();
  }

  Future<List<Map<String, dynamic>>> _loadVersesWithCache() async {
    final cachedData = box.read<List>(cacheKey);
    if (cachedData != null && cachedData.isNotEmpty) {
      _updateCache(); // Background refresh
      return List<Map<String, dynamic>>.from(cachedData);
    } else {
      return await _updateCache();
    }
  }

  Future<List<Map<String, dynamic>>> _updateCache() async {
    try {
      final verses = await ApiService.fetchVerses(widget.book, widget.chapter);
      await box.write(cacheKey, verses);
      return verses;
    } catch (e) {
      debugPrint('Error fetching verses: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.book} - ${widget.chapter}',
            style: const TextStyle(fontSize: 18, color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: versesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading verses'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No verses found'));
          }

          final verses = snapshot.data!;
          return ListView.separated(
            itemCount: verses.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final v = verses[index];
              return ListTile(
                
                title: Text('${v['verse'] ?? ""}'),
              );
            },
          );
        },
      ),
    );
  }
}
