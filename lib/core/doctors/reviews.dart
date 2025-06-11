import 'package:flutter/material.dart';
import 'package:vitalbreast3/core/models/all.dart';

class Review {
  final String avatarUrl;
  final String content;

  Review({required this.avatarUrl, required this.content});
}

class DoctorReviewsScreen extends StatefulWidget {
  final Doctor doctor;
  const DoctorReviewsScreen({super.key, required this.doctor});

  @override
  // ignore: library_private_types_in_public_api
  _DoctorReviewsScreenState createState() => _DoctorReviewsScreenState();
}

class _DoctorReviewsScreenState extends State<DoctorReviewsScreen> {
  final TextEditingController _reviewController = TextEditingController();

  List<Review> reviews = [
    Review(
      avatarUrl: 'assets/avatar1.png',
      content:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut',
    ),
    Review(
      avatarUrl: 'assets/avatar2.png',
      content:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut',
    ),
    Review(
      avatarUrl: 'assets/avatar3.png',
      content:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut',
    ),
  ];

  void _sendReview() {
    if (_reviewController.text.isNotEmpty) {
      setState(() {
        reviews.add(
          Review(
            avatarUrl: 'assets/avatar_me.png',
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.pink[300]),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Reviews',
          style: TextStyle(
            color: Colors.pink[300],
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Doctor profile section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                // Doctor avatar
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.pink[100],
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/5.png'),
                    )
                  ),
                ),
                const SizedBox(height: 12),
                // Doctor name
                const Text(
                  'Dr. Razan Ali',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                // Doctor title
                Text(
                  'Senior Surgeon',
                  style: TextStyle(color: Colors.grey[500], fontSize: 16),
                ),
                const SizedBox(height: 10),
                // Rating stars
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.pink[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            color: Colors.pink[300],
                            size: 16,
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Reviews section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Some Reviews',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Reviews list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return ReviewCard(review: reviews[index]);
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
                      hintStyle: const TextStyle(color: Colors.black38),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xffFFD1E2),
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
                    decoration: BoxDecoration(
                      color: Colors.pink[300],
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

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.pink[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.pink[200],
            backgroundImage: AssetImage(review.avatarUrl),
          ),
          const SizedBox(width: 12),
          // Review content
          Expanded(
            child: Text(
              review.content,
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }
}
