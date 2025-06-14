import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:vitalbreast3/core/data/remote/dio_helper.dart';
import 'package:vitalbreast3/core/data/local/cashe_helper.dart';

class TweetsScreen extends StatefulWidget {
  const TweetsScreen({super.key});

  @override
  State<TweetsScreen> createState() => _TweetsScreenState();
}

class _TweetsScreenState extends State<TweetsScreen> {
  final TextEditingController _commentController = TextEditingController();

  List<dynamic> tweets = [];
  bool _isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchTweets();
  }

  Future<void> _fetchTweets() async {
    setState(() {
      _isLoading = true;
    });
    final token = await CasheHelper.getData(key: 'token');

    try {
      final response = await DioHelper.get(
        url: '/tweets/stories/',
        options: Options(
          headers: {
            'Authorization': 'Bearer$token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
        tweets = response.data.reversed.toList();  
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          errorMessage = 'Error: ${response.statusCode}';
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to load tweets: ${response.statusCode}'),
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        errorMessage = 'Error: $e';
      });
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to load tweets: $e')));
      }
    }
  }
void _addStory() {
  if (_commentController.text.isNotEmpty) {
    setState(() {
      tweets.insert(0, {  // Insert at index 0 instead of add()
        "id": "eb84a1eb-3e29-4a0c-ac17-1e16521da862",
        "author": {
            "id": "b68d1f78-7c8c-4cfc-a00d-71583806bb28",
            "name": "rafaat",
            "email": "rafaat@gmail.com",
            "phone": "0120016815466"
        },
        "content": _commentController.text.trim(),
        "num_of_likes": 0,
        "num_of_comments": 0,
        "created_at": DateTime.now().toIso8601String(), // Use current time
        "updated_at": DateTime.now().toIso8601String()
      });
      _commentController.clear();
    });
  }
}

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                // Tweets list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: tweets.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TweetCard(
                          tweet: tweets[index],
                          onLikePressed: () {
                            setState(() {
                              tweets[index]['num_of_likes']++;
                            });
                          },
                          onRepliesPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        RepliesScreen(tweet: tweets[index]),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),

                // Add tweet input field with send button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xffFFD1E2),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            controller: _commentController,
                            decoration: const InputDecoration(
                              hintText: 'Add your tweet here',
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.black45),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: _addStory,
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.pink[300],
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
  }
}

class TweetCard extends StatelessWidget {
  final dynamic tweet;
  final VoidCallback onLikePressed;
  final VoidCallback onRepliesPressed;

  const TweetCard({
    super.key,
    required this.tweet,
    required this.onLikePressed,
    required this.onRepliesPressed,
  });

  @override
  Widget build(BuildContext context) {
    final createdAt = DateTime.parse(tweet['created_at']);
    final formattedDate = DateFormat('MMM d, y • h:mm a').format(createdAt);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 5),
        ],
      ),
      child: Column(
        children: [
          // Profile image
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.pink[100],
            child: Text(
              tweet['author']['name'][0].toString().toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Name
          Text(
            tweet['author']['name'],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.pink[300],
            ),
          ),
          const SizedBox(height: 4),

          // Date
          Text(
            formattedDate,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),

          // Like button and counter
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onLikePressed,
                child: Icon(Icons.favorite, color: Colors.pink[300], size: 18),
              ),
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.pink[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tweet['num_of_likes'].toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.comment, color: Colors.pink[300], size: 18),
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.pink[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tweet['num_of_comments'].toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Tweet content
          Text(
            tweet['content'],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 16),

          // Replies button
          InkWell(
            onTap: onRepliesPressed,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.pink[300],
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                'Replies',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RepliesScreen extends StatefulWidget {
  final dynamic tweet;

  const RepliesScreen({super.key, required this.tweet});

  @override
  State<RepliesScreen> createState() => _RepliesScreenState();
}

class _RepliesScreenState extends State<RepliesScreen> {
  final TextEditingController _replyController = TextEditingController();
  final Dio _dio = Dio();
  List<dynamic> replies = [];
  bool isLoading = true;
  bool isSending = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchReplies();
  }

  Future<void> _fetchReplies() async {
    try {
      final response = await _dio.get(
        'https://engmohamedshr18.pythonanywhere.com/tweets/stories/${widget.tweet['id']}/replies/',
      );

      if (response.statusCode == 200) {
        setState(() {
          replies = response.data;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load replies');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error: $e';
        // Mock data for demonstration
        replies = [
          {
            'id': '1',
            'author': {'name': 'User One', 'email': 'user1@example.com'},
            'content': 'This is a sample reply to the tweet.',
            'created_at': '2023-06-15T10:30:00Z',
          },
          {
            'id': '2',
            'author': {'name': 'User Two', 'email': 'user2@example.com'},
            'content': 'Another interesting perspective on this topic!',
            'created_at': '2023-06-15T11:45:00Z',
          },
        ];
      });
    }
  }

  Future<void> _sendReply() async {
    if (_replyController.text.isEmpty) return;

    setState(() {
      isSending = true;
    });

    try {
      final response = await _dio.post(
        'https://engmohamedshr18.pythonanywhere.com/tweets/stories/${widget.tweet['id']}/replies/',
        data: {
          'content': _replyController.text,
          'author': {'id': 'current-user-id', 'name': 'Current User'},
        },
      );

      if (response.statusCode == 201) {
        _replyController.clear();
        _fetchReplies(); // Refresh the replies list
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to send reply: $e')));
    } finally {
      setState(() {
        isSending = false;
      });
    }
  }

  void _addReply() {
    if (_replyController.text.isNotEmpty) {
      setState(() {
        replies.add({
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'author': {'name': 'Me'},
          'content': _replyController.text,
          'created_at': DateTime.now().toIso8601String(),
        });
        _replyController.clear();
      });
    }
  }

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    'Replies',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[300],
                    ),
                  ),
                ],
              ),
            ),

            // Original Tweet (using same design as TweetCard but smaller)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.pink[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.pink[200]!),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.pink[100],
                      child: Text(
                        widget.tweet['author']['name'][0]
                            .toString()
                            .toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.tweet['author']['name'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.pink[300],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.tweet['content'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Replies List
            Expanded(
              child:
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: replies.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: ReplyCard(reply: replies[index]),
                          );
                        },
                      ),
            ),

            // Reply Input (same design as tweet input)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xffFFD1E2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: _replyController,
                        decoration: const InputDecoration(
                          hintText: 'Add your reply here',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.black45),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: isSending ? null : _addReply,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isSending ? Colors.grey : Colors.pink[300],
                        shape: BoxShape.circle,
                      ),
                      child:
                          isSending
                              ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                              : const Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 24,
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReplyCard extends StatelessWidget {
  final dynamic reply;

  const ReplyCard({super.key, required this.reply});

  @override
  Widget build(BuildContext context) {
    final createdAt = DateTime.parse(reply['created_at']);
    final formattedDate = DateFormat('MMM d, y • h:mm a').format(createdAt);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile image
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.pink[100],
            child: Text(
              reply['author']['name'][0].toString().toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Name
          Text(
            reply['author']['name'],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.pink[300],
            ),
          ),
          const SizedBox(height: 4),

          // Date
          Text(
            formattedDate,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          const SizedBox(height: 12),

          // Reply content
          Text(
            reply['content'],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
