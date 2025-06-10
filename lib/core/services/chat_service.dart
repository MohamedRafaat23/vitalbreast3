import 'package:dio/dio.dart';

class ChatService {
  final Dio _dio = Dio();
  final String baseUrl = 'https://engmohamedshr18.pythonanywhere.com/chat/ask-google/';

  Future<String> sendMessage(String message) async {
    try {
      final response = await _dio.post(
        baseUrl,
        data: {'message': message},
      );
      
      if (response.statusCode == 200) {
        return response.data['answer'] ?? 'Sorry, I could not process your request.';
      } else {
        throw Exception('Failed to get response');
      }
    } catch (e) {
      throw Exception('Error sending message: $e');
    }
  }
} 