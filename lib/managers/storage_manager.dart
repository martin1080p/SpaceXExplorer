
import 'package:get_storage/get_storage.dart';

class StorageManager{

  init() async{
    await GetStorage.init();
  

    if(this.read("item_limit") == null)
      this.write("item_limit", 10);
    if(this.read("sort_direction") == null)
      this.write("sort_direction", "asc");
    if(this.read("sort_parameter") == null)
      this.write("sort_parameter", "flight_number");

  }

  read(String key){
    return GetStorage().read(key);
  }

  write(String key, var value){
    GetStorage().write(key, value);
  }
}