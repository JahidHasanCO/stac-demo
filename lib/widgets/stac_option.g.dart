// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stac_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StacOption _$StacOptionFromJson(Map<String, dynamic> json) => StacOption(
  title: json['title'] as String?,
  url: json['url'] as String?,
  value: json['value'] as String,
);

Map<String, dynamic> _$StacOptionToJson(StacOption instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'value': instance.value,
      'type': instance.type,
    };
