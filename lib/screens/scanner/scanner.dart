import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  File? _selectedImage;
  String? _apiResult;
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();
  final Dio _dio = Dio();

  Future<void> _pickImage() async {
    try {
      setState(() {
        _isLoading = true;
        _apiResult = null;
      });

      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });

        await _uploadImage(_selectedImage!);
      }
    } catch (e) {
      setState(() {
        _apiResult = 'حدث خطأ: ${e.toString()}';
        print(_apiResult);
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _uploadImage(File image) async {
    try {
      String fileName = image.path.split('/').last;
      String fileExtension = fileName.split('.').last.toLowerCase();

      // تحديد نوع المحتوى بناء على امتداد الملف
      MediaType contentType;
      if (fileExtension == 'png') {
        contentType = MediaType('image', 'png');
      } else if (fileExtension == 'gif') {
        contentType = MediaType('image', 'gif');
      } else {
        // الافتراضي jpeg
        contentType = MediaType('image', 'jpeg');
      }

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          image.path,
          filename: fileName,
          contentType: contentType,
        ),
      });

      var response = await _dio.post(
        'https://your-api-url.com/predict',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        // تحسين معالجة الاستجابة
        String result = _parseApiResponse(response.data);
        setState(() {
          _apiResult = result;
        });
      } else {
        setState(() {
          _apiResult = 'خطأ في السيرفر (${response.statusCode})';
          print(_apiResult);
        });
      }
    } on DioException catch (e) {
      String errorMessage = 'خطأ في الشبكة';
      if (e.response != null) {
        errorMessage += ': ${e.response?.statusCode}';
        if (e.response?.data != null) {
          errorMessage += ' - ${e.response?.data.toString()}';
        }
      } else {
        errorMessage += ': ${e.message}';
      }
      setState(() {
        _apiResult = errorMessage;
      });
    } catch (e) {
      setState(() {
        _apiResult = 'خطأ غير متوقع: ${e.toString()}';
        print(_apiResult);
      });
    }
  }

  String _parseApiResponse(dynamic response) {
    try {
      if (response == null) return 'لا توجد استجابة من الخادم';

      if (response is String) {
        // إذا كانت الاستجابة نصية مباشرة
        return response;
      } else if (response is Map) {
        // إذا كانت الاستجابة كائن JSON
        if (response.containsKey('result')) {
          return _translateResult(response['result'].toString());
        } else if (response.containsKey('message')) {
          return response['message'].toString();
        } else if (response.containsKey('error')) {
          return response['error'].toString();
        }
      }

      return response.toString();
    } catch (e) {
      return 'لا يمكن تفسير النتيجة: ${e.toString()}';
    }
  }

  String _translateResult(String result) {
    result = result.toLowerCase();
    if (result.contains('normal')) return 'طبيعي';
    if (result.contains('abnormal')) return 'غير طبيعي';
    if (result.contains('positive')) return 'إيجابي';
    if (result.contains('negative')) return 'سلبي';
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ماسح الأشعة'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // عرض الصورة المختارة
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _selectedImage != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    _selectedImage!,
                    fit: BoxFit.contain,
                  ),
                )
                    : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.image_search, size: 60, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(
                        'لم يتم اختيار صورة بعد',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // زر اختيار الصورة
            ElevatedButton(
              onPressed: _isLoading ? null : _pickImage,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('اختر صورة من المعرض'),
            ),

            const SizedBox(height: 20),

            // عرض نتيجة التحليل
            if (_apiResult != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _apiResult!.contains('غير طبيعي') || _apiResult!.contains('خطأ')
                      ? Colors.red.withOpacity(0.1)
                      : Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _apiResult!.contains('غير طبيعي') || _apiResult!.contains('خطأ')
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
                child: Text(
                  _apiResult!.startsWith('نتيجة التحليل:')
                      ? _apiResult!
                      : 'نتيجة التحليل: $_apiResult',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _apiResult!.contains('غير طبيعي') || _apiResult!.contains('خطأ')
                        ? Colors.red
                        : Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}