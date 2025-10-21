class HttpPostAction {
  final String url;
  final Map<String, dynamic>? payload;
  final String? successNavigate;

  const HttpPostAction({required this.url, this.payload, this.successNavigate});

  factory HttpPostAction.fromJson(Map<String, dynamic> json) => HttpPostAction(
    url: json['url'] as String,
    payload: (json['payload'] as Map?)?.cast<String, dynamic>(),
    successNavigate: json['successNavigate'] as String?,
  );

  @override
  String toString() {
    return 'HttpPostAction(url: $url, payload: $payload, successNavigate: $successNavigate)';
  }
}
