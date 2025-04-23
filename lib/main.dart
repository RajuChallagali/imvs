import 'package:flutter/material.dart';
import 'package:imvs/appinits/app.dart';
import 'package:get_storage/get_storage.dart';

void main()async {
  await GetStorage.init();
  runApp(const MyApp());
}

