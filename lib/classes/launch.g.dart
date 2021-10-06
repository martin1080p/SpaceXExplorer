// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Launch _$LaunchFromJson(Map<String, dynamic> json) => Launch(
      flightNumber: json['flight_number'] as int,
      name: json['name'] as String?,
      details: json['details'] as String?,
      dateUtc: json['date_utc'] == null
          ? null
          : DateTime.parse(json['date_utc'] as String),
      image: json['links']['flickr']['original'] as List<dynamic>,
      badge: json['links']['patch']['small'] as String?,
      success: json['success'] as bool?,
      cores: json['cores'] as List<dynamic>?,
    );

Map<String, dynamic> _$LaunchToJson(Launch instance) => <String, dynamic>{
      'flightNumber': instance.flightNumber,
      'name': instance.name,
      'details': instance.details,
      'dateUtc': instance.dateUtc?.toIso8601String(),
      'image': instance.image,
      'badge': instance.badge
    };
