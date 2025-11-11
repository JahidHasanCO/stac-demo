import 'package:json_annotation/json_annotation.dart';
import 'package:stac_core/stac_core.dart';

part 'stac_switch_button.g.dart';

@JsonSerializable(explicitToJson: true)
class StacSwitchButton extends StacWidget {
  final String title;
  final bool value;
  final bool isDisabled;

  const StacSwitchButton({
    required this.title,
    required this.value,
    required this.isDisabled,
  });

  @override
  String get type => 'switchButton';

  factory StacSwitchButton.fromJson(Map<String, dynamic> json) =>
      _$StacSwitchButtonFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StacSwitchButtonToJson(this);
}
