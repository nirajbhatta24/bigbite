import 'package:artsy/app/constants.dart';
import 'package:artsy/data_source/remote_data_source/response/product_response.dart';
import 'package:artsy/helper/http_service.dart';
import 'package:artsy/model/products.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';

class ProductRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<List<Product>> getAllProduct() async {
    try {
      Response response = await _httpServices.get(
        Constant.productURL,
      );
      if (response.statusCode == 200) {
        ProductResponse productResponse =
            ProductResponse.fromJson(response.data);
        return productResponse.data!;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<List<Product>?> getProductsByCategory(String categoryId) async {
    try {
      Response response = await _httpServices.get(
        Constant.searchProductByCategoryURL,
        queryParameters: {
          'categoryId': categoryId,
        },
      );
      if (response.statusCode == 201) {
        ProductResponse proResponse = ProductResponse.fromJson(response.data);
        return proResponse.data!;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<Product>?> getProductsById(String productId) async {
    try {
      Response response = await _httpServices.get(
        Constant.searchProductByIDURL,
        queryParameters: {
          'productId': productId,
        },
      );
      if (response.statusCode == 201) {
        ProductResponse proResponse = ProductResponse.fromJson(response.data);
        return proResponse.data!;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
