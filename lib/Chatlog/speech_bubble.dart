import 'package:flutter/material.dart';

class SpeechBubble extends StatelessWidget {
  final String speech;
  const SpeechBubble({
    super.key,
    required this.speech
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColorLight, borderRadius: BorderRadius.circular(5.0)),
        padding: const EdgeInsets.all(5.0),
        child: Text(speech, style: const TextStyle(fontSize: 20.0)),
      ),
    );
  }
}