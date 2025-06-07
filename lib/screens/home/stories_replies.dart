import 'package:flutter/material.dart';

class Reply {
  final String name;
  final String avatarUrl;
  final String timeAgo;
  final String content;
  bool isLiked;

  Reply({
    required this.name,
    required this.avatarUrl,
    required this.timeAgo,
    required this.content,
    this.isLiked = false,
  });
}

class RepliesScreen extends StatefulWidget {
  const RepliesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RepliesScreenState createState() => _RepliesScreenState();
}

class _RepliesScreenState extends State<RepliesScreen> {
  final TextEditingController _reviewController = TextEditingController();

  List<Reply> replies = [
    Reply(
      name: 'Rahma Ali',
      avatarUrl: 'assets/avatar1.png',
      timeAgo: '2 hours ago',
      content:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    Reply(
      name: 'Rahma Ali',
      avatarUrl: 'assets/avatar2.png',
      timeAgo: '2 hours ago',
      content:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    Reply(
      name: 'Rahma Ali',
      avatarUrl: 'assets/avatar1.png',
      timeAgo: '2 hours ago',
      content:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
  ];

  void _sendReview() {
    if (_reviewController.text.isNotEmpty) {
      setState(() {
        replies.add(
          Reply(
            name: 'Me',
            avatarUrl: 'assets/avatar_me.png',
            timeAgo: 'just now',
            content: _reviewController.text,
          ),
        );
        _reviewController.clear();
      });
    }
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xffFA7CA5)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Replies',
          style: TextStyle(
            color: Color(0xffFA7CA5),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Replies list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: replies.length,
              itemBuilder: (context, index) {
                return ReplyCard(
                  reply: replies[index],
                  onLikePressed: () {
                    setState(() {
                      replies[index].isLiked = !replies[index].isLiked;
                    });
                  },
                );
              },
            ),
          ),

          // Input field for review
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 5),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _reviewController,
                    decoration: InputDecoration(
                      hintText: 'Add your review here...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _sendReview,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xffFA7CA5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReplyCard extends StatelessWidget {
  final Reply reply;
  final VoidCallback onLikePressed;

  const ReplyCard({
    super.key,
    required this.reply,
    required this.onLikePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.pink[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar and name row
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xffFFD1E2),
                child: ClipOval(child: Icon(Icons.person, color: Colors.white)),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reply.name,
                    style: const TextStyle(
                      color: Color(0xffFA7CA5),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'added a reply',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        reply.timeAgo,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: onLikePressed,
                child: Icon(
                  reply.isLiked ? Icons.favorite : Icons.favorite_border,
                  color:
                      reply.isLiked
                          ? const Color(0xffFA7CA5)
                          : Colors.grey[400],
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Reply content
          Text(
            reply.content,
            style: TextStyle(fontSize: 14, color: Colors.grey[800]),
          ),
        ],
      ),
    );
  }
}
