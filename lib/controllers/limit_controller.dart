import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LimitController extends GetxController{

  RxInt itemCount = RxInt(GetStorage().read("item_limit").toInt());

}