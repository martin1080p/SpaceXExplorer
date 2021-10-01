import 'package:get_storage/get_storage.dart';

initializeStorage() async{
  await GetStorage.init();

  final storage = GetStorage();

  const String itemLimitName = "item_limit"; 
  const int itemLimitDefault = 10;

  if(storage.read(itemLimitName) == null){
    storage.write(itemLimitName, itemLimitDefault);
  }
}