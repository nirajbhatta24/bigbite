import 'package:artsy/data_source/remote_data_source/response/cart_response.dart';
import 'package:artsy/data_source/remote_data_source/response/order_response.dart';
import 'package:artsy/model/order.dart';
import 'package:artsy/model/products.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import '../../app/constants.dart';
import '../../helper/http_service.dart';
import '../../model/cart.dart';

class OrderRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<bool> addOrder(Orders neworder) async {
    try {
      Response response = await _httpServices.post(
        Constant.orderURL,
        options: Options(
          headers: {
            'Authorization': Constant.token,
          },
        ),
        data: {
          "products": neworder.products,
          "quantity": neworder.quantity,
          "amount": neworder.amount,
          "status": neworder.status,
          "user": Constant.user,
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

  Future<List<Orders>> getAllCart() async {
    try {
      Response response = await _httpServices.get(
        "${Constant.orderURL}/${Constant.user.userID}",
        options: Options(
          headers: {
            'Authorization': Constant.token,
          },
        ),
      );
      if (response.statusCode == 200) {
        OrderResponse orderResponse = OrderResponse.fromJson(response.data);
        return orderResponse.data!;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<bool?> deleteProductFromCart(int cartid) async {
    try {
      Response response = await _httpServices.delete(
        "${Constant.cartURL}/$cartid",
        options: Options(
          headers: {
            'Authorization': Constant.token,
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
