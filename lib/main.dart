import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:space_x/alerts/settings_alert.dart';
import 'package:space_x/controllers/storage_controller.dart';
import 'package:space_x/requests/api_requests.dart';

void main() async{
  await initializeStorage();
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
      home: HomePage("SpaceX Explorer"),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;

  HomePage(this.title);

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.settings
            ),
            onPressed: (){
              showDialog(
                context: context,
                builder: (BuildContext context){
                  return SettingsAlert();
                }
              );
            },
          ),
          title: Text(title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Test',
              ),
            ],
          ),
        ),
        floatingActionButton:
            FloatingActionButton(
              onPressed: () {
                //SpaceXRequest().searchRequest("crs 20");
                print(GetStorage().read("slider"));
              },
              tooltip: 'Increment',
              child: Icon(Icons.add),
            )
          ,
      );
  }
}
