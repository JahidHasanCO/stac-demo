import 'dart:io';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import '../sdui_state_shim.dart';
import 'package:stac_demo/shared/stac/actions/http_post_action.dart';
import '../../../screens/home_screen.dart';

class HttpPostActionParser implements StacActionParser<HttpPostAction> {
  const HttpPostActionParser();

  final String backendBase = 'https://dummyjson.com/';

  @override
  // Accept the stac-generated JSON which uses "httpPost"
  String get actionType => 'http.post';

  @override
  HttpPostAction getModel(Map<String, dynamic> json) {
    // normalize body vs payload
    final map = Map<String, dynamic>.from(json);
    if (map.containsKey('body') && !map.containsKey('payload')) {
      map['payload'] = map['body'];
    }
    return HttpPostAction.fromJson(map);
  }

  @override
  Future<void> onCall(
    BuildContext context,
    covariant HttpPostAction model,
  ) async {
    // 1) Resolve all payload entries: {{...}} and {actionType:getFormValue}
    print(model.toString());
    final resolved = <String, dynamic>{};
    print('Payload before resolve: ${model.payload}');
    (model.payload ?? const {}).forEach((k, v) {
      resolved[k] = _resolveValue(v);
      print('Resolved $k => ${resolved[k]}');
    });

    // 2) Decide multipart vs JSON: if any value is a local file path => multipart
    final hasFile = resolved.values.any(
      (v) =>
          v is String &&
          v.isNotEmpty &&
          _looksLikePath(v) &&
          File(v).existsSync(),
    );

    http.Response response;

    final uriString = (model.url.startsWith('http')) ? model.url : '$backendBase${model.url}';
    if (hasFile) {
      final uri = Uri.parse(uriString);
      final req = http.MultipartRequest('POST', uri);

      for (final entry in resolved.entries) {
        final key = entry.key;
        final val = entry.value;

        if (val is String &&
            val.isNotEmpty &&
            _looksLikePath(val) &&
            File(val).existsSync()) {
          final file = File(val);
          // final filename = val.split(Platform.pathSeparator).last;
          req.files.add(await http.MultipartFile.fromPath(key, file.path));
        } else if (val != null) {
          // Multipart fields must be strings
          req.fields[key] = val.toString();
        }
      }

      final streamed = await req.send();
      response = await http.Response.fromStream(streamed);
    } else {
      // Fallback JSON body
      response = await http.post(
        Uri.parse(uriString),
        headers: const {'Content-Type': 'application/json'},
        body: jsonEncode(resolved),
      );
    }

    // 3) Handle errors and navigate on success
    Map<String, dynamic>? bodyJson;
    try {
      bodyJson = response.body.isNotEmpty
          ? jsonDecode(response.body) as Map<String, dynamic>
          : null;
    } catch (_) {}

    if (response.statusCode < 200 || response.statusCode >= 300) {
      final msg =
          bodyJson?['message']?.toString() ??
          'Request failed (${response.statusCode}). Please try again.';
      if (!context.mounted) return;
      await showDialog<void>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    // If this was the demo login endpoint, simulate success and navigate to HomeScreen
    final next = bodyJson?['nextRoute'] ?? model.successNavigate;
    if (next != null && context.mounted) {
      // support simple names
      if (next == '/home' || next == '/home_screen' || next == '/home-screen' || next == '/homeScreen' || next == 'home_screen') {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const HomeScreen()));
        return;
      }
      // fallback: show simple route scaffold
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => Scaffold(appBar: AppBar(title: Text(next.toString())), body: Center(child: Text('Route: $next')))));
    }
  }

  dynamic _resolveValue(dynamic v) {
    // "{{files.id_front}}" or "{{form.username}}"
    print("Resolving value: ${v}");
    if (v is String && v.startsWith('{{') && v.endsWith('}}')) {
      final key = v.substring(2, v.length - 2); // e.g., files.id_front
      return SduiState.get(key);
    }
    // { "actionType": "getFormValue", "id": "username" }
    if (v is Map && v['actionType'] == 'getFormValue') {
      final id = v['id']?.toString();
      print("Resolving form value for id: $id");

      if (id != null && id.isNotEmpty) {
        // We store form values under "form.<id>"
        return SduiState.get(id);
      }
    }
    return v;
  }

  bool _looksLikePath(String v) {
    return v.startsWith('/') || v.contains('\\') || v.startsWith('file:');
  }
}
