import 'view.dart';
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});



  @override
  Widget build(BuildContext context){

    List<String?> messages = ['This is Gemini Bot'];
    final provider = Provider.of<ChatProvider>(context);

    TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){exit(0);}, icon: const Icon(Icons.exit_to_app)),
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Home Screen'),
        centerTitle: true,
        titleSpacing: 2.0,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Consumer<ChatProvider>(
            builder: (context, value, child) {
              return ChatLogView(messages: value.listOfChats);
            },
          ),
          BlocBuilder<DisplayChatLogBloc, DisplayChatLogState>(
            buildWhen: (previous, current) =>
                previous.runtimeType != current.runtimeType,
            builder: (context, state) {
              if (state is LoadingState) {
                return Column(children: [
                  ...messages.map((e) => Text(e!)),
                  const SizedBox(
                    width: 10,
                  ),
                  const CircularProgressIndicator()
                ]);
              } else if (state is LoadedState) {
                List<String> updatedMessages = List.from(messages)
                  ..add(state.message);
                provider.addChat(Chat(prompt: messages.last, output: state.message));
                return Column(
                    children: updatedMessages.map((e) => Text(e)).toList());
              } else {
                messages.add('Error generating response');
                return Column(children: messages.map((e) => Text(e!)).toList());
              }
            },
          ),
        ],)

      ),
      floatingActionButton: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0,8.0,8.0,8.0),
              child: Container(
                color: Colors.white,
                child: TextField(
                    decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.red),
                        hintText: 'Write your Query',
                        border: OutlineInputBorder()),
                    controller: controller),
              ),
            ),
          ),
          IconButton(
            iconSize: 40.0,
            style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Theme.of(context).primaryColorLight),
            onPressed: () {
              context
                  .read<DisplayChatLogBloc>()
                  .add(SendChat(controller.text));
              messages.add(controller.text);
              controller.clear();
            },
            icon: const Icon(Icons.send_rounded),
          )
        ],
      ),
    );
  }

}


