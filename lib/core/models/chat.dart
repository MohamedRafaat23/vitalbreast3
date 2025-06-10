class Chat {
  String? answer;
  String? chatId;

  Chat({this.answer, this.chatId});

  Chat.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
    chatId = json['chat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['answer'] = answer;
    data['chat_id'] = chatId;
    return data;
  }
}