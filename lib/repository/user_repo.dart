import 'dart:io';
import 'package:artsy/app/constants.dart';
import 'package:artsy/app/network_connectivity.dart';
import 'package:artsy/data_source/remote_data_source/user_remote_data_source.dart';
import '../model/user.dart';
import '../data_source/local_data_source/user_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'user_repo.g.dart';

@riverpod
UserRepository userRepository(UserRepositoryRef ref) => UserRepositoryImpl();

abstract class UserRepository {
  Future<List<User>> getUsers();
  Future<int> addUser(File? file, User user);
  Future<bool> loginUser(String username, String password);
  Future<User> getProfile();
  Future<bool> updateUser(String newpassword);
}

class UserRepositoryImpl extends UserRepository {
  @override
  Future<int> addUser(File? file, User user) async {
    bool status = await NetworkConnectivity.isOnline();
    if (status) {
      return UserRemoteDataSource().addUser(file, user);
    } else {
      return UserDataSource().addUser(file, user);
    }
  }

  @override
  Future<List<User>> getUsers() {
    return UserDataSource().getUsers();
  }

  @override
  Future<bool> loginUser(String username, String password) async {
    bool status = await NetworkConnectivity.isOnline();
    if (status) {
      return UserRemoteDataSource().loginUser(username, password);
    } else {
      return UserDataSource().loginUser(username, password);
    }
  }

  @override
  Future<User> getProfile() async {
    bool status = await NetworkConnectivity.isOnline();
    if (status) {
      return UserRemoteDataSource().getProfile();
    } else {
      return Constant.user;
    }
  }

  @override
  Future<bool> updateUser(String newpassword) async {
    bool status = await NetworkConnectivity.isOnline();
    if (status) {
      return UserRemoteDataSource().changePassWord(newpassword);
    } else {
      return false;
    }
  }
}

