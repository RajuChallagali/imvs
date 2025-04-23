import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:imvs/services/api/prayer_api_service.dart';
import 'package:intl/intl.dart';

class LiturgyPage extends StatefulWidget {
  const LiturgyPage({super.key});
  static const String routeName = "/LiturgyPage";

  @override
  State<LiturgyPage> createState() => _LiturgyPageState();
}

class _LiturgyPageState extends State<LiturgyPage> {
  late Future<Map<String, dynamic>?> dailyReading;
  DateTime selectedDate = DateTime.now();
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    _loadReadingForDate(selectedDate);
  }

  void _loadReadingForDate(DateTime date) {
  final String formattedDate = DateFormat('yyyy-MM-dd').format(date);
  final String cacheKey = 'dailyReading_$formattedDate';

  setState(() {
    // Check cache first
    if (box.hasData(cacheKey)) {
      dailyReading = Future.value(box.read(cacheKey));
      // Still fetch in background and update cache if changed
      _updateReadingCache(formattedDate, cacheKey);
    } else {
      // Fetch and cache if not available
      dailyReading = _updateReadingCache(formattedDate, cacheKey);
    }
  });
}

Future<Map<String, dynamic>?> _updateReadingCache(String formattedDate, String cacheKey) async {
  try {
    final freshData = await ApiService.fetchDailyReading(DateTime.parse(formattedDate));
    if (freshData != null) {
      await box.write(cacheKey, freshData);
    }
    return freshData;
  } catch (e) {
    debugPrint("Error fetching reading: $e");
    return null;
  }
}

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      _loadReadingForDate(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.center,
        ),
      ),
      child: FutureBuilder<Map<String, dynamic>?>(
        future: dailyReading,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final reading = snapshot.data!;
            final date = DateFormat.yMMMMEEEEd().format(selectedDate);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: [
                    // Header Card
                    ElevatedButton.icon(
                      icon: const Icon(Icons.calendar_today),
                      label: const Text("Select Date"),
                      onPressed: () => _pickDate(context),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(date,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 6),
                            Text(reading['Description of The Day'] ?? '',
                                style: const TextStyle(fontSize: 16)),
                            const SizedBox(height: 4),
                            Text(
                              "Liturgical Color: ${reading['liturgyColor'] ?? 'N/A'}",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Dynamically display available readings
                    if ((reading['1st-Rd-Description'] ?? '').isNotEmpty)
                      _buildReadingCard(
                        title: "మొదటి పఠనము",
                        intro: reading['1st-Rd-Intro'],
                        reference: reading['1st-Rd-citation'],
                        content: reading['1st-Rd-Description'],
                        greeting: 'ఒ: ఇది ప్రభువు వాక్కు',
                        thanks: 'అం: సర్వేశ్వరునికి వందనములు',
                      ),
                    if ((reading['Response'] ?? '').isNotEmpty)
                      _buildResponseCard(
                        title: "ప్రత్యుత్తర గీతం",
                        reference: reading['Psalm citation'],
                        response: reading['Response'],
                        content: [
                          reading['1st Verse'],
                          SizedBox(height: 4),
                          reading['2nd Verse'],
                          SizedBox(height: 4),
                          reading['3rd Verse'],
                          SizedBox(height: 4),
                          reading['4th Verse'],
                        ].whereType<String>().join('\n'),
                      ),
                    if ((reading['2nd-Rdg-Description'] ?? '').isNotEmpty)
                      _buildReadingCard(
                        title: "రెండవ పఠనము",
                        intro: reading['2nd-Rdg-Text'],
                        reference: reading['2nd-Rdg-Verse'],
                        content: reading['2nd-Rdg-Description'],
                        greeting: 'ఒ: ఇది ప్రభువు వాక్కు',
                        thanks: 'అం: సర్వేశ్వరునికి వందనములు',
                      ),
                    if ((reading['Acclamation'] ?? '').isNotEmpty)
                      _buildAcclamationCard(
                        title: "అల్లెలూయ వచనము",
                        reference: reading['Acclamation-citation'],
                        content: reading['Acclamation'],
                      ),
                    if ((reading['Gospel Description'] ?? '').isNotEmpty)
                      _buildGospelCard(
                        title: "సువిశేష పఠనము",
                        intro: reading['Gospel Intro'],
                        reference: reading['Gospel Verse'],
                        content: reading['Gospel Description'],
                        greeting: "గు: ఇది క్రీస్తు సువిశేషము",
                        thanks: "అం: క్రీస్తువా! మీకు స్తుతి కలుగును గాక", 
                      ),
                  ],
                ),
              ),
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

  Widget _buildReadingCard({
    required String title,
    required String? intro,
    required String? reference,
    required String? content,
    required String greeting,
    required String thanks,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            if (intro != null && intro.isNotEmpty)
              Text(intro,
                  style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.black)),
            if (reference != null && reference.isNotEmpty)
              Text(reference,
                  style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 10),
            Text(content ?? '',
                style: const TextStyle(fontSize: 16, height: 1.5)),
            const SizedBox(height: 10),
            Text(greeting,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const SizedBox(height: 4),
            Text(thanks,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget _buildResponseCard({
    required String title,
    required String? reference,
    required String? response,
    required String? content,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            if (reference != null && reference.isNotEmpty)
              Text(reference ?? '',
                  style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 10),
            Text(response ?? '',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const SizedBox(height: 4),
            Text(content ?? '',
                style: const TextStyle(fontSize: 16, height: 1.5)),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildAcclamationCard({
    required String title,
    required String? reference,
    required String? content,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            if (reference != null && reference.isNotEmpty)
              Text(reference ?? '',
                  style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 10),
            Text(content ?? '',
                style: const TextStyle(fontSize: 16, height: 1.5)),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildGospelCard({
    required String title,
    required String? intro,
    required String? reference,
    required String? content,
    required String greeting,
    required String thanks,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            if (intro != null && intro.isNotEmpty)
              Text(intro,
                  style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.black)),
              const SizedBox(height: 4),    
            if (reference != null && reference.isNotEmpty)
              Text(reference,
                  style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 10),
            Text(content ?? '',
                style: const TextStyle(fontSize: 16, height: 1.5)),
            const SizedBox(height: 10),
            Text(greeting,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const SizedBox(height: 4),
            Text(thanks,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
