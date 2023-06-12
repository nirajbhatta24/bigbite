import 'package:artsy/data_source/remote_data_source/response/cart_response.dart';
import 'package:artsy/model/products.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import '../../app/constants.dart';
import '../../helper/http_service.dart';
import '../../model/cart.dart';

class CartRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<bool> addProductToCart(
      Product product, int quantity, int amount) async {
    try {
      debugPrint(product.productId!);
      Response response = await _httpServices.post(
        Constant.cartURL,
        options: Options(
          headers: {
            'Authorization': Constant.token,
          },
        ),
        data: {
          "product": product,
          "quantity": quantity,
          "amount": amount,
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

  Future<int> deleteAllCartFromUser() async {
    try {
      Response response = await _httpServices.delete(
        "${Constant.cartURL}/user/${Constant.user.userID}",
        options: Options(
          headers: {
            'Authorization': Constant.token,
          },
        ),
      );
      if (response.statusCode == 200) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  Future<List<Cart>> getAllCart() async {
    try {
      Response response = await _httpServices.get(
        "${Constant.cartURL}/user/${Constant.user.userID}",
        options: Options(
          headers: {
            'Authorization': Constant.token,
          },
        ),
      );
      if (response.statusCode == 200) {
        CartResponse cartResponse = CartResponse.fromJson(response.data);
        return cartResponse.data!;
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
