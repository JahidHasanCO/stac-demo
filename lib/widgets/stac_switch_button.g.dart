// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stac_switch_button.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StacSwitchButton _$StacSwitchButtonFromJson(Map<String, dynamic> json) =>
    StacSwitchButton(
      title: json['title'] as String,
      value: json['value'] as bool,
      isDisabled: json['isDisabled'] as bool,
    );

Map<String, dynamic> _$StacSwitchButtonToJson(StacSwitchButton instance) =>
    <String, dynamic>{
      'title': instance.title,
      'value': instance.value,
      'isDisabled': instance.isDisabled,
      'type': instance.type,
    };
