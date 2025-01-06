import 'package:flutter/material.dart';
import 'package:my_gemini_app/Chatlog/speech_bubble.dart';


class ChatLogView extends StatelessWidget {
  const ChatLogView({super.key, required this.messages});
  final List<String> messages;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return SpeechBubble(
                    speech: messages[index]
                );

              }),
        ),

      ],
    );
  }
}

