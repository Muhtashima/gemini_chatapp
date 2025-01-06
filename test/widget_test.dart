// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_gemini_app/Chatlog/bloc/Chatlog_bloc.dart';
import 'package:my_gemini_app/bloc_observer.dart';
import 'package:my_gemini_app/my_service.dart';

void main() async {
  MyService _client = MyService();
  _client.initializeService();

  Bloc.observer = SimpleBlocObserver();

  // Initialize the BLoC
  final bloc = DisplayChatLogBloc(client: _client);

  // Listen to state changes
  final subscription = bloc.stream.listen((state) {
    print('Current State: $state');
  });

  // Dispatch the SendPrompt event
  bloc.add(SendPrompt('Write a story about a magic backpack'));

  // Wait for some time to allow state transitions
  await Future.delayed(Duration(seconds: 10));

  // Cancel the subscription to the stream
  await subscription.cancel();

  // Close the BLoC
  await bloc.close();
}
