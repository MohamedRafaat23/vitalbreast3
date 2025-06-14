import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:vitalbreast3/widgets/custom_elevated_button.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;
  File? _selectedImage;
  Map<String, dynamic>? _results;
  bool _showResults = false;

  static const String apiUrl = 'https://a499-45-242-23-60.ngrok-free.app/predict';

  Future<void> _uploadImage(String imagePath) async {
    if (!mounted) return;

    setState(() {
      _isUploading = true;
      _showResults = false;
      _results = null;
    });

    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      
      // Add the file to the request
      var file = await http.MultipartFile.fromPath('file', imagePath);
      request.files.add(file);

      // Add headers if needed
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
      });
      
      // Send the request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (mounted) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          try {
            // طباعة معلومات الاستجابة للتشخيص
            debugPrint('Response Status: ${response.statusCode}');
            debugPrint('Response Headers: ${response.headers}');
            debugPrint('Response Body: ${response.body}');
            debugPrint('Response Body Type: ${response.body.runtimeType}');
            
            // التحقق من نوع المحتوى
            String contentType = response.headers['content-type'] ?? '';
            
            if (contentType.contains('application/json')) {
              // إذا كانت الاستجابة JSON
              _results = json.decode(response.body);
            } else {
              // محاولة تحويل إلى JSON أولاً
              try {
                var jsonResponse = json.decode(response.body);
                _results = jsonResponse;
              } catch (jsonError) {
                // إذا فشل التحويل، اعتبر الاستجابة كـ string
                debugPrint('Response is not JSON, treating as string: ${response.body}');
                _results = {
                  'prediction': response.body.trim(),
                  'confidence': 'N/A',
                  'format': 'text'
                };
              }
            }
            
            setState(() {
              _showResults = true;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Analysis completed successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          } catch (e) {
            _results = {'error': 'Failed to parse response: $e'};
            setState(() {
              _showResults = true;
            });
          }
          debugPrint('Upload successful: ${response.body}');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Upload failed: ${response.statusCode}'),
              backgroundColor: Colors.red,
            ),
          );
          debugPrint('Upload failed: ${response.statusCode} - ${response.body}');
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error uploading image: $e'),
            backgroundColor: Colors.red,
          ),
        );
        debugPrint('Upload error: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _showResults = false;
          _results = null;
        });
        debugPrint('Image selected from gallery: ${image.path}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error selecting image: $e')),
        );
      }
    }
  }

  void _resetScreen() {
    setState(() {
      _selectedImage = null;
      _results = null;
      _showResults = false;
    });
  }

  Widget _buildResultItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsSection() {
    if (!_showResults || _results == null) return const SizedBox.shrink();
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.analytics_outlined, 
                   color: Colors.green.shade700, size: 20),
              const SizedBox(width: 8),
              Text(
                'Analysis Results',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // عرض النتائج بناءً على النوع
          if (_results!.containsKey('prediction'))
            _buildResultItem('Prediction', _results!['prediction'].toString()),
          
          if (_results!.containsKey('confidence') && _results!['confidence'] != 'N/A')
            _buildResultItem('Confidence', 
                _results!['confidence'] is num 
                  ? '${(_results!['confidence'] * 100).toStringAsFixed(2)}%'
                  : _results!['confidence'].toString()),
          
          if (_results!.containsKey('class'))
            _buildResultItem('Class', _results!['class'].toString()),
          
          if (_results!.containsKey('error'))
            _buildResultItem('Error', _results!['error'].toString()),
          
          // عرض باقي البيانات
          ..._results!.entries
              .where((entry) => !['prediction', 'confidence', 'class', 'error', 'format', 'type'].contains(entry.key))
              .map((entry) => _buildResultItem(entry.key, entry.value.toString())),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: const Text(
              'Image Scanner',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),

          const Divider(height: 1, color: Color.fromARGB(255, 116, 116, 116)),

          // Content Area
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Image Preview Area
                  Container(
                    width: double.infinity,
                    height: 300,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Image preview or placeholder
                        if (_selectedImage != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          )
                        else
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                              color: Colors.grey.shade50,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image_outlined,
                                  size: 60,
                                  color: Colors.grey.shade400,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No image selected',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Choose an image from gallery',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        // Upload progress overlay
                        if (_isUploading)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(color: Colors.white),
                                  SizedBox(height: 16),
                                  Text(
                                    'Processing image...',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Results Section - استخدام الدالة المحسنة
                  _buildResultsSection(),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Button Area
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.pink[50],
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.photo_library_outlined,
                  size: 30,
                  color: Colors.black,
                ),
                const SizedBox(height: 16),
                
                // Gallery Button
                if (!_showResults)
                  CustomElevatedButton(
                    text: _selectedImage == null 
                        ? 'Choose Image from Gallery' 
                        : 'Change Image',
                    onTap: _isUploading ? null : _pickImageFromGallery,
                  ),
                
                // Analyze Button
                if (_selectedImage != null && !_showResults)
                  Column(
                    children: [
                      const SizedBox(height: 12),
                      CustomElevatedButton(
                        text: 'Analyze Image',
                        onTap: _isUploading ? null : () => _uploadImage(_selectedImage!.path),
                      ),
                    ],
                  ),
                
                // Reset Button
                if (_showResults)
                  CustomElevatedButton(
                    text: 'Scan New Image',
                    onTap: _resetScreen,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}