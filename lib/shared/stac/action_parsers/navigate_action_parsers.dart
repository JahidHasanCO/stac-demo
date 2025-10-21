import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac_demo/shared/stac/actions/navigate_action.dart';
import '../../../screens/home_screen.dart';

class NavigateActionParser implements StacActionParser<NavigateAction> {
  const NavigateActionParser();

  @override
  String get actionType => 'navigate';

  @override
  NavigateAction getModel(Map<String, dynamic> json) =>
      NavigateAction.fromJson(json);

  @override
  Future<void> onCall(BuildContext ctx, covariant NavigateAction m) async {
    if (!ctx.mounted) return;
    // very small router: if route == '/home' or 'home_screen' go to HomeScreen
    Widget target;
    if (m.route == '/home' || m.route == 'home_screen') {
      target = const HomeScreen();
    } else {
      // fallback: show a simple scaffold with route name
      target = Scaffold(appBar: AppBar(title: Text(m.route)), body: Center(child: Text('Route: ${m.route}')));
    }

    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) => target));
  }
}