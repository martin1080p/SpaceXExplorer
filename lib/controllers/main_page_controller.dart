import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainPageController extends GetxController{

  

  RxBool inSearching = false.obs;
  RxString searchText = "".obs;

  RxString sortDirection = "asc".obs;
  RxString sortParameter = "flight_number".obs;

  RxInt limitItemCount = RxInt(GetStorage().read("item_limit").toInt());


  RxInt selectedLimit = RxInt(GetStorage().read("item_limit").toInt());
  RxString selectedSortDirection = "asc".obs;
  RxString selectedSortParameter = "flight_number".obs;
}