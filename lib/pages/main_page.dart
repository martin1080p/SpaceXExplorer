import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_x/alerts/settings_alert.dart';
import 'package:space_x/alerts/sort_alert.dart';
import 'package:space_x/controllers/app_controller.dart';
import 'package:space_x/elements/launch_view_list.dart';
import 'package:space_x/requests/api_requests.dart';
import 'package:space_x/managers/storage_manager.dart';

// ignore: must_be_immutable
class MainPage extends StatelessWidget {
  final String title;

  MainPage(this.title);

  AppController appController = Get.put(AppController());

  SpaceXRequest request = SpaceXRequest();

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return GetX<AppController>(builder: (controller) {
          return Scaffold(
                appBar: controller.inSearching.value ? _appBarSearch(context) : _appBarIdle(context, this.title),
                body: Container(
                  alignment: Alignment.topCenter,
                  child: LaunchViewList(),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    //SpaceXRequest().searchRequest("crs 20");
                    controller.loadNextPage();
                    print("loaded next page");
                  },
                  child: Icon(Icons.add),
                ),
              );
            
        });
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
            appController.inSearching.value = true;
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
          appController.inSearching.value = false;
          appController.loadNewPage();
        },
      ),
      title: TextField(
        autofocus: true,
        onChanged: (text) {
          searchText = text;
        },
        onSubmitted: (text) {
          appController.searchText.value = searchText;
          appController.loadNewPage();
          FocusScope.of(context).unfocus();
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            appController.searchText.value = searchText;
            appController.loadNewPage();
            FocusScope.of(context).unfocus();
          },
        ),
        _filterWidget(context)
      ],
    );
  }

  Widget _filterWidget(context) {
    return IconButton(
        icon: Icon(Icons.filter_list),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return SortAlert();
              });
        });
  }
}
