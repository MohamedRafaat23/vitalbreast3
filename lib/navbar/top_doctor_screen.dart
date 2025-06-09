import 'package:flutter/material.dart';
import 'package:vitalbreast3/core/doctors/body_doctor_screen.dart';
import 'package:vitalbreast3/core/doctors/filtered_location.dart';
import 'package:vitalbreast3/screens/ChatBot/chat_bot.dart';
import 'package:vitalbreast3/screens/home/stories_screen.dart';
import 'package:vitalbreast3/screens/profile/profile_screan.dart';
import 'package:vitalbreast3/screens/scanner/scanner.dart';
import 'package:vitalbreast3/widgets/context_navigation_extansions.dart';
import 'package:vitalbreast3/core/data/remote/dio_helper.dart';
import 'package:vitalbreast3/core/network/api_constant.dart';
import 'package:vitalbreast3/core/data/local/cashe_helper.dart';
import 'package:vitalbreast3/core/models/user.dart';
import 'package:dio/dio.dart';

class LayoutMainScreen extends StatefulWidget {
  const LayoutMainScreen({super.key});
  static const String routeName = '/layout_main_screen';

  @override
  State<LayoutMainScreen> createState() => _LayoutMainScreenState();
}

class _LayoutMainScreenState extends State<LayoutMainScreen> {
  int index = 0;
  String? userName;
  String? profileImage;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    try {
      final response = await DioHelper.dio.get(
        '${ApiConstant.baseUrl}/accounts/auth/users/me/',
        options: Options(
          headers: {
            'Authorization': 'Token ${CasheHelper.getData(key: 'token')}',
          },
        ),
      );

      if (response.statusCode == 200) {
        final user = User.fromJson(response.data);
        setState(() {
          userName = user.name;
          profileImage = user.profileImage;
        });
      }
    } catch (e) {
      debugPrint('Error fetching name: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayName =
        isLoading ? 'Loading...' : (userName?.split(' ').first ?? 'Guest');
    final firstLetter =
        (userName?.isNotEmpty ?? false) ? userName![0].toUpperCase() : 'S';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xffFFD1E2),
              radius: 16,
              backgroundImage:
                  (profileImage != null && profileImage!.isNotEmpty)
                      ? NetworkImage(profileImage!)
                      : null,
              child:
                  (profileImage == null || profileImage!.isEmpty)
                      ? Text(
                        firstLetter,
                        style: const TextStyle(
                          color: Color(0xffFA7CA5),
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      : null,
            ),

            const SizedBox(width: 8),
            Text(
              'Hello $displayName!',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on, color: Colors.grey),
            onPressed: () {
              context.push(const DoctorListingScreen());
            },
          ),
        ],
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
          BottomNavigationBarItem(
            icon: Icon(Icons.document_scanner_outlined),
            label: 'Scanner',
          ),
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
    const BodyDoctorScreen(),
    const ScannerScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];
}
