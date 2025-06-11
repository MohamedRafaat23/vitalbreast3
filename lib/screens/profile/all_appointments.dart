import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vitalbreast3/core/data/local/cashe_helper.dart';
import 'package:vitalbreast3/core/data/remote/dio_helper.dart';
import 'package:vitalbreast3/core/models/appointmint.dart';
import 'package:vitalbreast3/widgets/context_navigation_extansions.dart';
import 'package:vitalbreast3/screens/profile/cancel_appointment.dart';
import 'package:vitalbreast3/screens/profile/patient_details.dart';
 
class AllAppointmentsScreen extends StatefulWidget {
  const AllAppointmentsScreen({super.key});

  @override
  State<AllAppointmentsScreen> createState() => _AllAppointmentsScreenState();
}

class _AllAppointmentsScreenState extends State<AllAppointmentsScreen> {  
  late Future<List<Appointment>> _appointmentsFuture;

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }
 Future<void> fetchAppointments() async {
    try {
      final response = await DioHelper.get(
        url:  "/clinic/appointments/",
        options: Options(
            // ...
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${CasheHelper.getData(key: "token")}',
            }
        ));

      if (response.statusCode == 200) {
          _appointmentsFuture = response.data;
       } else {
        throw Exception('Failed to load appointments');
      }
    } catch (e) {
      throw Exception('Error fetching appointments: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
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
              child: FutureBuilder<List<Appointment>>(
                future: _appointmentsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No appointments found'));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return AppointmentCard(
                        appointment: snapshot.data![index],
                      );
                    },
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
                   "https://images.unsplash.comfDB8fHx8&auto=format&fit=crop&w=687&q=80",
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
                    appointment.doctor?.name ?? 'Unknown Doctor',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${appointment.timeSlot?.date ?? 'No date'}   ${appointment.timeSlot?.startTime ?? 'No time'}',
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
