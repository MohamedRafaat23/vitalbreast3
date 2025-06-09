// import 'package:flutter/material.dart';
// import 'package:vitalbreast3/screens/home/stories_screen.dart';
// import 'package:vitalbreast3/screens/profile/profile_screan.dart';
// import 'package:vitalbreast3/core/data/remote/dio_helper.dart';
// import 'package:vitalbreast3/core/network/api_constant.dart';
// import 'package:vitalbreast3/core/data/local/cashe_helper.dart';
// import 'package:dio/dio.dart';
// import 'package:vitalbreast3/core/models/user.dart';

// class LayoutMainScreen extends StatefulWidget {
//   const LayoutMainScreen({super.key});
//   static const String routeName = '/layout_main_screen';

//   @override
//   State<LayoutMainScreen> createState() => _LayoutMainScreenState();
// }

// class _LayoutMainScreenState extends State<LayoutMainScreen> {
//   int index = 0;
//   User? _user;
//   bool _loading = true;
//   String? cachedName;

//   @override
//   void initState() {
//     super.initState();

//     // اقرأ الاسم المخزن من الكاش
//     cachedName = CasheHelper.getData(key: 'username');

//     // بعدين fetch من API
//     fetchUser();
//   }

//   Future<void> fetchUser() async {
//     try {
//       final response = await DioHelper.dio.get(
//         '${ApiConstant.baseUrl}/accounts/auth/users/me/',
//         options: Options(
//           headers: {
//             'Authorization': 'Token ${CasheHelper.getData(key: 'token')}',
//           },
//         ),
//       );
//       if (response.statusCode == 200) {
//         final user = User.fromJson(response.data);

//         // خزن الاسم في الكاش
//         await CasheHelper.saveData(key: 'username', value: user.name);

//         setState(() {
//           _user = user;
//           cachedName = user.name;
//         });
//       }
//     } catch (e) {
//       debugPrint('Error fetching user: $e');
//     } finally {
//       setState(() {
//         _loading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     String displayName =
//         _loading ? 'Loading...' : cachedName?.split(' ').first ?? 'Guest';

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: const Color(0xffFFD1E2),
//               radius: 16,
//               child: Text(
//                 _user?.name?.substring(0, 1).toUpperCase() ?? '',
//                 style: const TextStyle(
//                   color: Color(0xffFA7CA5),
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),

//             const SizedBox(width: 8),
//             Text(
//               _loading
//                   ? 'Loading...'
//                   : 'Hello ${_user?.name?.split(' ').first ?? 'Guest'}!',
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Colors.black,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: screenList[index],
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: const Color(0xffFA7CA5),
//         unselectedItemColor: Colors.grey,
//         currentIndex: index,
//         onTap: (value) {
//           setState(() {
//             index = value;
//           });
//         },
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.medical_services),
//             label: 'Doctors',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.reddit_outlined),
//             label: 'Chatbot',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outline),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }

//   List screenList = [const StoriesScreen(), const ProfileScreen()];
// }
