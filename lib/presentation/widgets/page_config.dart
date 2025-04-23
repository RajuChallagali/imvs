import 'package:flutter/material.dart';
import 'package:imvs/presentation/pages/bible_page.dart';
import 'package:imvs/presentation/pages/liturgy_page.dart';
import 'package:imvs/presentation/pages/mass_page.dart';
import 'package:imvs/presentation/pages/prayers_page.dart';
import 'package:imvs/presentation/pages/songs_page.dart';
import 'package:imvs/presentation/pages/youtube_page.dart';

class PageConfig {
  final String title;
  final Color backgroundColor;
  final Widget page;

  PageConfig({
    required this.title,
    required this.backgroundColor,
    required this.page,
  });
}

final List<PageConfig> pageConfigs = [
  PageConfig(
    title: 'ప్రార్థనలు',
    backgroundColor: Colors.purple.shade50,
    page: const PrayersPage(),
  ),
  PageConfig(
    title: 'పఠనములు',
    backgroundColor: Colors.orange.shade50,
    page: const LiturgyPage(),
  ),
  PageConfig(
    title: 'దివ్యబలిపూజ',
    backgroundColor: Colors.blue.shade50,
    page: const MassPage(),
  ),
  PageConfig(
    title: 'బైబిల్',
    backgroundColor: Colors.blue.shade50,
    page: const BiblePage(),
  ),
  PageConfig(
    title: 'పాటలు',
    backgroundColor: Colors.green.shade50,
    page: const SongsPage(),
  ),
  PageConfig(
    title: 'యూట్యూబ్',
    backgroundColor: Colors.red.shade50,
    page: const YouTubePage(),
  ),
];
