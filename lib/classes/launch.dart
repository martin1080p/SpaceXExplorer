import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part of 'launch.g.dart';

@JsonSerializable()
class Launch{

  final int flightNumber;
  final String? name;
  final String? details;
  final DateTime? dateUtc;
  final String? image;


  Launch({required this.flightNumber, this.name, this.details, this.dateUtc, this.image});

  factory Launch.fromJson(Map<String, dynamic> json) => _$LaunchFromJson(json);
  Map<String, dynamic> toJson() => _$LaunchToJson(this);
}