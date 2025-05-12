import 'package:flutter/material.dart';



class DoctorListingScreen extends StatelessWidget {
  const DoctorListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Header
              Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundImage:
                        NetworkImage('https://i.pravatar.cc/150?img=5'),
                  ),
                  const SizedBox(width: 8),
                  RichText(
                    text: const TextSpan(
                      text: 'Hello ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sarah!',
                          style: TextStyle(
                            color: Color(0xffFA7CA5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Filter Text
              const Row(
                children: [
                  Text(
                    'Filtered by location',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.home_filled,
                    color: Color(0xffFA7CA5),
                    size: 20,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Doctor List
              Expanded(
                child: ListView(
                  children: const [
                    DoctorCard(
                      name: 'Dr. Ahmed Hesham',
                      time: '10:30 AM-5:30 PM',
                      location: 'Sheraton, Cairo',
                      rating: 4.7,
                      salary: 350,
                      imgUrl: 'https://i.pravatar.cc/150?img=11',
                      isFemale: false,
                    ),
                    SizedBox(height: 12),
                    DoctorCard(
                      name: 'Dr. Hala Ahmed',
                      time: '10:30 AM-3:30 PM',
                      location: 'Nasr City',
                      rating: 5.0,
                      salary: 300,
                      imgUrl: 'https://i.pravatar.cc/150?img=1',
                      isFemale: true,
                    ),
                    SizedBox(height: 12),
                    DoctorCard(
                      name: 'Dr. Youssef Hesham',
                      time: '11:00 AM-4:00 PM',
                      location: 'Maadi',
                      rating: 4.8,
                      salary: 320,
                      imgUrl: 'https://i.pravatar.cc/150?img=12',
                      isFemale: false,
                    ),
                    SizedBox(height: 12),
                    DoctorCard(
                      name: 'Dr. Mariam Mostafa',
                      time: '10:00 AM-2:30 PM',
                      location: 'Dokki',
                      rating: 4.5,
                      salary: 280,
                      imgUrl: 'https://i.pravatar.cc/150?img=3',
                      isFemale: true,
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String time;
  final String location;
  final double rating;
  final int salary;
  final String imgUrl;
  final bool isFemale;

  const DoctorCard({
    super.key,
    required this.name,
    required this.time,
    required this.location,
    required this.rating,
    required this.salary,
    required this.imgUrl,
    required this.isFemale,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Doctor Image
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: isFemale ? const Color(0xffFA7CA5) : const Color(0xffFFD1E2),
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(imgUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Doctor Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 14,
                        color: Color(0xffFA7CA5),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 14,
                        color: Color(0xffFA7CA5),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        location,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(
                        Icons.attach_money,
                        size: 14,
                        color: Color(0xffFA7CA5),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Salary: $salary LE',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Rating and Arrow
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 14,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        rating.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xffFA7CA5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
