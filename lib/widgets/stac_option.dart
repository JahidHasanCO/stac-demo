import 'package:json_annotation/json_annotation.dart';
import 'package:stac_core/stac_core.dart';

part 'stac_option.g.dart';

@JsonSerializable(explicitToJson: true)
class StacOption extends StacWidget {
  final String? title;
  final String? url;
  final String value;

  const StacOption({
    this.title,
    this.url,
    required this.value,
  });

  @override
  String get type => 'option';

  factory StacOption.fromJson(Map<String, dynamic> json) =>
      _$StacOptionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StacOptionToJson(this);
}