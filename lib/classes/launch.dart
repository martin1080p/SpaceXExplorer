import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:space_x/pages/detail_page.dart';
part 'launch.g.dart';

@JsonSerializable()
class Launch extends StatelessWidget {
  final int flightNumber;
  final String? name;
  final String? details;
  final DateTime? dateUtc;
  final List<dynamic>? image;
  final String? badge;
  final bool? success;
  final List<dynamic>? cores;

  Launch(
      {required this.flightNumber,
      this.name,
      this.details,
      this.dateUtc,
      this.image,
      this.badge,
      this.success,
      this.cores});

  factory Launch.fromJson(Map<String, dynamic> json) => _$LaunchFromJson(json);
  Map<String, dynamic> toJson() => _$LaunchToJson(this);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(
            name: name,
            details: details,
            dateUtc: dateUtc,
            image: image,
            badge: badge,
            success: success,
            cores: cores
          ))
        );
      },
      child: Card(
        child: Container(
          //height: MediaQuery.of(context).size.height / 6,
          child: ListTile(
              leading: Container(
                child: SizedBox(
                  width: Get.width / 8,
                  child: Hero(
                    tag: name.toString(),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CachedNetworkImage(
                        imageUrl: badge.toString(),
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Image.asset('../assets/rocket.png'),
                      ),
                    ),
                  ),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: Get.width / 2,
                    child: Text(
                      name.toString(),
                      maxLines: 1,
                      //overflow: TextOverflow.fade,
                    ),
                  ),
                  Text(
                    DateFormat('MMM yyyy').format(dateUtc as DateTime),
                    style: TextStyle(
                      fontSize: 15
                    ),
                  )
                ],
              ),
              subtitle: Text(
                details == null ? "" : details.toString(),
                maxLines: 2,
              ),
              isThreeLine: true,
          ),
        ),
      ),
    );
  }
}
