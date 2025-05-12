import 'package:flutter/material.dart';
import 'dart:ui';



class CancelAppointmentScreen extends StatefulWidget {
  const CancelAppointmentScreen({super.key});

  @override
  State<CancelAppointmentScreen> createState() =>
      _CancelAppointmentScreenState();
}

class _CancelAppointmentScreenState extends State<CancelAppointmentScreen> {
  int? _selectedReasonIndex;
  final TextEditingController _reasonController = TextEditingController();
  final List<String> _cancellationReasons = [
    'Conference Travel',
    'Weather Conditions',
    'Because Of Illness',
    'Others',
  ];

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const pink = Color(0xffFA7CA5);
    const lightPink = Color(0xFFFFD6E5);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Main content
            Column(
              children: [
                // Header
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                        'Cancel Appointment',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: pink,
                        ),
                      ),
                    ],
                  ),
                ),

                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),

                        const Text(
                          'Reason for canceling\nthe appointment',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Radio options
                        ...List.generate(_cancellationReasons.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: _selectedReasonIndex == index
                                    ? lightPink
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(50),
                              ),

                              child: RadioListTile<int>(
                                hoverColor: Colors.transparent,
                                title: Text(
                                  _cancellationReasons[index],
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                value: index,
                                groupValue: _selectedReasonIndex,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedReasonIndex = value;
                                  });
                                },
                                activeColor: pink,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 0,
                                ),
                                visualDensity: const VisualDensity(
                                  horizontal: -4,
                                  vertical: -4,
                                ),
                              ),
                            ),
                          );
                        }),

                        const SizedBox(height: 20),

                        // Text field for custom reason
                        Container(
                          height: 150,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: lightPink,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: TextField(
                            controller: _reasonController,
                            maxLines: null,
                            expands: true,
                            decoration: const InputDecoration(
                              hintText: 'Enter Your Reason Here...',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Cancel Button at bottom
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        _showConfirmationDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.black,
                        elevation: 5,
                        side: const BorderSide(color: Colors.white, width: 1),
                        backgroundColor: pink,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Cancel Appointment',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
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

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Confirm Cancellation',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Are you sure you want to cancel this appointment?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: TextButton.styleFrom(
                            shadowColor: Colors.black,
                            elevation: 5,
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xffFA7CA5),
                          ),
                          child: const Text('No'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Implement cancellation logic
                            Navigator.of(context).pop();
                            // You could also navigate back or show success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Appointment successfully cancelled'),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.black,
                            elevation: 5,
                            side:
                                const BorderSide(color: Colors.white, width:1 ),
                            backgroundColor: const Color(0xffFA7CA5),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: const Text('Yes'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
