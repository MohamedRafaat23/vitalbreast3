
import 'package:flutter/material.dart';
import 'package:vitalbreast3/widgets/context_navigation_extansions.dart';
import 'package:vitalbreast3/screens/profile/cancel_appointment.dart';
import 'package:vitalbreast3/screens/profile/patient_details.dart';



class Appointment {
  final String name;
  final String date;
  final String time;
  final String imageUrl;

  Appointment({
    required this.name,
    required this.date,
    required this.time,
    required this.imageUrl,
  });
}

class AllAppointmentsScreen extends StatelessWidget {
  const AllAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for appointments
    final List<Appointment> appointments = List.generate(
      6, // Generate 6 items as shown in the image
      (index) => Appointment(
        name: 'Aliaa Ahmed',
        date: '12 FEB 2025',
        time: '11:00 am',
        imageUrl: 'https://via.placeholder.com/150',
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'All Appointments',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffFA7CA5),
                    ),
                  ),
                ],
              ),
            ),

            // Appointment List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  return AppointmentCard(
                    appointment: appointments[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const AppointmentCard({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    const pink = Color(0xffFA7CA5);
    const lightPink = Color(0xFFFFD6E5);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            // Profile image with pink circle
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: pink,
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    appointment.imageUrl,
                    width: 46,
                    height: 46,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.white,
                      );
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Name and date information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appointment.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${appointment.date}   ${appointment.time}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // Action buttons
            Row(
              children: [
                // Details button
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push(const PatientDetailsScreen());
                      // Handle details action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: lightPink,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Details',
                      style: TextStyle(
                        color: Color(0xffFA7CA5),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 6),

                // Cancel button
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push(const CancelAppointmentScreen());
                      // Handle cancel action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFA7CA5),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
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
