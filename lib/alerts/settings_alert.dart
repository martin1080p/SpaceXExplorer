import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_x/controllers/app_controller.dart';
import 'package:space_x/managers/storage_manager.dart';

// ignore: must_be_immutable
class SettingsAlert extends StatelessWidget {
  AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return GetX<AppController>(builder: (controller) {
      return AlertDialog(
        title: Text("Settings"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text("Limit item count"),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (controller.selectedLimit.value > 7) controller.selectedLimit--;
                      },
                    ),
                    Text(controller.selectedLimit.toString()),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        if (controller.selectedLimit.value < 50) controller.selectedLimit++;
                      },
                    )
                  ],
                ),
              ),
              Divider()
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () {
              appController.selectedLimit.value = StorageManager().read("item_limit");
              Navigator.pop(context, 'Cancel');
            },
          ),
          TextButton(
            child: Text("Save"),
            onPressed: () {
              StorageManager().write("item_limit", appController.selectedLimit.value);
              appController.limitItemCount = appController.selectedLimit.value;

              appController.loadNewPage();
              Navigator.pop(context, 'Save');
            },
          )
        ],
      );
    });
  }
}
