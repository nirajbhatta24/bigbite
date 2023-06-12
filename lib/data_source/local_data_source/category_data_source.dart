import 'package:artsy/helper/objectbox.dart';
import 'package:artsy/model/category.dart';

import '../../state/objectbox_state.dart';

class CategoryDataSource {
  // Get the objectBox instance from state
  ObjectBoxInstance get objectBoxInstance => ObjectBoxState.objectBoxInstance!;

  Future<int> addCategory(Category category) async {
    try {
      return objectBoxInstance.addCategory(category);
    } catch (e) {
      return 0;
    }
  }

  Future addAllCategory(List<Category> lstcategory) async {
    try {
      return objectBoxInstance.addAllCategory(lstcategory);
    } catch (e) {
      return false;
    }
  }

  Future<List<Category>> getAllCategory() async {
    try {
      return Future.value(objectBoxInstance.getAllCategory());
    } catch (e) {
      throw Exception('Error in getting all category ${e.toString()}');
    }
  }

  // Future<List<Product>> getProductByCategoryName(String categoryName) {
  //   try {
  //     return Future.value(objectBoxInstance.getProductByCategoryName(categoryName));
  //   } catch (e) {
  //     return Future.value([]);
  //   }
  // }
}
