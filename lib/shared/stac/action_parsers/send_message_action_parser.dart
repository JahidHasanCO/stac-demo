import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac_demo/shared/stac/actions/send_message_action.dart';

class SendMessageActionParser implements StacActionParser<SendMessageAction> {
  @override
  String get actionType => 'send_message';

  @override
  SendMessageAction getModel(Map<String, dynamic> json) {
    return SendMessageAction.fromJson(json);
  }

  @override
  FutureOr onCall(BuildContext context, SendMessageAction model) {
    print('message for send: ${model.message}');
  }
}
