// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stac_chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StacChatMessage _$StacChatMessageFromJson(Map<String, dynamic> json) =>
    StacChatMessage(
      chatMessageType: json['chatMessageType'] as String,
      label: json['label'] as String,
      iconPath: json['iconPath'] as String,
      chatMessage: json['chatMessage'] as String,
      optionEntities: const StacOptionListConverter().fromJson(
        json['optionEntities'] as List,
      ),
      switchButtonEntities: const StacSwitchButtonListConverter().fromJson(
        json['switchButtonEntities'] as List,
      ),
      canReply: json['canReply'] as bool,
      errorText: json['errorText'] as String?,
      validationRegex: json['validationRegex'] as String?,
    );

Map<String, dynamic> _$StacChatMessageToJson(StacChatMessage instance) =>
    <String, dynamic>{
      'chatMessageType': instance.chatMessageType,
      'label': instance.label,
      'iconPath': instance.iconPath,
      'chatMessage': instance.chatMessage,
      'errorText': instance.errorText,
      'validationRegex': instance.validationRegex,
      'switchButtonEntities': const StacSwitchButtonListConverter().toJson(
        instance.switchButtonEntities,
      ),
      'optionEntities': const StacOptionListConverter().toJson(
        instance.optionEntities,
      ),
      'canReply': instance.canReply,
      'type': instance.type,
    };
