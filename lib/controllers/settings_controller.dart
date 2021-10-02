import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController{

  RxInt limitItemCount = RxInt(GetStorage().read("item_limit").toInt());

}