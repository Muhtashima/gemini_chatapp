import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gemini_app/Models/database.dart';
import 'package:my_gemini_app/Service/my_service.dart';
import 'package:my_gemini_app/View/my_app.dart';
import 'bloc_observer.dart';
import 'package:provider/provider.dart';

void main() async {
  //Collect previous client chats from _databaseName Database using sqflite package
  WidgetsFlutterBinding.ensureInitialized();
  MyService service = MyService();
  await service.initializeService();
  Bloc.observer = SimpleBlocObserver();

  runApp(ChangeNotifierProvider(
    create: (context) => ChatProvider()..getListOfChats(),
    child: MyApp(
      client: service,
    ),
  ));
}













