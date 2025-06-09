import 'package:flutter/material.dart';
import 'package:vitalbreast3/screens/home/stories_screen.dart';
import 'package:vitalbreast3/screens/profile/profile_screan.dart';
class LayoutMainScreen extends StatefulWidget {
  const LayoutMainScreen({super.key});
  static const String routeName = '/layout_main_screen';

  @override
  State<LayoutMainScreen> createState() => _LayoutMainScreenState();
}

class _LayoutMainScreenState extends State<LayoutMainScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xffFFD1E2),
              radius: 16,
              child: Text(
                'S',
                style: TextStyle(
                  color: Color(0xffFA7CA5),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Hello Sarah!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
       
      ),
      body: screenList[index],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xffFA7CA5),
        unselectedItemColor: Colors.grey,
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },

        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Doctors',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.document_scanner_outlined),
          //   label: 'Scanner',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.reddit_outlined),
            label: 'Chatbot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  List screenList = [
    const StoriesScreen(),
    const ProfileScreen(),
  ];
}
