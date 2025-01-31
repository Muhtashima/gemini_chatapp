
part of 'Chatlog_bloc.dart';
class DisplayChatLogState{
const DisplayChatLogState({required this.message});
final String message;
}
class LoadingState extends DisplayChatLogState{
  const LoadingState({required super.message});

}


class LoadedState extends DisplayChatLogState{
  const LoadedState({required super.message});

}


class ErrorState extends DisplayChatLogState{
  const ErrorState({required super.message});

}

