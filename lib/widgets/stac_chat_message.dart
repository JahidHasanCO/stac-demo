import 'package:json_annotation/json_annotation.dart';
import 'package:stac_core/stac_core.dart';
import 'stac_option.dart';
import 'stac_switch_button.dart';

part 'stac_chat_message.g.dart';

/// Converter for List<StacOption>
class StacOptionListConverter
    implements JsonConverter<List<StacOption>, List<dynamic>> {
  const StacOptionListConverter();

  @override
  List<StacOption> fromJson(List<dynamic> json) {
    return json
        .map((e) => StacOption.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  List<dynamic> toJson(List<StacOption> object) {
    return object.map((e) => e.toJson()).toList();
  }
}

/// Converter for List<StacSwitchButton>
class StacSwitchButtonListConverter
    implements JsonConverter<List<StacSwitchButton>, List<dynamic>> {
  const StacSwitchButtonListConverter();

  @override
  List<StacSwitchButton> fromJson(List<dynamic> json) {
    return json
        .map((e) => StacSwitchButton.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  List<dynamic> toJson(List<StacSwitchButton> object) {
    return object.map((e) => e.toJson()).toList();
  }
}

@JsonSerializable(explicitToJson: true)
class StacChatMessage extends StacWidget {
  final String chatMessageType; // Using string instead of enum for simplicity
  final String label;
  final String iconPath;
  final String chatMessage;
  final String? errorText;
  final String? validationRegex;

  @StacSwitchButtonListConverter()
  final List<StacSwitchButton> switchButtonEntities;

  @StacOptionListConverter()
  final List<StacOption> optionEntities;

  final bool canReply;

  const StacChatMessage({
    required this.chatMessageType,
    required this.label,
    required this.iconPath,
    required this.chatMessage,
    required this.optionEntities,
    required this.switchButtonEntities,
    required this.canReply,
    this.errorText,
    this.validationRegex,
  });

  @override
  String get type => 'chatMessage';

  factory StacChatMessage.fromJson(Map<String, dynamic> json) =>
      _$StacChatMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StacChatMessageToJson(this);
}
