import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:vitalbreast3/core/doctors/doctor_details.dart';
import 'package:vitalbreast3/widgets/context_navigation_extansions.dart';
import 'package:intl/intl.dart';
import 'package:vitalbreast3/core/models/all.dart'; // Updated import to all.dart

class DoctorListingScreen extends StatelessWidget {
  const DoctorListingScreen({super.key});

  // Fetch doctors using Dio
  Future<List<Doctor>> fetchDoctors() async {
    try {
      final dio = Dio();
      final response = await dio.get(
        'https://engmohamedshr18.pythonanywhere.com/clinic/doctors/',
      );
      if (response.statusCode == 200) {
        List jsonResponse = response.data;
        return jsonResponse.map((doctor) => Doctor.fromJson(doctor)).toList();
      } else {
        throw Exception('Failed to load doctors: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching doctors: $e');
    }
  }

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


              // Doctor List
              Expanded(
                child: FutureBuilder<List<Doctor>>(
                  future: fetchDoctors(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No doctors found'));
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final doctor = snapshot.data![index];
                        // Infer gender based on name (simplified)
                        bool isFemale = doctor.name.contains('Hannah') ||
                            doctor.name.contains('Brandy');
                        // Format current date for filtering time slots
                        final today =
                        DateFormat('yyyy-MM-dd').format(DateTime.now());
                        // Get today's time slots with formatted time
                        String time = doctor.timeSlots
                            .where((slot) => slot.date == today)
                            .map((slot) =>
                        '${slot.startTime.substring(0, 5)}-${slot.endTime.substring(0, 5)}')
                            .join(', ');
                        time = time.isEmpty ? 'Not available today' : time;
                        // Use clinic contact phone as placeholder for location
                        String location = doctor.clinics.isNotEmpty
                            ? 'Clinic: ${doctor.clinics[0].contactPhone}'
                            : 'Unknown location';
                        // Generate random salary as it's not in API
                        int salary = 300 + (index * 10);
                        return Column(
                          children: [
                            DoctorCard(
                              name: doctor.name,
                              time: time,
                              location: location,
                              rating: double.parse(doctor.rating),
                              salary: salary,
                              imgUrl:
                              'https://i.pravatar.cc/150?img=${index + 1}',
                              isFemale: isFemale,
                              doctor: doctor,
                            ),
                            const SizedBox(height: 12),
                          ],
                        );
                      },
                    );
                  },
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
  final Doctor doctor;

  const DoctorCard({
    super.key,
    required this.name,
    required this.time,
    required this.location,
    required this.rating,
    required this.salary,
    required this.imgUrl,
    required this.isFemale,
    required this.doctor,
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
                color:
                isFemale ? const Color(0xffFA7CA5) : const Color(0xffFFD1E2),
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
                        size: 15,
                        color: Color(0xffFA7CA5),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          time,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
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
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
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
                  child: InkWell(
                    onTap: () {
                      context.push(DoctorDetailScreen(doctor: doctor));
                    },
                    child: const Icon(
                      Icons.arrow_forward_sharp,
                      color: Colors.white,
                      size: 20,
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