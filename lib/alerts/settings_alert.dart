import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_x/controllers/settings_controller.dart';
import 'package:space_x/managers/storage_manager.dart';

// ignore: must_be_immutable
class SettingsAlert extends StatelessWidget {

  SettingsController settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Settings"),
      content: GetX<SettingsController>(builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "Limit item count"
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if(controller.limitItemCount.value > 1)
                          controller.limitItemCount--;
                      },
                    ),
                    Text(controller.limitItemCount.toString()),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        if(controller.limitItemCount.value < 50)
                          controller.limitItemCount++;
                      },
                    )
                  ],
                ),
              ),
              Divider()
            ],
          ),
        );
      }),
      actions: [
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            settingsController.limitItemCount.value = StorageManager().read("item_limit");
            Navigator.pop(context, 'Cancel');
          },
        ),
        TextButton(
          child: Text("Save"),
          onPressed: () {
            StorageManager().write("item_limit", settingsController.limitItemCount.value);
            Navigator.pop(context, 'Save');
          },
        )
      ],
    );
  }
}
