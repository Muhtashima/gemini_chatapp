import 'package:flutter_gemini/flutter_gemini.dart';
const apiKey = 'AIzaSyB_eeE981hsvnZPE_HR03J7gRDmfYyvA3I';

class MyService {

  String? answer;
  Candidates? response;
  String? role; //changes during runTime
  String? finishReason; //changes during runTime
  GeminiException? exception;

  MyService();


  Future<void> initializeService() async {
    Gemini.init(apiKey: apiKey, enableDebugging: true);
  }


  // Future<Candidates?> sendPrompt(String userprompt){
  //    return Gemini.instance.prompt(parts: [
  //     Part.text(userprompt),
  //   ]);
  // }


  Stream<Candidates?> sendPrompt(String userprompt){
    return Gemini.instance.promptStream(parts: [
      Part.text(userprompt),
    ]);
  }


}
