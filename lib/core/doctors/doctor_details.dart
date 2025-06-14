import 'package:flutter/material.dart';
import 'package:vitalbreast3/core/doctors/appointment.dart';
import 'package:vitalbreast3/core/doctors/reviews.dart';
import 'package:vitalbreast3/core/models/all.dart';
import 'package:vitalbreast3/widgets/context_navigation_extansions.dart'; // Import shared models

class DoctorDetailScreen extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetailScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    // Infer gender for image placeholder (simplified)
    bool isFemale = doctor.name.contains('Hannah') || doctor.name.contains('Brandy');
    // Format stats
    String patientCount = doctor.patientCount == '0' ? '100+' : '${doctor.patientCount}+';
    String experienceYears = '${doctor.experienceYears}+';
    String reviewsCount = doctor.reviewsCount == '0' ? '50+' : '${doctor.reviewsCount}+';
    String rating = doctor.rating;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xffFA7CA5)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Doctor',
          style: TextStyle(
            color: Color(0xffFA7CA5),
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  width: double.infinity,
                  height: 240,
                  color: Theme.of(context).primaryColor,
                  child: Image.network(
                    'https://img.freepik.com/free-photo/portrait-3d-male-doctor_23-2151107212.jpg?ga=GA1.1.146803951.1749855391&semt=ais_hybrid&w=740',
                    fit: BoxFit.cover,
                  ),
                ),
              ), 
              const SizedBox(height: 16),
              // Doctor Info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width:250,
                    child: Text(
                      doctor.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        rating,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Text(
                      //   '($reviewsCount reviews)',
                      //   style: const TextStyle(
                      //     fontSize: 8,
                      //     color: Colors.grey,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Specialist Doctor', // Placeholder for specialty
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              // Stats Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatColumn(Icons.person_outline, const Color(0xffFA7CA5),
                      patientCount, 'Patients'),
                  _buildStatColumn(Icons.calendar_today_outlined,
                      const Color(0xffFA7CA5), experienceYears, 'Years'),
                  _buildStatColumn(Icons.star_outline, const Color(0xffFA7CA5),
                      rating, 'Rating'),
                  _buildStatColumn(Icons.chat_bubble_outline,
                      const Color(0xffFA7CA5), reviewsCount, 'Reviews'),
                ],
              ),
              const SizedBox(height: 24),
              // About Doctor Section
              const Text(
                'About Doctor',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '${doctor.name} is a highly experienced specialist with over $experienceYears of experience. They have served $patientCount patients with a rating of from $reviewsCount reviews.',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              // Buttons
              ElevatedButton(
                onPressed: () {
                 context.push(AppointmentScreen(doctor: doctor)); // Pass doctor
                },
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                  backgroundColor: const Color(0xffFA7CA5),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'Book Appointment',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {
                 context.push(DoctorReviewsScreen(doctor: doctor)); // Pass doctor
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                  backgroundColor: const Color(0xffFFD1E2),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'See Reviews',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffFA7CA5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(
      IconData icon, Color color, String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}