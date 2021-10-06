import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_x/managers/storage_manager.dart';
import 'package:space_x/pages/main_page.dart';

void main() async {
  await StorageManager().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SpaceX Explorer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage("SpaceX Explorer"),
    );
  }
}
