import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import '../../Service/my_service.dart';

part 'Chatlog_event.dart';

part 'Chatlog_state.dart';

class DisplayChatLogBloc
    extends Bloc<DisplayChatLogEvent, DisplayChatLogState> {

  //MyService
  final MyService _client;
  StreamSubscription<Candidates?>? _clientStreamSubscription;
  List<String> _streamParts = [];



  DisplayChatLogBloc({required MyService client}):_client = client, super(const LoadedState(message: 'All the Loaded States')){
    on<SendPromptStream>(_onSendPromptStream);
    on<SendPrompt>(_onSendPrompt);
    on<SendChat>(_onSendChat);
    on<PromptReceived>(_onPromptReceived);

  }

  Future<void> _onSendPromptStream(SendPromptStream event, Emitter<DisplayChatLogState> emit) async{
    emit(LoadingState(message: event.message));
    //This is the STREAM
    await _clientStreamSubscription?.cancel();// Await stream closure to re-allocate memories
    final clientStream = _client.sendPromptStream(event.message);

    _clientStreamSubscription = clientStream.listen((incoming) {
      _streamParts.add(incoming!.output!);
      //Handling events without onError and onDone
      // if (incoming?.finishReason != null && incoming!.finishReason! == 'STOP') { // NULL CHECK before operator checking
      //   add(PromptReceived(_streamParts.join('//')));
      // }else{
      //   if(incoming?.output != null){
      //     _streamParts.add(incoming!.output!);
      //   }
      //   _streamParts.clear();
      // }
    },
    onError: (error){ emit(ErrorState(message: error));},
    onDone: (){ add(PromptReceived(_streamParts.join(' '))); }

    );

  }

  Future<void> _onSendPrompt(SendPrompt event, Emitter<DisplayChatLogState> emit) async{
    emit(LoadingState(message: event.message));
    //This is the FUTURE

    final _clientFuture =  _client.sendPrompt(event.message);
    _clientFuture.then((value) {
      if(value?.finishReason != null && value!.finishReason! == 'STOP'){
        add(PromptReceived(value.output!));
      }
    });

  }

  Future<void> _onPromptReceived(PromptReceived event, Emitter<DisplayChatLogState> emit)async {
    emit(LoadedState(message: event.message));
  }



  Future<void> _onSendChat(SendChat event, Emitter<DisplayChatLogState> emit) async {
    emit(LoadingState(message: event.message));

    final _clientFuture = _client.sendChat(event.message);
    _clientFuture.then(
      (value) {
        if(value?.finishReason != null && value!.finishReason! == 'STOP'){
          add(PromptReceived(value.output!));
      }
  });
}

}


