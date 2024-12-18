import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:portfolio/main.dart';

class UserApiService {
  static String baseUrl = "https://crud-f621.onrender.com/api/user/";
  final dio = Dio();

  Future<List<dynamic>> getUsers() async {
    try {
      final response = await dio.get("$baseUrl/viewcreatedusers");
      "${response.data}".log();
      "Status Code: ${response.statusCode}".log();
      "Users: ${response.data}".log();
      return response.data;
    } catch (e) {
      "Error: $e".log();
      return [];
    }
  }

  Future<void> createUser(String name, String email, String address) async {
    final url = '$baseUrl/create';

    try {
      // Send the POST request using Dio
      final response = await dio.post(
        url,
        data: json.encode({
          'name': name,
          'email': email,
          'address': address,
        }),
        options: Options(
          headers: {
            'Content-Type': 'application/json'
          }, // Setting the Content-Type header
        ),
      );

      // Log the response body and status code
      "${response.data}".log();
      "${response.statusCode}".log();
    } on DioException catch (error) {
      // Handle Dio-specific errors
      "Error: ${error.response?.statusCode} - ${error.response?.data}".log();
    } catch (e) {
      // General error handling
      "Error: $e".log();
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await dio.delete("$baseUrl/delete/$id",
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ));
    } on DioException catch (e) {
      "Error: $e".log();
    }
  }

  Future<void> updateUser(
      String id, String? name, String? email, String? address) async {
    try {
      final response = await dio.put(
        "$baseUrl/update/$id",
        data: {
          "name": name,
          "email": email,
          "address": address,
        },
      );

      // Check the response status
      if (response.statusCode == 200) {
        print("User updated successfully");
      } else {
        print("Error updating user: ${response.data}");
      }
    } on DioException catch (error) {
      // Handle error
      print("Error: ${error.response?.statusCode} - ${error.response?.data}");
      throw Exception('Failed to update user');
    }
  }
}
