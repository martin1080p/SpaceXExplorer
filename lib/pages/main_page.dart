import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_x/alerts/settings_alert.dart';
import 'package:space_x/alerts/sort_alert.dart';
import 'package:space_x/controllers/main_page_controller.dart';
import 'package:space_x/managers/storage_manager.dart';

// ignore: must_be_immutable
class MainPage extends StatelessWidget {
  final String title;

  MainPage(this.title);

  MainPageController mainPageController = Get.put(MainPageController());

  @override
  Widget build(BuildContext context) {
    return GetX<MainPageController>(
      builder: (controller) {
        return Scaffold(
          appBar: controller.inSearching.value ? _appBarSearch(context) : _appBarIdle(context, this.title),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '',
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              //SpaceXRequest().searchRequest("crs 20");
              print(StorageManager().read('item_limit'));
            },
            child: Icon(Icons.add),
          ),
        );
      }
    );
  }

  PreferredSizeWidget _appBarIdle(BuildContext context, String title) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return SettingsAlert();
              });
        },
      ),
      title: Text(title),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            mainPageController.inSearching.value = true;
          },
        ),
        _filterWidget(context)
      ],
    );
  }

  PreferredSizeWidget _appBarSearch(BuildContext context) {
    String searchText = "";
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          mainPageController.inSearching.value = false;
        },
      ),
      title: TextField(
        autofocus: true,
        onChanged: (text){
          searchText = text;
        },
        onSubmitted: (text){
          mainPageController.searchText.value = searchText;
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            mainPageController.searchText.value = searchText;
            FocusScope.of(context).unfocus();
          },
        ),
        _filterWidget(context)
      ],
    );
  }

  Widget _filterWidget(context){
    return IconButton(
      icon: Icon(Icons.filter_list),
      onPressed: (){
        showDialog(
          context: context,
          builder: (BuildContext context){
            return SortAlert();
          }
        );
      }
    );
  }
}
