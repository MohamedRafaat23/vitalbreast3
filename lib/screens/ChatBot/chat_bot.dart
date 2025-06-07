import 'package:flutter/material.dart';

class Message {
  final String text;
  final bool isUser;

  Message({required this.text, required this.isUser});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [
    Message(text: "Hello chatGPT, how are you today?", isUser: true),
    Message(text: "Hello, I'm fine. how can i help you?", isUser: false),
    Message(text: "What is the best programming language?", isUser: true),
    Message(
      text:
          "There are many programming languages in the market that are used in designing and building websites",
      isUser: false,
    ),
    Message(text: "So explain to me more", isUser: true),
    Message(
      text:
          "There are many programming languages in the market that are used in designing and building websites, ",
      isUser: false,
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 15),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.pink[100],
            child: Icon(Icons.smart_toy, color: Colors.pink[400], size: 24),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chatbot',
                style: TextStyle(
                  color: Colors.pink[400],
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Row(
                children: [
                  CircleAvatar(radius: 4, backgroundColor: Colors.green),
                  const SizedBox(width: 4),
                  const Text(
                    'Online',
                    style: TextStyle(color: Colors.green, fontSize: 12),
                  ),
                ],
              ),
              Container(
                height: 1,

                color: const Color.fromARGB(255, 116, 116, 116),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!message.isUser)
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.pink[100],
                child: Icon(Icons.smart_toy, color: Colors.pink[400], size: 18),
              ),
            if (!message.isUser) const SizedBox(width: 8),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: message.isUser ? Colors.pink[300] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  message.text,
                  style: TextStyle(
                    color: message.isUser ? Colors.white : Colors.black87,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            if (message.isUser) const SizedBox(width: 8),
            if (message.isUser)
              const CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage("assets/3.png"),
                //  NetworkImage(
                //   'https://randomuser.me/api/portraits/women/17.png',
                // ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -2),
            blurRadius: 4,
            color: Colors.black,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.pink[100],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Hello chatGPT, how are you today?',
                        hintStyle: TextStyle(color: Colors.pink[300]),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(color: Colors.pink[800], fontSize: 15),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.pink[400]),
                    onPressed: () {
                      if (_controller.text.trim().isNotEmpty) {
                        setState(() {
                          _messages.add(
                            Message(text: _controller.text, isUser: true),
                          );
                          // Clear the text field after sending
                          _controller.clear();
                        });
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.mic_none_sharp, color: Colors.pink[400]),
                    onPressed: () {
                      // Voice input logic
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
