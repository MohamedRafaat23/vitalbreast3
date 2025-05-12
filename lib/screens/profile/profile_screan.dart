
import 'package:flutter/material.dart';
import 'package:vitalbreast3/widgets/context_navigation_extansions.dart';
import 'package:vitalbreast3/screens/profile/all_appointments.dart';
import 'dart:ui';

import 'package:vitalbreast3/screens/profile/my_profile.dart';



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _showLogoutDialog = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content with scrolling
          ListView(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            children: [
              SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Profile title
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffFA7CA5),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Profile picture
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xffFA7CA5),
                        image: const DecorationImage(
                          image:
                              NetworkImage('https://i.pravatar.cc/300?img=5'),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Username
                    const Text(
                      'Sarah Ali',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Menu options
                    _buildMenuItem(
                      icon: Icons.person_outline,
                      title: 'My Profile',
                      onTap: () {
                        context.push(const MyProfileScreen());
                      },
                    ),

                    _buildMenuItem(
                      icon: Icons.watch_later,
                      title: 'Appointment management',
                      onTap: () {
                        context.push(const AllAppointmentsScreen());
                      },
                    ),
                    
                    _buildMenuItem(
                      icon: Icons.lock_outline,
                      title: 'Password Manager',
                      onTap: () {},
                    ),
                    

                    // Logout button
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: ElevatedButton(
                        onPressed: () =>
                            setState(() => _showLogoutDialog = true),
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.black,
                          elevation: 5,
                          backgroundColor: const Color(0xffFA7CA5),
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white, width: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text(
                          'Log Out',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // Bottom space for better scrolling experience
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),

          // Blur overlay when dialog is shown
          if (_showLogoutDialog)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  color: Colors.black,
                ),
              ),
            ),

          // Logout confirmation dialog
          if (_showLogoutDialog)
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffFA7CA5),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Are you sure you want to log out?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // No button
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () =>
                                setState(() => _showLogoutDialog = false),
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.black,
                              elevation: 5,
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              
                              side: const BorderSide(
                                  color: Colors.black, width: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text('No'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Yes, Log Out button
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle logout logic
                              setState(() => _showLogoutDialog = false);
                            },
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.black,
                              elevation: 5,
                              backgroundColor: const Color(0xffFA7CA5),
                              foregroundColor: Colors.white,
                              side: const BorderSide(
                                  color: Colors.white, width: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text('Yes, Log Out'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xffFFD1E2),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffFA7CA5),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
