import 'dart:io';
import 'package:artsy/app/constants.dart';
import 'package:artsy/data_source/remote_data_source/response/login_response.dart';
import 'package:artsy/data_source/remote_data_source/response/profile_response.dart';
import 'package:artsy/helper/http_service.dart';
import 'package:artsy/model/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRemoteDataSource {
  _setDataTosharedPref(String token) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      print('token saved');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  final Dio _httpServices = HttpServices().getDioInstance();

  Future<int> addUser(File? file, User user) async {
    try {
      MultipartFile? image;
      if (file != null) {
        var mimeType = lookupMimeType(file.path);
        image = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
          contentType: MediaType("image", mimeType!.split('/')[1]),
        );
      }
      FormData formData = FormData.fromMap({
        'fname': user.fname,
        'lname': user.lname,
        'email': user.email,
        'username': user.username,
        'password': user.password,
        'image': image,
      });
      Response response = await _httpServices.post(
        Constant.userURL,
        data: formData,
      );
      if (response.statusCode == 201) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  Future<bool> loginUser(username, password) async {
    try {
      Response response = await _httpServices.post(
        Constant.userLoginURL,
        data: {'username': username, 'password': password},
      );
      if (response.statusCode == 200) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        Constant.token = "Bearer ${loginResponse.token}";
        Constant.user = loginResponse.user!;
        _setDataTosharedPref(Constant.token);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<User> getProfile() async {
    try {
      Response response = await _httpServices.get(
        Constant.userprofileURL,
        options: Options(
          headers: {
            'Authorization': Constant.token,
          },
        ),
      );
      if (response.statusCode == 200) {
        ProfileResponse profileResponse =
            ProfileResponse.fromJson(response.data);
        return profileResponse.data!;
      } else {
        return User();
      }
    } catch (e) {
      debugPrint(e.toString());
      return User();
    }
  }

  Future<bool> changePassWord(String newPassword) async{
    try{
      Response response = await _httpServices.put(
       '${Constant.userURL}/${Constant.user.userID}',
        options: Options(
          headers: {
            'Authorization': Constant.token,
          },
        ),
        data: {
          'password': newPassword,
        },
      );
      if(response.statusCode == 200){
        return true;
      }else{
        return false;
      }
    }catch(e){
      debugPrint(e.toString());
      return false;
    }
  }
}
