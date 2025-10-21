import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import '../sdui_state_shim.dart';
import 'package:stac_demo/shared/stac/actions/set_value_action.dart';

class SetValueActionParser implements StacActionParser<SetValueAction> {
  const SetValueActionParser();
  @override
  String get actionType => 'customSetValue';
  @override
  SetValueAction getModel(Map<String, dynamic> json) =>
      SetValueAction.fromJson(json);
  @override
  Future<void> onCall(BuildContext context, covariant SetValueAction m) async {
    print("SetValueAction: setting ${m.key} => ${ m.value}");
    SduiState.set(m.key, m.value);
  }
}