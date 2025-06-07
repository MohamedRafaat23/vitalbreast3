import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../../core/data/remote/dio_helper.dart';
import '../../../core/network/api_constant.dart';
import '../../../core/data/local/cashe_helper.dart';
import '../../../core/models/user.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<MyProfileScreen> {
  bool _isLoading = false;
  User? _user;

  // Initial values
  final Map<String, String> _profileData = {
    'Full Name': '',
    'Phone Number': '',
    'Email': '',
    'Date Of Birth': '',
    'City': '',
  };

  String? _selectedFilePath;

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await DioHelper.dio.get(
        '${ApiConstant.baseUrl}/accounts/auth/users/me/',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${CasheHelper.getData(key: 'token')}',
          },
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          _user = User.fromJson(response.data);
          _profileData['Full Name'] = _user?.name ?? '';
          _profileData['Phone Number'] = _user?.phone ?? '';
          _profileData['Email'] = _user?.email ?? '';
          _profileData['City'] = _user?.city ?? '';
        });
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred while fetching profile data';
      if (e.response?.data != null && e.response?.data['message'] != null) {
        errorMessage = e.response?.data['message'];
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An unexpected error occurred')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const lighterPink = Color(0xFFFFD6E5);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xffFA7CA5),
                ),
              )
            : CustomScrollView(
                slivers: [
                  // App Bar
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () => Navigator.maybePop(context),
                    ),
                    title: const Text(
                      'My Profile',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffFA7CA5),
                      ),
                    ),
                    centerTitle: true,
                  ),

                  // Content
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 20),

                          // Profile picture
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffFA7CA5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(55),
                                      child: Image.network(
                                        'https://via.placeholder.com/110',
                                        width: 110,
                                        height: 110,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return const Icon(
                                            Icons.person,
                                            size: 60,
                                            color: Colors.white,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: Color(0xffFFD1E2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.edit,
                                      color: Color(0xffFA7CA5),
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Form fields
                          ..._profileData.entries.map((entry) => _buildFormField(
                                label: entry.key,
                                initialValue: entry.value,
                                backgroundColor: const Color(0xffFFD1E2),
                                onChanged: (value) {
                                  setState(() {
                                    _profileData[entry.key] = value;
                                  });
                                },
                              )),

                          const SizedBox(height: 4),

                          // Certificate upload
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Certificate',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                  color: lighterPink,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.cloud_download_outlined,
                                      size: 40,
                                      color: Colors.black54,
                                    ),
                                    const SizedBox(height: 12),
                                    ElevatedButton(
                                      onPressed: () {
                                        // File picker logic would go here
                                        setState(() {
                                          _selectedFilePath =
                                              'selected_certificate.pdf';
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xffFA7CA5),
                                        foregroundColor: Colors.white,
                                        minimumSize: const Size(1200, 35),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18),
                                        ),
                                      ),
                                      child: const Text('Select file'),
                                    ),
                                    if (_selectedFilePath != null)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          'File: $_selectedFilePath',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 32),

                          // Update button
                          ElevatedButton(
                            onPressed: _isLoading
                                ? null
                                : () async {
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    try {
                                      final response = await DioHelper.dio.put(
                                        '${ApiConstant.baseUrl}/accounts/auth/users/me/',
                                        data: {
                                          'name': _profileData['Full Name'],
                                          'phone': _profileData['Phone Number'],
                                          'email': _profileData['Email'],
                                          'city': _profileData['City'],
                                        },
                                        options: Options(
                                          headers: {
                                            'Authorization':
                                                'Bearer ${CasheHelper.getData(key: 'token')}',
                                          },
                                        ),
                                      );

                                      if (response.statusCode == 200) {
                                        setState(() {
                                          _user = User.fromJson(response.data);
                                        });
                                        if (mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                                content: Text('Profile updated successfully')),
                                          );
                                        }
                                      }
                                    } on DioException catch (e) {
                                      String errorMessage =
                                          'An error occurred while updating profile';
                                      if (e.response?.data != null &&
                                          e.response?.data['message'] != null) {
                                        errorMessage = e.response?.data['message'];
                                      }
                                      if (mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(errorMessage)),
                                        );
                                      }
                                    } catch (e) {
                                      if (mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                              content: Text('An unexpected error occurred')),
                                        );
                                      }
                                    } finally {
                                      if (mounted) {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      }
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffFA7CA5),
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Text(
                              _isLoading ? 'Updating...' : 'Update Profile',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required String initialValue,
    required Color backgroundColor,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: initialValue,
            onChanged: onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: backgroundColor,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
