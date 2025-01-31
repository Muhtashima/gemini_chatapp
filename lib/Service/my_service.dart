import 'dart:developer';
import 'package:flutter_gemini/flutter_gemini.dart';

const apiKey = 'AIzaSyB_eeE981hsvnZPE_HR03J7gRDmfYyvA3I';

class MyService {

  String? answer;
  Candidates? response;
  String? role; //changes during runTime
  String? finishReason; //changes during runTime
  GeminiException? exception;
  List<Content>? chats = [Content(parts: [Part.text('Search Something')], role: 'model')];



  Future<void> initializeService() async {
    Gemini.instance = Gemini.init(apiKey: apiKey, enableDebugging: true);
  }


  Future<Candidates?> sendPrompt(String userprompt){
     return Gemini.instance.prompt(parts: [
      Part.text(userprompt),
    ]);
  }


  Stream<Candidates?> sendPromptStream(String userprompt){
    return Gemini.instance.promptStream(parts: [
      Part.text(userprompt),
    ]);
  }

  Future<Candidates?> sendChat(String userprompt) {
    chats?.add(Content(parts: [Part.text(userprompt)], role: 'user'));
    return Gemini.instance
        .chat(chats!);
    //     .then((value) => print(value?.output))
    //     .onError(
    //   (error, stackTrace) {
    //     print('Error : $error, StackTrace : $stackTrace');
    //   },
    // );
  }

  Future<void> get listModels{

    return Gemini.instance.listModels()
        .then((models) => print(models)) /// list
        .catchError((e) => log('listModels', error: e));
  }

  Future<void> get modelInfo{

    return Gemini.instance.info(model: 'gemini-pro')
        .then((info) => print(info))
        .catchError((e) => log('info', error: e));
  }




}
