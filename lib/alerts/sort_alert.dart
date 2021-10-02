import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_x/controllers/main_page_controller.dart';
import 'package:space_x/managers/storage_manager.dart';

// ignore: must_be_immutable
class SortAlert extends StatelessWidget {

  MainPageController sortController = Get.put(MainPageController());

  @override
  Widget build(BuildContext context) {
    return GetX<MainPageController>(
      builder: (controller) {
        return AlertDialog(
          content: SingleChildScrollView(
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
                            groupValue: controller.selectedSortDirection.value,
                            onChanged: (val) {
                              controller.selectedSortDirection.value = val.toString();
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text("Descending"),
                          Radio<String>(
                            value: "desc",
                            groupValue: controller.selectedSortDirection.value,
                            onChanged: (val) {
                              controller.selectedSortDirection.value = val.toString();
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
                            groupValue: controller.selectedSortParameter.value,
                            onChanged: (val) {
                              controller.selectedSortParameter.value = val.toString();
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
                            groupValue: controller.selectedSortParameter.value,
                            onChanged: (val) {
                              controller.selectedSortParameter.value = val.toString();
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
                            groupValue: controller.selectedSortParameter.value,
                            onChanged: (val) {
                              controller.selectedSortParameter.value = val.toString();
                            },
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: (){
                sortController.selectedSortDirection.value = StorageManager().read("sort_direction");
                sortController.selectedSortParameter.value = StorageManager().read("sort_parameter");
                Navigator.pop(context, 'Cancel');
              },
            ),
            TextButton(
              child: Text("Save"),
              onPressed: () {
                StorageManager().write("sort_direction", sortController.selectedSortDirection.value);
                StorageManager().write("sort_parameter", sortController.selectedSortParameter.value);
                sortController.sortDirection.value = sortController.selectedSortDirection.value;
                sortController.sortParameter.value = sortController.selectedSortParameter.value;
                Navigator.pop(context, 'Save');
              },
            )
          ],
        );
      }
    );
  }
}
