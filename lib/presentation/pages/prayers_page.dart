import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:imvs/data/model/prayer.dart';
import 'package:imvs/services/api/prayer_api_service.dart';

class PrayersPage extends StatefulWidget {
  const PrayersPage({super.key});
  static const String routeName = "/PrayersPage";

  @override
  State<PrayersPage> createState() => _PrayersPageState();
}

class _PrayersPageState extends State<PrayersPage> {
  
  late Future<List<Map<String, dynamic>>> prayersData;
  final box = GetStorage();
  final String cacheKey = 'cached_prayers';

  @override
  initState() {
    super.initState();
    prayersData = _fetchPrayersWithCache();
  }

  Future<List<Map<String, dynamic>>> _fetchPrayersWithCache() async {
    // Load from cache first
    List<Map<String, dynamic>>? cachedPrayers =
        (box.read(cacheKey) as List?)?.cast<Map<String, dynamic>>();

    // Start with cached if available
    if (cachedPrayers != null && cachedPrayers.isNotEmpty) {
      // Fetch updated data in background
      _fetchAndUpdateCache();
      return cachedPrayers;
    }

    // If no cache, fetch directly
    return await _fetchAndUpdateCache();
  }

  Future<List<Map<String, dynamic>>> _fetchAndUpdateCache() async {
    try {
      final allData = await ApiService.fetchAllData();
      final prayers = allData['Prayers'] ?? [];
      await box.write(cacheKey, prayers);
      return prayers;
    } catch (e) {
      debugPrint("Error fetching prayers: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: LinearGradient(colors:[ Colors.yellow, Colors.white], begin: Alignment.topCenter, end: Alignment.center),),
      child: Center(
        
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: prayersData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //List<Prayer> prayers = snapshot.data!;
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var prayer = snapshot.data![index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      leading: const Icon(Icons.bookmark, color: Colors.deepPurple),
                      title: Text(prayer['title'], style: const TextStyle(fontSize: 18)),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrayerDetailPage(
                              title: prayer['title'],
                              content: prayer['description'],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
             
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const CircularProgressIndicator();
          },
        ), 
        /*return ListView.builder(
          itemCount: prayers.length,
          itemBuilder: (context, index) {
            final prayer = prayers[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: const Icon(Icons.bookmark, color: Colors.deepPurple),
                title: Text(prayer['title']!, style: const TextStyle(fontSize: 18)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrayerDetailPage(
                        title: prayer['title']!,
                        content: prayer['content']!,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),*/
      ),
    );
  }
}

class PrayerDetailPage extends StatelessWidget {
  final String title;
  final String content;

  const PrayerDetailPage({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontSize: 18, color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            content,
            style: const TextStyle(fontSize: 18, height: 1.5),
          ),
        ),
      ),
    );
  }
}