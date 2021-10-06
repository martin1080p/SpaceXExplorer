import 'package:get/get.dart';
import 'package:space_x/controllers/app_controller.dart';
import 'package:flutter/material.dart';

class LaunchViewList extends StatefulWidget {
  @override
  _LaunchViewListState createState() => _LaunchViewListState();
}

class _LaunchViewListState extends State<LaunchViewList> {

  AppController appController = Get.find<AppController>();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    appController.loadNewPage();
    super.initState();

    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        appController.loadNextPage();
      }
    });

  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        appController.loadNewPage();
        return SingleChildScrollView(
          controller: scrollController,
          child: GetBuilder<AppController>(builder: (controller) {
            return Container(
              child: controller.isLoadingNew ?
                Align(
                  alignment: Alignment.topCenter,
                  child: LinearProgressIndicator(),
                ) :
                Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: controller.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return controller.data[index];
                      },
                    ),
                    SizedBox(
                      height: 20,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: controller.isLoadingNext ?
                        LinearProgressIndicator() : 
                        Container(),
                      )
                    )
                  ],
                ),
            );
          }),
        );
      }
    );
  }
}
