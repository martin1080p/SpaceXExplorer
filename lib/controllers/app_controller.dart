import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:space_x/classes/launch.dart';
import 'package:space_x/elements/launch_view_list.dart';
import 'package:space_x/requests/api_requests.dart';

class AppController extends GetxController {
  RxBool inSearching = false.obs;
  RxString searchText = "".obs;

  String sortDirection = "asc";
  String sortParameter = "flight_number";

  int limitItemCount = GetStorage().read("item_limit").toInt();

  RxInt selectedLimit = RxInt(GetStorage().read("item_limit").toInt());
  RxString selectedSortDirection = "asc".obs;
  RxString selectedSortParameter = "flight_number".obs;

  bool isLoadingNew = true;
  bool isLoadingNext = false;

  int loadedPageIndex = 0;

  List<Widget> data = [];

  void doUpdate() {
    this.update();
  }

  Future<List<Launch>> fetchData(int pageNumber) async {
    var fetchResponse =
        await SpaceXRequest().basicRequest(pageNumber, limitItemCount, sortParameter, sortDirection, inSearching.value, searchText.value);
    if (fetchResponse.statusCode == 200) {
      List<Launch> launchTempList = [];
      var results = jsonDecode(fetchResponse.body)["docs"];

      for (var result in results) {
        launchTempList.add(Launch.fromJson(result));
      }

      return launchTempList;
    }
    return [];
  }

  void loadNextPage() async{
    isLoadingNext = true;
    doUpdate();
    loadedPageIndex++;
    data.addAll(await fetchData(loadedPageIndex));
    isLoadingNext = false;
    doUpdate();
  }

  void loadNewPage() async{
    isLoadingNew = true;
    loadedPageIndex = 1;
    doUpdate();
    data = await fetchData(loadedPageIndex);
    isLoadingNew = false;
    doUpdate();
  }
}
