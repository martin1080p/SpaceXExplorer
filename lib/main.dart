import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:space_x/alerts/settings_alert.dart';
import 'package:space_x/managers/storage_manager.dart';
import 'package:space_x/pages/main_page.dart';
import 'package:space_x/requests/api_requests.dart';

void main() async{
  await StorageManager().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpaceX Explorer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage("SpaceX Explorer"),
    );
  }
}


