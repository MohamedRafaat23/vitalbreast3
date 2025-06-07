import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vitalbreast3/core/data/local/cashe_helper.dart';
import 'package:vitalbreast3/core/data/remote/dio_helper.dart';
import 'package:vitalbreast3/core/network/api_constant.dart';
import 'package:vitalbreast3/screens/home/stories_replies.dart';
import 'package:vitalbreast3/widgets/context_navigation_extansions.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StoriesScreenState createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  final TextEditingController _commentController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await DioHelper.dio.get(
        ApiConstant.story,
        options: Options(
          headers: {
            'Authorization': 'Token ${CasheHelper.getData(key: 'token')}',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Handle successful response
        print('Data received: ${response.data}');
        // You can parse the response data here
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred while fetching data';
      if (e.response?.data != null && e.response?.data['message'] != null) {
        errorMessage = e.response?.data['message'];
      }
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An unexpected error occurred')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  List<StoryData> stories = [
    StoryData(
      name: 'Mayada Ahmed',
      likes: 36,
      story:
          "support from my family kept me going. Now I'm in recovery, and I thank God every day for the gift of health.",
    ),
    StoryData(
      name: 'Sara Mohammed',
      likes: 16,
      story:
          "I discovered the disease by chance during a routine checkup. I was so scared at first, but my doctor encouraged me to have surgery and",
    ),
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _addStory() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        stories.add(
          StoryData(name: 'Me', likes: 0, story: _commentController.text),
        );
        _commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                // Stories title
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 16.0),
                //   child: Text(
                //     'Stories',
                //     style: TextStyle(
                //       fontSize: 32,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.pink[300],
                //     ),
                //   ),
                // ),

                // Stories list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: stories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: StoryCard(
                          name: stories[index].name,
                          likes: stories[index].likes,
                          story: stories[index].story,
                          onLikePressed: () {
                            setState(() {
                              stories[index].likes++;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),

                // Add comment input field with send button
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
                              hintText: 'Add your story here',
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

class StoryData {
  final String name;
  int likes;
  final String story;

  StoryData({required this.name, required this.likes, required this.story});
}

class StoryCard extends StatelessWidget {
  final String name;
  final int likes;
  final String story;
  final VoidCallback onLikePressed;

  const StoryCard({
    super.key,
    required this.name,
    required this.likes,
    required this.story,
    required this.onLikePressed,
  });

  @override
  Widget build(BuildContext context) {
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
            child: const Icon(Icons.person, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 8),

          // Name
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.pink[300],
            ),
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
                  likes.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Story text
          Text(
            story,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 16),

          // Replies button
          InkWell(
            onTap: () {
              context.push(const RepliesScreen());
            },
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
