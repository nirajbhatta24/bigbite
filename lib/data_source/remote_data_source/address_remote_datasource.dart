
import 'package:artsy/data_source/remote_data_source/response/address_response.dart';
import 'package:artsy/model/products.dart';
import 'package:artsy/model/shipping.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import '../../app/constants.dart';
import '../../helper/http_service.dart';


class AddressRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<bool> addAddress(String address, String city, String state) async {
    try {
      Response response = await _httpServices.post(
        Constant.addressURL,
        options: Options(
          headers: {
            'Authorization': Constant.token,
          },
        ),
        data: {
          "address": address,
          "city": city,
          "state": state,  
          "user":Constant.user.userID,        
        },
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Address>> getAddress() async {
    try {
      Response response = await _httpServices.get(
        "${Constant.baseURL}/address/${Constant.user.userID}",
        options: Options(
          headers: {
            'Authorization': Constant.token,
          },
        ),
      );
      if (response.statusCode == 200) {
        AddressResponse addressResponse = AddressResponse.fromJson(response.data);
        return addressResponse.data!;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }
}
