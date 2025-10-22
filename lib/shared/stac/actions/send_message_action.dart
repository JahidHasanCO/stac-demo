class SendMessageAction {
  SendMessageAction({required this.message});

  final String message;

  factory SendMessageAction.fromJson(Map<String, dynamic> json) {
    final message = json['message'];
    if (message is! String) {
      return SendMessageAction(message: message.toString());
    }
    return SendMessageAction(message: message);
  }
}
