import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:imvs/services/api/prayer_api_service.dart';
import 'package:intl/intl.dart';

class MassPage extends StatefulWidget {
  const MassPage({super.key});

  static const String routeName = "/MassPage";

  @override
  State<MassPage> createState() => _MassPageState();
}

class _MassPageState extends State<MassPage> {
  final storage = GetStorage();
  String selectedItemKey = 'కృతజ్ఞతా ప్రార్థన-1';
  String selectedCreedKey = 'నీసెయా విశ్వాస ప్రమాణము';
  late Future<Map<String, dynamic>?> massToday;
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    _loadReadingForDate(selectedDate);
  }

  void _loadReadingForDate(DateTime date) {
  final key = DateFormat('yyyy-MM-dd').format(date);

  final cached = storage.read<Map<String, dynamic>>(key);

  if (cached != null) {
    setState(() {
      massToday = Future.value(cached);
    });
  } else {
    setState(() {
      massToday = ApiService.fetchDailyReading(date).then((data) {
        if (data != null) {
          storage.write(key, data); // Save to local cache
        }
        return data;
      });
    });
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

  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.cyan, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.center,
        ),
      ),
      child: FutureBuilder<Map<String, dynamic>?>(
        future: massToday,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final mass = snapshot.data!;
            final formattedDate = DateFormat.yMMMMEEEEd().format(selectedDate);

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
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(formattedDate,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 6),
                            Text(mass['Description of The Day'] ?? '',
                                style: const TextStyle(fontSize: 16)),
                            const SizedBox(height: 4),
                            Text(
                              "Liturgical Color: ${mass['liturgyColor'] ?? 'N/A'}",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Dynamically display available prayers for mass
                    if ((mass['Entrance Antiphon'] ?? '').isNotEmpty)
                      _buildPrayerCard(
                        title: "ప్రవేశ వచనము",
                        content: mass['Entrance Antiphon'],
                      ),
                    if ((mass['Introductory Rites'] ?? '').isNotEmpty)
                      _buildPrayerCard(
                        title: "ప్రారంభ క్రమము",
                        content: mass['Introductory Rites'],
                      ),
                    if ((mass['Gloria'] ?? '').isNotEmpty)
                      _buildPrayerCard(
                        title: "గ్లోరియా",
                        content: mass['Gloria'],
                      ),
                    if ((mass['Collect'] ?? '').isNotEmpty)
                      _buildPrayerCard(
                        title: "సంఘ ప్రార్థన",
                        content: mass['Collect'],
                      ),
                    _buildPrayerCard(
                        title: 'దైవ వాక్యార్చన', content: 'దైవ వాక్య పఠనములు'),

                    if ((mass['N-Creed-Prayer'] ?? '').isNotEmpty)
                      buildDropdownCreedCard(
                        title: "విశ్వాస ప్రమాణము",
                        selectedValue: selectedCreedKey,
                        items: {
                          'నీసెయా విశ్వాస ప్రమాణము': mass['N-Creed-Prayer'],
                          'అపోస్తలుల విశ్వాస ప్రమాణము': mass['A-Creed-Prayer'],
                        },
                        onChanged: (value) {
                          setState(() {
                            selectedCreedKey = value!;
                          });
                        },
                      ),

                    if ((mass['Pr-of-Faithful'] ?? '').isNotEmpty)
                      _buildPrayerCard(
                        title: "విశ్వాసుల ప్రార్థన",
                        content: mass['Pr-of-Faithful'],
                      ),

                    if ((mass['Offertory'] ?? '').isNotEmpty)
                      _buildPrayerCard(
                        title: "కృతజ్ఞతార్చన",
                        content: mass['Offertory'],
                      ),

                    if ((mass['Pr-Offerings'] ?? '').isNotEmpty)
                      _buildPrayerCard(
                        title: "అర్పణలపై ప్రార్థన",
                        content: mass['Pr-Offerings'],
                      ),
                    if ((mass['Preface'] ?? '').isNotEmpty)
                      _buildPrayerCard(
                        title: "స్తుతిగీతము",
                        content: mass['Preface'],
                      ),
                    if ((mass['Preface'] ?? '').isNotEmpty)
                      buildDropdownCard(
                        title: "కృతజ్ఞతా ప్రార్థన",
                        selectedValue: selectedItemKey,
                        items: {
                          'కృతజ్ఞతా ప్రార్థన-1': mass['Euch-Pr-I'],
                          'కృతజ్ఞతా ప్రార్థన-2': mass['Euch-Pr-II'],
                          'కృతజ్ఞతా ప్రార్థన-3': mass['Euch-Pr-III'],
                          'కృతజ్ఞతా ప్రార్థన-3 Old': mass['Euch-Pr-III (Old)'],
                          'కృతజ్ఞతా ప్రార్థన-4': mass['Euch-Pr-IV'],
                        },
                        onChanged: (value) {
                          setState(() {
                            selectedItemKey = value!;
                          });
                        },
                      ),

                    if ((mass['The Communion Rite'] ?? '').isNotEmpty)
                      _buildPrayerCard(
                        title: "సత్ప్రసాద క్రమము",
                        content: mass['The Communion Rite'],
                      ),
                    if ((mass['Communion Antiphon'] ?? '').isNotEmpty)
                      _buildPrayerCard(
                        title: "సత్ప్రసాద వచనము",
                        content: mass['Communion Antiphon'],
                      ),
                    if ((mass['After Communion'] ?? '').isNotEmpty)
                      _buildPrayerCard(
                        title: "సత్ప్రసాద స్వీకరణానంతర ప్రార్థన",
                        content: mass['After Communion'],
                      ),
                    if ((mass['Concluding Rites'] ?? '').isNotEmpty)
                      _buildBlessingsCard(
                        title: "ముగింపు క్రమము",
                        content: mass['Concluding Rites'],
                        blessing: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'ప్రజలపై ఆశీర్వచనము\n' ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              TextSpan(
                                text: mass['Blessings'] ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        dismissal: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: "Dismissal\n",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              TextSpan(
                                text: mass['Dismissal'] ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
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

  Widget _buildPrayerCard({
    required String? title,
    required String? content,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? '',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              content ?? '',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlessingsCard({
    required String? title,
    required String? content,
    required Widget blessing,
    required Widget dismissal,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? '',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              content ?? '',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            blessing,
            const SizedBox(height: 8),
            dismissal,
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget buildDropdownCard({
    required String title,
    required String selectedValue,
    required Map<String, String> items,
    required void Function(String?) onChanged,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedValue,
              isExpanded: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              items: items.entries.map((entry) {
                final key = entry.key;
                final item = entry.value;
                final content = entry.key;

                final fisrtLine = content.trim().split('\n').first;
                print('First line: $fisrtLine');
                return DropdownMenuItem<String>(
                  value: key,
                  child: Text(fisrtLine),
                );
              }).toList(),
              onChanged: onChanged,
            ),
            const SizedBox(height: 20),
            Text(
              items[selectedValue] ?? '',
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDropdownCreedCard({
    required String title,
    required String selectedValue,
    required Map<String, String> items,
    required void Function(String?) onChanged,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedValue,
              isExpanded: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              items: items.entries.map((entry) {
                final key = entry.key;
                final item = entry.value;
                final content = entry.key;

                final fisrtLine = content.trim().split('\n').first;
                print('First line: $fisrtLine');
                return DropdownMenuItem<String>(
                  value: key,
                  child: Text(fisrtLine),
                );
              }).toList(),
              onChanged: onChanged,
            ),
            const SizedBox(height: 20),
            Text(
              items[selectedValue] ?? '',
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
