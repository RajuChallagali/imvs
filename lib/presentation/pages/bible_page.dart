import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:imvs/presentation/pages/chapters_page.dart';
import 'package:imvs/services/api/prayer_api_service.dart';

class BiblePage extends StatelessWidget {
  const BiblePage({super.key});
  static const String routeName = "/BiblePage";

  Future<List<String>> _loadBibleBooks() async {
    final storage = GetStorage();
    final cachedBooks = storage.read<List>('bible_books');
    if (cachedBooks != null && cachedBooks.isNotEmpty) {
      return List<String>.from(cachedBooks);
    } else {
      final books = await ApiService.fetchBibleBooks();
      await storage.write('bible_books', books);
      return books;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.brown, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.center,
        ),
      ),
      child: FutureBuilder<List<String>>(
        future: _loadBibleBooks(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final books = snapshot.data!;
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: const Icon(Icons.book, color: Colors.deepPurple),
                    title: Text(books[index], style: const TextStyle(fontSize: 18)),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChaptersPage(bookName: books[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
