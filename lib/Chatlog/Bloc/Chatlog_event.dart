part of "Chatlog_bloc.dart";
abstract class DisplayChatLogEvent{
  const DisplayChatLogEvent(this.message);
  final String message;
}

final class SendPrompt extends DisplayChatLogEvent{
  const SendPrompt(super.message);

}

final class SendPromptStream extends DisplayChatLogEvent{
  const SendPromptStream(super.message);

}


final class SendChat extends DisplayChatLogEvent{
  const SendChat(super.message);

}

final class PromptReceived extends DisplayChatLogEvent{
  const PromptReceived(super.message);

}




