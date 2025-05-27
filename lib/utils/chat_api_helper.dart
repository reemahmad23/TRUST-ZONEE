import 'package:dio/dio.dart';
import 'package:trust_zone/utils/token_helper.dart';

import '../core/network/dio_helper.dart';

Future<String?> createConversation(String receiverId) async {
  try {
    final token = await TokenHelper.getToken();

    if (token == null) {
      print('❌ No token found');
      return null;
    }

    final response = await DioHelper.dio.post(
      'https://trustzone.azurewebsites.net/api/Conversation',
      data: {
        'user2Id': receiverId.toString(),
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    print('Status code: ${response.statusCode}');
    print('Response data: ${response.data}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.data;

      if (data != null) {
        if (data is String || data is int) {
          return data.toString();
        } else if (data is Map<String, dynamic> && data.containsKey('conversationId')) {
          return data['conversationId'].toString();
        } else {
          print('❌ Unexpected response data format: $data');
          return null;
        }
      } else {
        print('❌ Response data is null');
        return null;
      }
    } else {
      print('❌ API Error: ${response.statusCode} - ${response.statusMessage}');
      print('Response data: ${response.data}');
      return null;
    }
  } on DioError catch (dioError) {
    print('❌ Dio error: ${dioError.message}');
    if (dioError.response != null) {
      print('❌ Dio error response data: ${dioError.response?.data}');
      print('❌ Dio error status code: ${dioError.response?.statusCode}');
    }
    return null;
  } catch (e) {
    print('❌ Exception: $e');
    return null;
  }
}
