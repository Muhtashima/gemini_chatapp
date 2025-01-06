import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gemini_app/Chatlog/bloc/Chatlog_bloc.dart';
import 'package:my_gemini_app/my_service.dart';
import 'Chatlog/chat_log_view.dart';


void main() async {
  MyService _client = MyService();
  _client.initializeService();
  runApp(MyApp(client: _client));
}




class MyApp extends StatelessWidget {
  const MyApp({super.key, required MyService client}): _client = client;
  final MyService _client;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) {
          return DisplayChatLogBloc(client: _client);
        },
        child: MyHomePage(title: 'Gemini Homepage'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});
  final String title;


  final TextEditingController _controller = TextEditingController();
  final List<String> messages = ['This is Gemini','Write a story about Magic backpack','Here is your answer'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(title),
        centerTitle: true,
        titleSpacing: 2.0,
      ),
      body: BlocBuilder<DisplayChatLogBloc,DisplayChatLogState>(
        buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
        builder: (context, state){
          if(state is LoadingState){

            return const Center(child: CircularProgressIndicator());
          }else if(state is LoadedState){
            List<String> updatedMessages = List.from(messages)..add(state.message);
            return ChatLogView(messages: updatedMessages);
          }else{

            return ChatLogView(messages: messages);}
        },
      ),
      floatingActionButton: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  decoration:
                  const InputDecoration(border: OutlineInputBorder()),
                  controller: _controller),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                //messages.add(_controller.text);
                context.read<DisplayChatLogBloc>().add(SendPrompt(_controller.text));
              },
              child: const Icon(Icons.send_rounded)),

        ],
      ),
    );
  }

}


