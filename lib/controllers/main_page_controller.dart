import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainPageController extends GetxController{

  RxBool inSearching = false.obs;
  RxString searchText = "".obs;

}