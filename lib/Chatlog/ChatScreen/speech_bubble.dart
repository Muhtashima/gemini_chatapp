import 'package:flutter/material.dart';

class SpeechBubble extends StatelessWidget {
  final String speech;
  final String role;
  const SpeechBubble({
    super.key,
    required this.speech,
    required this.role
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: (role == 'user') ? const EdgeInsets.fromLTRB(40.0, 8.0, 8.0, 8.0) : const EdgeInsets.fromLTRB(8.0, 8.0, 40.0, 8.0),
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColorLight, borderRadius: BorderRadius.circular(5.0)),
        padding: const EdgeInsets.all(5.0),
        child: Text(speech, style: const TextStyle(fontSize: 20.0)),
      ),
    );
  }
}