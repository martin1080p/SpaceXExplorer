import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cached_network_image/cached_network_image.dart';
part 'launch.g.dart';

@JsonSerializable()
class Launch extends StatelessWidget {
  final int flightNumber;
  final String? name;
  final String? details;
  final DateTime? dateUtc;
  final List<dynamic>? image;
  final String? badge;

  Launch(
      {required this.flightNumber,
      this.name,
      this.details,
      this.dateUtc,
      this.image,
      this.badge});

  factory Launch.fromJson(Map<String, dynamic> json) => _$LaunchFromJson(json);
  Map<String, dynamic> toJson() => _$LaunchToJson(this);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: MediaQuery.of(context).size.height / 6,
        child: ListTile(
            leading: CachedNetworkImage(
              imageUrl: badge.toString(),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Image.asset('../assets/rocket.png'),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    name.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    details.toString(),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
