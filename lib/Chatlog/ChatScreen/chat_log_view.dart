import 'package:flutter/material.dart';
import 'package:my_gemini_app/Chatlog/ChatScreen/speech_bubble.dart';


class ChatLogView extends StatelessWidget {
  const ChatLogView({super.key, required this.messages});
  final List<String> messages;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return SpeechBubble(
            speech: messages[index],
            role: index.isEven ? 'user' : 'model',
          );
        });
  }
}
