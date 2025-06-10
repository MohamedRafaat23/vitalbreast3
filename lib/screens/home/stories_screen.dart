import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';


class TweetsScreen extends StatefulWidget {
  const TweetsScreen({super.key});

  @override
  State<TweetsScreen> createState() => _TweetsScreenState();
}

class _TweetsScreenState extends State<TweetsScreen> {
  final Dio _dio = Dio();
  List<dynamic> tweets = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchTweets();
  }

  Future<void> _fetchTweets() async {
    try {
      final response = await _dio.get(
        'https://engmohamedshr18.pythonanywhere.com/tweets/stories/',
      );

      if (response.statusCode == 200) {
        setState(() {
          tweets = response.data;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load tweets');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tweets'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage))
          : ListView.builder(
        itemCount: tweets.length,
        itemBuilder: (context, index) {
          final tweet = tweets[index];
          return TweetCard(
            tweet: tweet,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RepliesScreen(tweet: tweet),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class TweetCard extends StatelessWidget {
  final dynamic tweet;
  final VoidCallback onTap;

  const TweetCard({
    super.key,
    required this.tweet,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final createdAt = DateTime.parse(tweet['created_at']);
    final formattedDate = DateFormat('MMM d, y • h:mm a').format(createdAt);

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: Text(tweet['author']['name'][0]),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tweet['author']['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '@${tweet['author']['name'].toLowerCase().replaceAll(' ', '')}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(tweet['content']),
              const SizedBox(height: 10),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                  Text(tweet['num_of_likes'].toString()),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: const Icon(Icons.comment),
                    onPressed: onTap,
                  ),
                  Text(tweet['num_of_comments'].toString()),
                  const Spacer(),
                  Text(
                    formattedDate,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
        ),
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
      // Note: You'll need to implement this endpoint in your API
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
            'author': {
              'name': 'User One',
              'email': 'user1@example.com',
            },
            'content': 'This is a sample reply to the tweet.',
            'created_at': '2023-06-15T10:30:00Z',
          },
          {
            'id': '2',
            'author': {
              'name': 'User Two',
              'email': 'user2@example.com',
            },
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
      // Note: You'll need to implement this endpoint in your API
      final response = await _dio.post(
        'https://engmohamedshr18.pythonanywhere.com/tweets/stories/${widget.tweet['id']}/replies/',
        data: {
          'content': _replyController.text,
          'author': {
            'id': 'current-user-id',
            'name': 'Current User',
          },
        },
      );

      if (response.statusCode == 201) {
        _replyController.clear();
        _fetchReplies(); // Refresh the replies list
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send reply: $e')),
      );
    } finally {
      setState(() {
        isSending = false;
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
    final tweetCreatedAt = DateTime.parse(widget.tweet['created_at']);
    final formattedTweetDate = DateFormat('MMM d, y • h:mm a').format(tweetCreatedAt);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Replies'),
      ),
      body: Column(
        children: [
          // Original Tweet
          Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        child: Text(widget.tweet['author']['name'][0]),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.tweet['author']['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '@${widget.tweet['author']['name'].toLowerCase().replaceAll(' ', '')}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(widget.tweet['content']),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {},
                      ),
                      Text(widget.tweet['num_of_likes'].toString()),
                      const SizedBox(width: 20),
                      const Icon(Icons.comment),
                      Text(widget.tweet['num_of_comments'].toString()),
                      const Spacer(),
                      Text(
                        formattedTweetDate,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Replies List
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage))
                : ListView.builder(
              itemCount: replies.length,
              itemBuilder: (context, index) {
                final reply = replies[index];
                final replyCreatedAt = DateTime.parse(reply['created_at']);
                final formattedReplyDate = DateFormat('MMM d, y • h:mm a').format(replyCreatedAt);

                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              child: Text(reply['author']['name'][0]),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  reply['author']['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '@${reply['author']['name'].toLowerCase().replaceAll(' ', '')}',
                                  style:
                                  TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              formattedReplyDate,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(reply['content']),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Reply Input
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _replyController,
                    decoration: InputDecoration(
                      hintText: 'Write a reply...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                isSending
                    ? const CircularProgressIndicator()
                    : IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendReply,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}