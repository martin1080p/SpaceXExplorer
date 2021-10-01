import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:space_x/controllers/limit_controller.dart';

class SettingsAlert extends StatelessWidget{

  var limitController = Get.put(LimitController());
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Settings"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: GetX<LimitController>(
              builder: (controller) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: (){
                        controller.itemCount--;
                      },
                    ),
                    Text(controller.itemCount.toString()),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: (){
                        controller.itemCount++;
                      },
                    )
                  ],
                );
              }
            ),
          )
        ],
      ),
      actions: [
        TextButton(
          child: Text(
            "Cancel"
          ),
          onPressed: () {
            limitController.itemCount.value =  GetStorage().read("item_limit");
            Navigator.pop(context, 'Cancel');
          },
        ),
        TextButton(
          child: Text(
            "Save"
          ),
          onPressed: () {
            GetStorage().write("item_limit", limitController.itemCount.value);
            print(GetStorage().read("item_limit"));
            Navigator.pop(context, 'Save');
          },
        )
      ],
    );
  }
}