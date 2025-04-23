import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imvs/presentation/pages/about_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  static const String routeName = "/SettingsPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('సెట్టింగులు'),
        backgroundColor: Colors.brown.shade100,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          const ListTile(
            leading: Icon(Icons.language),
            title: Text('భాష'),
            subtitle: Text('తెలుగు (మూలం)'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const Divider(),

          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text('రాత్రి మోడ్'),
            value: false, // Replace with theme controller logic if needed
            onChanged: (bool value) {
              // Handle dark mode toggle
              // e.g., ThemeController.to.toggleTheme();
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.star_rate_rounded),
            title: const Text('రేట్ చేయండి'),
            onTap: () {
              // Launch Play Store / App Store URL
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.feedback_rounded),
            title: const Text('అభిప్రాయం ఇవ్వండి'),
            onTap: () {
              // Launch feedback form or email
            },
          ),
        ],
      ),
    );
  }
}
