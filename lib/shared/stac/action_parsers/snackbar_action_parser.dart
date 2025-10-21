import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac_demo/shared/stac/actions/snackbar_action.dart';

class SnackbarActionParser implements StacActionParser<SnackbarAction> {
  const SnackbarActionParser();

  @override
  String get actionType => 'snackbar';

  @override
  SnackbarAction getModel(Map<String, dynamic> json) =>
      SnackbarAction.fromJson(json);

  @override
  Future<void> onCall(BuildContext ctx, covariant SnackbarAction m) async {
    if (!ctx.mounted) return;
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(m.message)));
  }
}
