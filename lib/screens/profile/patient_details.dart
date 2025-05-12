import 'package:flutter/material.dart';



class PatientDetailsScreen extends StatelessWidget {
  const PatientDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const pink = Color(0xffFA7CA5);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                  Text(
                    'Patient Details',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: pink,
                      shadows: [
                        Shadow(
                          color: Colors.grey,
                          offset: const Offset(1, 1),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content area
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),

                      // Date pill
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 24),
                          decoration: BoxDecoration(
                            color: pink,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            'FEB 24, 2025',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      // Time
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
                          child: Text(
                            'WED, 11:00 AM',
                            style: TextStyle(
                              color: Color(0xffFA7CA5),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      // Divider
                      Container(
                        height: 1,
                        color: const Color(0xffFA7CA5),
                      ),

                      const SizedBox(height: 16),

                      // Patient information
                      _buildInfoRow('Full Name', 'Sarah Ali'),
                      _buildInfoRow('Age', '30'),
                      _buildInfoRow('Gender', 'Female'),
                      _buildInfoRow('City', 'Shebin El-Kom'),
                      _buildInfoRow('Phone Number', '01023013078'),

                      // Divider
                      Container(
                        height: 1,
                        color: const Color(0xffFA7CA5),
                        margin: const EdgeInsets.symmetric(vertical: 16),
                      ),

                      // Problem section
                      const Text(
                        'Problem',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Problem description
                      const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
