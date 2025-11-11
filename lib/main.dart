import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'widgets/stac_chat_message.dart';
import 'parsers/stac_chat_message_parser.dart';

void main() async {
  // Register your custom parser during Stac initialization
  await Stac.initialize(parsers: const [StacChatMessageParser()]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stac Chat Message Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ChatMessageDemo(),
    );
  }
}

class ChatMessageDemo extends StatelessWidget {
  const ChatMessageDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // Example JSON that would come from your server
    final chatMessageJson = {
      "type": "chatMessage",
      "chatMessageType": "email",
      "label": "Email",
      "iconPath": "assets/icons/email.png",
      "chatMessage": "What is your email address?",
      "switchButtonEntities": [
        {"title": "Back Button", "value": true, "isDisabled": false},
        {"title": "Skip Button", "value": false, "isDisabled": false},
      ],
      "errorText": "Please enter a valid email address",
      "validationRegex": r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$",
      "optionEntities": [
        {"title": "Work Email", "value": "work"},
        {"title": "Personal Email", "value": "personal"},
      ],
      "canReply": true,
    };

    // Parse the JSON into a StacChatMessage widget
    final chatMessage = StacChatMessage.fromJson(chatMessageJson);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Message Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Render using the parser
            StacChatMessageParser().parse(context, chatMessage),
          ],
        ),
      ),
    );
  }
}
