import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_x/controllers/sort_controller.dart';
import 'package:space_x/managers/storage_manager.dart';

// ignore: must_be_immutable
class SortAlert extends StatelessWidget {

  SortController sortController = Get.put(SortController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: GetX<SortController>(builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Choose sort direction",
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text("Ascending"),
                      Radio<String>(
                        value: "asc",
                        groupValue: controller.sortDirection.value,
                        onChanged: (val) {
                          controller.sortDirection.value = val.toString();
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Descending"),
                      Radio<String>(
                        value: "desc",
                        groupValue: controller.sortDirection.value,
                        onChanged: (val) {
                          controller.sortDirection.value = val.toString();
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                thickness: 2,
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Choose sort parameter",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Flight number"),
                      Radio<String>(
                        value: "flight_number",
                        groupValue: controller.sortParameter.value,
                        onChanged: (val) {
                          controller.sortParameter.value = val.toString();
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Date of departure"),
                      Radio<String>(
                        value: "date_unix",
                        groupValue: controller.sortParameter.value,
                        onChanged: (val) {
                          controller.sortParameter.value = val.toString();
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Mission name"),
                      Radio<String>(
                        value: "name",
                        groupValue: controller.sortParameter.value,
                        onChanged: (val) {
                          controller.sortParameter.value = val.toString();
                        },
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      }),
      actions: [
        TextButton(
          child: Text("Cancel"),
          onPressed: (){
            sortController.sortDirection.value = StorageManager().read("sort_direction");
            sortController.sortParameter.value = StorageManager().read("sort_parameter");
            Navigator.pop(context, 'Cancel');
          },
        ),
        TextButton(
          child: Text("Save"),
          onPressed: () {
            StorageManager().write("sort_direction", sortController.sortDirection.value);
            StorageManager().write("sort_parameter", sortController.sortParameter.value);
            Navigator.pop(context, 'Save');
          },
        )
      ],
    );
  }
}
