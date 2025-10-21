class SetValueAction {
  final String key;
  final dynamic value;

  const SetValueAction({required this.key, this.value});

  factory SetValueAction.fromJson(Map<String, dynamic> j) =>
      SetValueAction(key: j['key'] as String, value: j['value']);
}
