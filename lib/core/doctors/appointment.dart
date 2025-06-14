import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vitalbreast3/core/data/local/cashe_helper.dart';
import 'package:vitalbreast3/core/data/remote/dio_helper.dart';
import 'package:vitalbreast3/core/doctors/your_appointment.dart';
import 'package:vitalbreast3/widgets/context_navigation_extansions.dart';
import 'package:vitalbreast3/core/models/all.dart';
import 'package:vitalbreast3/core/doctors/doctor_details.dart';

import '../models/appointmint.dart' as Appointment;
import '../network/api_constant.dart';

class AppointmentScreen extends StatefulWidget {
  final Doctor doctor;
  const AppointmentScreen({super.key, required this.doctor});

  @override
  AppointmentScreenState createState() => AppointmentScreenState();
}

class AppointmentScreenState extends State<AppointmentScreen> {
  int selectedDayIndex = 2; // Default to Wednesday (index 2)
  int? selectedTimeIndex;
  final TextEditingController problemController = TextEditingController();

  final List<String> days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
  final List<int> dates = [10, 11, 12, 13, 14, 15];
  final List<String> timeSlots = [
    '11:00 AM',
    '12:00 PM',
    '12:30 PM',
    '1:00 PM',
    '1:30 PM',
    '2:00 PM',
    '3:00 PM',
    '3:30 PM',
    '3:50 PM',
    '4:00 PM'
  ];

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white, // White background
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(),
                _buildCalendar(),
                const SizedBox(height: 20),
                _buildAvailableTimeSection(),
                const SizedBox(height: 20),
                _buildPatientDetailsForm(),
                const SizedBox(height: 30),
                _buildSubmitButton(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xffFA7CA5)),
            onPressed: () {
              context.push(DoctorDetailScreen(doctor: widget.doctor));
            },
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Appointment',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffFA7CA5),
                ),
              ),
            ),
          ),
          const SizedBox(width: 48), // Balance the back button
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'FEB',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffFA7CA5),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Color(0xffFA7CA5)),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
        SizedBox(
          height: 80,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: Color(0xffFA7CA5)),
                onPressed: () {},
              ),
              Expanded(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDayIndex = index;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: selectedDayIndex == index
                              ? const Color(0xffFA7CA5)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Colors.pink.shade100,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${dates[index]}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: selectedDayIndex == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            Text(
                              days[index],
                              style: TextStyle(
                                fontSize: 12,
                                color: selectedDayIndex == index
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: Colors.pink),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvailableTimeSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Available Time',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xffFA7CA5),
            ),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 2.0,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: timeSlots.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTimeIndex = index;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedTimeIndex == index
                        ? const Color(0xffFA7CA5)
                        : const Color(0xffFFD1E2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      timeSlots[index],
                      style: TextStyle(
                        fontSize: 10,
                        color: selectedTimeIndex == index
                            ? Colors.white
                            : const Color(0xffFA7CA5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPatientDetailsForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Patient Details',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xffFA7CA5),
            ),
          ),
          const SizedBox(height: 10),
          _buildFormField('Full Name', 'Sarah Ali'),
          _buildFormField('Age', '30'),
          _buildFormField('City', 'Shebin El-Kom'),
          _buildFormField('Phone Number', '01023013078'),
          const SizedBox(height: 10),
          const Text(
            'Describe your problem',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xffFA7CA5),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.pink.shade100),
            ),
            child: TextField(
              controller: problemController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Enter Your Problem Here...',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xffFFD1E2),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xffFA7CA5),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () async {
            context.push(AppointmentDetailsScreen());
           },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffFA7CA5),
            shadowColor: Colors.black,
            elevation: 5,
            side: const BorderSide(color: Colors.white, width: 2),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: const Text(
            'Submit your appointment',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
