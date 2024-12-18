import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/features/users/services/api_service.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/models/user_model.dart';

class UserProvider extends StateNotifier<Map<String, dynamic>> {
  UserProvider() : super({'users': [], 'isLoading': false}) {
    getData();
  }

  // Fetch data and update loading state
  Future<void> getData() async {
    state = {'users': state['users'], 'isLoading': true}; // Set loading to true

    try {
      List<dynamic> lists = await UserApiService().getUsers();
      List<UserModel> userList = lists
          .map(
            (e) => UserModel.fromJson(e),
          )
          .toList();

      "the users lists are ..............$userList".log();

      state = {
        'users': userList,
        'isLoading': false
      }; // Set loading to false after data is fetched
    } on DioException catch (e) {
      "$e error".log();
      state = {
        'users': state['users'],
        'isLoading': false
      }; // Stop loading on error
    }
  }

  // Add a new user and update state
  Future<void> addUser(String name, String email, String address) async {
    UserModel newUser = UserModel(name: name, email: email, address: address);
    await UserApiService().createUser(name, email, address);
    state = {
      'users': [...state['users'], newUser],
      'isLoading': false
    };
  }

  // Remove a user and update state
  Future<void> removeUser(String id) async {
    state = {
      'users': state['users'].where((user) => user.id != id).toList(),
      'isLoading': false
    };
    await UserApiService().deleteUser(id);
  }

  // Update an existing user and update state
  Future<void> updateUser(
      String id, String name, String mail, String addr) async {
    await UserApiService().updateUser(id, name, mail, addr);
    state = {
      'users': state['users'].map((user) {
        if (user.id == id) {
          return user.copyWith(name: name, email: mail, address: addr);
        }
        return user;
      }).toList(),
      'isLoading': false
    };
  }
}

final userProvider = StateNotifierProvider<UserProvider, Map<String, dynamic>>(
  (ref) => UserProvider(),
);
