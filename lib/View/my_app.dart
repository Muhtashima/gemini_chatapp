
import 'view.dart';

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
        child: MyHomePage(),
      ),
    );
  }
}