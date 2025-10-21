class NavigateAction {
  final String route;
  const NavigateAction(this.route);
  factory NavigateAction.fromJson(Map<String, dynamic> j) =>
      NavigateAction(j['route'] as String);
}
