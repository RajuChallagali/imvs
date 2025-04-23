import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ApiService {
  static const String baseUrl =
      'https://script.google.com/macros/s/AKfycbwUoQASmYrgUTh-yOLFmypy0PrtQL43KouIrYxoMCR_YrCvdw_jd7K2t73za8yUKo73/exec'; // Replace with your URL

  static Future<Map<String, List<Map<String, dynamic>>>> fetchAllData() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      // Convert all sheet data into List<Map<String, dynamic>>
      Map<String, List<Map<String, dynamic>>> structuredData = {};
      jsonResponse.forEach((sheetName, data) {
        structuredData[sheetName] = List<Map<String, dynamic>>.from(data);
      });

      return structuredData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<String>> fetchBibleBooks() async {
    final res = await http.get(Uri.parse(baseUrl));
    final data = json.decode(res.body);
    final bible = List<Map<String, dynamic>>.from(data['Bible'] ?? []);

    final books = bible
        .map((e) => e['book'])
        .where((book) => book != null) // ✅ filter nulls
        .cast<String>() // ✅ safely cast
        .toSet()
        .toList();

    return books;
  }

  static Future<List<String>> fetchChapters(String book) async {
    final res = await http.get(Uri.parse(baseUrl));
    final data = json.decode(res.body);
    final bible = List<Map<String, dynamic>>.from(data['Bible'] ?? []);

    final chapters = bible
        .where((e) => e['book'] == book) // ✅ filter by selected book
        .map((e) => e['chapter'])
        .where((chapter) => chapter != null)
        .cast<String>()
        .toSet()
        .toList();

    return chapters;
  }

  static Future<List<Map<String, dynamic>>> fetchVerses(
      String book, String chapter) async {
    final res = await http.get(Uri.parse(baseUrl));
    final data = json.decode(res.body);
    final bible = List<Map<String, dynamic>>.from(data['Bible'] ?? []);
    final verses = bible
        .where((e) => e['book'] == book && e['chapter'] == chapter)
        .toList();
    return verses;
  }

  static Future<Map<String, dynamic>?> fetchDailyReading(
      DateTime selectedDate) async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      // Normalize selected date (remove time part)
      final dateOnly =
          DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

      print('today: $dateOnly');

      // Fetch only "Mass Readings" sheet
      List<Map<String, dynamic>> readings =
          List<Map<String, dynamic>>.from(jsonResponse['Bible Readings'] ?? []);
      //print('readings: $readings');
      for (var reading in readings) {
        if (reading['date'] != null) {
          try {
            DateTime sheetDate = DateTime.parse(reading['date']).toLocal();
            final sheetDateOnly =
                DateTime(sheetDate.year, sheetDate.month, sheetDate.day);

            if (sheetDateOnly == dateOnly) {
              return reading;
            }
          } catch (e) {
            print("Date parse error: $e");
          }
        }
      }

      for (var reading in readings) {
        if (reading != null && reading['date'] != null) {
          try {
            final readingDate = DateTime.parse(reading['date']);
            final cleanDate =
                DateTime(readingDate.year, readingDate.month, readingDate.day);

            if (cleanDate == dateOnly) {
              return Map<String, dynamic>.from(reading);
            }
          } catch (e) {
            print("Date parse error: $e");
          }
        }
      }

      return null;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
