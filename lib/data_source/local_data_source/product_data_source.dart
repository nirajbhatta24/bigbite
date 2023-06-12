import 'dart:io';

import 'package:artsy/helper/objectbox.dart';
import 'package:artsy/model/products.dart';
import 'package:artsy/state/objectbox_state.dart';

class ProductDataSource {
  ObjectBoxInstance get objectBoxInstance => ObjectBoxState.objectBoxInstance!;
  //OR
 
  Future<int> addProduct(File? file, Product product) async {
    try {
      return objectBoxInstance.addProduct(product);
    } catch (e) {
      return Future.value(0);
    }
  }

  Future addAllProduct(List<Product> lstproduct) async {
    try {
      return objectBoxInstance.addAllProduct(lstproduct);
    } catch (e) {
      return false;
    }
  }

  Future<List<Product>> getProducts() {
    try {
      return Future.value(objectBoxInstance.getAllProduct());
    } catch (e) {
      throw Exception('Error in getting all Product');
    }
  }
}
