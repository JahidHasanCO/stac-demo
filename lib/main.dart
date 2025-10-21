import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stac_demo/shared/stac/action_parsers/http_post_action_parser.dart';
import 'package:stac_demo/shared/stac/action_parsers/navigate_action_parsers.dart';
import 'package:stac_demo/shared/stac/action_parsers/set_value_action_parser.dart';

import 'default_stac_options.dart';

Future<void> main() async {
  await Stac.initialize(
    options: defaultStacOptions,
    actionParsers: [
      HttpPostActionParser(),
      NavigateActionParser(),
      SetValueActionParser(),
      SetValueActionParser(),
    ],
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // show the login_screen as defined in stac/generated screens
      home: Stac.fromAssets('assets/json/login_screen.json'),
    );
  }
}
