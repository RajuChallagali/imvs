import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imvs/presentation/pages/home_page.dart';
import 'package:imvs/presentation/pages/introPage.dart';
import 'package:imvs/services/api/prayer_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, this.title});
  static const String routeName = "/SplashPage";

  final String? title;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
 
  @override

  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed(IntroPage.routeName);
    });
  }
  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/imvsAppLogo.png',
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: 20),
                const Text(
                  'ఇదే మన విశ్వాసం',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                /*if (_loading)
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.brown),
                ),*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}
