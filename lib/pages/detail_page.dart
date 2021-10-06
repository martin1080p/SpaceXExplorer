import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPage extends StatelessWidget {
  final String? name;
  final String? details;
  final DateTime? dateUtc;
  final List<dynamic>? image;
  final String? badge;
  final bool? success;
  final List<dynamic>? cores;

  DetailPage({@required this.name, this.details, this.dateUtc, this.image, this.badge, this.success, this.cores});

  @override
  Widget build(BuildContext context) {
    double _screenWidth = Get.width;
    double _screenHeight = Get.height;

    TextTheme textTheme = Theme.of(context).textTheme;

    ImageProvider backgroundImg = (((image as List<dynamic>).isEmpty)
        ? AssetImage('assets/background.jpg')
        : NetworkImage((image as List<dynamic>)[0])) as ImageProvider;

    return Scaffold(
      appBar: AppBar(
        title: Text(name.toString()),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        return Stack(
          children: [
            Container(
              width: Get.width,
              height: Get.height,
              decoration: BoxDecoration(image: DecorationImage(image: backgroundImg, fit: BoxFit.cover)),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, _screenHeight / 8, 20, _screenHeight / 16),
              padding: EdgeInsets.fromLTRB(20, _screenWidth / 8, 20, 20),
              width: Get.width,
              height: Get.height,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  )),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      name.toString(),
                      style:
                          TextStyle(fontFamily: textTheme.headline1?.fontFamily, fontWeight: textTheme.headline1?.fontWeight, fontSize: 26),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(DateFormat('dd. MM. yyyy').format(dateUtc as DateTime)),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(details == null ? "" : details.toString()),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "# Of cores: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(cores!.length.toString())
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Successful: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(success.toString())
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Launch time: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(DateFormat('hh:mm dd/MM/yyyy').format(dateUtc as DateTime))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: _screenHeight / 8 - _screenWidth / 8, left: 20),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(radius: _screenWidth / 8, backgroundColor: Colors.white),
                  Hero(
                    tag: name.toString(),
                    child: CircleAvatar(
                        radius: _screenWidth / 8 - 5, backgroundColor: Colors.white, backgroundImage: NetworkImage(badge.toString())),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
