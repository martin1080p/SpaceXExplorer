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

  String sortDirection = "desc";
  String sortParameter = "flight_number";

  int limitItemCount = GetStorage().read("item_limit").toInt();

  RxInt selectedLimit = RxInt(GetStorage().read("item_limit").toInt());
  RxString selectedSortDirection = "desc".obs;
  RxString selectedSortParameter = "flight_number".obs;

  bool isLoadingNew = true;
  bool isLoadingNext = false;

  int loadedPageIndex = 0;
  bool hasNextPage = true;

  RxInt startFilterYear = 2006.obs;
  RxInt endFilterYear = (DateTime.now().year).obs;

  List<Widget> data = [];

  SpaceXRequest requestManager = SpaceXRequest();

  void doUpdate() {
    this.update();
  }

  Future<List<Launch>> fetchData(int pageNumber) async {
    var fetchResponse =
        await requestManager.basicRequest(pageNumber, limitItemCount, sortParameter, sortDirection, inSearching.value, searchText.value, startFilterYear.value, endFilterYear.value);
    if(fetchResponse == null)
      return [];

    if (fetchResponse.statusCode == 200) {
      List<Launch> launchTempList = [];
      var results = jsonDecode(fetchResponse.body);
      hasNextPage = results['hasNextPage'];

      for (var result in results["docs"]) {
        launchTempList.add(Launch.fromJson(result));
      }

      return launchTempList;
    }
    hasNextPage = false;
    return [];
  }

  void loadNextPage() async{
    if(!hasNextPage)
      return;
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
