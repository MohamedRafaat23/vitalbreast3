import 'package:flutter/material.dart';
import 'package:vitalbreast3/core/doctors/doctor_card.dart';


class BodyDoctorScreen extends StatelessWidget {
  const BodyDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: 10,
              itemBuilder: (context, index) {
                return DoctorCard(
                  name: 'Dr. Maria Harris',
                  specialty: 'Cardiologist',
                  rating: '4.9',
                  time: index % 2 == 0 ? '09:30 AM' : '11:30 AM',
                  isAvailable: true,
                );
              },
            ),
          )
        
      ;
  }
}