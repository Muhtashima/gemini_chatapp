class Chat{
  final int? id;
  final String? prompt;
  final String? output;
  Chat({this.id, this.prompt, this.output});

  Map<String,Object?> toMap() { // Alternatively, Map<String, Object?> toJson()
    return {
      'id': id,
      'prompt': prompt,
      'output': output
    };
  }

  static Chat fromMap(Map<String, Object?> map){
  int? id = map['id'] as int?;
  String prompt = map['prompt'] as String;
  String output = map['output'] as String;
  return Chat(id: id, prompt: prompt, output: output);
  }

    @override
    String toString(){
    return 'Chat{id : $id, prompt: $prompt, output: $output}';
    }



}



