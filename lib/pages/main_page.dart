import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_x/alerts/settings_alert.dart';
import 'package:space_x/alerts/sort_alert.dart';
import 'package:space_x/controllers/app_controller.dart';
import 'package:space_x/elements/launch_view_list.dart';
import 'package:space_x/requests/api_requests.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';

// ignore: must_be_immutable
class MainPage extends StatelessWidget {
  final String title;

  MainPage(this.title);

  AppController appController = Get.put(AppController());
  SliderController sliderController = Get.put(SliderController());

  SpaceXRequest request = SpaceXRequest();

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return GetX<AppController>(builder: (controller) {
          return Scaffold(
                appBar: controller.inSearching.value ? _appBarSearch(context) : _appBarIdle(context, this.title),
                body: Container(
                  alignment: Alignment.topCenter,
                  child: LaunchViewList(),
                ),
                bottomNavigationBar: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))
                  ),
                  child: Center(
                    child: InkWell(
                      child: Icon(Icons.apps),
                      onTap: (){
                        sliderController.sliderStartValue.value = appController.startFilterYear.value.toDouble();
                        sliderController.sliderEndValue.value = appController.endFilterYear.value.toDouble();
                        showAdaptiveActionSheet(
                          context: context,
                          title: const Text(
                            'Filter by launch year...',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          actions: <BottomSheetAction>[
                              BottomSheetAction(title: GetX<SliderController>(
                                builder: (_controller) {
                                  return Row(
                                    children: [
                                      Text(_controller.sliderStartValue.value.toInt().toString()),
                                      Expanded(
                                        child: SliderTheme(
                                          data: SliderThemeData(
                                            showValueIndicator: ShowValueIndicator.never
                                          ),
                                          child: RangeSlider(
                                            values: RangeValues(_controller.sliderStartValue.value, _controller.sliderEndValue.value),
                                            max: DateTime.now().year.toDouble(),
                                            min: 2006.0,
                                            divisions: DateTime.now().year - 2006,
                                            labels: RangeLabels(_controller.sliderStartValue.value.toInt().toString(), _controller.sliderEndValue.value.toInt().toString()),
                                            onChanged: (val){
                                              _controller.sliderStartValue.value = val.start;
                                              _controller.sliderEndValue.value = val.end;
                                            },
                                          ),
                                        ),
                                      ),
                                      Text(_controller.sliderEndValue.value.toInt().toString()),
                                    ],
                                  );
                                }
                              ), onPressed: (){}),
                          ],
                          cancelAction: CancelAction(
                            title: Text('Save'),
                            onPressed: (){
                              controller.startFilterYear.value = sliderController.sliderStartValue.value.toInt();
                              controller.endFilterYear.value = sliderController.sliderEndValue.value.toInt();
                              controller.loadNewPage();
                              Navigator.of(context).pop();
                            }
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            
        });
      }
    );
  }

  PreferredSizeWidget _appBarIdle(BuildContext context, String title) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return SettingsAlert();
              });
        },
      ),
      title: Text(title),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            appController.inSearching.value = true;
          },
        ),
        _filterWidget(context)
      ],
    );
  }

  PreferredSizeWidget _appBarSearch(BuildContext context) {
    String searchText = "";
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          appController.inSearching.value = false;
          appController.loadNewPage();
        },
      ),
      title: TextField(
        autofocus: true,
        onChanged: (text) {
          searchText = text;
        },
        onSubmitted: (text) {
          appController.searchText.value = searchText;
          appController.loadNewPage();
          FocusScope.of(context).unfocus();
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            appController.searchText.value = searchText;
            appController.loadNewPage();
            FocusScope.of(context).unfocus();
          },
        ),
        _filterWidget(context)
      ],
    );
  }

  Widget _filterWidget(context) {
    return IconButton(
        icon: Icon(Icons.filter_list),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return SortAlert();
              });
        });
  }
}

class SliderController extends GetxController{

  RxDouble sliderStartValue = 0.0.obs;
  RxDouble sliderEndValue = 0.0.obs;
  
}

