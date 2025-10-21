class SnackbarAction {
  final String message;

  const SnackbarAction(this.message);

  factory SnackbarAction.fromJson(Map<String, dynamic> j) =>
      SnackbarAction(j['message'] as String);
}
