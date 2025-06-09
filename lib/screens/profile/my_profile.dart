import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/data/local/cashe_helper.dart';
import '../../../core/data/remote/dio_helper.dart';
import '../../../core/models/user.dart';
import '../../../core/network/api_constant.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<MyProfileScreen> {
  bool _isLoading = false;
  User? _user;
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  String? _uploadedImageUrl;

  final Map<String, String> _profileData = {
    'Full Name': '',
    'Phone Number': '',
    'Email': '',
    'City': '',
  };

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    setState(() => _isLoading = true);
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
        _user = User.fromJson(response.data);
        _profileData['Full Name'] = _user?.name ?? '';
        _profileData['Phone Number'] = _user?.phone ?? '';
        _profileData['Email'] = _user?.email ?? '';
        _profileData['City'] = _user?.city ?? '';
        _uploadedImageUrl = _user?.profileImage;
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('⚠️ Failed to fetch profile')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedImage = File(picked.path));
      await _uploadToImgbb(_selectedImage!);
    }
  }

  Future<void> _uploadToImgbb(File image) async {
    const imgbbApiKey = 'b8a6a51b1cd9b97c86af8a695ecdd13a';
    final url = 'https://api.imgbb.com/1/upload?key=$imgbbApiKey';

    try {
      final base64Image = base64Encode(await image.readAsBytes());
      final formData = FormData.fromMap({'image': base64Image});

      final response = await Dio().post(url, data: formData);

      if (response.statusCode == 200) {
        final imageUrl = response.data['data']['url'];
        setState(() => _uploadedImageUrl = imageUrl);
        print('👁 Uploaded Image URL: $imageUrl');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Image uploaded to ImgBB')),
        );
      } else {
        throw Exception('Upload failed');
      }
    } catch (_) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('❌ ImgBB upload failed')));
    }
  }

  Future<void> _updateProfile() async {
    setState(() => _isLoading = true);

    try {
      print('👁 Uploaded Image URL: $_uploadedImageUrl');

      final response = await DioHelper.dio.patch(
        '${ApiConstant.baseUrl}/accounts/auth/users/me/',
        data: {
          'name': _profileData['Full Name'],
          'phone': _profileData['Phone Number'],
          'email': _profileData['Email'],
          'city': _profileData['City'],
          if (_uploadedImageUrl != null) 'profile_img': _uploadedImageUrl,
        },
        options: Options(
          headers: {
            'Authorization': 'Token ${CasheHelper.getData(key: 'token')}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        _user = User.fromJson(response.data);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Profile updated successfully')),
        );
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Failed to update profile')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageWidget =
        _selectedImage != null
            ? Image.file(
              _selectedImage!,
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            )
            : (_uploadedImageUrl != null
                ? Image.network(
                  _uploadedImageUrl!,
                  width: 110,
                  height: 110,
                  fit: BoxFit.cover,
                )
                : const Icon(Icons.person, size: 60, color: Colors.white));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:
            _isLoading
                ? const Center(
                  child: CircularProgressIndicator(color: Color(0xffFA7CA5)),
                )
                : CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      floating: true,
                      backgroundColor: Colors.white,
                      elevation: 0,
                      leading: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
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
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
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
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: imageWidget,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: _pickImage,
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
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),
                            ...[
                              'Full Name',
                              'Phone Number',
                              'Email',
                              'City',
                            ].map(
                              (key) => _buildFormField(
                                label: key,
                                initialValue: _profileData[key] ?? '',
                                backgroundColor: const Color(0xffFFD1E2),
                                onChanged: (val) => _profileData[key] = val,
                              ),
                            ),
                            const SizedBox(height: 32),
                            ElevatedButton(
                              onPressed: _isLoading ? null : _updateProfile,
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
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: initialValue,
            onChanged: onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: backgroundColor,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              border: OutlineInputBorder(
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
